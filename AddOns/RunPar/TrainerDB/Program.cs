using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using Microsoft.Boogie.VCExprAST;
using System.Diagnostics;
using System.ComponentModel;
using System.Xml.Serialization;
using System.IO;
using Trainer;

namespace TrainerDB
{
    public class Driver
    {
        public static bool useStubs = false;

        static void Main(string[] args)
        {
            if (args.Length != 2)
            {
                Console.WriteLine("Usage: TrainerDB.exe dbfile outfile");
                return;
            }

            AtomDictionary atoms = null;
            StubAnnotatedSummaryDictionary candidates = null;

            using (var fs = new System.IO.FileStream(args[0], System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read))
            {
                var serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                var obj = serializer.Deserialize(fs);
                atoms =  obj as AtomDictionary;
                if (atoms != null)
                {
                    atoms.Print(args[1]);
                }
                candidates = obj as StubAnnotatedSummaryDictionary;
                if (candidates != null)
                {
                    candidates.Print(args[1]);
                }
            }
        }

        public static AtomDictionary ReadAtomDB(string file)
        {
            using (var fs = new System.IO.FileStream(file, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read))
            {
                var serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                var obj = serializer.Deserialize(fs);
                return obj as AtomDictionary;
            }
        }

        public static void WriteDB(object db, string file)
        {
            using (var fs = new System.IO.FileStream(file, System.IO.FileMode.Create, System.IO.FileAccess.Write, System.IO.FileShare.None))
            {
                var serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                serializer.Serialize(fs, db);
            }
        }

        public static StubAnnotatedSummaryDictionary ReadCandidateDB(string file)
        {
            using (var fs = new System.IO.FileStream(file, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read))
            {
                var serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                var obj = serializer.Deserialize(fs);
                return obj as StubAnnotatedSummaryDictionary;
            }
        }
    }

    [Serializable]
    public class SummaryDictionary
    {
        // Actual table of (property, predicate) pairs
        public List<Tuple<string, string>> table;

        // A dictionary representation of the table, for fast access
        [NonSerialized]
        private Dictionary<string, HashSet<string>> map;

        public SummaryDictionary()
        {
            table = new List<Tuple<string, string>>();
            map = new Dictionary<string, HashSet<string>>();
        }

        public void Add(string property, string predicate)
        {
            if (!map.ContainsKey(property))
                map.Add(property, new HashSet<string>());
            map[property].Add(predicate);
        }

        // map -> table
        public void Marshall()
        {
            table = new List<Tuple<string, string>>();
            map.Iter(kvp =>
                kvp.Value.Iter(v => table.Add(Tuple.Create(kvp.Key, v))));
        }

        // table -> map
        public void DeMarshall()
        {
            map = new Dictionary<string, HashSet<string>>();
            table.Iter(s => map[s.Item1] = new HashSet<string>());
            table.Iter(s => map[s.Item1].Add(s.Item2));
        }

        public void Print(string file)
        {
            var fs = new System.IO.StreamWriter(file);
            foreach (var kvp in map)
            {
                fs.WriteLine("======= {0} =======", kvp.Key);
                kvp.Value.Iter(s => fs.WriteLine("  {0}", s));
            }
            fs.Close();
        }

        public string DumpPredicates(string rule, out int NumPreds)
        {
            string ret = "";
            NumPreds = 0;
            if (map.ContainsKey(rule))
            {
                map[rule].Iter(s => ret = ret + Environment.NewLine + "ensures " + s + ";");
                NumPreds = map[rule].Count;
            }
            return ret;
        }
    }

    [Serializable]
    public class AnnotatedSummaryDictionary
    {
        // Actual table of (property, mustmod, predicate) tuples
        public List<Tuple<string, string, string>> table;

        // A dictionary representation of the table, for fast access
        // property -> (mustmod, predicate)
        [NonSerialized]
        private Dictionary<string, HashSet<Tuple<string, string>>> map;

        // A Z3 prover for inferring annotations on predicates
        [NonSerialized]
        private static ProverInterface prover = null;

