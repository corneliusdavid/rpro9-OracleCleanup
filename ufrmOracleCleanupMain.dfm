object frmOracleCleanupMain: TfrmOracleCleanupMain
  Left = 0
  Top = 0
  Caption = 'Oracle Uninstall Cleanup'
  ClientHeight = 311
  ClientWidth = 981
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    981
    311)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 297
    Height = 89
    AutoSize = False
    Caption = 
      'After a failed Retail Pro 9 install, Oracle is not uninstalled c' +
      'leanly. This means you can'#39't immediately re-run the Retail Pro 9' +
      ' installer as it will tell you to uninstall Oracle first. This p' +
      'rogram helps rectify that problem.'
    WordWrap = True
  end
  object btnStep1: TButton
    Left = 24
    Top = 108
    Width = 175
    Height = 53
    Caption = 'Step 1'
    CommandLinkHint = 'Delete Registry Keys'
    Style = bsCommandLink
    TabOrder = 0
    OnClick = btnStep1Click
  end
  object lbLog: TListBox
    Left = 311
    Top = 8
    Width = 661
    Height = 295
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
  object btnStep2: TButton
    Left = 24
    Top = 175
    Width = 175
    Height = 50
    Caption = 'Step 2'
    CommandLinkHint = 'Reboot the computer'
    Style = bsCommandLink
    TabOrder = 2
    OnClick = btnStep2Click
  end
  object btnStep3: TButton
    Left = 24
    Top = 239
    Width = 175
    Height = 58
    Caption = 'Step 3'
    CommandLinkHint = 'Delete Folders'
    Style = bsCommandLink
    TabOrder = 3
    OnClick = btnStep3Click
  end
end
