unit uMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm12 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Panel2: TPanel;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    procedure Label2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;
  Seconds : integer = 0;
implementation

uses uOptions, ComCtrls;

{$R *.dfm}

procedure TForm12.Label2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm12.FormShow(Sender: TObject);
begin
  Timer1.Enabled := true;
  Seconds := 0;
  Form12.AlphaBlendValue := byte(Form9.AlphaBlendMessages.Position);
end;

procedure TForm12.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := False;
end;

procedure TForm12.Timer1Timer(Sender: TObject);
begin
  if Seconds >= Form9.MessageShowTime.Value then Form12.Close;
  inc(Seconds);
end;

end.
