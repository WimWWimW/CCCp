unit photoFrame;
{ -------------------------------------------------------------------
  Unit:     Photo frame
  Project:  CCCp
  group:    GUI

  Purpose:  Frame to view the photos taken and the liveView

  Author:   Wim° de Winter
  Date:     april 2020

  ----- copyright (C) WP. de Winter, Wageningen ---------------------
  ----- Free to use and change; all rights reserved ----------------- }

interface

uses {custom units:} canonCamera, navigatorFrame, histogramFrame, canonShooter,
     {standard lib:} Forms, SysUtils, Classes, ComCtrls, StdCtrls, Controls, ExtCtrls,
                     ActnList, Buttons, Windows, AdvPanel, Graphics;

type

  TfraPhoto = class(TFrame)
    pnlBehind: TPanel;
    Image1: TImage;
    Panel1: TPanel;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Panel3: TPanel;
    Button1: TButton;
    btnLiveView: TButton;
    ActionList: TActionList;
    actTakePict: TAction;
    actLVstart: TAction;
    actDFmin3: TAction;
    actDFmin2: TAction;
    actDFmin1: TAction;
    actAutoFocus: TAction;
    actDFplus1: TAction;
    actDFplus2: TAction;
    actDFplus3: TAction;
    TimerLiveView: TTimer;
    btnZoom: TSpeedButton;
    actZoom1x: TAction;
    actZoom5x: TAction;
    actZoom10x: TAction;
    actOrientation: TAction;
    SpeedButton4: TSpeedButton;
    fraNavigator1: TfraNavigator;
    pnlStatus: TPanel;
    fraHistogram1: TfraHistogram;
    pbxZoomFocus: TPaintBox;
    pnlImage: TPanel;
    procedure EnabledIfConnected(Sender: TObject);
    procedure EnabledIfInLiveView(Sender: TObject);
    procedure actLVstartExecute(Sender: TObject);
    procedure actTakePictExecute(Sender: TObject);
    procedure FocusDrive(Sender: TObject);
    procedure TimerLiveViewTimer(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure EVFZoom(Sender: TObject);
    procedure actOrientationExecute(Sender: TObject);
    procedure pbxZoomFocusPaint(Sender: TObject);
    procedure pbxZoomFocusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbxZoomFocusMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pbxZoomFocusMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actOrientationUpdate(Sender: TObject);
  private
    FCurrent: TFileName;
    FCamera: TCamera;
    FOnNewFile: TNotifyEvent;
    FLastPos:   TPoint;
    FScale: Double;
    FMoving: Boolean;
    FLiveView: Boolean; // violates OaOO
    procedure navigatorChangedPosition(Left, Top: Integer);
    procedure updateZoomBox(info: TZoomInfo);
    procedure SetLiveView(const Value: Boolean);
    procedure ShowFile(const fileName: string); 
  protected
  public
    constructor Create(anOwner: TComponent); override;
    procedure   AfterConstruction(); override;
    procedure   imageDownloaded(const filename: string);
    procedure   SetCamera(const Value: TCamera);
    property LiveView: Boolean read FLiveView write SetLiveView;
    property OnNewFile: TNotifyEvent read FOnNewFile write FOnNewFile;
  end;

implementation

{$R *.dfm}

uses {standard lib:} Math, StrUtils, Menus, JPEG,
     {custom units:} EDSDKType, jpegUtils, canonLiveView, histogramFunctions, CanonBase,
  Variants;

type TPhotoImage = class(TImage) end;

{ TfraPhoto }

constructor TfraPhoto.Create(anOwner: TComponent);
begin
    inherited;
    FCamera                 := nil;
    FOnNewFile              := nil;
    pnlImage.DoubleBuffered := True;
    FMoving                 := False;
end;


procedure TfraPhoto.AfterConstruction;
begin
    inherited;
    actDFmin3.tag  := ord(kEdsEvfDriveLens_Near1);
    actDFmin2.tag  := ord(kEdsEvfDriveLens_Near2);
    actDFmin1.tag  := ord(kEdsEvfDriveLens_Near3);
    actDFplus1.tag := ord(kEdsEvfDriveLens_Far1);
    actDFplus2.tag := ord(kEdsEvfDriveLens_Far2);
    actDFplus3.tag := ord(kEdsEvfDriveLens_Far3);

    fraNavigator1.onReposition := navigatorChangedPosition;
end;


procedure TfraPhoto.SetCamera(const Value: TCamera);
begin
    FCamera := Value;
    FCamera.onNewFile := imageDownloaded;
end;



procedure TfraPhoto.imageDownloaded(const fileName: string);
var h: THistogram;
var i: Integer; bmp: TBitmap;
begin
    if Lowercase(ExtractFileExt(fileName)) = '.jpg' then
        begin
        showFile(fileName);
        fraHistogram1.updateData(histogram(fileName));

        if Assigned(FOnNewFile) then
            FOnNewFile(self);
        end { if }
    else
        begin
        FCamera.JPegFromRaw(fileName, FCamera.tempFileName);
        imageDownloaded(FCamera.tempFileName);
        end;
end;



procedure TfraPhoto.EnabledIfConnected(Sender: TObject);
begin
    (Sender as TAction).Enabled := Assigned(FCamera) and FCamera.connected;
end;



procedure TfraPhoto.EnabledIfInLiveView(Sender: TObject);
begin
    (Sender as TAction).Enabled := Assigned(FCamera) and FCamera.inLiveView;
end;



procedure TfraPhoto.actTakePictExecute(Sender: TObject);
begin
    FCamera.ShutterRelease;
end;



procedure TfraPhoto.actLVstartExecute(Sender: TObject);
begin
    with (Sender as TAction) do
        begin
        Self.LiveView := Checked;
        Caption := ifThen(Checked, 'End', 'Start') + ' Live View';
        end { with };
end;



procedure TfraPhoto.FocusDrive(Sender: TObject);
var move: EdsEvfDriveLens;
begin
    move := EdsEvfDriveLens((Sender as TAction).tag);

    FCamera.DriveLens(move);
end;



procedure TfraPhoto.TimerLiveViewTimer(Sender: TObject);
var frame: string;
begin
    Self.LiveView := FCamera.inLiveView;
    try
        try
            frame := FCamera.GetLiveViewFrame();
        except
            Exit;
        end { try };

        showFile(frame);

        fraHistogram1.updateData(FCamera.ZoomInfo.histogram);
        fraNavigator1.UpdatePosition(FCamera.ZoomInfo);
        updateZoomBox(FCamera.ZoomInfo);
    except
    end;
end;


procedure TfraPhoto.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
    Handled := False;
end;


procedure TfraPhoto.EVFZoom(Sender: TObject);
begin
    FCamera.LVZoom  := ifThen((Sender as TAction).Checked, 5, 1);
    btnZoom.Down    := (Sender as TAction).Checked;
end;



procedure TfraPhoto.actOrientationExecute(Sender: TObject);
const arrows : array[TOrientation] of char = (#$AD, #$AE, #$AF, #$AC);
begin
    with (Sender as TAction) do
        begin
        FCamera.Orientation := TOrientation( (Ord(FCamera.Orientation) + 1) mod 4);
        Caption := arrows[FCamera.Orientation];
        end { with };

    if not LiveView then
        begin
        jpegUtils.setOrientation(FCurrent, po90Degrees);
        ShowFile(FCurrent);
        end { if };
end;



procedure TfraPhoto.navigatorChangedPosition(Left, Top: Integer);
var p: TZoomInfo;
begin
    p := FCamera.ZoomInfo;
    with p do
        begin
        ZoomRect.point.x := Left;
        ZoomRect.point.y := Top;
        FCamera.rotate2Rectangles(TPoint(CoordSys), TPoint(Zoomrect.size), TPoint(ZoomRect.point), True);
        FCamera.LVZoomPosition := ZoomRect.point;
        end { with };
end;



procedure TfraPhoto.pbxZoomFocusPaint(Sender: TObject);
begin
    with (Sender as TPaintBox).Canvas do
        begin
        Brush.Style := bsClear;
        pen.Style := psSolid;
        pen.Width := 3;
        pen.Color := clRed;
        Rectangle((Sender as TPaintBox).ClientRect);
        end { with };
end;



procedure TfraPhoto.pbxZoomFocusMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FLastPos    := pbxZoomFocus.ClientToScreen(Point(x, y));
    FMoving     := True;
end;



procedure TfraPhoto.pbxZoomFocusMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var p: TPoint;
    r: TRect;
begin
    r := TPhotoImage(Image1).DestRect();

    if ssLeft in Shift then
        with pbxZoomFocus do
            begin
            p       := ClientToScreen(Point(x, y));
            Left    := Max(0, Min(Left + p.X - FLastPos.X, r.Right - Width));
            Top     := Max(0, Min(Top  + p.Y - FLastPos.Y, r.Bottom - Height));
            FLastPos:= p;
            end { with };
end;



procedure TfraPhoto.pbxZoomFocusMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var p: TZoomInfo;
begin
    p := FCamera.ZoomInfo;
    with p do
        begin
        ZoomRect.point.x := Round(pbxZoomFocus.Left * FScale);
        ZoomRect.point.y := Round(pbxZoomFocus.Top  * FScale);
        FCamera.rotate2Rectangles(TPoint(CoordSys), TPoint(Zoomrect.size), TPoint(ZoomRect.point), True);
        FCamera.LVZoomPosition := ZoomRect.point;
        end { with };
    FMoving := False;
end;



procedure TfraPhoto.updateZoomBox(info: TZoomInfo);
begin
    if FMoving then
        Exit;
        
    if info.Level > 1 then
        pbxZoomFocus.Visible := False
    else
        begin
        pbxZoomFocus.Visible := True;
        FScale := info.CoordSys.height / TPhotoImage(Image1).DestRect().Bottom;
        with pbxZoomFocus do
            begin
            Top     := Round(info.ZoomRect.point.y     / FScale);
            Left    := Round(info.ZoomRect.point.x     / FScale);
            Width   := Round(info.ZoomRect.size.width  / FScale);
            Height  := Round(info.ZoomRect.size.height / FScale);
            end { with };
        end;
end;


procedure TfraPhoto.SetLiveView(const Value: Boolean);
begin
    if Value <> FLiveView then
        begin
        FLiveView               := Value;
        TimerLiveView.Enabled   := FLiveView;
        FCamera.inLiveView      := FLiveView;
        pbxZoomFocus.Visible    := FLiveView;
        fraNavigator1.Visible   := FLiveView;
        fraHistogram1.Visible   := True; //FLiveView;
        end { if };
end;



procedure TfraPhoto.ShowFile(const fileName: string);
begin
    FCurrent := filename;
    Image1.Picture.LoadFromFile(fileName);
    pnlStatus.Caption := FileName;
end;

procedure TfraPhoto.actOrientationUpdate(Sender: TObject);
begin
    (Sender as TAction).Enabled := fileExists(FCurrent);
end;

end.


