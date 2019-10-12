var firstNumber: integer;
var secondNumber: integer;

var firstTransformedNumber: real;
var secondTransformedNumber: real;

begin
  write('Enter the first number: ');
  readln(firstNumber);
  
  write('Enter the second number: ');
  readln(secondNumber);

  writeln();
  
  firstTransformedNumber := firstNumber;
  secondTransformedNumber := secondNumber;
  
  if firstNumber < secondNumber then
  begin
    firstTransformedNumber := (firstNumber + secondNumber) / 2;
    secondTransformedNumber := firstNumber * secondNumber * 2;
  end;
  
  if firstNumber > secondNumber then
  begin
    secondTransformedNumber := (firstNumber + secondNumber) / 2;
    firstTransformedNumber := firstNumber * secondNumber * 2;
  end;
  
  writeln('Resulting numbers:');
  writeln('The first number: ', firstTransformedNumber);
  writeln('The second number: ', secondTransformedNumber);
end.
