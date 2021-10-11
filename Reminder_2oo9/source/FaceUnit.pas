Unit FaceUnit;

interface

uses windows, sysutils, classes, dialogs, Graphics, PNGImage;
(******************************************************************************)
  type
  TRGBArray = ARRAY[0..0] OF TRGBTriple;
  pRGBArray = ^TRGBArray;
  (* face rec & animations*)
  type
  TFaceRes = (rEyes, rPupils, rMouth, rFace, rOther);

  TFaceStatus = record
    face,eye,mouth,pupilL,pupilR,other : string[20];
    P1,P2 : tPoint; (* pupils pointers x & y *)
  end;

  TAnimations = array of TFaceStatus;

  TDoubleParam = Record
    pName  : String;
    pParam : String;
  end;
(******************************************************************************)
procedure DrawFace(Canvas: TCanvas; Face: TFaceStatus);
procedure DrawFacePNG(PNG: TPNGObject; Face: TFaceStatus; UseColor: boolean; Color : cardinal);
procedure DeleteFrame(var animarr: TAnimations; frameid: integer);
procedure ClearFace(var Face: TFaceStatus);

function LoadFace(var Face: TFaceStatus; FaceName: string; errmsg: boolean = false) : boolean;
function SaveFace(Face: TFaceStatus; savename: string) : boolean;

function LoadAnimations(var animarr: TAnimations; animname: string; errmsg: boolean = false) : boolean;
function SaveAnimations(animarr: TAnimations; animname: string) : boolean;

function ExistFaceRes(Face: TFaceStatus) : boolean;
function ExistAnimRes(Anim: TAnimations) : boolean;

function StrToParam(const KeyLine: String; Suffix : Char): TDoubleParam;
function NameToRes(ResName: string; FaceRes: TFaceRes) : string;
function ResToName(ResName: string; FaceRes: TFaceRes) : string;
function IndexByName(Name: string; List: TStrings) : integer;

Procedure ResListToList(ResList: TStrings; List: TStrings);
var
  (* stable *)
  faces,others,eyes,mouths,pupils : tstringlist;
  respth, reseyes, respupils, resmouth, resfaces, resothers : string;
  animpath, facepath : string;
(******************************************************************************)
implementation
(******************************************************************************)
function IndexByName(Name: string; List: TStrings) : integer;
var
  i : integer;
begin
  Result := -1;
  for i := 0 to List.Count-1 do
    if LowerCase(Name) = LowerCase(list[i]) then begin
      Result := i;
      exit;
    end;
end;

Procedure ResListToList(ResList: TStrings; List: TStrings);
var
  i : integer;
begin
  List.Add('-');
  for i := 0 to ResList.Count-1 do
    List.Add(StrToParam(ResList[i],'=').pParam);
end;
(******************************************************************************)
function ResToName(ResName: string; FaceRes: TFaceRes) : string;
var
  i : integer;
begin
  Result := '';
  if ResName = '-' then begin
    Result := '-';
    exit;
  end;
  case FaceRes of
    rEyes  : begin
               for i := 0 to eyes.Count-1 do
                 if StrToParam(eyes[i],'=').pName = ResName then
                 begin
                   Result := StrToParam(eyes[i],'=').pParam;
                   exit;
                 end;
             end;
    rPupils: begin
               for i := 0 to pupils.Count-1 do
                 if StrToParam(pupils[i],'=').pName = ResName then
                 begin
                   Result := StrToParam(pupils[i],'=').pParam;
                   exit;
                 end;
             end;
    rMouth : begin
               for i := 0 to mouths.Count-1 do
                 if StrToParam(mouths[i],'=').pName = ResName then
                 begin
                   Result := StrToParam(mouths[i],'=').pParam;
                   exit;
                 end;
             end;
    rFace  : begin
               for i := 0 to faces.Count-1 do
                 if StrToParam(faces[i],'=').pName = ResName then
                 begin
                   Result := StrToParam(faces[i],'=').pParam;
                   exit;
                 end;
             end;
    rOther : begin
               for i := 0 to others.Count-1 do
                 if StrToParam(others[i],'=').pName = ResName then
                 begin
                   Result := StrToParam(others[i],'=').pParam;
                   exit;
                 end;
             end;
  end;
end;
(******************************************************************************)
function NameToRes(ResName: string; FaceRes: TFaceRes) : string;
var
  i : integer;
