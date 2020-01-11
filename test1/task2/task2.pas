const inputFileName = 'input.dat';
const outputFileName = 'output.dat';

const numbersCount = 64;

const generatedArraySize = numbersCount;
const partArraySize = 16;

const resultingArraySize = generatedArraySize div 16 + 1;

type integerArrayType = array [1..generatedArraySize] of integer;
type sixteenArrayType = array [1..partArraySize] of integer;

type resultingArrayType = array [1..generatedArraySize] of sixteenArrayType;

procedure generateFile();
begin
  var inputFile: file of integer;
  Assign(inputFile, inputFileName);
  Rewrite(inputFile);
  
  for var index := 1 to numbersCount do
  begin
    write(inputFile, random(100));
  end;
  
  Close(inputFile);
end;

function getDataInFile(currentFile: file of integer): integerArrayType;
begin
  reset(currentFile);
  
  var index: integer := 1;
  var data: integerArrayType;
  while not EOF(currentFile) do
  begin
    var number: integer;
    read(currentFile, number);
    data[index] := number;
    index := index + 1;
  end;
  
  Result := data;
end;

function divideData(data: integerArrayType): resultingArrayType;
begin
  var dividedData: resultingArrayType;
  var sixteenArray :sixteenArrayType;
  
  var dividedDataIndex: integer := 1;
  
  for var index: integer := 1 to generatedArraySize do
  begin
    if index mod 16 = 0 then
    begin
      sixteenArray[16] := data[index];
      dividedData[dividedDataIndex] := sixteenArray;
      dividedDataIndex := dividedDataIndex + 1;
    end
    else
    begin  
      sixteenArray[index mod 16] := data[index];
    end;
  end;
  
  Result := dividedData;
end;

procedure writeDataToFile(outputFile: file of sixteenArrayType; data: resultingArrayType);
begin
  rewrite(outputFile);
  
  for var index := 1 to resultingArraySize do
  begin
    write(outputFile, data[index]);
  end;
end;

procedure viewDividedData(dividedData: resultingArrayType);
begin
  write('[');
  for var index: integer := 1 to resultingArraySize - 2 do
  begin
    write(dividedData[index]);
    write(', ');
  end;
  write(dividedData[resultingArraySize - 1]);
  write(']');
end;

begin
  generateFile();
  
  var inputFile: file of integer;
  var outputFile: file of sixteenArrayType;

  Assign(inputFile, inputFileName);
  Assign(outputFile, outputFileName);
  
  var data: integerArrayType := getDataInFile(inputFile);
  writeln('Data: ');
  writeln(data);
  writeln();
  
  var dividedData: resultingArrayType := divideData(data);
  writeln('Divided data: ');
  viewDividedData(dividedData);
  
  writeDataToFile(outputFile, dividedData);
  
  Close(inputFile);
  Close(outputFile);
end.