        [NonSerialized]
        private static readonly bool TrustAnnotations = false;

        public AnnotatedSummaryDictionary()
        {
            table = new List<Tuple<string, string, string>>();
            map = new Dictionary<string, HashSet<Tuple<string, string>>>();
        }

        public List<string> getPropertyList()
        {
            List<string> keys = new List<string>();
            foreach (var key in map.Keys)
                keys.Add(key);
            return keys;
        }

        public HashSet<string> getPredicates(string property)
        {
            HashSet<string> ret = new HashSet<string>();
            foreach (var tup in map[property])
                ret.Add(tup.Item2);
            return ret;
        }

        public void Add(string property, string predicate)
        {
            if (!map.ContainsKey(property))
                map.Add(property, new HashSet<Tuple<string, string>>());

            // drop the predicate, if it exists (for recomputing the annotation)
            map[property].RemoveWhere(tup => tup.Item2 == predicate);

            Debug.Assert(prover != null);
            var annotations = FindAnnotations(predicate);
            map[property].Add(Tuple.Create(annotations, predicate));
        }

        public void Delete(string property)
        {
            if (!map.ContainsKey(property))
                return;

            map[property] = new HashSet<Tuple<string, string>>();
        }

        // Convert SummaryDictionary to AnnotatedSummaryDictionary
        public static AnnotatedSummaryDictionary FromSummaryDictionary(SummaryDictionary dict)
        {
            Debug.Assert(prover != null);

            var ret = new AnnotatedSummaryDictionary();

            foreach (var tup in dict.table)
                ret.Add(tup.Item1, tup.Item2);

            ret.Marshall();

            return ret;
        }

        public static AnnotatedSummaryDictionary GetDictionary(object summaries)
        {
            if (summaries is AnnotatedSummaryDictionary)
                return (summaries as AnnotatedSummaryDictionary);
            Debug.Assert(summaries is SummaryDictionary);
            CreateProver();
            var ret = FromSummaryDictionary(summaries as SummaryDictionary);
            CloseProver();
            return ret;
        }

        // map -> table
        public void Marshall()
        {
            table = new List<Tuple<string, string, string>>();
            map.Iter(kvp =>
                kvp.Value.Iter(v => table.Add(Tuple.Create(kvp.Key, v.Item1, v.Item2))));
        }

        // table -> map
        public void DeMarshall()
        {
            map = new Dictionary<string, HashSet<Tuple<string, string>>>();
            if (TrustAnnotations)
            {
                table.Iter(s => map[s.Item1] = new HashSet<Tuple<string, string>>());
                table.Iter(s => map[s.Item1].Add(Tuple.Create(s.Item2, s.Item3)));
            }
            else
            {
                CreateProver();
                table.Iter(s => Add(s.Item1, s.Item2));
                CloseProver();
            }
        }

        public void Print(string file)
        {
            var fs = new System.IO.StreamWriter(file);
            foreach (var kvp in map)
            {
                fs.WriteLine("======= {0} =======", kvp.Key);
                kvp.Value.Iter(s => fs.WriteLine("  {0} {1}", s.Item1, s.Item2));
            }
            fs.Close();
        }

        public string DumpPredicates(string rule, out int NumPreds)
        {
            string ret = "";
            NumPreds = 0;
            if (map.ContainsKey(rule))
            {
                if (Driver.useStubs)
                    map[rule].Iter(s => ret = ret + Environment.NewLine + "ensures " + s.Item1 + " " + s.Item2 + ";");
                else
                    map[rule].Iter(s => ret = ret + Environment.NewLine + "ensures " + s.Item1 + " " + s.Item2 + ";");
                NumPreds = map[rule].Count;
            }
            return ret;
        }

