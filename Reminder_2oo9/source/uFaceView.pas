unit uFaceView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, StdCtrls, pngimage, ExtCtrls, FaceUnit;

type
  TForm4 = class(TForm)
    Panel3: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Bevel1: TBevel;
    Button2: TButton;
    Button3: TButton;
    Button1: TButton;
    Button4: TButton;
    Panel2: TPanel;
    Image1: TImage;
    ListView1: TListView;
    Edit2: TEdit;
    Button5: TButton;
    ImageList1: TImageList;
    Image2: TImage;
    Function ScanDir(Dir:String) : Boolean;
    procedure FormShow(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    FaceName : String;
    { Public declarations }
  end;

var
  Form4: TForm4;
  MyFace : TFaceStatus;
implementation

uses uCreateFace;

Function TForm4.ScanDir(Dir:String) : Boolean;
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
      if LowerCase(ExtractFileExt(Dir+SR.Name)) = '.fc' then
      begin
        with ListView1.Items.Add do begin
          Caption := ExtractFileName(SR.Name);
          if LoadFace(MyFace,SR.Name) then
            if ExistFaceRes(MyFace) then
            ImageIndex := 0 else ImageIndex := 1;
        end;
      end;
    FindRes:=FindNext(SR);
  end;
  SysUtils.FindClose(SR);
  Result := true;
end;

{$R *.dfm}

procedure TForm4.FormShow(Sender: TObject);
begin
  ModalResult := mrNone;
  ListView1.Clear;
  ScanDir(facepath);
end;

procedure TForm4.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if item.ImageIndex = 0 then begin
    FaceName := Item.Caption;
    LoadFace(MyFace,Item.Caption);
    DrawFace(Image1.Canvas,MyFace);
    Button3.Enabled := true;
    Edit2.Text := FaceName;
  end else Button3.Enabled := false;
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
  Form2.EditFace := false;
  Form2.NewFace  := true;
  Form2.ShowModal;
  ListView1.Clear;
  ScanDir(facepath);
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  if ListView1.Selected = nil then exit;
  
  Form2.EditFace := true;
  Form2.FaceName := ListView1.Selected.Caption;
  Form2.NewFace  := true;
  Form2.MyFace   := MyFace;
  Form2.ShowModal;
  ListView1.Clear;
  ScanDir(facepath);
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TForm4.Button5Click(Sender: TObject);
begin
  if ListView1.Selected = nil then exit;

  if FileExists(facepath+ListView1.Selected.Caption) then
  begin
    DeleteFile(facepath+ListView1.Selected.Caption);
    ListView1.Clear;
    ScanDir(facepath);
  end;
end;

end.
