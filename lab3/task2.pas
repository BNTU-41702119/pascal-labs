function calculate(value: integer): real;
begin
  Result := 1 + 1 / (value * value);
end;

var inputValue: integer;

var result: real;

begin
  write('Enter please ending index: ');
  readln(inputValue);
  
  result := 0;
  
  if inputValue > 0 then
  begin
    for var index := 1 to inputValue do
    begin
      result := result + calculate(index);
    end;
    
    write('Result: ', result);
  end
  else
  begin
    writeln('Bad inputed value!');
  end;
end.
