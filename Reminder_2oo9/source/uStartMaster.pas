unit uStartMaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage;

type
  TForm11 = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Button2: TButton;
    Button3: TButton;
    Panel3: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Image2: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

{$R *.dfm}

procedure TForm11.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TForm11.FormShow(Sender: TObject);
begin
  ModalResult := mrNone;
end;

procedure TForm11.Button3Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
