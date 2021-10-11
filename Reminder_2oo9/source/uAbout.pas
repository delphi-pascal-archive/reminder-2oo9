unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, shellapi;

type
  TForm13 = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Button2: TButton;
    Image2: TImage;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

{$R *.dfm}

procedure TForm13.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm13.Label7Click(Sender: TObject);
begin
  shellexecute(handle,
  'Open',
  'mailto:BlackCash2006@Yandex.ru?subject=Reminder_2oo9',
  nil, nil, sw_restore);
end;

end.