        public static Expr ToExpr(string str)
        {
            Program program;

            // parse str as an unresolved expr
            var programText = string.Format("procedure foo(); ensures {0};", str);
            Parser.Parse(programText, "dummy.bpl", out program);

            // get variables
            var gv = (new GatherVariables());
            gv.Visit(program);
            foreach (var v in gv.variables)
            {
                programText += Environment.NewLine + string.Format("var {0}: int;", v);
            }

            // try parsing again
            Parser.Parse(programText, "dummy.bpl", out program);
            // resolve
            program.Resolve();

            return program.TopLevelDeclarations.OfType<Procedure>()
                .First().Ensures.First().Condition;
        }

        public static void CreateProver()
        {
            CommandLineOptions.Clo.ApplyDefaultOptions();
            CommandLineOptions.Clo.StratifiedInlining = 1;
            prover = ProverInterface.CreateProver(new Program(), "log", CommandLineOptions.Clo.SimplifyLogFileAppend, -1);
        }

        public static void CloseProver()
        {
            prover.Close();
            CommandLineOptions.Clo.TheProverFactory.Close();
            prover = null;
        }

        public static string FindAnnotations(string predicate)
        {
            var expr = ToExpr(predicate);
            var ret = "";

            // Get variables used in the expr
            var variables = new HashSet<Variable>();
            var vu = new GatherNonOldVariables();
            vu.VisitExpr(expr);

            foreach (var v in vu.variables)
            {
                ret += string.Format(" {{:mustmod \"{0}\" }}", v);
            }

            return ret;
        }

        // deprecated
        public static string FindAnnotationsOld(string predicate)
        {
            var expr = ToExpr(predicate);
            var ret = "";

            // Get variables used in the expr
            var variables = new HashSet<Variable>();
            var vu = new VarsUsed();
            vu.VisitExpr(expr);
            variables = vu.Vars;

            // yogi_error variable present?
            var err = variables.Where(v => v.Name == "yogi_error").FirstOrDefault();
            Expr pre = Expr.True;
            if (err != null)
                pre = Expr.Eq(new OldExpr(Token.NoToken, Expr.Ident(err)), Expr.Literal(0));

            foreach (var v in variables)
            {
                Expr nmod = Expr.Eq(new OldExpr(Token.NoToken, Expr.Ident(v)), Expr.Ident(v));
                nmod = Expr.And(nmod, pre);
                var check = Expr.And(nmod, Expr.Not(expr));
                if (CheckIfUnsat(check))
                {
                    ret += string.Format(" {{:mustmod \"{0}\" }}", v);
                    continue;
                }
                if (err != null && v.Name == err.Name)
                    continue;

                var rand = new System.Random();
                var rvalues = new HashSet<int>();
                for (int i = 0; i < 3; i++) rvalues.Add(rand.Next(0, 10));
                for (int i = 0; i < 3; i++) rvalues.Add(rand.Next(-10, 0));

                foreach (var val in rvalues)
                {
                    //Console.WriteLine("Trying {0}", val);
                    check = Expr.And(nmod, Expr.Eq(new OldExpr(Token.NoToken, Expr.Ident(v)), Expr.Literal(val)));
                    check = Expr.And(check, expr);
                    if (CheckIfUnsat(check))
                    {
                        ret += string.Format(" {{:mustmod \"{0}\" }}", v);
                        break;
                    }

                }
            }

            return ret;
        }

        // Is a UNSAT?
        private static bool CheckIfUnsat(Expr a)
        {
            var gen = prover.VCExprGen;
            var gatherLitA = new GatherLiterals();
            gatherLitA.Visit(a);

            // Create fresh variables
            var counter = 0;
            var incarnations = new Dictionary<string, VCExpr>();
            foreach (var literal in gatherLitA.literals)
            {
                if (incarnations.ContainsKey(literal.Item2.ToString()))
                    continue;

                //if(!literal.Item1.TypedIdent.Type.IsInt && !literal.Item1.TypedIdent.Type.IsBool)
                var v = gen.Variable("UNSATCheck" + counter, literal.Item1.TypedIdent.Type);
                incarnations.Add(literal.Item2.ToString(), v);
                counter++;
            }

            var vc1 = ToVcExpr(a, incarnations, gen);
            var vc = gen.LabelPos("Temp", vc1);

            // check
            prover.AssertAxioms();
            prover.Push();
            prover.Assert(vc, true);
            prover.Check();
            var outcome = prover.CheckOutcomeCore(new DummyErrorReporter());
            prover.Pop();

            if (outcome == ProverInterface.Outcome.Valid)
                return true;
            return false;
        }

