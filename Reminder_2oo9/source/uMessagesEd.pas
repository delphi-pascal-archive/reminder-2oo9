unit uMessagesEd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, ComCtrls, ImgList, Expression, FaceUnit, CoolTrayIcon;

  type
  TMsgType = (none, mesg, warn, happyb, alarm);

  TMyMessage = record
    MsgName : String[50];
    MsgText : String[200];
    MsgSnd  : String[100];
    MsgType : TMsgType;
    MsgExp  : String[100];
    MsgFace : String[100];
    Act     : boolean;
    Del     : boolean;
  end;

  TMsgArr  = array of TMyMessage;

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Panel3: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Button4: TButton;
    Button3: TButton;
    Button5: TButton;
    ListView1: TListView;
    ImageList1: TImageList;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Label3: TLabel;
    Image9: TImage;
    function LoadMessages(var msgarr: TMsgArr) : boolean;
    function SaveMessages(msgarr: TMsgArr) : boolean;
    procedure DeleteMsg(var MsgArr: TMsgArr; ID: integer);
    procedure RefreshMessages;

    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
  private
    { Private declarations }
  public
    MsgArr : TMsgArr;
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses uNewMessage, uFaceForm, uMessage, uOptions;

procedure TForm5.RefreshMessages;
var
  i : integer;
  s : string;
