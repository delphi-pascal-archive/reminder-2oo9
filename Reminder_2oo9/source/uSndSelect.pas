unit uSndSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, MPlayer;

type
  TForm10 = class(TForm)
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    MediaPlayer1: TMediaPlayer;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TForm10.Button1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TForm10.FormShow(Sender: TObject);
var
  pth : string;
  lst : TStringList;
begin
  ModalResult := mrNone;

  pth := ExtractFilePath(ParamStr(0))+'sounds\';
  if not DirectoryExists(pth) then exit;
  if not FileExists(pth+'sounds.ini') then exit;

  lst := TStringList.Create;
  try
  lst.LoadFromFile(pth+'sounds.ini');
  ComboBox1.Items.Text := lst.Text;
  finally
  lst.Free;
  end;
end;

procedure TForm10.SpeedButton1Click(Sender: TObject);
begin
  if not FileExists(ExtractFilePath(ParamStr(0))+'sounds\' + ComboBox1.Text) then exit;

  MediaPlayer1.Close;
  MediaPlayer1.FileName := ExtractFilePath(ParamStr(0))+'sounds\' + ComboBox1.Text;
  MediaPlayer1.Open;
  MediaPlayer1.Play;
end;

procedure TForm10.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MediaPlayer1.Close;
end;

end.
