object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Example Read a Simple File XML'
  ClientHeight = 512
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object TopPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 637
    Height = 41
    Align = alTop
    TabOrder = 0
    object ButtonExit: TButton
      AlignWithMargins = True
      Left = 556
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
  object mXMLView: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 50
    Width = 637
    Height = 459
    Align = alClient
    Lines.Strings = (
      '')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
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
  object OpenDialog: TOpenDialog
    DefaultExt = '*.xml'
    Filter = 'All type|*.*|xml|*.xml'
    Left = 120
    Top = 84
  end
end
