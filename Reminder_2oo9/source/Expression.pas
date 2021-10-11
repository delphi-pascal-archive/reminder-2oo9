Unit Expression;

interface

uses windows, sysutils, classes, faceunit, DateUtils, dialogs;
(******************************************************************************)
  type
  TExpStatus  = (eMore, eLess, eRavn, sNone);

  TExpression = record
    hh,ss,mm       : integer;
    dddd,mmmm,yyyy,ddmm : integer;
    sthh,stss,stmm,stdddd,stmmmm,styyyy,stddmm : TExpStatus;
    RND : boolean; 
  end;
(******************************************************************************)
function TestExpression(Exp: String) : boolean;
function ReplaseAllString(Line, Prefix, Return: String) : String;
function ReplaseString(InStr,FindStr,ReplaseStr: String) : string;

implementation
(******************************************************************************)
function ReplaseString(InStr,FindStr,ReplaseStr: String) : string;
var
  id  : integer;
  str : string;
begin
  Result := InStr;
  id     := pos(LowerCase(FindStr), LowerCase(InStr));
  str    := InStr;
  Delete(str,id,length(FindStr));
  Insert(ReplaseStr,str,id);
  Result := str;
end;

function ReplaseAllString(Line, Prefix, Return: String) : String;
var
  tmp  : string;
begin
  tmp := Line;
  while pos(Prefix,tmp) > 0 do
    tmp := ReplaseString(tmp,prefix,return);

  Result := tmp;
end;

function DeleteSpaces(Line: String) : String;
var
  tmp  : string;
begin
  tmp := Line;
  while pos(' ',tmp) > 0 do
    tmp := ReplaseString(tmp,' ','');
  Result := tmp;
end;

procedure GetWordsList(Line: String; List : TStrings);
var
  tmp : String;
begin
  tmp := Line;
  tmp := ReplaseAllString(tmp,' ',#13#10);
  List.Text := tmp;
end;
(******************************************************************************)
procedure ClearExp(var Exp: TExpression);
begin
  Exp.hh   := -1;
  Exp.ss   := -1;
  Exp.mm   := -1;
  Exp.dddd := -1;
  Exp.mmmm := -1;
  Exp.yyyy := -1;
  Exp.ddmm := -1;
  (* *)
  Exp.sthh   := sNone;
  Exp.stss   := sNone;
  Exp.stmm   := sNone;
  Exp.stdddd := sNone;
  Exp.stmmmm := sNone;
  Exp.styyyy := sNone;
  Exp.stddmm := sNone;
  (* *)
  Exp.RND := False;
end;

function TestExpression(Exp: String) : boolean;
var
  E    : TExpression;
  N    : TExpression;
  st   : TExpStatus;
  Str  : string;
  suf  : char;
  List : TStringList;
  i    : integer;
  err  : boolean;
begin
  ClearExp(E);
  ClearExp(N);
  Result := False;
  (* *)
  if Exp = '#RND#' then begin
    Result := true;
    exit;
  end;
  (* *)
  List := TStringList.Create;
  Str := DeleteSpaces(Exp);
  List.Text := ReplaseAllString(Str,';',#13#10);
  (* *)
  try
  for i := 0 to List.Count-1 do begin
    if pos('=',list[i]) <> 0 then suf := '=';
    if pos('>',list[i]) <> 0 then suf := '>';
    if pos('<',list[i]) <> 0 then suf := '<';
    //
    case suf of
      '>' : st := eMore;
      '<' : st := eLess;
      '=' : st := eRavn;
    end;
    //
    if StrToParam(list[i],suf).pName = 'hh'   then begin
      E.hh := strtoint(StrToParam(list[i],suf).pParam);
      E.sthh := st;
    end;
    if StrToParam(list[i],suf).pName = 'ss'   then begin
      E.ss := strtoint(StrToParam(list[i],suf).pParam);
      E.stss := st;
    end;
    if StrToParam(list[i],suf).pName = 'mm'   then begin
      E.mm := strtoint(StrToParam(list[i],suf).pParam);
      E.stmm := st;
    end;
    if StrToParam(list[i],suf).pName = 'ddmm' then begin
      E.ddmm := strtoint(StrToParam(list[i],suf).pParam);
      E.stddmm := st;
    end;
    if StrToParam(list[i],suf).pName = 'dddd' then begin
      E.dddd := strtoint(StrToParam(list[i],suf).pParam);
      E.stdddd := st;
    end;
    if StrToParam(list[i],suf).pName = 'mmmm' then begin
      E.mmmm := strtoint(StrToParam(list[i],suf).pParam);
      E.stmmmm := st;
    end;
    if StrToParam(list[i],suf).pName = 'yyyy' then begin
      E.yyyy := strtoint(StrToParam(list[i],suf).pParam);
      E.styyyy := st;
    end;
  end;
  (* *)
  finally
  List.Free;
  end;
  (* *)
  N.hh := HourOfTheDay(now);
  N.ss := SecondOfTheMinute(now);
  N.mm := MinuteOfTheHour(now);
  N.dddd := DayOfTheWeek(Now);
  N.ddmm := DayOfTheMonth(Now);
  N.mmmm := MonthOfTheYear(Now);
  N.yyyy := YearOf(Now);
  (* *)
  err := false;
  if E.hh <> -1 then
    case E.sthh of
      eMore : begin
                if E.hh < N.hh then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eLess : begin
                if E.hh > N.hh then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eRavn : begin
                if E.hh = N.hh then else
                begin
                  err := true;
                  exit;
                end;
              end;
    end;
  (* *)
  if E.ss <> -1 then
    case E.stss of
      eMore : begin
                if E.ss < N.ss then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eLess : begin
                if E.ss > N.ss then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eRavn : begin
                if E.ss = N.ss then else
                begin
                  err := true;
                  exit;
                end;
              end;
    end;
  (* *)
  if E.mm <> -1 then
    case E.stmm of
      eMore : begin
                if E.mm < N.mm then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eLess : begin
                if E.mm > N.mm then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eRavn : begin
                if E.mm = N.mm then else
                begin
                  err := true;
                  exit;
                end;
              end;
    end;
  (* *)
  if E.dddd <> -1 then
    case E.stdddd of
      eMore : begin
                if E.dddd < N.dddd then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eLess : begin
                if E.dddd > N.dddd then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eRavn : begin
                if E.dddd = N.dddd then else
                begin
                  err := true;
                  exit;
                end;
              end;
    end;
  (* *)
  if E.ddmm <> -1 then
    case E.stddmm of
      eMore : begin
                if E.ddmm < N.ddmm then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eLess : begin
                if E.ddmm > N.ddmm then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eRavn : begin
                if E.ddmm = N.ddmm then else
                begin
                  err := true;
                  exit;
                end;
              end;
    end;
  (* *)
  if E.mmmm <> -1 then
    case E.stmmmm of
      eMore : begin
                if E.mmmm < N.mmmm then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eLess : begin
                if E.mmmm > N.mmmm then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eRavn : begin
                if E.mmmm = N.mmmm then else
                begin
                  err := true;
                  exit;
                end;
              end;
    end;
  (* *)
  if E.yyyy <> -1 then
    case E.styyyy of
      eMore : begin
                if E.yyyy < N.yyyy then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eLess : begin
                if E.yyyy > N.yyyy then else
                begin
                  err := true;
                  exit;
                end;
              end;
      eRavn : begin
                if E.yyyy = N.yyyy then else
                begin
                  err := true;
                  exit;
                end;
              end;
    end;
    (* *)
    if not err then Result := true else Result := false;
end;
(******************************************************************************)
end.
