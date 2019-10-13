uses angles;


begin
  write('Enter angle please: ');

  var angle: real;
  readln(angle);
  
  var ctg: real := getCtg(angle);
  write('Catangens of the angle "', angle, '" equal to ', ctg);
end.
