object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Example Read a Simple XML Text'
  ClientHeight = 670
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object TopPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 628
    Height = 41
    Align = alTop
    TabOrder = 0
    object ButtonExecute: TButton
      AlignWithMargins = True
      Left = 89
      Top = 6
      Width = 137
      Height = 29
      Margins.Left = 5
      Margins.Top = 5
      Margins.Bottom = 5
      Action = ActionReadVersionEncoding
      Align = alLeft
      TabOrder = 0
    end
    object ButtonExit: TButton
      AlignWithMargins = True
      Left = 547
      Top = 6
      Width = 75
      Height = 29
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Action = ActionExit
      Align = alRight
      TabOrder = 1
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
      TabOrder = 2
    end
  end
  object mXMLSource: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 50
    Width = 628
    Height = 305
    Align = alTop
    Lines.Strings = (
      '')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object mXMLView: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 361
    Width = 628
    Height = 306
    Align = alClient
    Lines.Strings = (
      '')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 2
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
    object ActionReadVersionEncoding: TAction
      Caption = 'Read Version/Encoding'
      OnExecute = ActionReadVersionEncodingExecute
      OnUpdate = ActionReadVersionEncodingUpdate
    end
  end
end
