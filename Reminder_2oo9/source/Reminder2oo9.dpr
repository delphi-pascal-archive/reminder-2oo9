program Reminder2oo9;

uses
  Forms,
  SysUtils,
  Windows,
  Dialogs,
  Controls,
  FaceUnit,
  uCreateAnim in 'uCreateAnim.pas' {Form1},
  uCreateFace in 'uCreateFace.pas' {Form2},
  uAnimView in 'uAnimView.pas' {Form3},
  uFaceView in 'uFaceView.pas' {Form4},
  uMessagesEd in 'uMessagesEd.pas' {Form5},
  uNewMessage in 'uNewMessage.pas' {Form6},
  uSelFaceType in 'uSelFaceType.pas' {Form7},
  uFaceForm in 'uFaceForm.pas' {Form8},
  uOptions in 'uOptions.pas' {Form9},
  uSndSelect in 'uSndSelect.pas' {Form10},
  uStartMaster in 'uStartMaster.pas' {Form11},
  uMessage in 'uMessage.pas' {Form12},
  uAbout in 'uAbout.pas' {Form13},
  uTipOfDay in 'uTipOfDay.pas' {Form14};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm14, Form14);  
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TForm12, Form12);
  Application.CreateForm(TForm13, Form13);
  Form5.LoadMessages(Form5.MsgArr);

  if Form9.RunHiden.Checked then Application.ShowMainForm := False;
  if not Form14.TipOfDay.Checked then Form14.ShowModal;

  Form8.Timer1.Enabled := False;
  if not FileExists(facepath +'default.fc') then
    if Form11.ShowModal <> mrOk then ExitProcess(0) else
    begin
      Form2.FaceName := 'default.fc';
      Form2.EditFace := true;
      Form2.NewFace  := true;
      if Form2.ShowModal <> mrOk then begin
        MessageDlg('Вы не создали образ поумолчанию! Приложение будет закрыто.',mtWarning,[mbOK],0);
        ExitProcess(0);
      end;
    end;
  Form8.Timer1.Enabled := True;
  Form8.CoolTrayIcon1.HideTaskbarIcon;

  Form9.loadoptions(true);
  
  Application.Run;
end.