        private static VCExpr ToVcExpr(Expr expr, Dictionary<string, VCExpr> incarnations, VCExpressionGenerator gen)
        {
            if (expr is LiteralExpr)
            {
                var val = (expr as LiteralExpr).Val;
                if (val is bool)
                {
                    if ((bool)val)
                    {
                        return VCExpressionGenerator.True;
                    }
                    else
                    {
                        return VCExpressionGenerator.False;
                    }
                }
                else if (val is Microsoft.Basetypes.BigNum)
                {
                    return gen.Integer((Microsoft.Basetypes.BigNum)val);
                }

                throw new NotImplementedException("Cannot handle literals of this type");
            }

            if (expr is IdentifierExpr)
            {
                return ToVcVar((expr as IdentifierExpr).Name, incarnations, false);
            }

            if (expr is OldExpr)
            {
                var ide = (expr as OldExpr).Expr as IdentifierExpr;
                Debug.Assert(ide != null);

                return ToVcVar(ide.Name, incarnations, true);
            }

            if (expr is NAryExpr)
            {
                var nary = expr as NAryExpr;
                if (nary.Fun is UnaryOperator)
                {
                    if ((nary.Fun as UnaryOperator).Op == UnaryOperator.Opcode.Not)
                        return gen.Not(ToVcExpr(nary.Args[0], incarnations, gen));
                    else if ((nary.Fun as UnaryOperator).Op == UnaryOperator.Opcode.Neg)
                        return gen.Function(VCExpressionGenerator.SubIOp, gen.Integer(Microsoft.Basetypes.BigNum.FromInt(0)), ToVcExpr(nary.Args[0], incarnations, gen));
                    else
                        Debug.Assert(false, "No other unary op is handled");
                }
                if (nary.Fun is BinaryOperator)
                {
                    return gen.Function(Translate(nary.Fun as BinaryOperator), ToVcExpr(nary.Args[0], incarnations, gen), ToVcExpr(nary.Args[1], incarnations, gen));
                }
                if (nary.Fun is MapSelect && nary.Args.Count == 2)
                {
                    return gen.Select(ToVcExpr(nary.Args[0], incarnations, gen), ToVcExpr(nary.Args[1], incarnations, gen));
                }
                Debug.Assert(false, "No other op is handled");
            }
            throw new NotImplementedException(string.Format("Expr of type {0} is not handled", expr.GetType().ToString()));
        }

        private static VCExpr ToVcVar(string v, Dictionary<string, VCExpr> incarnations, bool tryOld)
        {
            if (tryOld)
            {
                var oldv = string.Format("old({0})", v);
                if (incarnations.ContainsKey(oldv))
                {
                    return incarnations[oldv];
                }
                throw new Exception("Cannot handle this case");
            }

            if (incarnations.ContainsKey(v))
            {
                return incarnations[v];
            }

            throw new Exception("Cannot handle this case");
        }

