unit SaveOptions;

interface
uses
  Forms, Classes, Spin, SysUtils, StdCtrls, ComCtrls, ExtCtrls, Graphics, FaceUnit;

  function LoadFormOptions(xForm: TForm; const l: TStringList):boolean;
  function SaveFormOptions(xForm: TForm; var l: TStringList):boolean;
  function SaveSingleObject(sObject : TComponent; var l: TStringList):boolean;
  function LoadSingleObject(sObject : TComponent; const l: TStringList):boolean;
implementation
//----------------------------------------------------------------------------//
function LoadFormOptions(xForm: TForm; const l: TStringList):boolean;
var
  i: integer;
  j: integer;
begin
  Result := True;
  //
    for i := 0 to l.Count-1 do
        for j := 0 to xForm.ComponentCount-1 do
        begin
        {}
          if xForm.Components[j].Name = strtoparam(l[i],'=').pName then
          begin

            if xForm.Components[j] is TListView then
            if (xForm.Components[j] as TListView).Tag <> 1 then
            with (xForm.Components[j] as TListView).Items.Add do
              Caption := strtoparam(l[i],'=').pParam;

            if xForm.Components[j] is TCheckBox then
              (xForm.Components[j] as TCheckBox).Checked    := StrToBool(strtoparam(l[i],'=').pParam);

            if xForm.Components[j] is TRadioButton then
              (xForm.Components[j] as TRadioButton).Checked := StrToBool(strtoparam(l[i],'=').pParam);

            if xForm.Components[j] is TEdit then
            if (xForm.Components[j] as TEdit).Tag <> 1 then
               (xForm.Components[j] as TEdit).Text          := strtoparam(l[i],'=').pParam;

            if xForm.Components[j] is TTrackBar then
              (xForm.Components[j] as TTrackBar).Position   := StrToint(strtoparam(l[i],'=').pParam);

            if xForm.Components[j] is TComboBox then
              (xForm.Components[j] as TComboBox).ItemIndex  := StrToint(strtoparam(l[i],'=').pParam);

            if xForm.Components[j] is TShape then
              (xForm.Components[j] as TShape).Brush.Color   := StringToColor(strtoparam(l[i],'=').pParam);

            if xForm.Components[j] is TSpinEdit then
              (xForm.Components[j] as TSpinEdit).Value      := StrToInt(strtoparam(l[i],'=').pParam);

            if xForm.Components[j] is TRadioGroup then
              (xForm.Components[j] as TRadioGroup).ItemIndex:= StrToInt(strtoparam(l[i],'=').pParam);
          end;
        {}
        end;
end;
//----------------------------------------------------------------------------//
function SaveSingleObject(sObject : TComponent; var l: TStringList):boolean;
begin
      if sObject is TLabel then
      if (sObject as TLabel).Tag <> 1 then
          l.Add(sObject.Name+'='+(sObject as TLabel).Caption);

      if sObject is TCheckBox then
          l.Add(sObject.Name+'='+BoolToStr((sObject as TCheckBox).Checked));

      if sObject is TRadioButton then
          l.Add(sObject.Name+'='+BoolToStr((sObject as TRadioButton).Checked));

      if sObject is TEdit then
      if (sObject as TEdit).Tag <> 1 then
          l.Add(sObject.Name+'='+(sObject as TEdit).Text);

      if sObject is TTrackBar then
          l.Add(sObject.Name+'='+IntToStr((sObject as TTrackBar).Position));

      if sObject is TComboBox then
          l.Add(sObject.Name+'='+IntToStr((sObject as TComboBox).ItemIndex));

      if sObject is TShape then
          l.Add(sObject.Name+'='+ColorToString((sObject as TShape).Brush.Color));

      if sObject is TSpinEdit then
          l.Add(sObject.Name+'='+IntToStr((sObject as TSpinEdit).Value));

      if sObject is TRadioGroup then
          l.Add(sObject.Name+'='+IntToStr((sObject as TRadioGroup).ItemIndex));
end;
//----------------------------------------------------------------------------//
function LoadSingleObject(sObject : TComponent; const l: TStringList):boolean;
var
  i:integer;
