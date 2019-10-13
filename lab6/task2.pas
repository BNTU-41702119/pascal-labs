const arraySize = 10;
const minRandomNumber = -9;
const maxRandomNumber = 9;

type integerArrayType = array [1..arraySize] of integer;

procedure viewArray(arr: integerArrayType; size: integer);
begin
  write('[');
  for var index := 1 to size - 1 do
  begin
    write(arr[index] + ', ');
  end;
  writeln(arr[size] + ']');
end;

function generateRandomArray(): integerArrayType;
begin
  var generatedArray: integerArrayType;

  for var index := 1 to arraySize do
  begin
    generatedArray[index] := Random(minRandomNumber, maxRandomNumber);
  end;
  
  Result := generatedArray;
end;

var filteredArraySize: integer := 0;

function getIncompatibleWithNatural(integerArray: integerArrayType; naturalNumber: integer): integerArrayType;
begin
  var filteredArray: integerArrayType;
  var currentIndex: integer := 0;

  for var index := 1 to arraySize do
  begin
    if integerArray[index] mod naturalNumber <> 0 then
    begin
      currentIndex := currentIndex + 1;
      filteredArray[currentIndex] := integerArray[index];
    end;
  end;
  
  filteredArraySize := currentIndex;
  Result := filteredArray;
end;

function sortArray(integerArray: integerArrayType; size: integer): integerArrayType;
begin
  var sortedArray: integerArrayType;

  for var index := 1 to size do
  begin
    sortedArray[index] := integerArray[index];
  end;

  for var i := 1 to size - 1 do
  begin
    for var j := 1 to size - i do
    begin
      if sortedArray[j] < sortedArray[j + 1] then
      begin
        var nextElement: integer := sortedArray[j + 1];
        var currentElement: integer := sortedArray[j];
        
        sortedArray[j + 1] := currentElement;
        sortedArray[j] := nextElement;
      end;
    end;
  end;

  Result := sortedArray;
end;

begin
  var naturalNumber: integer;
  write('Enter natural number: ');
  readln(naturalNumber);

  var generatedArray: integerArrayType := generateRandomArray();
  var filteredArray: integerArrayType := getIncompatibleWithNatural(generatedArray, naturalNumber);
  var sortedArray: integerArrayType := sortArray(filteredArray, filteredArraySize);

  write('Generated array: ');
  viewArray(generatedArray, arraySize);

  write('Filtered array: ');
  viewArray(filteredArray, filteredArraySize);
  
  write('Sorted array: ');
  viewArray(sortedArray, filteredArraySize);
end.