        private static VCExprOp Translate(BinaryOperator op)
        {
            switch (op.Op)
            {
                case BinaryOperator.Opcode.Add:
                    return VCExpressionGenerator.AddIOp;
                case BinaryOperator.Opcode.Sub:
                    return VCExpressionGenerator.SubIOp;
                case BinaryOperator.Opcode.Mul:
                    return VCExpressionGenerator.MulIOp;
                case BinaryOperator.Opcode.Div:
                    return VCExpressionGenerator.DivIOp;
                case BinaryOperator.Opcode.Mod:
                    return VCExpressionGenerator.ModOp;
                case BinaryOperator.Opcode.Eq:
                case BinaryOperator.Opcode.Iff:
                    // we don't distinguish between equality and equivalence at this point
                    return VCExpressionGenerator.EqOp;
                case BinaryOperator.Opcode.Neq:
                    return VCExpressionGenerator.NeqOp;
                case BinaryOperator.Opcode.Lt:
                    return VCExpressionGenerator.LtOp;
                case BinaryOperator.Opcode.Le:
                    return VCExpressionGenerator.LeOp;
                case BinaryOperator.Opcode.Ge:
                    return VCExpressionGenerator.GeOp;
                case BinaryOperator.Opcode.Gt:
                    return VCExpressionGenerator.GtOp;
                case BinaryOperator.Opcode.Imp:
                    return VCExpressionGenerator.ImpliesOp;
                case BinaryOperator.Opcode.And:
                    return VCExpressionGenerator.AndOp;
                case BinaryOperator.Opcode.Or:
                    return VCExpressionGenerator.OrOp;
                case BinaryOperator.Opcode.Subtype:
                    return VCExpressionGenerator.SubtypeOp;
                default:
                    Debug.Assert(false);
                    throw new NotImplementedException();
            }
        }

    }

    [Serializable]
    public class StubAnnotatedSummaryDictionary
    {
        // (mustmod, stubs, predicate)
        private List<Tuple<string, string, string>> table;

        // (mustmod, stubs, predicate)
        [NonSerialized]
        private HashSet<Tuple<string, string, string>> map;

        // A Z3 prover for inferring annotations on predicates
        [NonSerialized]
        private static ProverInterface prover = null;

        [NonSerialized]
        private static readonly bool TrustAnnotations = false;

        public StubAnnotatedSummaryDictionary()
        {
            table = new List<Tuple<string, string, string>>();
            map = new HashSet<Tuple<string, string, string>>();
        }

        public static StubAnnotatedSummaryDictionary Merge(IEnumerable<StubAnnotatedSummaryDictionary> dbs)
        {
            Debug.Assert(!Driver.useStubs, "stubs annotation net yet supported");
            
            var ret = new StubAnnotatedSummaryDictionary();
            var preds = new HashSet<string>();
            foreach (var db in dbs)
            {
                foreach (var tup in db.table)
                {
                    if (preds.Contains(tup.Item3))
                        continue;
                    preds.Add(tup.Item3);
                    ret.table.Add(tup);
                }
            }
            return ret;
        }

        public void Update(string stubs, string predicate)
        {
            // Intersect stubs in the database with the new stubs as the argument.
            var tuple = map.FirstOrDefault(tup => tup.Item3 == predicate);
            var finalStubs = stubs;
            if (tuple != null)
            {
                if (!string.IsNullOrEmpty(tuple.Item2))
                {
                    var oldStubs = tuple.Item2.Substring("{:stubs \"[".Count(), tuple.Item2.Count() - "{:stubs \"[]\"}".Count());
                    var newStubs = stubs.Substring("{:stubs \"[".Count(), stubs.Count() - "{:stubs \"[]\"}".Count());
                    var oldStubSet = new HashSet<string>(oldStubs.Split(','));
                    var newStubSet = new HashSet<string>(newStubs.Split(','));
                    var finalStubSet = newStubSet.Intersection(oldStubSet);
                    finalStubs = "{:stubs \"[" + string.Join(",", finalStubSet) + "]\"}";
                }
            }

            // drop the predicate, if it exists (for recomputing the annotation)
            map.RemoveWhere(tup => tup.Item3 == predicate);

            Debug.Assert(prover != null);
            var annotations = FindAnnotations(predicate);
            map.Add(Tuple.Create(annotations, finalStubs, predicate));
        }

        public void Add(string stubs, string predicate)
        {

            // drop the predicate, if it exists (for recomputing the annotation)
            map.RemoveWhere(tup => tup.Item3 == predicate);

            Debug.Assert(prover != null);
            var annotations = FindAnnotations(predicate);
            map.Add(Tuple.Create(annotations, stubs, predicate));
        }

        public static StubAnnotatedSummaryDictionary GetDictionary(object summaries)
        {
            Debug.Assert(summaries is StubAnnotatedSummaryDictionary);
            return (summaries as StubAnnotatedSummaryDictionary);
        }

