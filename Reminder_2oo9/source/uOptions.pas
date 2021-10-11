unit uOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ComCtrls, Spin, SaveOptions, FaceUnit, Registry;

type
  TForm9 = class(TForm)
    Panel3: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Bevel1: TBevel;
    Button2: TButton;
    Button3: TButton;
    ListBox1: TListBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    AutoRun: TCheckBox;
    StayOnTop: TCheckBox;
    UseColorTheme: TCheckBox;
    ThemeColor: TShape;
    Panel2: TPanel;
    Image1: TImage;
    Label3: TLabel;
    RepeatAnim: TSpinEdit;
    Label4: TLabel;
    RepeatFaces: TSpinEdit;
    Image9: TImage;
    RunHiden: TCheckBox;
    AlphaBlendMessages: TTrackBar;
    Label5: TLabel;
    AutoHideMessages: TCheckBox;
    MessageShowTime: TSpinEdit;
    Label6: TLabel;
    MessagesToTray: TCheckBox;
    procedure loadoptions(pos: boolean);
    procedure TabSheet2Show(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses uCreateAnim, uFaceForm, uTipOfDay;

procedure AddToAutoRun(StrName: ShortString; delete: boolean);
  var
  reg: TRegistry;
begin
  Reg := nil;
  try
    reg := TRegistry.Create;
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.LazyWrite := false;
    reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',false);
  if delete then reg.WriteString(StrName, ParamStr(0))
  else reg.DeleteValue(StrName);
    reg.CloseKey;
    reg.free;
  except
    if Assigned(Reg) then Reg.Free;
  end;
end;

Procedure HSVtoRGB (const zH, zS, zV: integer; var aR, aG, aB: integer);
const
  d = 255*60;
var
  a    : integer;
  hh   : integer;
  p,q,t: integer;
  vs   : integer;
begin
  if (zH = 0) or (zS = 0) or (ZV = 0)  then
  begin
    aR := zV;
    aG := zV;
    aB := zV;
  end
  else
  begin
    if zH = 360 then hh := 0 else hh := zH;
    a  := hh mod 60;
    hh := hh div 60;
    vs := zV * zS;
    p  := zV - vs div 255;
    q  := zV - (vs*a) div d;
    t  := zV - (vs*(60 - a)) div d;
    case hh of
    0: begin aR := zV; aG :=  t ; aB :=  p; end;
    1: begin aR :=  q; aG := zV ; aB :=  p; end;
    2: begin aR :=  p; aG := zV ; aB :=  t; end;
    3: begin aR :=  p; aG :=  q ; aB := zV; end;
    4: begin aR :=  t; aG :=  p ; aB := zV; end;
    5: begin aR := zV; aG :=  p ; aB :=  q; end;
    else begin aR := 0; aG := 0 ; aB := 0; end;
    end;  
  end;
end;

{$R *.dfm}

procedure TForm9.loadoptions(pos: boolean);
var
  opt : TStringList;
  i   : integer;
begin
  opt := TStringList.Create;
  try
    if FileExists(ExtractFilePath(paramstr(0))+'options.cfg') then
      opt.LoadFromFile(ExtractFilePath(paramstr(0))+'options.cfg');

    LoadFormOptions(Form9,opt);
    try
    LoadSingleObject(Form14.TipOfDay, opt);
    except
    end;

    if pos then
    for i := 0 to opt.Count-1 do begin
      if StrToParam(opt[i],'=').pName = 'Top'  then Form8.Top  := strtoint(StrToParam(opt[i],'=').pParam);
      if StrToParam(opt[i],'=').pName = 'Left' then Form8.Left := strtoint(StrToParam(opt[i],'=').pParam);
    end;

  finally
    opt.Free;
  end;
  AddToAutoRun('Reminder 2oo9',AutoRun.Checked);
end;

procedure TForm9.TabSheet2Show(Sender: TObject);
var
  i : integer;
  colo : Tcolor;
  R,G,B : integer;
begin
  for i := 1 to image1.width do
  begin
    HSVtoRGB(i, 255, 255, R, G, B);
    colo := RGB(R,G,B);
    with image1.canvas do
    begin
      pen.color := colo;
      moveto(i,0);
      lineto(i, image1.height);
    end;
  end;
end;

procedure TForm9.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ThemeColor.Brush.color := image1.canvas.pixels[X,Y];
end;

procedure TForm9.Button2Click(Sender: TObject);
var
  opt : TStringList;
begin
  AddToAutoRun('Reminder 2oo9',AutoRun.Checked);
  
  opt := TStringList.Create;
  SaveFormOptions(Form9,opt);
  SaveSingleObject(Form14.TipOfDay,opt);
  opt.Add('Top='+inttostr(form8.Top));
  opt.Add('Left='+inttostr(form8.Left));
  try
    opt.SaveToFile(ExtractFilePath(paramstr(0))+'options.cfg');
  finally
    opt.Free;
  end;
  close;
end;

procedure TForm9.Button3Click(Sender: TObject);
begin
  loadoptions(false);
  AddToAutoRun('Reminder 2oo9',AutoRun.Checked);
  close;
end;

procedure TForm9.FormCreate(Sender: TObject);
begin
  loadoptions(true);
end;
procedure TForm9.FormShow(Sender: TObject);
begin
  loadoptions(false);
end;

procedure TForm9.ListBox1Click(Sender: TObject);
begin
  PageControl1.Pages[ListBox1.ItemIndex].Show;
end;

end.
