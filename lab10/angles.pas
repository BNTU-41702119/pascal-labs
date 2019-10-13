unit angles;

interface
function getCtg(angle: real): real;

implementation
  function getCtg(angle: real): real;
  begin
    var ctg: real := cos(angle) / sin(angle);
  
    Result := ctg;
  end;
end.
