object frmCamera: TfrmCamera
  Left = -1011
  Top = 19
  BorderStyle = bsSingle
  Caption = 'Canon Camera Control'
  ClientHeight = 562
  ClientWidth = 971
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    000001000200202002000100010030010000260000002020100001000400E802
    0000560100002800000020000000400000000100010000000000000100000000
    000000000000000000000000000000000000FFFFFF00000000003C0E703C2231
    8C442BCE73D4243FFC241800001808A80A900853D5100827EA101403E4281429
    EA282C15E4342C2868342C1384341424E828158B65A815ACE9A8158DE5A82DCD
    E9B42DC205B42DC729B415CFE5A815EFE9A809E7C39009F0179009FAAF901800
    0018243FFC242BCE73D422318C443C0E703C0000000083F18FC181C003818000
    00018000000180000001C0000003E0000007E0000007E0000007C0000003C000
    0003800000018000000180000001C0000003C0000003C0000003C00000038000
    00018000000180000001C0000003C0000003E0000007E0000007E0000007C000
    000380000001800000018000000181C0038183F18FC128000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000003333000000333003330000003333000030
    0030003300033000330003000300003030333300333003330033330303000030
    0300003333333333330000300300000330088888888888888888880330000000
    30070070700000707070080300000000300307070F7FFF070707080300000000
    30063070FFFFFF0070707803000000030303600000FFFF700700683030000003
    0306307070088870707038303000003033036007070887700707683303000030
    3306307070000770700638330300003033036007008770000703683303000003
    0307307007007770700638303000000303038000778708700703883030000003
    030830708F008880700838303000000303038000FF088F800703883030000030
    330838008F08FFF0700838330300003033088700707070000708E83303000030
    3308EE00078807707008E83303000003030E8E0088888880070E883030000003
    0308EE80788887703078E8303000000030088E8008888700008EE80300000000
    300EE88E000000070888880300000000300E8EEE80707070EE8E880300000003
    3000000000000000000000033000003003000033333333333300003003000030
    3033330033300333003333030300003000300033000330003300030003000033
    33000000333003330000003333000000000000000000000000000000000083F1
    8FC181C00381800000018000000180000001C0000003E0000007E0000007E000
    0007C0000003C0000003800000018000000180000001C0000003C0000003C000
    0003C0000003800000018000000180000001C0000003C0000003E0000007E000
    0007E0000007C000000380000001800000018000000181C0038183F18FC1}
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 289
    Height = 562
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    inline fraCameraState1: TfraCameraState
      Left = 1
      Top = 1
      Width = 287
      Height = 82
      Align = alTop
      TabOrder = 0
      inherited Panel1: TPanel
        Width = 287
        Height = 82
        inherited pnlModelName: TPanel
          Width = 283
        end
      end
    end
    inline fraCameraSettings1: TfraCameraSettings
      Left = 1
      Top = 83
      Width = 287
      Height = 265
      Align = alTop
      TabOrder = 1
      inherited Panel3: TPanel
        Width = 287
        Height = 265
      end
    end
    inline fraPresets1: TfraPresets
      Left = 1
      Top = 348
      Width = 287
      Height = 214
      Align = alTop
      TabOrder = 2
      inherited pnlProgress: TPanel
        Width = 287
      end
    end
  end
  inline fraPhoto1: TfraPhoto
    Left = 289
    Top = 0
    Width = 682
    Height = 562
    Align = alClient
    TabOrder = 1
    inherited pnlBehind: TPanel
      Width = 682
      Height = 562
      inherited Panel1: TPanel
        Width = 678
      end
      inherited Panel3: TPanel
        Top = 457
        Width = 678
      end
      inherited pnlStatus: TPanel
        Top = 537
        Width = 678
      end
      inherited pnlImage: TPanel
        Width = 678
        Height = 432
        inherited Image1: TImage
          Width = 676
          Height = 430
        end
      end
    end
  end
  object ApplicationEvents1: TApplicationEvents
    Left = 24
    Top = 352
  end
  object TimerMain: TTimer
    Interval = 2500
    OnTimer = TimerMainTimer
    Left = 272
    Top = 336
  end
end
