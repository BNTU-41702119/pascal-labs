type coordinateType = array [1..2] of real;

function enterCoordinate(): coordinateType;
begin
  var firstCoordinate: real := 0;
  var secondCoordinate: real := 0;
  
  write('First coordinate: ');
  readln(firstCoordinate);
  
  write('Second coordinate: ');
  readln(secondCoordinate);
  
  var coordinate: coordinateType := (firstCoordinate, secondCoordinate);
  Result := coordinate;
end;

function getRangeBetweenCoordinates(firstCoodrinate: coordinateType; secondCoodrinate: coordinateType): real;
begin
  var rangeBetweenCoordinates: real := sqrt(sqr(firstCoodrinate[2] - secondCoodrinate[2]) + sqr(firstCoodrinate[1] - secondCoodrinate[1]));
  
  Result := rangeBetweenCoordinates;
end;

function getPerimeter(ABLength: real; BCLength: real; CALength: real): real;
begin
  var perimeter: real := ABLength + BCLength + CALength;

  Result := perimeter;
end;

function getArea(ABLength: real; BCLength: real; CALength: real): real;
begin
  var perimeter: real := getPerimeter(ABLength, BCLength, CALength);
  var halfPerimeter: real := perimeter / 2;

  var area: real := sqrt(halfPerimeter * (halfPerimeter - ABLength) * (halfPerimeter - BCLength) * (halfPerimeter - CALength));

  Result := area;
end;

begin
  writeln('Enter coorditane A please');
  var coordinateA: coordinateType := enterCoordinate();
  writeln;

  writeln('Enter coorditane B please');
  var coordinateB: coordinateType := enterCoordinate();
  writeln;

  writeln('Enter coorditane C please');
  var coordinateC: coordinateType := enterCoordinate();
  writeln;

  var ABLength: real := getRangeBetweenCoordinates(coordinateA, coordinateB);
  var BCLength: real := getRangeBetweenCoordinates(coordinateB, coordinateC);
  var CALength: real := getRangeBetweenCoordinates(coordinateC, coordinateA);

  var perimeter: real := getPerimeter(ABLength, BCLength, CALength);
  
  var area: real := getArea(ABLength, BCLength, CALength);

  writeln('AB: ', ABLength);
  writeln('BC: ', BCLength);
  writeln('CA: ', CALength);
  writeln('Perimeter: ', perimeter);
  writeln('Area: ', area);
end.
