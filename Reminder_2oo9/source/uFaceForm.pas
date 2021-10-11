unit uFaceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, FaceUnit, pngimage, ExtCtrls, MPlayer, CoolTrayIcon,
  ImgList, XPMan;

type
  TForm8 = class(TForm)
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Timer1: TTimer;
    Timer2: TTimer;
    N8: TMenuItem;
    N9: TMenuItem;
    MediaPlayer1: TMediaPlayer;
    CoolTrayIcon1: TCoolTrayIcon;
    N10: TMenuItem;
    ImageList1: TImageList;
    N11: TMenuItem;
    XPManifest1: TXPManifest;
    N12: TMenuItem;
    function draw(handle: HWND; MFace: TFaceStatus) : boolean;
    function drawan(handle: HWND) : boolean;
    procedure BooM;

    procedure N7Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure CoolTrayIcon1DblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
  private
    { Private declarations }
  public
    Anim    : TAnimations;
    MyFace  : TFaceStatus;
    FacePth : String;
    Anims   : boolean;
    repeats : integer;
    { Public declarations }
  end;

  TRGBArray = ARRAY[0..0] OF TRGBTriple;
  pRGBArray = ^TRGBArray;

  AlphaRGB = packed record
    B: Byte;
    G: Byte;
    R: Byte;
    A: Byte;
  end;
  pARGB = ^TARGB;
  TARGB = array [WORD] of AlphaRGB;

var
  Form8: TForm8;
  bmp     : tbitmap;
  FaceD   : TPNGObject;
  FaceR   : TPNGObject;
  FaceT   : TPNGObject;
  MyFace  : TFaceStatus;
  Frame   : integer;

  Clicks  : integer = 0;

  MouseOn : Boolean = false;
implementation

uses uMessagesEd, uAnimView, uFaceView, uCreateFace, uCreateAnim, uOptions,
  uAbout, Math, dateutils, uTipOfDay;

{$R *.dfm}

(******************************************************************************)
procedure LoadFromPNGFileForBG(png: TPNGObject);
var
 i,j:integer;
 pA: pARGB;
 pB: pByteArray;
begin
 bmp.PixelFormat:=pf32bit;
 bmp.Width:=PNG.Width;
 bmp.Height:=PNG.Height;
 BitBlt(bmp.Canvas.Handle,0,0,bmp.Width,bmp.Height,PNG.Canvas.Handle,0,0,SRCCOPY);
  for i := 0 to png.Height - 1 do
   begin
    pA := bmp.Scanline[i];
    pB := PNG.AlphaScanline[i];
    for j := 0 to png.Width - 1 do
     begin
      pA[j].A := pB[j];
      pA[j].B := (pA[j].B * pB[j]) shr 8;
      pA[j].G := (pA[j].G * pB[j]) shr 8;
      pA[j].R := (pA[j].R * pB[j]) shr 8;
     end;
   end;

end;

function tform8.draw(handle: HWND; MFace: TFaceStatus) : boolean;
var
  BF    : TBlendFunction;
  DC    : HDC;
  bs    : TSize;
  xySrc : TPoint;
  xy    : TPoint;
  i     : integer;
begin
  //LoadFace(MFace,fname);
  xy.x := 0;
  xy.y := 0;
  Result:=false;
  bmp.FreeImage;
  (*draw*)
  DrawFacePNG(FaceD,MyFace,form9.UseColorTheme.Checked,form9.ThemeColor.Brush.Color);
  (*end*)
  LoadFromPNGFileForBG(FaceD);
  with BF do
   begin
    BlendOp    := AC_SRC_OVER;
    BlendFlags := 0;
    SourceConstantAlpha := 255;
    AlphaFormat         := AC_SRC_ALPHA;
  end;
  DC:=GetDC(0);
  bs.cx:=bmp.Width;
  bs.cy:=bmp.Height;
  xySrc.X:=0;
  xySrc.Y:=0;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
  Result := UpdateLayeredWindow(Handle,0,nil,@bs,bmp.Canvas.Handle,
  @xySrc,clNone,@BF,ULW_ALPHA);
  ReleaseDC(0,DC);
end;

function tform8.drawan(handle: HWND) : boolean;
var
  BF    : TBlendFunction;
  DC    : HDC;
  bs    : TSize;
  xySrc : TPoint;
  xy    : TPoint;
  i     : integer;
