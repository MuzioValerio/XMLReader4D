object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Example Load From Stream File XML'
  ClientHeight = 664
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 358
    Width = 639
    Height = 7
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 643
  end
  object mXMLView: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 368
    Width = 633
    Height = 293
    Align = alClient
    Lines.Strings = (
      '')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object TopPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 633
    Height = 41
    Align = alTop
    TabOrder = 1
    object ButtonExit: TButton
      AlignWithMargins = True
      Left = 552
      Top = 6
      Width = 75
      Height = 29
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Action = ActionExit
      Align = alRight
      TabOrder = 0
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 75
      Height = 29
      Margins.Left = 5
      Margins.Top = 5
      Margins.Bottom = 5
      Action = ActionExecute
      Align = alLeft
      TabOrder = 1
    end
    object EditPath: TEdit
      Left = 96
      Top = 9
      Width = 361
      Height = 23
      TabOrder = 2
    end
    object Button2: TButton
      Left = 463
      Top = 8
      Width = 75
      Height = 25
      Action = ActionLoadFile
      TabOrder = 3
    end
  end
  object mXMLSource: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 50
    Width = 633
    Height = 305
    Align = alTop
    Lines.Strings = (
      '')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.xml'
    Filter = 'All type|*.*|xml|*.xml'
    Left = 120
    Top = 84
  end
  object ActionList: TActionList
    Left = 39
    Top = 84
    object ActionExit: TAction
      Caption = 'Exit'
      OnExecute = ActionExitExecute
    end
    object ActionExecute: TAction
      Caption = 'Execute'
      OnExecute = ActionExecuteExecute
    end
    object ActionLoadFile: TAction
      Caption = 'Load File'
      OnExecute = ActionLoadFileExecute
    end
  end
end
