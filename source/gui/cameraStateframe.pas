unit cameraStateframe;
{ -------------------------------------------------------------------
  Unit:     camera State Frame
  Project:  CCCp
  group:    GUI

  Purpose:  Gui to watch the camera state (i.e. connected, battery &
            liveView).

  Author:   Wim° de Winter
  Date:     april 2020

  ----- copyright (C) WP. de Winter, Wageningen ---------------------
  ----- Free to use and change; all rights reserved ----------------- }

interface

uses {custom units:} CanonCamera, EDSDKType,
     {standard lib:} Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvProgressBar, StdCtrls, ExtCtrls;

type
  TfraCameraState = class(TFrame)
    Panel1: TPanel;
    shpConnect: TShape;
    Label1: TLabel;
    lblPowerSource: TLabel;
    barBatteryLevel: TAdvProgressBar;
    pnlModelName: TPanel;
    Timer1: TTimer;
    Label2: TLabel;
    Shape2: TShape;
    lblLiveView: TLabel;
    shpLiveView: TShape;
    lblZoom: TLabel;
    procedure Timer1Timer(Sender: TObject);
  private
    FCamera: TCamera;
    procedure checkBatteryLevel(Camera: TCamera);
    function getZoomFactor: string;
  public
    procedure setCamera(aCamera: TCamera);
  end;

implementation

uses Math;

{$R *.dfm}
procedure TfraCameraState.checkBatteryLevel(Camera: TCamera);
var BatteryLevel: integer;
begin
    BatteryLevel := Camera[kEdsPropID_BatteryLevel];
    with barBatteryLevel do
        if BatteryLevel in [0, 255] then
            begin
            Level2Color := $00a0a0a0;
            Position    := 50;
            lblPowerSource.Caption := 'AC Power';
            end
        else
            begin
            Level3Color := $0000FFCC;
            Position    := BatteryLevel;
            lblPowerSource.Caption := 'Battery';
            end;
end;


procedure TfraCameraState.setCamera(aCamera: TCamera);
begin
    FCamera := aCamera;
    Timer1.Enabled := True;
    pnlModelName.Caption := FCamera.ModelName;
end;



procedure TfraCameraState.Timer1Timer(Sender: TObject);
begin
    if Assigned(FCamera) then
        try
            checkBatteryLevel(FCamera);
            shpConnect.Brush.Color  := ifThen(FCamera.connected,  clGreen, clRed);
            shpLiveView.Brush.Color := ifThen(FCamera.inLiveView, clRed, clGray);
        except
            Timer1.Enabled          := False; // voorkom repetitie van fouten
            shpConnect.Brush.Color  := clRed;
        end { if };

    if Assigned(FCamera) then
        try
            lblZoom.Caption         := getZoomFactor;
        except
            lblZoom.Caption         := '???';
        end { if };
end;


function TfraCameraState.getZoomFactor: string;
begin
    case FCamera.LVZoom of
     1:     Result := 'zoom x1';
     5:     Result := 'zoom x5';
    10:     Result := 'zoom x10';
    else    Result := '';
    end { case };
end;

end.
