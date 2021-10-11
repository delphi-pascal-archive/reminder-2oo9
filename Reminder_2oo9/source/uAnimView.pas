unit uAnimView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ComCtrls, Buttons, ImgList, FaceUnit;

type
  TForm3 = class(TForm)
    Panel3: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Image2: TImage;
    Label2: TLabel;
    Panel1: TPanel;
    Bevel1: TBevel;
    Button2: TButton;
    Button3: TButton;
    Button1: TButton;
    Panel2: TPanel;
    Image1: TImage;
    ListView1: TListView;
    SpeedButton4: TSpeedButton;
    ImageList1: TImageList;
    Timer1: TTimer;
    Button4: TButton;
    Edit2: TEdit;
    Button5: TButton;
    Function ScanDir(Dir:String) : Boolean;

    procedure FormShow(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListView1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    FaceName : String;
    { Public declarations }
  end;

var
  Form3 : TForm3;
  Anim  : TAnimations;
  Frame : integer;
implementation

uses uCreateAnim;

Function TForm3.ScanDir(Dir:String) : Boolean;
Var
  SR        : TSearchRec;
  FindRes,i : Integer;
begin
  Result := false;
  FindRes:=FindFirst(Dir+'*.*',faAnyFile,SR);
  While FindRes=0 do
   begin
    if ((SR.Attr and faDirectory)=faDirectory) and
    ((SR.Name='.')or(SR.Name='..')) then
      begin
      FindRes:=FindNext(SR);
      Continue;
      end;
    if ((SR.Attr and faDirectory)=faDirectory) then
      begin
        ScanDir(Dir+SR.Name+'\');
        FindRes:=FindNext(SR);
        Continue;
      end;
    if FileExists(Dir+SR.Name) then
      if LowerCase(ExtractFileExt(Dir+SR.Name)) = '.anim' then
      begin
        with ListView1.Items.Add do begin
          Caption := ExtractFileName(SR.Name);
          if LoadAnimations(Anim,SR.Name) then
            if ExistAnimRes(Anim) then
            ImageIndex := 0 else ImageIndex := 1;
        end;
      end;
    FindRes:=FindNext(SR);
  end;
  SysUtils.FindClose(SR);
  Result := true;
end;

{$R *.dfm}

procedure TForm3.FormShow(Sender: TObject);
begin
  ModalResult := mrNone;
  ListView1.Clear;
  ScanDir(animpath);
end;

procedure TForm3.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if item.ImageIndex = 0 then begin
    FaceName := Item.Caption;
    LoadAnimations(Anim,Item.Caption);
    DrawFace(Image1.Canvas,anim[0]);
    Button3.Enabled := true;
    Edit2.Text := FaceName;
  end else Button3.Enabled := false;
end;

procedure TForm3.SpeedButton4Click(Sender: TObject);
begin
  if Timer1.Enabled then
    Timer1.Enabled := false
    else
    Timer1.Enabled := true;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  if Frame > Length(anim)-1 then Frame := 0;
  DrawFace(Image1.Canvas,anim[Frame]);
  inc(Frame);
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  if ListView1.Selected = nil then exit;

  Timer1.Enabled := False;
  LoadAnimations(Form1.Anim,ListView1.Selected.Caption);
  Form1.BuildFrames;
  Form1.Editable := True;
  Form1.AnimName := ListView1.Selected.Caption;
  Form1.ShowModal;
  ListView1.Clear;
  ScanDir(animpath);
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := False;
end;

procedure TForm3.ListView1Click(Sender: TObject);
begin
  Timer1.Enabled := false;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  Timer1.Enabled := False;
  Form1.Editable := False;
  Form1.ListBox1.Clear;
  Form1.ShowModal;
  ListView1.Clear;
  ScanDir(animpath);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  if ListView1.Selected = nil then exit;

  if FileExists(animpath+ListView1.Selected.Caption) then
  begin
    DeleteFile(animpath+ListView1.Selected.Caption);
    ListView1.Clear;
    ScanDir(animpath);
  end;
end;

end.
