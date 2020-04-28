object fraCameraSettings: TfraCameraSettings
  Left = 0
  Top = 0
  Width = 289
  Height = 285
  TabOrder = 0
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 289
    Height = 285
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label8: TLabel
      Left = 16
      Top = 24
      Width = 42
      Height = 13
      Caption = 'Ae mode'
    end
    object Label9: TLabel
      Left = 16
      Top = 56
      Width = 66
      Height = 13
      Caption = 'Exposure time'
    end
    object Label10: TLabel
      Left = 16
      Top = 88
      Width = 40
      Height = 13
      Caption = 'Aperture'
    end
    object Label11: TLabel
      Left = 16
      Top = 120
      Width = 14
      Height = 13
      Caption = 'Iso'
    end
    object Label12: TLabel
      Left = 16
      Top = 152
      Width = 70
      Height = 13
      Caption = 'White Balance'
    end
    object Label13: TLabel
      Left = 16
      Top = 184
      Width = 55
      Height = 13
      Caption = 'Drive Mode'
    end
    object Label20: TLabel
      Left = 16
      Top = 216
      Width = 62
      Height = 13
      Caption = 'Image quality'
    end
    object cmbAeMode: TComboBox
      Left = 96
      Top = 20
      Width = 177
      Height = 21
      Color = cl3DLight
      Enabled = False
      ItemHeight = 13
      TabOrder = 0
      OnChange = comboSettingsChanged
      Items.Strings = (
        'Program      '
        'Tv           '
        'Av           '
        'Manual       '
        'Bulb         '
        'A_DEP        '
        'DEP          '
        'Custom       '
        'Lock         '
        'Green        '
        'NightPortrait'
        'Sports       '
        'Portrait     '
        'Landscape    '
        'Closeup      '
        'FlashOff     '
        'CreativeAuto '
        'Movie        '
        'PhotoInMovie ')
    end
    object cmbExpTime: TComboBox
      Left = 96
      Top = 52
      Width = 177
      Height = 21
      Color = cl3DLight
      ItemHeight = 13
      TabOrder = 1
      OnChange = comboSettingsChanged
    end
    object cmbAperture: TComboBox
      Left = 96
      Top = 84
      Width = 177
      Height = 21
      Color = cl3DLight
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
      OnChange = comboSettingsChanged
    end
    object cmbISO: TComboBox
      Left = 96
      Top = 116
      Width = 177
      Height = 21
      Color = cl3DLight
      Enabled = False
      ItemHeight = 13
      TabOrder = 3
      OnChange = comboSettingsChanged
    end
    object cmbWhiteBalance: TComboBox
      Left = 96
      Top = 148
      Width = 177
      Height = 21
      Color = cl3DLight
      Enabled = False
      ItemHeight = 13
      TabOrder = 4
      OnChange = comboSettingsChanged
    end
    object cmbDriveMode: TComboBox
      Left = 96
      Top = 180
      Width = 177
      Height = 21
      Color = cl3DLight
      Enabled = False
      ItemHeight = 13
      TabOrder = 5
      OnChange = comboSettingsChanged
    end
    object cmbImgQual: TComboBox
      Left = 96
      Top = 212
      Width = 177
      Height = 21
      Color = cl3DLight
      Enabled = False
      ItemHeight = 13
      TabOrder = 6
      OnChange = comboSettingsChanged
    end
    object chkMirror: TCheckBox
      Left = 16
      Top = 240
      Width = 97
      Height = 17
      Caption = 'mirror lockup'
      TabOrder = 7
      OnClick = chkMirrorClick
    end
  end
end