begin
  try
  if Length(anim)-1 < 0 then exit;
  MyFace := anim[frame];
  xy.x := 0;
  xy.y := 0;
  Result:=false;
  bmp.FreeImage;
  (*draw*)
  DrawFacePNG(FaceD,MyFace,form9.UseColorTheme.Checked,form9.ThemeColor.Brush.Color);
  (*end*)
  LoadFromPNGFileForBG(FaceD);
  with BF do
   begin
    BlendOp := AC_SRC_OVER;
    BlendFlags := 0;
    SourceConstantAlpha := 255;
    AlphaFormat := AC_SRC_ALPHA;
  end;
  DC:=GetDC(0);
  bs.cx:=bmp.Width;
  bs.cy:=bmp.Height;
  xySrc.X:=0;
  xySrc.Y:=0;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
  Result := UpdateLayeredWindow(Handle,0,nil,@bs,bmp.Canvas.Handle,
  @xySrc,clNone,@BF,ULW_ALPHA);
  ReleaseDC(0,DC);
  except
  end;
end;

procedure tForm8.BooM;
const
  rn : array [0..1] of integer = (-2,2);
var
p : tpoint;
i : integer;
begin
  p.X := Top;
  p.Y := Left;
  (* *)
  for i := 0 to 75 do begin
    Form8.Top  := Form8.Top + RandomFrom(rn);
    Form8.Left := Form8.Left + RandomFrom(rn);
    Sleep(50);
    Application.ProcessMessages;
  end;
  (* *)
  Top  := P.X;
  Left := p.Y;
end;

procedure TForm8.N7Click(Sender: TObject);
begin
  Form9.Button2.Click;
  Close;
end;

procedure TForm8.N3Click(Sender: TObject);
begin
  Form5.ShowModal;
end;

procedure TForm8.N5Click(Sender: TObject);
begin
  Form3.Button3.Visible := false;
  Form3.Showmodal;
  Form3.Button3.Visible := true;
end;

procedure TForm8.N4Click(Sender: TObject);
begin
  Form4.Button3.Visible := false;
  Form4.Showmodal;
  Form4.Button3.Visible := true;
end;

procedure TForm8.FormCreate(Sender: TObject);
begin
  bmp   := TBitmap.Create;
  FaceD := TPNGObject.Create;
  Form8.DoubleBuffered := true;
end;

procedure TForm8.Timer1Timer(Sender: TObject);
begin
  if Clicks > 0 then
    Clicks := Clicks - 2;

  if clicks > 8 then begin
    BooM;
    Clicks := 0;
  end;

  Form8.CoolTrayIcon1.HideTaskbarIcon;
  
  if Form9.StayOnTop.Checked then
    Form8.FormStyle := fsStayOnTop
    else
    Form8.FormStyle := fsNormal;

  if Timer2.Enabled then exit;
  LoadFace(MyFace,'default.fc');
  draw(form8.Handle,MyFace);
  Form5.RefreshMessages;
end;

procedure TForm8.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  const SC_DragMove = $F012;
begin
  inc(Clicks,1);
  ReleaseCapture;
  Form8.perform(WM_SysCommand, SC_DragMove, 0);
end;

procedure TForm8.FormShow(Sender: TObject);
begin
  Clicks := 0;
  if not Timer2.Enabled then begin
    LoadFace(MyFace,'default.fc');
    draw(form8.Handle,MyFace);
  end;
end;

procedure TForm8.Timer2Timer(Sender: TObject);
begin
  if Anims then begin
    if Frame > Length(anim)-1 then begin
      if repeats >= Form9.RepeatAnim.Value * 5 then begin
        Timer2.Enabled := false;
        Timer1.Enabled := true;
      end;
      Frame := 0;
      inc(repeats);
    end;
    drawan(form8.Handle);
    inc(Frame);
  end else begin
    LoadFace(MyFace,FacePth);
    draw(form8.Handle,MyFace);
    inc(repeats);
    if repeats >= Form9.RepeatFaces.Value * 5 then begin
      Timer2.Enabled := false;
      Timer1.Enabled := true;
    end;
  end;
end;

procedure TForm8.N8Click(Sender: TObject);
begin
  Form9.PageControl1.Pages[0].Show;
  Form9.ListBox1.ItemIndex := 0;
  Form9.ShowModal;
end;

procedure TForm8.CoolTrayIcon1DblClick(Sender: TObject);
begin
  //CoolTrayIcon1.ShowMainForm;
end;

procedure TForm8.N1Click(Sender: TObject);
begin
  CoolTrayIcon1.HideMainForm;
end;

procedure TForm8.N10Click(Sender: TObject);
begin
  CoolTrayIcon1.ShowMainForm;
end;

procedure TForm8.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Вы действительно хотите выйти из Reminder 2oo9 ?',mtInformation,[mbYes,mbNo],0) <> 6 then Action := caNone;
end;

procedure TForm8.N11Click(Sender: TObject);
begin
  Form13.Showmodal;
end;

procedure TForm8.N12Click(Sender: TObject);
begin
  Form14.showmodal;
end;

end.
