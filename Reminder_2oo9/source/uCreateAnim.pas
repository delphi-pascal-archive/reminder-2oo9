unit uCreateAnim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ComCtrls, Buttons, FaceUnit;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    Panel2: TPanel;
    Image1: TImage;
    Panel3: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    Timer1: TTimer;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Procedure BuildFrames;
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image4Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
  private
    { Private declarations }
  public
    Anim : TAnimations;
    Editable : boolean;
    AnimName : String;
    { Public declarations }
  end;

var
  Form1: TForm1;
  Frame: integer = 0;
implementation

uses uCreateFace, uAnimView;

{$R *.dfm}
Procedure TForm1.BuildFrames;
var
  i : integer;
begin
  ListBox1.Clear;
  for i := 0 to length(Anim)-1 do
    ListBox1.Items.Add('Frame '+inttostr(i));
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if not Editable then
    SetLength(Anim, 0);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex < 0 then exit;

  DrawFace(Image1.Canvas,anim[ListBox1.ItemIndex]);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Editable then begin
    SaveAnimations(Anim,AnimName);
    Close;
  end else begin
    AnimName := InputBox('Имя анимации','Введите имя:','Моя анимация');
    SaveAnimations(Anim,AnimName+'.anim');
    Close;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if ListBox1.Items.Count = 0 then exit;
  if Frame > ListBox1.Items.Count then Frame := 0;
  DrawFace(Image1.Canvas,anim[Frame]);
  inc(Frame);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := False;
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
  if Timer1.Enabled then
    Timer1.Enabled := false
    else
    Timer1.Enabled := true;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
  if ListBox1.ItemIndex < 0 then exit;
  Form2.EditFace := true;
  Form2.NewFace  := false;
  Form2.MyFace   := anim[ListBox1.ItemIndex];
  if Form2.showmodal = mrOk then begin
    SetLength(Anim, length(Anim)+1);
    Anim[Length(Anim)-1] := Form2.MyFace;
    BuildFrames;
  end;
end;

procedure TForm1.Image6Click(Sender: TObject);
begin
  if ListBox1.ItemIndex < 0 then exit;
  DeleteFrame(Anim,ListBox1.ItemIndex);
  BuildFrames;
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
  Form2.EditFace := false;
  Form2.NewFace  := false;
  if Form2.showmodal = mrOk then begin
    SetLength(Anim, length(Anim)+1);
    Anim[Length(Anim)-1] := Form2.MyFace;
    BuildFrames;
  end;
end;

end.
