unit uCreateFace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, Buttons, FaceUnit;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Panel3: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    Image1: TImage;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    Image2: TImage;
    Image5: TImage;
    Image6: TImage;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
  private
    { Private declarations }
  public
    MyFace : TFaceStatus;
    EditFace : Boolean;
    NewFace  : Boolean;
    FaceName : String;
    { Public declarations }
  end;

var
  Form2: TForm2;
  UpCount : integer;
implementation

{$R *.dfm}

procedure TForm2.FormShow(Sender: TObject);
begin
  ModalResult := mrNone;

  Combobox1.items.Clear;
  Combobox2.items.Clear;
  Combobox3.items.Clear;
  Combobox4.items.Clear;
  Combobox5.items.Clear;
  Combobox6.items.Clear;

  ResListToList(eyes,Combobox1.items);
  ResListToList(pupils,Combobox2.items);
  ResListToList(pupils,Combobox3.items);
  ResListToList(mouths,Combobox4.items);
  ResListToList(faces,Combobox5.items);
  ResListToList(others,Combobox6.items);

  Combobox1.ItemIndex := 0;
  Combobox2.ItemIndex := 0;
  Combobox3.ItemIndex := 0;
  Combobox4.ItemIndex := 0;
  Combobox5.ItemIndex := 0;
  Combobox6.ItemIndex := 0;

  if EditFace then begin
    Combobox1.ItemIndex := IndexByName(ResToName(MyFace.eye,rEyes),Combobox1.Items);
    Combobox2.ItemIndex := IndexByName(ResToName(MyFace.pupilL,rPupils),Combobox2.Items);
    Combobox3.ItemIndex := IndexByName(ResToName(MyFace.pupilR,rPupils),Combobox3.Items);
    Combobox4.ItemIndex := IndexByName(ResToName(MyFace.mouth,rMouth),Combobox4.Items);
    Combobox5.ItemIndex := IndexByName(ResToName(MyFace.face,rFace),Combobox5.Items);
    Combobox6.ItemIndex := IndexByName(ResToName(MyFace.other,rOther),Combobox6.Items);
  end;
  
  ComboBox1.OnChange(nil);
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
  MyFace.eye    := NameToRes(ComboBox1.Text,rEyes);
  MyFace.pupilL := NameToRes(ComboBox2.Text,rPupils);
  MyFace.pupilR := NameToRes(ComboBox3.Text,rPupils);
  MyFace.mouth  := NameToRes(ComboBox4.Text,rMouth);
  MyFace.face   := NameToRes(ComboBox5.Text,rFace);
  MyFace.other  := NameToRes(ComboBox6.Text,rOther);
  (* *)
  DrawFace(Image1.Canvas,MyFace);
end;

procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Image1.Cursor <> CrCross then exit;
  inc(UpCount);
  case UpCount of
    1 : begin
          MyFace.P1.X := X;
          MyFace.P1.Y := Y;
        end;
    2 : begin
          MyFace.P2.X := X;
          MyFace.P2.Y := Y;
          Image1.Cursor := crDefault;
        end;
  end;
  DrawFace(Image1.Canvas,MyFace);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  if NewFace then begin
    if not EditFace then begin
      FaceName := InputBox('Имя образа','Введите имя:','Мой образ');
      SaveFace(MyFace,FaceName+'.fc');
    end else begin
      SaveFace(MyFace,FaceName);
    end;
  end;

  ModalResult := mrOk;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TForm2.Image6Click(Sender: TObject);
begin
  Randomize;

  ComboBox1.ItemIndex := Random(ComboBox1.Items.Count)+1;
  ComboBox2.ItemIndex := Random(ComboBox2.Items.Count)+1;
  ComboBox3.ItemIndex := Random(ComboBox3.Items.Count)+1;
  ComboBox4.ItemIndex := Random(ComboBox4.Items.Count)+1;
  ComboBox5.ItemIndex := Random(ComboBox5.Items.Count)+1;
  ComboBox6.ItemIndex := 0;
  ComboBox1.OnChange(nil);
end;

procedure TForm2.Image5Click(Sender: TObject);
begin
  if image1.Cursor = crCross then
    image1.Cursor := crDefault
    else
    image1.Cursor := crCross;
    
  UpCount := 0;
end;

end.
