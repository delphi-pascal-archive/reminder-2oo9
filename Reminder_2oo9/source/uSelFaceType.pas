unit uSelFaceType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TForm7 = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    Edit2: TEdit;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    FaceName : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses uFaceView, uAnimView;

{$R *.dfm}

procedure TForm7.FormShow(Sender: TObject);
begin
  ModalResult := mrNone;
end;

procedure TForm7.Button1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TForm7.SpeedButton1Click(Sender: TObject);
begin
  if ComboBox1.ItemIndex = 0 then
  begin
    if Form4.ShowModal = mrOk then
      Edit2.Text := Form4.FaceName;
  end else begin
    if Form3.ShowModal = mrOk then
      Edit2.Text := Form3.FaceName;
  end;
end;

end.