begin
  Result := '';
  if ResName = '-' then begin
    Result := '-';
    exit;
  end;
  case FaceRes of
    rEyes  : begin
               for i := 0 to eyes.Count-1 do
                 if StrToParam(eyes[i],'=').pParam = ResName then
                 begin
                   Result := StrToParam(eyes[i],'=').pName;
                   exit;
                 end;
             end;
    rPupils: begin
               for i := 0 to pupils.Count-1 do
                 if StrToParam(pupils[i],'=').pParam = ResName then
                 begin
                   Result := StrToParam(pupils[i],'=').pName;
                   exit;
                 end;
             end;
    rMouth : begin
               for i := 0 to mouths.Count-1 do
                 if StrToParam(mouths[i],'=').pParam = ResName then
                 begin
                   Result := StrToParam(mouths[i],'=').pName;
                   exit;
                 end;
             end;

    rFace : begin
               for i := 0 to faces.Count-1 do
                 if StrToParam(faces[i],'=').pParam = ResName then
                 begin
                   Result := StrToParam(faces[i],'=').pName;
                   exit;
                 end;
             end;
    rOther : begin
               for i := 0 to others.Count-1 do
                 if StrToParam(others[i],'=').pParam = ResName then
                 begin
                   Result := StrToParam(others[i],'=').pName;
                   exit;
                 end;
             end;
  end;
end;
(******************************************************************************)
Procedure BmpColorize(R0,G0,B0 : integer; var png, png2: tpngobject);
var
  x, y : integer;
  Rowa : Prgbarray;
  Rowb : Prgbarray;
  R,G,B : integer;
  H0       : integer;
  H,S,V    : integer;
begin
  For y := 0 to png.height-1 do
  begin
    rowa := png2.Scanline[y];
    rowb := png.Scanline[y];
    for x := 0 to png.width-1 do
    begin
      R := (rowa[x].RgbtRed   div 2)+ (R0 div 1);
      G := (rowa[x].Rgbtgreen div 2)+ (G0 div 2);
      B := (rowa[x].Rgbtblue  div 2)+ (B0 div 3);

      if R > 255 then R := 255 else if R < 0 then R := 0;
      if G > 255 then G := 255 else if G < 0 then G := 0;
      if B > 255 then B := 255 else if B < 0 then B := 0;

      rowb[x].Rgbtred   := R;
      rowb[x].Rgbtgreen := G;
      rowb[x].Rgbtblue  := B;
    end;
  end;
end;

procedure colorizer(acolor : tcolor; var png: tpngobject);
var
  R0,G0,B0 : integer;
  png2: tpngobject;
begin
  png2 := TPNGObject.Create;
  png2.Assign(png);
  R0 := GetRValue((acolor));
  G0 := GetGValue((acolor));
  B0 := GetBValue((acolor));
  BmpColorize(R0,G0,B0,png2,png);
  png.assign(png2);
  png2.Free;
end;
(******************************************************************************)
procedure DrawFacePNG(PNG: TPNGObject; Face: TFaceStatus; UseColor: boolean; Color : cardinal);
var
  pupilL, pupilR, myface, eyes, mouth, other : TPNGObject;
begin
  if not ExistFaceRes(Face) then Exit;
  (* *)
  pupilL := TPNGObject.Create;
  pupilR := TPNGObject.Create;
  myface := TPNGObject.Create;
  other  := TPNGObject.Create;
  mouth  := TPNGObject.Create;
  eyes   := TPNGObject.Create;
  (* *)
  if face.face <> '-' then
    myface.LoadFromFile(resfaces+face.face);
  if face.other <> '-' then
    other.LoadFromFile(resothers+face.other);
  if face.pupilL <> '-' then
    pupilL.LoadFromFile(respupils+face.pupilL);
  if face.pupilR <> '-' then
    pupilR.LoadFromFile(respupils+face.pupilR);
  if face.eye <> '-' then
    eyes.LoadFromFile(reseyes+face.eye);
  if face.mouth <> '-' then
    mouth.LoadFromFile(resmouth+face.mouth);
  (* *)
  if UseColor then
  colorizer(color,myface);
  PNG.Assign(myface);
  (* *)
  PNG.Canvas.Draw(0,0,eyes);
  PNG.Canvas.Draw(0,0,mouth);
  PNG.Canvas.Draw(0,0,other);
  PNG.Canvas.Draw(Face.P1.X-(pupilL.Width div 2),Face.P1.Y-(pupilL.Height div 2),pupilL);
  PNG.Canvas.Draw(Face.P2.X-(pupilR.Width div 2),Face.P2.Y-(pupilR.Width div 2),pupilR);
  (* *)
  myface.Free;
  eyes.Free;
  other.Free;
  mouth.Free;
  pupilL.Free;
  pupilR.Free;
