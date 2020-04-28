object fraNavigator: TfraNavigator
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  TabOrder = 0
  object pnlFull: TPanel
    Left = 8
    Top = -41
    Width = 185
    Height = 281
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object pnlZoom: TPanel
      Left = 56
      Top = 112
      Width = 57
      Height = 57
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = clWhite
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -43
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnMouseDown = pnlZoomMouseDown
      OnMouseMove = pnlZoomMouseMove
      OnMouseUp = pnlZoomMouseUp
    end
  end
end
