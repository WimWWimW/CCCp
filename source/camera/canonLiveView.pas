unit canonLiveView;
{ -------------------------------------------------------------------
  Unit:     canon LiveView
  Project:  CCCp
  group:    camera

  Purpose:  TLiveViewer organizes the live-view capailities

  Author:   Wim° de Winter
  Date:     april 2020

  ----- copyright (C) WP. de Winter, Wageningen ---------------------
  ----- Free to use and change; all rights reserved ----------------- }

interface

uses {standard lib:} Windows, Messages, Classes, Sysutils, ExtCtrls, FMTBcd,
     {Canon API:}    EDSDKType,
     {custom units:} cameraProperties, canonObject, canonShooter, canonConnection;

type
    TLiveViewer = class(TShooter)
      private
        FIsInLiveView: Boolean;
        FPropZoom,
        FPropZoomPos,
        FPropImagePos,
        FPropZoomRect,
        FPropCoordSys,
        FPropHistogram: TCameraProperty;

        procedure StartLiveView;
        procedure StopLiveView;
        procedure SetLiveViewAF(AFMode: EdsEvfAFMode = Evf_AFMode_Quick);
        procedure SetLiveViewZoom(Zoom: Cardinal);
        procedure SetLiveViewZoomPosition(Point: EdsPoint);
        procedure setInLiveView(const Value: Boolean);
        procedure rotateZoomInfo();
      protected
        procedure afterConnection(); override;
      public
        function  GetLiveViewFrame: TFileName;
        procedure DriveLens(move: EdsEvfDriveLens);
        procedure rotate2Rectangles(var outSize, inSize, inPos: TPoint; mirrored: Boolean = False);
        property inLiveView:        Boolean read FIsInLiveView      write setInLiveView;
        property LVZoom:           Cardinal read FZoomInfo.Level    write SetLiveViewZoom;
        property LVZoomPosition:   EdsPoint read FZoomInfo.ZoomPos  write SetLiveViewZoomPosition;
        property ZoomInfo:        TZoomInfo read FZoomInfo;
      end;


implementation

uses {standard lib:} StrUtils, Variants,
     {custom units:} EDSDKapiEx, jpegUtils, CanonBase;


function Point(const p: Variant): EdsPoint;
begin
    Result.X := p[0];
    Result.Y := p[1];
end;


function Rect(const p: Variant): EdsRect;
begin
    Result.point.X      := p[0];
    Result.point.Y      := p[1];
    Result.size.width   := p[2];
    Result.size.height  := p[3];
end;


function Size(const p: Variant): EdsSize;
begin
    Result.width   := p[0];
    Result.height  := p[1];
end;



procedure TLiveViewer.StartLiveView;
begin
    SetProperty(kEdsPropID_Evf_OutputDevice, kEdsEvfOutputDevice_PC);
    FIsInLiveView := True;
end;



procedure TLiveViewer.StopLiveView;
begin
    SetProperty(kEdsPropID_Evf_OutputDevice, 0);
    FIsInLiveView := False;
end;



function TLiveViewer.GetLiveViewFrame(): TFileName;
var stream: EdsStreamRef;
    evfImage: EdsEvfImageRef;
    FileName: string;
begin
    if not Self.FIsInLiveView then
        Exit;

    FileName := self.tempFileName;
    if FileExists(FileName) then
        DeleteFile(FileName);

  { create file stream }
    stream  := CreateFileStream(PChar(fileName), kEdsFileCreateDisposition_CreateAlways, kEdsAccess_ReadWrite);
    try
        evfImage:= CreateEvfImageRef(stream);
        try
            DownloadEvfImage(Handle, evfImage);
            FZoomInfo.Level     :=       FPropZoom.getValue(evfImage);
            FZoomInfo.ZoomRect  := Rect( FPropZoomRect.getValue(evfImage));
            FZoomInfo.ZoomPos   := FZoomInfo.ZoomRect.point;
            FZoomInfo.CoordSys  := Size( FPropCoordSys.getValue(evfImage));

            readHistoGram(FPropHistogram.getValue(evfImage));
            Result  := ifThen(FileExists(Filename), FileName, '');
        finally
            Release(evfImage);
        end { try };

    finally
        Release(stream);
    end { try };

    jpegUtils.setOrientation(Result, Orientation);
    rotateZoomInfo();
