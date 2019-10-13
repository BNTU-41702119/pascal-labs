const firstNamesCount: integer = 10;
type firstNamesType = array [1..firstNamesCount] of string;
var firstNames: firstNamesType = ('Mike', 'Jack', 'Mini', 'Nelly', 'Casandra', 'Artem', 'Valera', 'Boosh', 'Lesly', 'Lilly');

const lastNamesCount: integer = 10;
type lastNamesType = array [1..lastNamesCount] of string;
var lastNames: lastNamesType = ('Johnson', 'Williams', 'Smith', 'Jones', 'Brown', 'Davis', 'Anderson', 'Wilson', 'Taylor', 'Moore');

const addressesCount: integer = 10;
type addressesType = array [1..addressesCount] of string;
var addresses: addressesType = ('Abby Park Street', 'Beatles Avenue', 'Communal Square', 'Dean Avenue', 'Galghard Road', 'Eastern Cesta', 'Impressionist Avenue', 'Highway Avenue', 'Pine Street', 'Venice Street ');

const examsCount: integer = 3;
type examsType = array [1..examsCount] of string;
var exams: examsType = ('Math', 'Pragramming', 'Language');

const minMark: integer = 1;
const maxMark: integer = 10;

Type examsSheetType = record
  maths: integer;
  programming: integer;
  language: integer;
end;

Type applicantsSheetType = record
  firstName: string;
  lastName: string;
  address: string;
  exams: examsSheetType;
end;

const applicantsSheetsCount: integer = 20;
type applicantsSheetsType = array [1..applicantsSheetsCount] of applicantsSheetType;

function getRandomFirstName(): string;
begin
  var randomFirstNameIndex: integer := Random(1, firstNamesCount);
  var randomFirstName: string := firstNames[randomFirstNameIndex];
  
  Result := randomFirstName;
end;

function getRandomLastName(): string;
begin
  var randomLastNameIndex: integer := Random(1, lastNamesCount);
  var randomLastName: string := lastNames[randomLastNameIndex];
  
  Result := randomLastName;
end;

function getRandomAddress(): string;
begin
  var randomAddressIndex: integer := Random(1, addressesCount);
  var randomAddress: string := addresses[randomAddressIndex];
  
  Result := randomAddress;
end;

function getRandomMark(): integer;
begin
  var randomMark: integer := Random(minMark, maxMark);
  
  Result := randomMark;
end;

function generateSheets(): applicantsSheetsType;
begin
  var applicantsSheets: applicantsSheetsType;

  for var index := 1 to applicantsSheetsCount do
  begin
    var randomFirstName: string := getRandomFirstName();
    var randomLastName: string := getRandomLastName();
    var randomAddress: string := getRandomAddress();
    var randomMathsMark: integer := getRandomMark();
    var randomProgrammingMark: integer := getRandomMark();
    var randomLanguageMark: integer := getRandomMark();
    
    with applicantsSheets[index] do
    begin
      firstName := randomFirstName;
      lastName := randomLastName;
      address := randomAddress;
      exams.maths := randomMathsMark;
      exams.programming := randomProgrammingMark;
      exams.language := randomLanguageMark;
    end;
  end;
  
  Result := applicantsSheets;
end;

Type filteredSheetsType = record
  sheets: applicantsSheetsType;
  size: integer;
end;

procedure pushToSheets(var sheets: filteredSheetsType; item: applicantsSheetType);
begin
  sheets.sheets[sheets.size + 1] := item;
  sheets.size := sheets.size + 1;
end;

function getAverageMark(exams: examsSheetType): real;
begin
  var examsAverage: real := (exams.maths + exams.programming + exams.language) / 3;
  
  Result := examsAverage;
end;

function filterSheets(sheets: applicantsSheetsType; size: integer; averageMark: real; lastNameStartingLetter: string): filteredSheetsType;
begin
  var filteredSheets: filteredSheetsType;
  filteredSheets.size := 0;
  
  for var index := 1 to size do
  begin
    var examsAverage: real := getAverageMark(sheets[index].exams);
    var isLastNameStartsWith: boolean := true;
    if lastNameStartingLetter <> '' then
    begin
      isLastNameStartsWith := sheets[index].lastName[1].ToLower() = lastNameStartingLetter.ToLower();
    end;

    if (examsAverage > averageMark) and (isLastNameStartsWith = true) then
    begin
      pushToSheets(filteredSheets, sheets[index]);
    end;
  end;
  
  Result := filteredSheets;
end;

procedure viewSheets(sheets: applicantsSheetsType; size: integer);
begin
  for var index := 1 to size do
  begin
    with sheets[index] do
    begin
      writeln('First name: ', firstName);
      writeln('Last name: ', lastName);
      writeln('Address: ', address);
      write('Exams: ');
      writeln('Maths: ', exams.maths);
      writeln('       Programming: ', exams.programming);
      writeln('       Language: ', exams.language);
    end;
    writeln;
  end;
end;

const averageMark = 6;
const lastNameStartingLetter = 'a';

begin
  var applicantsSheets: applicantsSheetsType := generateSheets();
  var filteredApplicantsSheets: filteredSheetsType := filterSheets(applicantsSheets, applicantsSheetsCount, averageMark, lastNameStartingLetter);

  writeln('All students');
  writeln;
  
  viewSheets(applicantsSheets, applicantsSheetsCount);

  writeln;
  writeln('---------------------------');
  writeln;

  writeln('Students with average mark: "', averageMark, '" and last names that starts with: "', lastNameStartingLetter, '"');
  writeln;
  writeln('Count: ', filteredApplicantsSheets.size);
  writeln;
  
  viewSheets(filteredApplicantsSheets.sheets, filteredApplicantsSheets.size);
end.
