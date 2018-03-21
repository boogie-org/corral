# **InstrumentAVP**

This tool can be used to add references from an AVP file to PROP file.

**Description**

The AVP file contains rules which describe the transformation of one boogie file to another. One set of rules contain the list of statements that are instrumented for a particular procedure in the boogie file. When FastAVN generates a defect trace containing these statements, it is usually required to see and analyze these statements. But, when the defect trace is visualized using the DefectViewer, these statements will be missing since they are not part of any source file.

To address this, a PROP file containing the procedure and the instrumented statements is maintained. Then, a reference is added from each procedure rule in the AVP file to its corresponding entry in the PROP file using the InstrumentAVP tool. This will enable the DefectViewer to find these statements and display them.

**PROP file format:**

The PROP file contains definitions for each procedure in AVP file where the set of instrumented statements forms the procedure body. For example, PROP file entry for a procedure foo can be as follows:

```c
int foo (
  int x)
{
  assert irql_current == 0;
}
```

Similarly, procedure definitions are added for each procedure in the AVP file.

**Note:**

The first line of the procedure header should follow the following format:
`ReturnType ProcedureName (`

**AVP file format:**

The following statement can be used in the procedure rule to add a reference to an entry in the PROP file:
`assert {:name "ProcedureName"} true;`

This statement is added for each rule in the AVP file. If there is more than one definition for a procedure in the PROP file, the first one is used.

**InstrumentAVP Usage:**

After the AVP and the PROP file is ready, the following command can be used to run the tool:

`InstrumentAVP.exe checkirql.avp checkirql.prop`

This will generate the `checkirql-with-linenums.avp` which contains references in the form of source line annotations. This modified AVP file will be used by FastAVN.

