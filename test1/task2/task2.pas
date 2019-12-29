const inputFileName = 'input.txt';
const outputFileName = 'output.txt';

const generatedArraySize = 10000;
const separatorsArraySize = 1;

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
  var separators: separatorsType = (',');

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

type sixteenArrayType = array [1..16] of integer;
type resultingArrayType = array [1..10000] of sixteenArrayType;

var sixteenArray: sixteenArrayType;

Type sizedResultingArrayType = record
  arr: resultingArrayType;
  size: integer;
end;

procedure writeToFile(outputFile: TextFile; sizedArr: sizedResultingArrayType);
begin
  for var index := 1 to sizedArr.size - 1 do
  begin
    write(outputFile, sizedArr.arr[index]);
    write(outputFile, ', ');
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
  
  var sizedResultingArray: sizedResultingArrayType;
  sizedResultingArray.size := 1;
  for var index := 1 to allNumbers.size do
  begin
    if index mod 16 = 0 then
    begin
      sixteenArray[16] := allNumbers.arr[index];
      sizedResultingArray.arr[sizedResultingArray.size] := sixteenArray;
      sizedResultingArray.size := sizedResultingArray.size + 1;
    end
    else
    begin
      sixteenArray[index mod 16] := allNumbers.arr[index];
    end;
  end;
  sizedResultingArray.arr[sizedResultingArray.size] := sixteenArray;
  
  write('[');
  for var index: integer := 1 to sizedResultingArray.size - 1 do
  begin
    write(sizedResultingArray.arr[index]);
    write(', ');
  end;
  write(sizedResultingArray.arr[sizedResultingArray.size]);
  writeln(']');

  rewrite(outputFile);

  writeToFile(outputFile, sizedResultingArray);

  CloseFile(inputFile);
  CloseFile(outputFile);
end.