        // map -> table
        public void Marshall()
        {
            table = new List<Tuple<string, string, string>>();
            map.Iter(tup => table.Add(tup));
        }

        // table -> map
        public void DeMarshall(string z3exe)
        {
            map = new HashSet<Tuple<string, string, string>>();
            if (TrustAnnotations)
            {
                table.Iter(s => map = new HashSet<Tuple<string, string, string>>());
                table.Iter(s => map.Add(Tuple.Create(s.Item1, s.Item2, s.Item3)));
            }
            else
            {
                CreateProver(z3exe);
                table.Iter(s => Add(s.Item2, s.Item3));
                CloseProver();
            }
        }

        public void Print(string file)
        {
            var fs = new System.IO.StreamWriter(file);
            foreach (var s in table)
            {
                if (s.Item2 == "")
                    fs.WriteLine("  {0} {1}", s.Item1, s.Item3);
                else
                    fs.WriteLine("  {0} {1} {2}", s.Item1, s.Item2, s.Item3);
            }
            fs.Close();
        }

        public string DumpPredicates(out int NumPreds)
        {
            string ret = "";
            NumPreds = 0;

            if (Driver.useStubs)
                map.Iter(s => ret = ret + Environment.NewLine + "ensures " + s.Item1 + " " + s.Item2 + " " + s.Item3 + ";");
            else
                map.Iter(s => ret = ret + Environment.NewLine + "ensures " + s.Item1 + " " + s.Item3 + ";");
            NumPreds = map.Count;
            return ret;
        }

        public static Expr ToExpr(string str)
        {
            Program program;

            // parse str as an unresolved expr
            var programText = string.Format("procedure foo(); ensures {0};", str);
            Parser.Parse(programText, "dummy.bpl", out program);

            // get variables
            var gv = (new GatherVariables());
            gv.Visit(program);
            foreach (var v in gv.variables)
            {
                programText += Environment.NewLine + string.Format("var {0}: int;", v);
            }

            // try parsing again
            Parser.Parse(programText, "dummy.bpl", out program);
            // resolve
            program.Resolve();

            return program.TopLevelDeclarations.OfType<Procedure>()
                .First().Ensures.First().Condition;
        }

        public static void CreateProver(string z3exe)
        {
            CommandLineOptions.Clo.Z3ExecutablePath = z3exe;
            CommandLineOptions.Clo.ApplyDefaultOptions();
            CommandLineOptions.Clo.StratifiedInlining = 1;
            prover = ProverInterface.CreateProver(new Program(), "log", CommandLineOptions.Clo.SimplifyLogFileAppend, -1);
        }

        public static void CloseProver()
        {
            prover.Close();
            CommandLineOptions.Clo.TheProverFactory.Close();
            prover = null;
        }

        public static string FindAnnotations(string predicate)
        {
            var expr = ToExpr(predicate);
            var ret = "";

            // Get variables used in the expr
            var variables = new HashSet<Variable>();
            var vu = new GatherNonOldVariables();
            vu.VisitExpr(expr);

            foreach (var v in vu.variables)
            {
                ret += string.Format(" {{:mustmod \"{0}\" }}", v);
            }

            return ret;
        }