end;


procedure TLiveViewer.SetLiveViewAF(AFMode: EdsEvfAFMode);
begin
    if not Self.FIsInLiveView then
        Exit;

    SendCommand(kEdsCameraCommand_DoEvfAf, EdsUInt32(AFMode));
end;


procedure TLiveViewer.SetLiveViewZoom(Zoom: Cardinal);
// The zoom ratio is set using EdsCameraRef, but obtained using live view image data,
// in other words, by using EdsEvfImageRef.
var data: EdsUInt32;
begin
    if not Self.FIsInLiveView then
        Exit;

    case Zoom of
    1:  data := EdsUInt32(kEdsEvfZoom_Fit);
    5:  data := EdsUInt32(kEdsEvfZoom_x5);
    10: data := EdsUInt32(kEdsEvfZoom_x10);
    else
        data := EdsUInt32(kEdsEvfZoom_Fit);
    end { case };

    SetPropertyData(Handle, kEdsPropID_Evf_Zoom, 0, Sizeof(data), data);
end;


procedure TLiveViewer.SetLiveViewZoomPosition(Point: EdsPoint);
var data: EdsPoint;
begin
    if not Self.FIsInLiveView then
        Exit;

    data.x := Point.X;
    Data.y := Point.Y;

    SetPropertyData(Handle, kEdsPropID_Evf_ZoomPosition, 0, Sizeof(data), data);
end;


procedure TLiveViewer.setInLiveView(const Value: Boolean);
begin
    if Value then
        StartLiveView
    else
        StopLiveView;
end;


procedure TLiveViewer.DriveLens(move: EdsEvfDriveLens);
begin
    SendCommand(kEdsCameraCommand_DriveLensEvf, EdsUInt32(move));
end;


procedure TLiveViewer.afterConnection;
begin
    inherited;

    FPropZoom      := self.properties[kEdsPropID_Evf_Zoom];
    FPropZoomPos   := self.properties[kEdsPropID_Evf_ZoomPosition];
    FPropImagePos  := self.properties[kEdsPropID_Evf_ImagePosition];
    FPropZoomRect  := self.properties[kEdsPropID_Evf_ZoomRect];
    FPropCoordSys  := self.properties[kEdsPropID_Evf_CoordinateSystem];
{$IFDEF API_V_2}
    FPropHistogram := self.properties[kEdsPropID_Evf_Histogram];
{$ELSE}
    FPropHistogram := self.properties[kEdsPropID_Evf_HistogramY];
{$ENDIF}
end;



procedure TLiveViewer.rotate2Rectangles(var outSize, inSize, inPos: TPoint; mirrored: Boolean);
    procedure swap(var P: TPoint);
    var z: Integer;
    begin
        z   := p.X;
        p.X := p.Y;
        p.Y := z;
    end;

begin
    if (Orientation = po0Degrees) then
        Exit

    else if (Orientation = po180Degrees) then
        begin
        inPos.x := outSize.x - (inPos.x + inSize.x);
        inPos.y := outSize.y - (inPos.y + inSize.y);
        end { else if }

    else if ((Orientation = po90Degrees) and not mirrored)
         or ((Orientation = po270Degrees)    and mirrored) then
        begin
        swap(TPoint(outSize));
        swap(TPoint(inPos));
        swap(TPoint(inSize));
        inPos.x := outSize.x - (inPos.x + inSize.x);
        end { else if }


    else if ((Orientation = po270Degrees) and not mirrored)
         or ((Orientation = po90Degrees)      and mirrored) then
        begin
        swap(TPoint(outSize));
        swap(TPoint(inPos));
        swap(TPoint(inSize));
        inPos.y := outSize.y - (inPos.y + inSize.y);
        end { else };
end;



procedure TLiveViewer.rotateZoomInfo;
begin
    with FZoomInfo do
        rotate2Rectangles(TPoint(CoordSys), TPoint(Zoomrect.size), TPoint(ZoomRect.point));
    FZoomInfo.ZoomPos   := FZoomInfo.ZoomRect.point;
end;

end.
