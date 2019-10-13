const inputFileName = 'input.txt';
const outputFileName = 'output.txt';

const generatedArraySize = 100;
const separatorsArraySize = 2;

type stringArrayType = array [1..generatedArraySize] of string;
type separatorsType = array [1..separatorsArraySize] of string;
type integerArrayType = array [1..generatedArraySize] of integer;

Type sizedIntegerArrayType = record
  arr: integerArrayType;
  size: integer;
end;

Type sizedStringArrayType = record
  arr: stringArrayType;
  size: integer;
end;
 
function concatArrays(arr1: sizedIntegerArrayType; arr2: sizedIntegerArrayType): sizedIntegerArrayType;
begin
  var concatedArray: sizedIntegerArrayType;
  concatedArray.size := 0;

  for var index := 1 to arr1.size do
  begin
    concatedArray.size := concatedArray.size + 1;
    concatedArray.arr[concatedArray.size] := arr1.arr[index];
  end;

  for var index := 1 to arr2.size do
  begin
    concatedArray.size := concatedArray.size + 1;
    concatedArray.arr[concatedArray.size] := arr2.arr[index];
  end;

  Result := concatedArray;
end; 

function oneOfSeparators(symbol: string; separators: separatorsType): boolean;
begin
  for var index := 1 to separatorsArraySize do
  begin
    if symbol = separators[index] then
    begin
      Result := true;
    end;
  end;
end;

function isWordSeparator(sympol: string): boolean;
begin
  var separators: separatorsType = (' ', ',');

  Result := oneOfSeparators(sympol, separators);
end;

var arrayLength: integer := 0;

procedure push(var stringArray: stringArrayType; var currentArrayIndex: integer; var tempWord: string);
begin
  stringArray[currentArrayIndex] := tempWord;
  currentArrayIndex := currentArrayIndex + 1;
end;

function splitString(text: string): sizedStringArrayType;
begin
  var stringArray: stringArrayType;
  var currentArrayIndex: integer := 1;

  var tempWord: string := '';

  for var index := 1 to text.Length do
  begin
    var wordSeparator: boolean := isWordSeparator(text[index]);
    if wordSeparator = true then
    begin
      if tempWord = '' then
      begin
        tempWord := '';
        continue;
      end;

      push(stringArray, currentArrayIndex, tempWord);
      arrayLength := currentArrayIndex - 1; 
      tempWord := '';
    end
    else
    begin
      tempWord := tempWord + text[index];
    end;
  end;
  
  var wordSeparator: boolean := isWordSeparator(text[text.Length]);
  if wordSeparator = false then
  begin
    push(stringArray, currentArrayIndex, tempWord);
    arrayLength := currentArrayIndex - 1; 
  end;

  var sizedStringArray: sizedStringArrayType;
  sizedStringArray.arr := stringArray;
  sizedStringArray.size := currentArrayIndex - 1;

  Result := sizedStringArray;
end;

procedure viewArray(generatedArray: sizedIntegerArrayType);
begin
  write('[');
  for var index := 1 to generatedArray.size - 1 do
  begin
    write(generatedArray.arr[index] + ', ');
  end;
  writeln(generatedArray.arr[generatedArray.size] + ']');
end;

function arrayToNumber(stringArray: sizedStringArrayType): sizedIntegerArrayType;
begin
  var integerArray: sizedIntegerArrayType;
  integerArray.size := stringArray.size;
  
  for var index := 1 to generatedArraySize do
  begin
    if stringArray.arr[index] <> '' then
    begin
      integerArray.arr[index] := stringArray.arr[index].ToInteger();
    end;
  end;
  
  Result := integerArray;
end;

function getEvenNumbers(sizedArr: sizedIntegerArrayType): sizedIntegerArrayType;
begin
  var evenNumbers: sizedIntegerArrayType;
  evenNumbers.size := 0;

  for var index := 1 to sizedArr.size do
  begin
    if sizedArr.arr[index] mod 2 = 0 then
    begin
      evenNumbers.size := evenNumbers.size + 1;
      evenNumbers.arr[evenNumbers.size] := sizedArr.arr[index];
    end;
  end;
  
  Result := evenNumbers;
end;

function getDevidableOnThreeNoSeven(sizedArr: sizedIntegerArrayType): sizedIntegerArrayType;
begin
  var devidableNumbers: sizedIntegerArrayType;
  devidableNumbers.size := 0;

  for var index := 1 to sizedArr.size do
  begin
    if (sizedArr.arr[index] mod 3 = 0) and (sizedArr.arr[index] mod 7 <> 0) then
    begin
      devidableNumbers.size := devidableNumbers.size + 1;
      devidableNumbers.arr[devidableNumbers.size] := sizedArr.arr[index];
    end;
  end;
  
  Result := devidableNumbers;
end;

function getExactSquare(sizedArr: sizedIntegerArrayType): sizedIntegerArrayType;
begin
  var exactSquareNumbers: sizedIntegerArrayType;
  exactSquareNumbers.size := 0;

  for var index := 1 to sizedArr.size do
  begin
    var roundedValue: integer := Round(Sqrt(sizedArr.arr[index]));
    if roundedValue * roundedValue = sizedArr.arr[index] then
    begin
      exactSquareNumbers.size := exactSquareNumbers.size + 1;
      exactSquareNumbers.arr[exactSquareNumbers.size] := sizedArr.arr[index];
    end;
  end;

  Result := exactSquareNumbers;
end;

procedure writeToFile(outputFile: TextFile; sizedArr: sizedIntegerArrayType);
begin
  for var index := 1 to sizedArr.size - 1 do
  begin
    write(outputFile, sizedArr.arr[index] + ', ');
  end;
  writeln(outputFile, sizedArr.arr[sizedArr.size]);
end;

begin
  var inputFile: TextFile;
  var outputFile: TextFile;

  AssignFile(inputFile, inputFileName);
  AssignFile(outputFile, outputFileName);
  
  var fileText: string;

  var allNumbers: sizedIntegerArrayType;

  reset(inputFile);
  while not eof(inputFile) do
  begin
    readln(inputFile, fileText);
    var splittedText: sizedStringArrayType := splitString(fileText);
    allNumbers := concatArrays(allNumbers, arrayToNumber(splittedText));
  end;
  
  viewArray(allNumbers);

  var evenNumbers: sizedIntegerArrayType := getEvenNumbers(allNumbers);
  viewArray(evenNumbers);

  var devidableNumbers: sizedIntegerArrayType := getDevidableOnThreeNoSeven(allNumbers);
  viewArray(devidableNumbers);

  var exactSquareNumbers: sizedIntegerArrayType := getExactSquare(allNumbers);
  viewArray(exactSquareNumbers);

  rewrite(outputFile);

  write(outputFile, 'All numbers: ');
  writeToFile(outputFile, allNumbers);

  write(outputFile, 'Even numbers: ');
  writeToFile(outputFile, evenNumbers);

  write(outputFile, 'Devidable numbers: ');
  writeToFile(outputFile, devidableNumbers);

  write(outputFile, 'Exact square numbers: ');
  writeToFile(outputFile, exactSquareNumbers);
  
  CloseFile(inputFile);
  CloseFile(outputFile);
end.