        // deprecated
        public static string FindAnnotationsOld(string predicate)
        {
            var expr = ToExpr(predicate);
            var ret = "";

            // Get variables used in the expr
            var variables = new HashSet<Variable>();
            var vu = new VarsUsed();
            vu.VisitExpr(expr);
            variables = vu.Vars;

            // yogi_error variable present?
            var err = variables.Where(v => v.Name == "yogi_error").FirstOrDefault();
            Expr pre = Expr.True;
            if (err != null)
                pre = Expr.Eq(new OldExpr(Token.NoToken, Expr.Ident(err)), Expr.Literal(0));

            foreach (var v in variables)
            {
                Expr nmod = Expr.Eq(new OldExpr(Token.NoToken, Expr.Ident(v)), Expr.Ident(v));
                nmod = Expr.And(nmod, pre);
                var check = Expr.And(nmod, Expr.Not(expr));
                if (CheckIfUnsat(check))
                {
                    ret += string.Format(" {{:mustmod \"{0}\" }}", v);
                    continue;
                }
                if (err != null && v.Name == err.Name)
                    continue;

                var rand = new System.Random();
                var rvalues = new HashSet<int>();
                for (int i = 0; i < 3; i++) rvalues.Add(rand.Next(0, 10));
                for (int i = 0; i < 3; i++) rvalues.Add(rand.Next(-10, 0));

                foreach (var val in rvalues)
                {
                    //Console.WriteLine("Trying {0}", val);
                    check = Expr.And(nmod, Expr.Eq(new OldExpr(Token.NoToken, Expr.Ident(v)), Expr.Literal(val)));
                    check = Expr.And(check, expr);
                    if (CheckIfUnsat(check))
                    {
                        ret += string.Format(" {{:mustmod \"{0}\" }}", v);
                        break;
                    }

                }
            }

            return ret;
        }

        // Is a UNSAT?
        private static bool CheckIfUnsat(Expr a)
        {
            var gen = prover.VCExprGen;
            var gatherLitA = new GatherLiterals();
            gatherLitA.Visit(a);

            // Create fresh variables
            var counter = 0;
            var incarnations = new Dictionary<string, VCExpr>();
            foreach (var literal in gatherLitA.literals)
            {
                if (incarnations.ContainsKey(literal.Item2.ToString()))
                    continue;

                //if(!literal.Item1.TypedIdent.Type.IsInt && !literal.Item1.TypedIdent.Type.IsBool)
                var v = gen.Variable("UNSATCheck" + counter, literal.Item1.TypedIdent.Type);
                incarnations.Add(literal.Item2.ToString(), v);
                counter++;
            }

            var vc1 = ToVcExpr(a, incarnations, gen);
            var vc = gen.LabelPos("Temp", vc1);

            // check
            prover.AssertAxioms();
            prover.Push();
            prover.Assert(vc, true);
            prover.Check();
            var outcome = prover.CheckOutcomeCore(new DummyErrorReporter());
            prover.Pop();

            if (outcome == ProverInterface.Outcome.Valid)
                return true;
            return false;
        }

        private static VCExpr ToVcExpr(Expr expr, Dictionary<string, VCExpr> incarnations, VCExpressionGenerator gen)
        {
            if (expr is LiteralExpr)
            {
                var val = (expr as LiteralExpr).Val;
                if (val is bool)
                {
                    if ((bool)val)
                    {
                        return VCExpressionGenerator.True;
                    }
                    else
                    {
                        return VCExpressionGenerator.False;
                    }
                }
                else if (val is Microsoft.Basetypes.BigNum)
                {
                    return gen.Integer((Microsoft.Basetypes.BigNum)val);
                }

                throw new NotImplementedException("Cannot handle literals of this type");
            }

            if (expr is IdentifierExpr)
            {
                return ToVcVar((expr as IdentifierExpr).Name, incarnations, false);
            }

            if (expr is OldExpr)
            {
                var ide = (expr as OldExpr).Expr as IdentifierExpr;
                Debug.Assert(ide != null);

                return ToVcVar(ide.Name, incarnations, true);
            }

            if (expr is NAryExpr)
            {
                var nary = expr as NAryExpr;
                if (nary.Fun is UnaryOperator)
                {
                    if ((nary.Fun as UnaryOperator).Op == UnaryOperator.Opcode.Not)
                        return gen.Not(ToVcExpr(nary.Args[0], incarnations, gen));
                    else if ((nary.Fun as UnaryOperator).Op == UnaryOperator.Opcode.Neg)
                        return gen.Function(VCExpressionGenerator.SubIOp, gen.Integer(Microsoft.Basetypes.BigNum.FromInt(0)), ToVcExpr(nary.Args[0], incarnations, gen));
                    else
                        Debug.Assert(false, "No other unary op is handled");
                }
                if (nary.Fun is BinaryOperator)
                {
                    return gen.Function(Translate(nary.Fun as BinaryOperator), ToVcExpr(nary.Args[0], incarnations, gen), ToVcExpr(nary.Args[1], incarnations, gen));
                }
                if (nary.Fun is MapSelect && nary.Args.Count == 2)
                {
                    return gen.Select(ToVcExpr(nary.Args[0], incarnations, gen), ToVcExpr(nary.Args[1], incarnations, gen));
                }
                Debug.Assert(false, "No other op is handled");
            }
            throw new NotImplementedException(string.Format("Expr of type {0} is not handled", expr.GetType().ToString()));
        }

