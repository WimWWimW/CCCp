object Frame1: TFrame1
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
  end
  object Button1: TButton
    Left = 16
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Button1'
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
  end
  object edtStepCount: TAdvSpinEdit
    Left = 168
    Top = 96
    Width = 73
    Height = 22
    Value = 0
    DateValue = 43932.863631898150000000
    HexValue = 0
    SpinFlat = True
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
  object ActionList1: TActionList
    Left = 8
    Top = 120
    object actRunStop: TAction
      Caption = 'start'
    end
  end
end
