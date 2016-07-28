# Proof Minimization

[Proof Minimization](https://github.com/boogie-org/corral/blob/master/AddOns/ProofMinimization) is a tool that takes a set of program proofs as input and returns a miniamal set of annotations sufficient for proving correctness of each input program. The algorithm is described in our ASE'16 paper cited below.

[PMinBench](https://github.com/boogie-org/corral/tree/master/AddOns/pminbench) is a wrapper utility around ProofMinimzation. It expects a set of Boogie programs as input. It will run [Duality](https://www.microsoft.com/en-us/research/project/duality) on them to spit out the proof of correctness. Next, it runs ProofMinimization on these proofs and prints the minimal template (a list of abstract annotations) on the console. 

To build, first build [Corral](https://github.com/boogie-org/corral) then open and build `pminbench.sln`.

To run, for example:

`Binaries\pminbench.exe spinlockrelease\*.bpl`

This should print something like:
```
    0 != old(depth) || assertsPassed
    0 - 1 + old(depth) == depth
    1 + old(depth) == depth
    depth == old(depth)
```
Note:
- The programs in `spinlockrelease\*.bpl` are based on Fig.2 of the ASE'16 paper.
- The `ok` bit is called `assertsPassed`.
- You may observe slightly different answers on your machine. This is because Duality can produce different proofs on
  different machines.
- After running the above command, one can inspect the duality proofs by looking at the files in the folder `proofbench`. The ensure clauses are the postconditions produced by Duality.
- Directly run `ProofMinimization` as `Binaries\ProofMinimization.exe proofbench\*.bpl /perf` and look for `Additional contract required:` printed on console.

Directories `cancelspinlock`, `spinlock`, `irql` have other examples. The example in `irql` is the same as one in `Fig. 3` of the ASE'16 paper. One can see it returns the abstract annotation `old(v_loop_int_0) == v_loop_int_0`

Passing the additional flag `/inlineDepth:2`, e.g., `Binaries\pminbench.exe irql\*.bpl /inlineDepth:2` makes the output (inferred set of annotations) even smaller. This flag increases the precision of `Houdini`, hence even more annotations can be dropped.

## Publications

Inferring Annotations For Device Drivers From Verification Histories. Zvonimir Pavlinovic, Akash Lal, Rahul Sharma. In Proc: Automated Software Engineering (ASE) 2016 

## Supplemental material
