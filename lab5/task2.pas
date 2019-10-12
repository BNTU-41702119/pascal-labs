const generatedArraySize = 100;
const separatorsArraySize = 7;

type stringArrayType = array [1..generatedArraySize] of string;
type separatorsType = array [1..separatorsArraySize] of string;

function enterText(): string;
begin
  var text: string := '';
  
  write('Enter text please: ');
  readln(text);
  
  Result := text;
end;

function oneOf(symbol: string; triggerSymbols: stringArrayType): boolean;
begin
  for var index := 1 to generatedArraySize do
  begin
    if symbol = triggerSymbols[index] then
    begin
      Result := true;
    end;
  end;
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
  var separators: separatorsType = (' ', ',', '.', ':', ';', '?', '!');
  
  Result := oneOfSeparators(sympol, separators);
end;

var arrayLength: integer := 0;

procedure push(var stringArray: stringArrayType; var currentArrayIndex: integer; var tempWord: string);
begin
  stringArray[currentArrayIndex] := tempWord;
  currentArrayIndex := currentArrayIndex + 1;
end;

function splitString(text: string): stringArrayType;
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
  
  Result := stringArray;
end;

procedure viewArray(generatedArray: stringArrayType);
begin
  write('[');
  for var index := 1 to arrayLength - 1 do
  begin
    write(generatedArray[index] + ', ');
  end;
  writeln(generatedArray[arrayLength] + ']');
end;

function countLiteralInWord(word: string; symbols: stringArrayType): integer;
begin
  var count: integer := 0;
  
  for var index := 1 to word.Length do
  begin
    if oneOf(word[index], symbols) then
    begin
      count := count + 1;
    end;
  end;
  
  Result := count;
end;

function countWordsThatStartsWith(words: stringArrayType; symbols: stringArrayType; length: integer): integer;
begin
  var count: integer := 0;
  
  for var index := 1 to length do
  begin
    if oneOf(words[index][1], symbols) then
    begin
      count := count + 1;
    end;
  end;
  
  Result := count;
end;

function countWordsWithStartingSameAsEnding(words: stringArrayType; length: integer): integer;
begin
  var count: integer := 0;
  
  for var index := 1 to length do
  begin
    var word: string := words[index];
    
    if word[1].ToLower() = word[word.Length].ToLower() then
    begin
      count := count + 1;
    end;
  end;
  
  Result := count;
end;

begin
  var text: string := 'Artem.Velera! Bush, Danik Aloha';
  
  var splittedText: stringArrayType := splitString(text);
  viewArray(splittedText);
  
  writeln('Count: ', arrayLength);
  
  var symbolTriggers1: stringArrayType;
  symbolTriggers1[1] := 'a';
  symbolTriggers1[2] := 'A';
  writeln('Number of "A" in the last word: ', countLiteralInWord(splittedText[arrayLength], symbolTriggers1));

  var symbolTriggers2: stringArrayType;
  symbolTriggers2[1] := 'b';
  symbolTriggers2[2] := 'B';
  writeln('Number of words that starts with "B": ', countWordsThatStartsWith(splittedText, symbolTriggers2, arrayLength));

  writeln('Number of words which starting symbol same as ending: ', countWordsWithStartingSameAsEnding(splittedText, arrayLength));
end.
