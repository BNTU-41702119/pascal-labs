var resistance1: integer;
var resistance2: integer;
var resistance3: integer;

var totalConnectionResistance: real;

begin
  write('Enter resistance R1: ');
  readln(resistance1);
  
  write('Enter resistance R2: ');
  readln(resistance2);
  
  write('Enter resistance R3: ');
  readln(resistance3);
  
  totalConnectionResistance := 1 / ((1 / resistance1) + (1 / resistance2) + (1 / resistance3));
  
  write('Total connection resistance: ', totalConnectionResistance);
end.