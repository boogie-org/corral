# ASE'16 Supplemental Material

The file `InferredTemplates.xlsx` contains all templates inferred for various rules that we experimented with in the paper. It is instructive to first get a local copy of SDV:
- Download and install [Windows 10 WDK](https://msdn.microsoft.com/en-us/library/windows/hardware/ff557573(v=vs.85).aspx)
- Navigate to the folder `c:\Program Files (x86)\Windows Kits\10\Tools\sdv`
- The file `osmodel\wdm\osmodel.c` is a model of the WDM driver interface. It contains stubs for various routines called by WDM drivers.
- The properties, or rules, can be found in the folder `rules\wdm`

How to read the file `InferredTemplates.xlsx`:
- Shared Vocabulary: variables defined in the SLIC file (model variables of the rule) or in `osmodel.c`. 
- Generic variables are prefixed with `v_fin_int`, `v_fout_int`, `v_loop_int`. Variables prefixed with `v_fin_int` are of type `FormalIn` (see section 2 of the paper). Variables prefixed with `v_fout_int` are of type `FormalOut` and variables prefixed with `v_loop_int` are of type `Local`. 
- The variable `yogi_error` encodes the `ok` bit. It is of type `int`. The postcondition `yogi_error == 0` implies that no assertion has failed in the procedure. 
- The tag `{:loop}` identifies loop invariants. The tag has no semantic meaning.
- Inferred annotations that contain a generic variable are colored red.
- Inferred annotations that contain multiple model variables (not counting `yogi_error`) and no generic variable are colored green.
- The presence of "red" and "green" is what gives the inferred annotations power beyond the manual templates.