begin
  for i := 0 to length(MsgArr)-1 do begin
    if TestExpression(MsgArr[i].MsgExp) then begin
      if MsgArr[i].MsgExp = '#RND#' then begin
        if Random(4500) <> Random(4000) then Continue; 
      end;
      if MsgArr[i].Act then begin
        if FileExists(ExtractFilePath(ParamStr(0))+'sounds\' + MsgArr[i].MsgSnd) then begin
          try
          Form8.MediaPlayer1.Close;
          Form8.MediaPlayer1.FileName := ExtractFilePath(ParamStr(0))+'sounds\' + MsgArr[i].MsgSnd;
          Form8.MediaPlayer1.Open;
          Form8.MediaPlayer1.Play;
          except
          end;
        end;
        if LowerCase(ExtractFileExt(MsgArr[i].MsgFace)) = '.fc' then
        begin
          Form8.FacePth := MsgArr[i].MsgFace;
          Form8.Anims   := False;
          Form8.repeats := 0;
        end
        else begin
          LoadAnimations(Form8.Anim,MsgArr[i].MsgFace);
          Form8.repeats := 0;
          Form8.Anims   := True;
        end;
        s := MsgArr[i].MsgText;
        
        s := ReplaseAllString(s,'$time$',FormatDateTime('hh:mm:ss',now));
        s := ReplaseAllString(s,'$year$',FormatDateTime('yyyy',now));
        s := ReplaseAllString(s,'$date$',FormatDateTime('mm.dd.yy',now));
        
        Form12.Label3.Caption := s;
        Form12.Label1.Caption := MsgArr[i].MsgName;
        Form8.Timer1.enabled := false;
        Form8.Timer2.enabled := true;
        if form12.Label3.Caption <> '' then
          if not form9.MessagesToTray.Checked then begin
            Form12.show;
          end
          else begin
            Form8.CoolTrayIcon1.ShowBalloonHint('Reminder 2oo9 - '+MsgArr[i].MsgName,s,bitInfo,10);
          end;
          if MsgArr[i].Del then
            Form8.BooM;
        exit;
      end;
      (* *)
    end;
  end;
end;

procedure TForm5.DeleteMsg(var MsgArr: TMsgArr; ID: integer);
var
  Msg : TMyMessage;
  i : integer;
begin
  for i := ID to length(msgarr)-1 do
  begin
    Msg := msgarr[i+1];
    msgarr[i] := msg;
  end;
  SetLength(msgarr,length(msgarr)-1);
end;

function TForm5.SaveMessages(msgarr: TMsgArr) : boolean;
var
  pth     : string;
  i       : integer;
  rs      : file of TMyMessage;
begin
  Result  := true;
  pth     := ExtractFilePath(paramstr(0))+'Messages.msg';

  AssignFile(rs, pth);
  Rewrite(rs);
  try
    try
    for i:= 0 to length(msgarr)-1 do begin
      Write (rs, msgarr[i]);
    end;
    except
      Result  := false;
    end;
  finally
    CloseFile(rs);
  end;
end;

function TForm5.LoadMessages(var msgarr: TMsgArr) : boolean;
var
  msg     : TMyMessage;
  pth     : string;
  i       : integer;
  rs      : file of TMyMessage;
begin
  Result  := false;
  pth     := ExtractFilePath(paramstr(0))+'Messages.msg';
  
  SetLength(msgarr,0);

  if not FileExists(pth) then begin
    exit;
  end;

  AssignFile(rs, pth);
  Reset(rs);

  try

    while not Eof(rs) do begin
      ZeroMemory(@msg,sizeof(TMyMessage));
      Read (rs, msg);
      SetLength(msgarr,length(msgarr)+1);
      msgarr[length(msgarr)-1] := msg;
    end;

  except
    CloseFile(rs);
    exit;
  end;
  
  Result := true;
  CloseFile(rs);
end;

function MsgToID(MSG : TMsgType) : integer;
begin
  case MSG of
    none : Result := 0;
    mesg : Result := 1;
    warn : Result := 2;
    happyb : Result := 3;
    alarm  : Result := 4;
  end;
end;

Procedure BuildMsgListFiltred(msgarr: TMsgArr; list : TListView; Filter: TMsgType);
var
  i : integer;
begin
  list.Clear;

  for i := 0 to Length(msgarr)-1 do
    if Filter = msgarr[i].MsgType then
    with list.Items.Add do begin
      Caption := msgarr[i].MsgName;
      if msgarr[i].Act then
        SubItems.Add('Активно')
        else
        SubItems.Add('Отключено');
      (* images!!! *)
      SubItems.Add(inttostr(i));
      if not msgarr[i].Act then ImageIndex := 5 else
      ImageIndex := MsgToID(msgarr[i].MsgType);
    end;
end;

Procedure BuildMsgListDisabled(msgarr: TMsgArr; list : TListView);
var
  i : integer;
begin
  list.Clear;

  for i := 0 to Length(msgarr)-1 do
    if not msgarr[i].Act then
    with list.Items.Add do begin
      Caption := msgarr[i].MsgName;
      if msgarr[i].Act then
        SubItems.Add('Активно')
        else
        SubItems.Add('Отключено');
      (* images!!! *)
      SubItems.Add(inttostr(i));
      if not msgarr[i].Act then ImageIndex := 5 else
      ImageIndex := MsgToID(msgarr[i].MsgType);
    end;
end;

Procedure BuildMsgList(msgarr: TMsgArr; list : TListView);
var
  i : integer;
begin
  list.Clear;

  for i := 0 to Length(msgarr)-1 do
    with list.Items.Add do begin
      Caption := msgarr[i].MsgName;
      if msgarr[i].Act then
        SubItems.Add('Активно')
        else
        SubItems.Add('Отключено');
      (* images!!! *)
      SubItems.Add(inttostr(i));
      if not msgarr[i].Act then ImageIndex := 5 else
      ImageIndex := MsgToID(msgarr[i].MsgType);
    end;
end;

{$R *.dfm}

procedure TForm5.Button4Click(Sender: TObject);
var
  Msg  : TMyMessage;
begin
  Form6.Memo1.Text := '';
  Form6.Edit1.Text := '';
  Form6.Edit2.Text := '';
  Form6.Edit3.Text := '';
  Form6.Edit4.Text := '';
  Form6.CheckBox1.Checked := True;
  Form6.CheckBox2.Checked := True;
  Form6.ComboBox1.ItemIndex := 0;
  
  if Form6.ShowModal = mrOk then begin
    Msg.MsgName := Form6.Edit1.Text;
    Msg.MsgText := Form6.Memo1.Text;
    Msg.MsgFace := Form6.Edit2.Text;
    Msg.MsgExp  := Form6.Edit3.Text;
    Msg.MsgSnd  := Form6.Edit4.Text;
    Msg.Act     := Form6.CheckBox1.Checked;
    Msg.Del     := Form6.CheckBox2.Checked;
    case Form6.ComboBox1.ItemIndex of
      0 : Msg.MsgType := none;
      1 : Msg.MsgType := mesg;
      2 : Msg.MsgType := warn;
      3 : Msg.MsgType := happyb;
      4 : Msg.MsgType := alarm;
    end;
    (* *)
    SetLength(msgarr,length(msgarr)+1);
    msgarr[length(msgarr)-1] := msg;

    BuildMsgList(MsgArr,ListView1);
  end;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  SaveMessages(MsgArr);
  close;
end;

procedure TForm5.Button5Click(Sender: TObject);
begin
  if ListView1.Selected <> nil then
    DeleteMsg(MsgArr, strtoint(ListView1.Selected.SubItems[1]));

    BuildMsgList(MsgArr,ListView1);
end;

procedure TForm5.Button3Click(Sender: TObject);
var
  Msg  : TMyMessage;
begin
  if ListView1.Selected = nil then exit;

  ZeroMemory(@Msg,sizeof(TMyMessage));

  Form6.Memo1.Text := MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgText;
  Form6.Edit1.Text := MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgName;
  Form6.Edit2.Text := MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgFace;
  Form6.Edit3.Text := MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgExp;
  Form6.Edit4.Text := MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgSnd;
  Form6.CheckBox1.Checked := MsgArr[strtoint(ListView1.Selected.SubItems[1])].Act;
  Form6.CheckBox2.Checked := MsgArr[strtoint(ListView1.Selected.SubItems[1])].Del;
  Form6.ComboBox1.ItemIndex := MsgToID(MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgType);
  (* *)
  if Form6.ShowModal = mrOk then begin
    MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgName := Form6.Edit1.Text;
    MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgText := Form6.Memo1.Text;
    MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgFace := Form6.Edit2.Text;
    MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgExp  := Form6.Edit3.Text;
    MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgSnd  := Form6.Edit4.Text;
    MsgArr[strtoint(ListView1.Selected.SubItems[1])].Act     := Form6.CheckBox1.Checked;
    MsgArr[strtoint(ListView1.Selected.SubItems[1])].Del     := Form6.CheckBox2.Checked;
    case Form6.ComboBox1.ItemIndex of
      0 : MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgType := none;
      1 : MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgType := mesg;
      2 : MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgType := warn;
      3 : MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgType := happyb;
      4 : MsgArr[strtoint(ListView1.Selected.SubItems[1])].MsgType := alarm;
    end;
    (* *)
    BuildMsgList(MsgArr,ListView1);
  end;
end;

procedure TForm5.ListView1DblClick(Sender: TObject);
begin
  Button3.OnClick(nil);
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm5.FormShow(Sender: TObject);
begin
  LoadMessages(msgarr);
  BuildMsgList(msgarr,ListView1);
end;

procedure TForm5.Image3Click(Sender: TObject);
begin
  BuildMsgListFiltred(MsgArr,ListView1,none);
end;

procedure TForm5.Image6Click(Sender: TObject);
begin
  BuildMsgListFiltred(MsgArr,ListView1,warn);
end;

procedure TForm5.Image5Click(Sender: TObject);
begin
  BuildMsgListFiltred(MsgArr,ListView1,mesg);
end;

procedure TForm5.Image4Click(Sender: TObject);
begin
  BuildMsgListFiltred(MsgArr,ListView1,happyb);
end;

procedure TForm5.Image1Click(Sender: TObject);
begin
  BuildMsgListFiltred(MsgArr,ListView1,alarm);  
end;

procedure TForm5.Image7Click(Sender: TObject);
begin
  BuildMsgListDisabled(MsgArr,ListView1)
end;

procedure TForm5.Image8Click(Sender: TObject);
begin
  BuildMsgList(msgarr,ListView1);
end;

end.
