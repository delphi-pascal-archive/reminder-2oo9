object Form9: TForm9
  Left = 453
  Top = 111
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 320
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 411
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      411
      48)
    object Bevel2: TBevel
      Left = 0
      Top = 46
      Width = 411
      Height = 2
      Align = alBottom
    end
    object Label1: TLabel
      Left = 42
      Top = 5
      Width = 65
      Height = 13
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 42
      Top = 21
      Width = 237
      Height = 13
      Caption = #1042#1099' '#1084#1086#1078#1077#1090#1077' '#1080#1079#1084#1077#1085#1080#1090#1100' '#1094#1074#1077#1090#1086#1074#1091#1102' '#1075#1072#1084#1084#1091' '#1086#1073#1088#1072#1079#1072'.'
    end
    object Image9: TImage
      Left = 5
      Top = 4
      Width = 32
      Height = 32
      Anchors = [akTop, akRight]
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
        00001008060000001FF3FF610000000467414D410000AFC837058AE900000019
        74455874536F6674776172650041646F626520496D616765526561647971C965
        3C000002E04944415478DA8D935F4853511CC7BFE75CB74CB7BBCD9CCAE69FDC
        688BFE584251D14B2F86A1160412F9504990254B09061949612926B297A28832
        F2CD8724A4B0CC88A007B510CAC250749B7275E936F37A77676EEA6E7737124A
        A57E703870CEF97E7EBFF33DBF432449C25AF1ECE276B53CA5320C05181A2C72
        0D44D73A47D602C4C584A15ECA90149A402143BE2381E61EBED11FFD27E079D5
        0E355551BF36C3A4D3992D204C02443F87F0AC6F0E94A415D4F645D705745ECA
        53C49A74B34E9FB525BE0D504686A8C14F8D2214E0E662CB482BAAEB8DAE0274
        3A77A919150D68D23359BDD90661DA0B71761A1225D8A837814DB72338392483
        3861311A339E747D88AE00BA2EE7AB29131767B16CA62C9EF2605E9C81A9F8B6
        02F73CADC286A45468332CF07B87119CE084858598B1B2F56394BCBA92AF960D
        0A688CD92C6BB6839F1EC53C3F834D054DC8B5584129C54CD08FF70FCE223149
        0F9D291B9323A398F6FA84C8C2B291745FDBDB9B9C96B59F35C9E229B72C0E22
        FD4833B27372410859F12718F0E375D329246A3448C9CC003734069FDBDF47BA
        6FEE2B94403A1353B2E99CFF9B9477FA31D1EA0C4AE6BF4314783CBA50025DAA
        56AE201093978A140F3AAF1F285C94A4ABE386D283E7CE5792482482FAFA7A05
        12AF223E6A6A6AA052A970FFDE5DF85FB40ED2E54567E3BB91AE3F9EB1B9B939
        545151A189C562686C6C84C562919B88C1D8D8189C4EA702A8ABAB03C7715BDB
        DADA8657F541434343C8E17068E26B320C56AB7505505D5DAD006A6B6B15407B
        7BFB2F80E3CD99BC70E8C74E910F9723C81C3ABAE73853B2FB185C2E176C369B
        720DAFD70B198C97BE0E740F75C9FD217E0D85C427C2ACF88994779C986019D6
        AC4DD6800FF308BB97505F7A0B2D2D2DB0DBED4A056EB71B65656578387C0706
        1D8BB9791E1E6E1C03FD836152DA5AFC36C48B56993699C0ABB7B1117DD42C65
        093939399678F6DF46F6F4F478A4CD4BEC8221AC1516439F4541B4C8957F21EB
        7DE7FF8D9FFFAC4A208D2522560000000049454E44AE426082}
      Stretch = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 278
    Width = 411
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      411
      42)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 411
      Height = 2
      Align = alTop
    end
    object Button2: TButton
      Left = 329
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1055#1088#1080#1085#1103#1090#1100
      Default = True
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 249
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object ListBox1: TListBox
    Left = 8
    Top = 56
    Width = 121
    Height = 209
    Style = lbOwnerDrawFixed
    ItemHeight = 25
    Items.Strings = (
      #1043#1083#1072#1074#1085#1099#1077
      #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077)
    TabOrder = 2
    OnClick = ListBox1Click
  end
  object PageControl1: TPageControl
    Left = 136
    Top = 56
    Width = 265
    Height = 209
    ActivePage = TabSheet1
    Style = tsFlatButtons
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      TabVisible = False
      object Label3: TLabel
        Left = 0
        Top = 152
        Width = 191
        Height = 13
        Caption = #1050#1086#1083'-'#1074#1086' '#1087#1086#1074#1090#1086#1088#1086#1074' '#1072#1085#1080#1084#1072#1094#1080' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      end
      object Label4: TLabel
        Left = 0
        Top = 176
        Width = 201
        Height = 13
        Caption = #1042#1088#1077#1084#1103' '#1087#1086#1082#1072#1079#1072' '#1086#1073#1088#1072#1079#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' ('#1089#1077#1082'.)'
      end
      object Label6: TLabel
        Left = 0
        Top = 120
        Width = 193
        Height = 13
        Caption = #1042#1088#1077#1084#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' ('#1089#1077#1082'.)'
      end
      object AutoRun: TCheckBox
        Left = 0
        Top = 0
        Width = 249
        Height = 17
        Caption = #1047#1072#1087#1091#1089#1082#1072#1090#1100#1089#1103' '#1089' '#1089#1080#1089#1090#1077#1084#1086#1081
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object StayOnTop: TCheckBox
        Left = 0
        Top = 16
        Width = 249
        Height = 17
        Caption = #1055#1086#1074#1077#1088#1093' '#1074#1089#1077#1093' '#1086#1082#1086#1085
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object RepeatAnim: TSpinEdit
        Left = 208
        Top = 149
        Width = 46
        Height = 22
        MaxValue = 1000
        MinValue = 1
        TabOrder = 2
        Value = 5
      end
      object RepeatFaces: TSpinEdit
        Left = 208
        Top = 173
        Width = 46
        Height = 22
        MaxValue = 1000
        MinValue = 1
        TabOrder = 3
        Value = 10
      end
      object RunHiden: TCheckBox
        Left = 0
        Top = 32
        Width = 249
        Height = 17
        Caption = #1047#1072#1087#1091#1089#1082#1072#1090#1100#1089#1103' '#1089#1082#1088#1099#1090#1099#1084
        TabOrder = 4
      end
      object AutoHideMessages: TCheckBox
        Left = 0
        Top = 96
        Width = 249
        Height = 17
        Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1089#1082#1088#1099#1074#1072#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
        TabOrder = 5
      end
      object MessageShowTime: TSpinEdit
        Left = 208
        Top = 117
        Width = 46
        Height = 22
        MaxValue = 1000
        MinValue = 1
        TabOrder = 6
        Value = 10
      end
      object MessagesToTray: TCheckBox
        Left = 0
        Top = 80
        Width = 249
        Height = 17
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074#1089#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' '#1074' '#1090#1088#1077#1077
        TabOrder = 7
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      TabVisible = False
      OnShow = TabSheet2Show
      object ThemeColor: TShape
        Left = 1
        Top = 27
        Width = 18
        Height = 17
      end
      object Label5: TLabel
        Left = 0
        Top = 61
        Width = 162
        Height = 13
        Caption = #1055#1088#1086#1079#1088#1072#1095#1085#1086#1089#1090#1100' '#1086#1082#1085#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1081':'
      end
      object UseColorTheme: TCheckBox
        Left = 0
        Top = 0
        Width = 217
        Height = 17
        Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1094#1074#1077#1090#1086#1074#1091#1102' '#1089#1093#1077#1084#1091
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 24
        Top = 27
        Width = 225
        Height = 17
        BevelOuter = bvLowered
        TabOrder = 1
        object Image1: TImage
          Left = 1
          Top = 1
          Width = 223
          Height = 15
          Align = alClient
          OnMouseDown = Image1MouseDown
        end
      end
      object AlphaBlendMessages: TTrackBar
        Left = 0
        Top = 80
        Width = 254
        Height = 29
        Max = 255
        Frequency = 10
        Position = 250
        TabOrder = 2
        TickMarks = tmBoth
        TickStyle = tsNone
      end
    end
  end
end
