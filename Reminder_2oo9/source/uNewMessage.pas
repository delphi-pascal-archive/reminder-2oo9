unit uNewMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, Buttons, Spin, Expression;

type
  TForm6 = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Panel3: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    Memo1: TMemo;
    Label6: TLabel;
    Edit3: TEdit;
    Button3: TButton;
    ComboBox1: TComboBox;
    Label7: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label8: TLabel;
    Edit4: TEdit;
    SpeedButton3: TSpeedButton;
    Image9: TImage;
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses uMessagesEd, ComCtrls, uSelFaceType, uSndSelect;

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TForm6.SpeedButton1Click(Sender: TObject);
begin
  Form7.Edit2.Text := '';
  Form7.ComboBox1.ItemIndex := 0;
  if Form7.Showmodal = mrOk then
    Edit2.Text := Form7.Edit2.Text;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TForm6.FormShow(Sender: TObject);
begin
  ModalResult := mrNone;
end;

procedure TForm6.SpeedButton3Click(Sender: TObject);
begin
  if Form10.showmodal = mrOk then begin
    Edit4.Text := Form10.ComboBox1.Text;
  end;
end;

procedure TForm6.Button3Click(Sender: TObject);
const
  NFO = '������ ������� ��� ������:'
         + #13#10 + 'x - ���� ��������.'
         + #13#10 + '#RND# - ��������� �����.'
         + #13#10 + 'hh (=,>,<) x - ���.'
         + #13#10 + 'mm (=,>,<) x - ������.'
         + #13#10 + 'ss (=,>,<) x - �������.'
         + #13#10
         + #13#10 + 'ddmm (=,>,<) x - ���� � ������.'
         + #13#10 + 'dddd (=,>,<) x - ���� � ������.'
         + #13#10 + 'mmmm (=,>,<) x - ����� ������.'
         + #13#10 + 'yyyy (=,>,<) x - ���.'
         + #13#10
         + #13#10 + '� ���������:'
         + #13#10 + '$time$ - ������� �����.'
         + #13#10 + '$year$ - ������� ���.'
         + #13#10 + '$date$ - ������� ����.'
         + #13#10
         + #13#10 + '��������:'
         + #13#10 + '�������: hh=12; mm=0; ss=0; dddd=1;'
         + #13#10 + '�������� ��� ��������� ����� ������� ������ ����������� � 12:00:00';
begin
  MessageDlg(NFO,mtInformation,[mbOK],0);
end;

end.
