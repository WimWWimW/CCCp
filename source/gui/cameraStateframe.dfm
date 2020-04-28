object fraCameraState: TfraCameraState
  Left = 0
  Top = 0
  Width = 124
  Height = 105
  TabOrder = 0
  object Label2: TLabel
    Left = 40
    Top = 32
    Width = 52
    Height = 13
    Caption = 'Connected'
  end
  object Shape2: TShape
    Left = 16
    Top = 30
    Width = 17
    Height = 17
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 124
    Height = 105
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object shpConnect: TShape
      Left = 16
      Top = 37
      Width = 17
      Height = 17
    end
    object Label1: TLabel
      Left = 40
      Top = 39
      Width = 52
      Height = 13
      Caption = 'Connected'
    end
    object lblPowerSource: TLabel
      Left = 119
      Top = 23
      Width = 57
      Height = 12
      Alignment = taCenter
      AutoSize = False
      Caption = 'Battery'
    end
    object barBatteryLevel: TAdvProgressBar
      Left = 119
      Top = 39
      Width = 56
      Height = 17
      BackgroundColor = clBtnFace
      CompletionSmooth = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      Level0Color = clRed
      Level0ColorTo = 13290239
      Level1Color = 5483007
      Level1ColorTo = 11064319
      Level2Color = 10526880
      Level2ColorTo = 13303756
      Level3Color = 55552
      Level3ColorTo = 14811105
      Level1Perc = 10
      Level2Perc = 20
      Position = 50
      ShowBorder = True
      ShowGradient = False
      ShowPercentage = False
      ShowPosition = False
      Version = '1.2.0.1'
    end
    object lblLiveView: TLabel
      Left = 40
      Top = 63
      Width = 41
      Height = 13
      Caption = 'live view'
    end
    object shpLiveView: TShape
      Left = 16
      Top = 61
      Width = 17
      Height = 17
    end
    object lblZoom: TLabel
      Left = 87
      Top = 64
      Width = 9
      Height = 13
      Caption = '...'
    end
    object pnlModelName: TPanel
      Left = 2
      Top = 2
      Width = 120
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = '(no camera connected)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
  end
end