        private static VCExpr ToVcVar(string v, Dictionary<string, VCExpr> incarnations, bool tryOld)
        {
            if (tryOld)
            {
                var oldv = string.Format("old({0})", v);
                if (incarnations.ContainsKey(oldv))
                {
                    return incarnations[oldv];
                }
                throw new Exception("Cannot handle this case");
            }

            if (incarnations.ContainsKey(v))
            {
                return incarnations[v];
            }

            throw new Exception("Cannot handle this case");
        }

        private static VCExprOp Translate(BinaryOperator op)
        {
            switch (op.Op)
            {
                case BinaryOperator.Opcode.Add:
                    return VCExpressionGenerator.AddIOp;
                case BinaryOperator.Opcode.Sub:
                    return VCExpressionGenerator.SubIOp;
                case BinaryOperator.Opcode.Mul:
                    return VCExpressionGenerator.MulIOp;
                case BinaryOperator.Opcode.Div:
                    return VCExpressionGenerator.DivIOp;
                case BinaryOperator.Opcode.Mod:
                    return VCExpressionGenerator.ModOp;
                case BinaryOperator.Opcode.Eq:
                case BinaryOperator.Opcode.Iff:
                    // we don't distinguish between equality and equivalence at this point
                    return VCExpressionGenerator.EqOp;
                case BinaryOperator.Opcode.Neq:
                    return VCExpressionGenerator.NeqOp;
                case BinaryOperator.Opcode.Lt:
                    return VCExpressionGenerator.LtOp;
                case BinaryOperator.Opcode.Le:
                    return VCExpressionGenerator.LeOp;
                case BinaryOperator.Opcode.Ge:
                    return VCExpressionGenerator.GeOp;
                case BinaryOperator.Opcode.Gt:
                    return VCExpressionGenerator.GtOp;
                case BinaryOperator.Opcode.Imp:
                    return VCExpressionGenerator.ImpliesOp;
                case BinaryOperator.Opcode.And:
                    return VCExpressionGenerator.AndOp;
                case BinaryOperator.Opcode.Or:
                    return VCExpressionGenerator.OrOp;
                case BinaryOperator.Opcode.Subtype:
                    return VCExpressionGenerator.SubtypeOp;
                default:
                    Debug.Assert(false);
                    throw new NotImplementedException();
            }
        }
    }

    [Serializable]
    public class AtomDictionary
    {
        // A table of annotated atoms 
        public List<string> table;

        public AtomDictionary()
        {
            table = new List<string>();
        }

        public void Add(string annotation, Expr atom)
        {
            var str = string.Format("{0} {1}", annotation == null ? "" : annotation.ToString(), atom);
            if (table.Contains(str)) return;
            table.Add(str);
        }

        public static AtomDictionary Merge(IEnumerable<AtomDictionary> atoms)
        {
            var ret = new HashSet<string>();
            atoms.Iter(atom => ret.UnionWith(atom.table));
            var merged = new AtomDictionary();
            merged.table.AddRange(ret);
            return merged;
        }

        public void Print(string file)
        {
            var fs = new System.IO.StreamWriter(file);
            foreach (var atom in table)
            {
                fs.WriteLine("{0}", atom);
            }
            fs.Close();
        }

        public string DumpPredicates(out int NumAtoms)
        {
            string ret = "";
            table.Iter(atom => ret = ret + Environment.NewLine + " ensures " + atom + ";");

            NumAtoms = table.Count;
            return ret;
        }
    }


}
