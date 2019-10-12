const generatedArraySize = 100;
const minRandomNumber = -9;
const maxRandomNumber = 9;

type integerArray = array [1..generatedArraySize] of integer;

function enterArraySize(): integer;
begin
  write('Enter please array size between 1 and 100: ');
  readln(Result);
end;

var arraySize: integer;

function generateRandomArray(): integerArray;
begin
  arraySize := enterArraySize();

  var generatedArray: integerArray;

  for var index := 1 to arraySize do
  begin
    generatedArray[index] := Random(minRandomNumber, maxRandomNumber);
  end;
  
  Result := generatedArray;
end;

function generateBasedOnUserPreferences(): integerArray;
begin
  arraySize := enterArraySize();

  var generatedArray: integerArray;

  for var index := 1 to arraySize do
  begin
    var arrayValue: integer;
    
    write('Enter please array value: ');
    readln(arrayValue);
    generatedArray[index] := arrayValue;
  end;
  
  Result := generatedArray;
end;

procedure viewGeneratedArray(generatedArray: integerArray);
begin
  write('[');
  for var index := 1 to arraySize - 1 do
  begin
    write(generatedArray[index] + ', ');
  end;
  writeln(generatedArray[arraySize] + ']');
end;

function calculateArraySum(generatedArray: integerArray): integer;
begin
  var sum: integer := 0;
  
  for var index := 1 to arraySize do
  begin
    sum := sum + generatedArray[index];
  end;
  
  Result := sum;
end;

function calculateAverage(value: integer; count: integer): real;
begin
  Result := value / count;
end;

function multiplyPositiveArrayNumbers(generatedArray: integerArray): integer;
begin
  var multipliedPositiveNumbersResult: integer := 1;
  var arrayHasPositive: boolean := false;
  
  for var index := 1 to arraySize do
  begin
    if generatedArray[index] > 0 then
    begin
      arrayHasPositive := true;
      multipliedPositiveNumbersResult := multipliedPositiveNumbersResult * generatedArray[index];
    end;
  end;
  
  if arrayHasPositive = false then
  begin
    multipliedPositiveNumbersResult := 0;
  end;
  
  Result := multipliedPositiveNumbersResult;
end;

var selectedOption: integer;

begin
  writeln('1. Generate random array;');
  writeln('2. Enter values by yourself.');
  write('Select please value generation option: ');
  readln(selectedOption);
  writeln;
  
  var generatedArray: integerArray;
  
  case selectedOption of
    1: generatedArray := generateRandomArray();
    2: generatedArray := generateBasedOnUserPreferences();
  end;
  
  write('Generated array: ');
  viewGeneratedArray(generatedArray);
  
  write('Sum of the array elements: ');
  var sum: integer := calculateArraySum(generatedArray);
  writeln(sum);
  
  write('Average of the array elements: ');
  var average: real := calculateAverage(sum, arraySize);
  writeln(average);
  
  write('Multiplied positive numbers of the array result: ');
  var multipliedPositiveNumbersResult: integer := multiplyPositiveArrayNumbers(generatedArray);
  writeln(multipliedPositiveNumbersResult);
end.