begin

    for i := 0 to l.Count-1 do
    if sObject.Name = strtoparam(l[i],'=').pName then
    begin
    {}

      if sObject is TListView then
      if (sObject as TListView).Tag <> 1 then
        with (sObject as TListView).Items.Add do
        Caption := strtoparam(l[i],'=').pParam;

      if sObject is TLabel then
      (sObject as TLabel).Caption       := strtoparam(l[i],'=').pParam;

      if sObject is TCheckBox then
      (sObject as TCheckBox).Checked    := StrToBool(strtoparam(l[i],'=').pParam);

      if sObject is TRadioButton then
      (sObject as TRadioButton).Checked := StrToBool(strtoparam(l[i],'=').pParam);

      if sObject is TEdit then
      if (sObject as TEdit).Tag <> 1 then
      (sObject as TEdit).Text           := strtoparam(l[i],'=').pParam;

      if sObject is TTrackBar then
      (sObject as TTrackBar).Position   := StrToint(strtoparam(l[i],'=').pParam);

      if sObject is TComboBox then
      (sObject as TComboBox).ItemIndex  := StrToint(strtoparam(l[i],'=').pParam);

      if sObject is TShape then
      (sObject as TShape).Brush.Color   := StringToColor(strtoparam(l[i],'=').pParam);

      if sObject is TSpinEdit then
      (sObject as TSpinEdit).Value      := StrToInt(strtoparam(l[i],'=').pParam);

      if sObject is TRadioGroup then
      (sObject as TRadioGroup).ItemIndex:= StrToInt(strtoparam(l[i],'=').pParam);
      {}
    end;
end;
//----------------------------------------------------------------------------//
function SaveFormOptions(xForm: TForm; var l: TStringList):boolean;
var
  i,j: integer;

begin
    {}
    l.Clear;

      for i := 0 to xForm.ComponentCount-1 do
      if xForm.Components[i] is TListView then
      if (xForm.Components[i] as TListView).Tag <> 1 then
      if (xForm.Components[i] as TListView).Items.Count <> 0 then
      for j := 0 to (xForm.Components[i] as TListView).Items.Count-1 do
          l.Add(xForm.Components[i].Name+'='+(xForm.Components[i] as TListView).Items.Item[j].Caption);

      for i := 0 to xForm.ComponentCount-1 do
      if xForm.Components[i] is TCheckBox then
          l.Add(xForm.Components[i].Name+'='+BoolToStr((xForm.Components[i] as TCheckBox).Checked));

      for i := 0 to xForm.ComponentCount-1 do
      if xForm.Components[i] is TRadioButton then
          l.Add(xForm.Components[i].Name+'='+BoolToStr((xForm.Components[i] as TRadioButton).Checked));

      for i := 0 to xForm.ComponentCount-1 do
      if xForm.Components[i] is TEdit then
      if (xForm.Components[i] as TEdit).Tag <> 1 then
          l.Add(xForm.Components[i].Name+'='+(xForm.Components[i] as TEdit).Text);

      for i := 0 to xForm.ComponentCount-1 do
      if xForm.Components[i] is TTrackBar then
          l.Add(xForm.Components[i].Name+'='+IntToStr((xForm.Components[i] as TTrackBar).Position));

      for i := 0 to xForm.ComponentCount-1 do
      if xForm.Components[i] is TComboBox then
          l.Add(xForm.Components[i].Name+'='+IntToStr((xForm.Components[i] as TComboBox).ItemIndex));

      for i := 0 to xForm.ComponentCount-1 do
      if xForm.Components[i] is TShape then
          l.Add(xForm.Components[i].Name+'='+ColorToString((xForm.Components[i] as TShape).Brush.Color));

      for i := 0 to xForm.ComponentCount-1 do
      if xForm.Components[i] is TSpinEdit then
          l.Add(xForm.Components[i].Name+'='+IntToStr((xForm.Components[i] as TSpinEdit).Value));

      for i := 0 to xForm.ComponentCount-1 do
      if xForm.Components[i] is TRadioGroup then
          l.Add(xForm.Components[i].Name+'='+IntToStr((xForm.Components[i] as TRadioGroup).ItemIndex));
    {}
    l.Add(' ');
end;
//----------------------------------------------------------------------------//
end.
