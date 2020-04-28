object fraPhoto: TfraPhoto
  Left = 0
  Top = 0
  Width = 660
  Height = 693
  TabOrder = 0
  object pnlBehind: TPanel
    Left = 0
    Top = 0
    Width = 660
    Height = 693
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 656
      Height = 23
      Align = alTop
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 2
      Top = 588
      Width = 656
      Height = 80
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        656
        80)
      object SpeedButton4: TSpeedButton
        Left = 8
        Top = 8
        Width = 23
        Height = 22
        Action = actOrientation
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object btnZoom: TSpeedButton
        Left = 376
        Top = 40
        Width = 75
        Height = 25
        Action = actZoom1x
        AllowAllUp = True
        Anchors = [akTop, akRight]
      end
      object Button1: TButton
        Left = 4
        Top = 48
        Width = 75
        Height = 25
        Action = actTakePict
        TabOrder = 0
      end
      object Button23: TButton
        Left = 616
        Top = 6
        Width = 33
        Height = 25
        Action = actDFplus3
        Anchors = [akTop, akRight]
        TabOrder = 1
      end
      object Button22: TButton
        Left = 576
        Top = 6
        Width = 33
        Height = 25
        Action = actDFplus2
        Anchors = [akTop, akRight]
        TabOrder = 2
      end
      object Button21: TButton
        Left = 536
        Top = 6
        Width = 33
        Height = 25
        Action = actDFplus1
        Anchors = [akTop, akRight]
        TabOrder = 3
      end
      object Button20: TButton
        Left = 496
        Top = 6
        Width = 33
        Height = 25
        Action = actAutoFocus
        Anchors = [akTop, akRight]
        TabOrder = 4
      end
      object Button19: TButton
        Left = 456
        Top = 6
        Width = 33
        Height = 25
        Action = actDFmin3
        Anchors = [akTop, akRight]
        TabOrder = 5
      end
      object Button18: TButton
        Left = 416
        Top = 6
        Width = 33
        Height = 25
        Action = actDFmin2
        Anchors = [akTop, akRight]
        TabOrder = 6
      end
      object Button17: TButton
        Left = 376
        Top = 6
        Width = 33
        Height = 25
        Action = actDFmin1
        Anchors = [akTop, akRight]
        TabOrder = 7
      end
      object btnLiveView: TButton
        Left = 575
        Top = 40
        Width = 75
        Height = 25
        Action = actLVstart
        Anchors = [akTop, akRight]
        TabOrder = 8
      end
      inline fraNavigator1: TfraNavigator
        Left = 86
        Top = 0
        Width = 100
        Height = 80
        HorzScrollBar.Visible = False
        VertScrollBar.Visible = False
        TabOrder = 9
        Visible = False
        inherited pnlFull: TPanel
          Left = 0
          Top = 0
          Width = 145
          Height = 80
          inherited pnlZoom: TPanel
            Top = 10
            Width = 30
            Height = 30
          end
        end
      end
      inline fraHistogram1: TfraHistogram
        Left = 191
        Top = 1
        Width = 144
        Height = 78
        TabOrder = 10
        inherited Image1: TImage
          Width = 144
          Height = 78
        end
      end
    end
    object pnlStatus: TPanel
      Left = 2
      Top = 668
      Width = 656
      Height = 23
      Align = alBottom
      Alignment = taRightJustify
      BevelOuter = bvLowered
      BorderStyle = bsSingle
      TabOrder = 2
    end
    object pnlImage: TPanel
      Left = 2
      Top = 25
      Width = 656
      Height = 563
      Align = alClient
      TabOrder = 3
      object Image1: TImage
        Left = 1
        Top = 1
        Width = 654
        Height = 561
        Align = alClient
        Proportional = True
        Stretch = True
      end
      object pbxZoomFocus: TPaintBox
        Left = 400
        Top = 111
        Width = 105
        Height = 105
        Color = clLime
        ParentColor = False
        Visible = False
        OnMouseDown = pbxZoomFocusMouseDown
        OnMouseMove = pbxZoomFocusMouseMove
        OnMouseUp = pbxZoomFocusMouseUp
        OnPaint = pbxZoomFocusPaint
      end
    end
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 192
    Top = 96
    object actTakePict: TAction
      Caption = 'Shutter'
      ShortCut = 32
      OnExecute = actTakePictExecute
      OnUpdate = EnabledIfConnected
    end
    object actLVstart: TAction
      AutoCheck = True
      Caption = 'start liveView'
      ShortCut = 16460
      OnExecute = actLVstartExecute
      OnUpdate = EnabledIfConnected
    end
    object actDFmin3: TAction
      Tag = 3
      Category = 'driveFocus'
      Caption = '<'
      ShortCut = 37
      OnExecute = FocusDrive
      OnUpdate = EnabledIfInLiveView
    end
    object actDFmin2: TAction
      Tag = 2
      Category = 'driveFocus'
      Caption = '<<'
      ShortCut = 8229
      OnExecute = FocusDrive
      OnUpdate = EnabledIfInLiveView
    end
    object actDFmin1: TAction
      Tag = 1
      Category = 'driveFocus'
      Caption = '<<<'
      ShortCut = 24613
      OnExecute = FocusDrive
      OnUpdate = EnabledIfInLiveView
    end
    object actAutoFocus: TAction
      Category = 'driveFocus'
      Caption = 'AF'
      Enabled = False
      OnExecute = FocusDrive
      OnUpdate = EnabledIfInLiveView
    end
    object actDFplus1: TAction
      Tag = 32769
      Category = 'driveFocus'
      Caption = '>'
      ShortCut = 39
      OnExecute = FocusDrive
      OnUpdate = EnabledIfInLiveView
    end
    object actDFplus2: TAction
      Tag = 32770
      Category = 'driveFocus'
      Caption = '>>'
      ShortCut = 8231
      OnExecute = FocusDrive
      OnUpdate = EnabledIfInLiveView
    end
    object actDFplus3: TAction
      Tag = 32771
      Category = 'driveFocus'
      Caption = '>>>'
      ShortCut = 24615
      OnExecute = FocusDrive
      OnUpdate = EnabledIfInLiveView
    end
    object actZoom1x: TAction
      Tag = 1
      Category = 'zoom'
      AutoCheck = True
      Caption = 'zoom'
      ShortCut = 16474
      OnExecute = EVFZoom
      OnUpdate = EnabledIfInLiveView
    end
    object actZoom5x: TAction
      Tag = 5
      Category = 'zoom'
      AutoCheck = True
      Caption = '5x'
      GroupIndex = 1
      OnExecute = EVFZoom
      OnUpdate = EnabledIfInLiveView
    end
    object actZoom10x: TAction
      Tag = 10
      Category = 'zoom'
      AutoCheck = True
      Caption = '10x'
      GroupIndex = 1
      OnExecute = EVFZoom
      OnUpdate = EnabledIfInLiveView
    end
    object actOrientation: TAction
      Caption = #173
      ShortCut = 16605
      OnExecute = actOrientationExecute
      OnUpdate = actOrientationUpdate
    end
  end
  object TimerLiveView: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerLiveViewTimer
    Left = 234
    Top = 96
  end
end