end;
(******************************************************************************)
procedure DrawFace(Canvas: TCanvas; Face: TFaceStatus);
var
  pupilL, pupilR, myface, eyes, mouth, other : TPNGObject;
begin
  if not ExistFaceRes(Face) then Exit;
  (* *)
  pupilL := TPNGObject.Create;
  pupilR := TPNGObject.Create;
  myface := TPNGObject.Create;
  other  := TPNGObject.Create;
  mouth  := TPNGObject.Create;
  eyes   := TPNGObject.Create;
  (* *)
  Canvas.FillRect(Canvas.ClipRect);
  (* *)
  if face.face <> '-' then
    myface.LoadFromFile(resfaces+face.face);
  if face.other <> '-' then
    other.LoadFromFile(resothers+face.other);
  if face.pupilL <> '-' then
    pupilL.LoadFromFile(respupils+face.pupilL);
  if face.pupilR <> '-' then
    pupilR.LoadFromFile(respupils+face.pupilR);
  if face.eye <> '-' then
    eyes.LoadFromFile(reseyes+face.eye);
  if face.mouth <> '-' then
    mouth.LoadFromFile(resmouth+face.mouth);
  (* *)
  Canvas.Draw(0,0,myface);
  Canvas.Draw(0,0,eyes);
  Canvas.Draw(0,0,mouth);
  Canvas.Draw(0,0,other);
  Canvas.Draw(Face.P1.X-(pupilL.Width div 2),Face.P1.Y-(pupilL.Height div 2),pupilL);
  Canvas.Draw(Face.P2.X-(pupilR.Width div 2),Face.P2.Y-(pupilR.Width div 2),pupilR);
  (* *)
  myface.Free;
  eyes.Free;
  other.Free;
  mouth.Free;
  pupilL.Free;
  pupilR.Free;
end;
(******************************************************************************)
procedure DeleteFrame(var animarr: TAnimations; frameid: integer);
var
  facest : TFaceStatus;
  i : integer;
begin
  for i := frameid to length(animarr)-1 do
  begin
    facest := animarr[i+1];
    animarr[i] := facest;
  end;
  SetLength(animarr,length(animarr)-1);
end;
(******************************************************************************)
function SaveAnimations(animarr: TAnimations; animname: string) : boolean;
var
  animpth : string;
  i       : integer;
  rs      : file of TFaceStatus;
begin
  Result  := true;
  animpth := animpath;

  (*!!! DIR EXISTS TEST*)

  AssignFile(rs, animpth+animname);
  Rewrite(rs);
  try
    try
    for i:= 0 to length(animarr)-1 do begin
      Write (rs, animarr[i]);
    end;
    except
      Result  := false;
    end;
  finally
    CloseFile(rs);
  end;
end;
(******************************************************************************)
function LoadAnimations(var animarr: TAnimations; animname: string; errmsg: boolean = false) : boolean;
var
  facest  : TFaceStatus;
  animpth : string;
  i       : integer;
  rs      : file of TFaceStatus;
begin
  Result  := false;
  animpth := animpath;

  if not FileExists(animpth+animname) then begin
    if errmsg then
    MessageDlg('Файл анимации не наиден.',mtError,[mbOK],0);
    exit;
  end;

  SetLength(animarr,0);
  AssignFile(rs, animpth+animname);
  Reset(rs);

  try

    while not Eof(rs) do begin
      ZeroMemory(@facest,sizeof(TFaceStatus));
      Read (rs, facest);
      SetLength(animarr,length(animarr)+1);
      animarr[length(animarr)-1] := facest;
    end;

  except
    if errmsg then
    MessageDlg('Ошибка загрузки анимации.',mtError,[mbOK],0);
    CloseFile(rs);
    exit;
  end;
  
  Result := true;
  CloseFile(rs);
end;
(******************************************************************************)
function SaveFace(Face: TFaceStatus; savename: string) : boolean;
var
  i       : integer;
  facepth : string;
  rs      : file of TFaceStatus;
begin
  Result  := true;
  facepth := ExtractFilePath(paramstr(0))+'Faces\';
  AssignFile(rs, facepth + savename);
  Rewrite(rs);
  try
    try
      Write (rs, Face);
    except
      Result  := false;
    end;
  finally
    CloseFile(rs);
  end;
end;
(******************************************************************************)
function LoadFace(var Face: TFaceStatus; FaceName: string; errmsg: boolean = false) : boolean;
var
  facepth : string;
  i       : integer;
  rs      : file of TFaceStatus;
