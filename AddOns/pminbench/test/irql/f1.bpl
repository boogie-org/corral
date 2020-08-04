// DRIVER
procedure {:entrypoint} main() {
   var loc: int;
   call init();
   call loc := KeRaiseIrql(2);
   while(*)    {
     call KeLowerIrql(loc);
     call do_work_at_low_irql();
     call loc := KeRaiseIrql(2);
   }
   call KeLowerIrql(loc); 
}

// RULE
procedure do_work_at_low_irql() 
{  assert sdv_irql_current == 0; }

// OS MODEL and RULE
var sdv_irql_current: int;

procedure init()
{  sdv_irql_current := 0; }

procedure KeRaiseIrql(new_irql: int) 
  returns (old_irql: int) {
   old_irql := sdv_irql_current;
   sdv_irql_current := new_irql;
}

procedure KeLowerIrql(new_irql: int) 
{  sdv_irql_current := new_irql; }
