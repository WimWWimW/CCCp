object fraPresets: TfraPresets
  Left = 0
  Top = 0
  Width = 276
  Height = 214
  TabOrder = 0
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 32
    Height = 13
    Caption = 'preset:'
  end
  object cmbPresets: TComboBox
    Left = 48
    Top = 13
    Width = 209
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnChange = loadPreset
  end
  object Button1: TButton
    Left = 16
    Top = 168
    Width = 75
    Height = 25
    Action = actRunStop
    TabOrder = 1
  end
  object radMode: TRadioGroup
    Left = 8
    Top = 40
    Width = 249
    Height = 89
    Caption = ' run... '
    Items.Strings = (
      'infinitely'
      'fixed # steps:')
    TabOrder = 2
    OnClick = radModeClick
  end
  object edtStepCount: TAdvSpinEdit
    Left = 168
    Top = 96
    Width = 73
    Height = 22
    Value = 1
    FloatValue = 1.000000000000000000
    TimeValue = 0.041666666666666660
    HexValue = 0
    SpinFlat = True
    Color = clSilver
    Enabled = False
    IncrementFloat = 0.100000000000000000
    IncrementFloatPage = 1.000000000000000000
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    MaxValue = 99
    MinValue = 1
    TabOrder = 3
    Visible = True
    Version = '1.5.1.0'
  end
  object chkShootLV: TCheckBox
    Left = 10
    Top = 136
    Width = 97
    Height = 17
    Caption = 'shoot in live view'
    TabOrder = 4
  end
  object Button2: TButton
    Left = 184
    Top = 168
    Width = 75
    Height = 25
    Action = actContinue
    TabOrder = 5
  end
  object pnlProgress: TPanel
    Left = 0
    Top = 196
    Width = 276
    Height = 18
    Align = alBottom
    BevelInner = bvLowered
    Caption = '- / -'
    TabOrder = 6
  end
  object ActionList1: TActionList
    Left = 8
    Top = 120
    object actRunStop: TAction
      AutoCheck = True
      Caption = 'start'
      OnExecute = actRunStopExecute
      OnUpdate = actRunStopUpdate
    end
    object actContinue: TAction
      Caption = 'Continue'
      Enabled = False
      OnExecute = actContinueExecute
    end
  end
  object TimerFocusRun: TTimer
    Enabled = False
    OnTimer = TimerFocusRunTimer
    Left = 88
    Top = 64
  end
  object TimerPause: TTimer
    Interval = 100
    OnTimer = TimerPauseTimer
    Left = 128
    Top = 64
  end
end