begin
  Result  := false;
  facepth := ExtractFilePath(paramstr(0))+'Faces\';
  if not FileExists(facepth+Facename) then begin
    if errmsg then
    MessageDlg('Файл не наиден.',mtError,[mbOK],0);
    exit;
  end;

  AssignFile(rs, facepth+FaceName);
  Reset(rs);

  try

    while not Eof(rs) do begin
      if Eof(rs) then exit;
      ZeroMemory(@Face,sizeof(TFaceStatus));
      Read (rs, Face);
    end;

  except
    if errmsg then
    MessageDlg('Ошибка загрузки.',mtError,[mbOK],0);
    CloseFile(rs);
    exit;
  end;
  Result := true;
  CloseFile(rs);
end;
(******************************************************************************)
procedure ClearFace(var Face: TFaceStatus);
begin
  ZeroMemory(@Face,sizeof(TFaceStatus));
end;
(******************************************************************************)
function ExistFaceRes(Face: TFaceStatus) : boolean;
begin
  Result := true;

  if not FileExists(resfaces  + face.face)   and (string(face.face)  <> '-') then begin
    Result := false;
    exit;
  end;
  if not FileExists(resothers + face.other)  and (string(face.other)  <> '-') then begin
    Result := false;
    exit;
  end;  
  if not FileExists(reseyes   + face.eye)    and (string(face.eye)    <> '-') then begin
    Result := false;
    exit;
  end;
  if not FileExists(respupils + face.pupilL) and (string(face.pupilL) <> '-') then begin
    Result := false;
    exit;
  end;
  if not FileExists(respupils + face.pupilR) and (string(face.pupilR) <> '-') then begin
    Result := false;
    exit;
  end;
  if not FileExists(resmouth  + face.mouth)  and (string(face.mouth)  <> '-') then begin
    Result := false;
    exit;
  end;
  
end;

function ExistAnimRes(Anim: TAnimations) : boolean;
var
  i : integer;
begin
  Result := true;
  for i := 0 to length(Anim)-1 do
    if not ExistFaceRes(Anim[i]) then
    begin
      Result := false;
      exit;
    end;
end;
(******************************************************************************)
function StrToParam(const KeyLine: String; Suffix : Char): TDoubleParam;
var
  tmp,tmp2 : String;
  i : integer;
begin
  tmp   := '';
  tmp2  := '';
  tmp   := Copy(KeyLine, 1, Pos(Suffix,KeyLine)-1);
  tmp2  := Copy(KeyLine, Length(tmp)+2, Length(KeyLine));
  if tmp2 = Suffix then tmp2 := '';

  Result.pName := tmp;
  Result.pParam:= tmp2;
end;
(******************************************************************************)
(*                                                                            *)
(******************************************************************************)
initialization
  (* *)
  others := TStringList.Create;
  faces  := TStringList.Create;
  eyes   := TStringList.Create;
  mouths := TStringList.Create;
  pupils := TStringList.Create;
  (* *)
  respth    := ExtractFilePath(paramstr(0))+'skin\';

  animpath  := ExtractFilePath(paramstr(0))+'Animations\';
  facepath  := ExtractFilePath(paramstr(0))+'Faces\';

  resfaces  := respth + 'faces\';
  resothers := respth + 'others\';
  reseyes   := respth + 'eyes\';
  respupils := respth + 'pupils\';
  resmouth  := respth + 'mouths\';

  if (not DirectoryExists(respth))    or (not DirectoryExists(reseyes))   or
     (not DirectoryExists(resfaces))  or (not DirectoryExists(resothers)) or
     (not DirectoryExists(respupils)) or (not DirectoryExists(resmouth))  then
  begin
    MessageDlg('Ошибка загрузки ресурсов. Приложение будет закрыто.',mtError,[mbOK],0);
    ExitProcess(0);
  end;
  (* *)
  if (not FileExists(reseyes+'eyes.ini'))     or (not FileExists(resmouth+'mouths.ini')) or
     (not FileExists(respupils+'pupils.ini')) or (not FileExists(resfaces+'faces.ini'))  or
     (not FileExists(resothers+'others.ini')) then
  begin
    MessageDlg('Ошибка загрузки списка ресурсов. Приложение будет закрыто.',mtError,[mbOK],0);
    ExitProcess(0);
  end;
  (* *)
  faces.LoadFromFile(resfaces+'faces.ini');
  others.LoadFromFile(resothers+'others.ini');
  eyes.LoadFromFile(reseyes+'eyes.ini');
  mouths.LoadFromFile(resmouth+'mouths.ini');
  pupils.LoadFromFile(respupils+'pupils.ini');
  (* *)
end.
