unit uTipOfDay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage;

type
  TForm14 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    TipOfDay: TCheckBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    ListBox1: TListBox;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form14: TForm14;

implementation

uses uOptions;

{$R *.dfm}

procedure TForm14.FormShow(Sender: TObject);
begin
  //
  Label2.Caption := ListBox1.Items.Strings[Random(ListBox1.Items.Count)];
end;

procedure TForm14.Button2Click(Sender: TObject);
begin
  Label2.Caption := ListBox1.Items.Strings[Random(ListBox1.Items.Count)];
end;

procedure TForm14.Button1Click(Sender: TObject);
begin
  Form9.Button2.Click;
  Close;
end;

end.
