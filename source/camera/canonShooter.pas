unit canonShooter;
{ -------------------------------------------------------------------
  Unit:     canon Shooter
  Project:  CCCp
  group:    camera

  Purpose:  TShooter organizes the picture taking capabilities of the
            software.

  Author:   Wim° de Winter
  Date:     april 2020

  ----- copyright (C) WP. de Winter, Wageningen ---------------------
  ----- Free to use and change; all rights reserved ----------------- }

interface

uses {standard lib:} Windows, Messages, Classes, Sysutils, ExtCtrls,
     {Canon API:}    EDSDKType,
     {custom units:} cameraProperties, canonObject, canonBase, canonConnection,
                     jpegUtils, histogramFunctions;

type
    TFileEvent      = procedure (const filename: string) of object;
    TProgressEvent  = function (inPercent: Cardinal): boolean of object;

    TZoomInfo = record
        Level:      Cardinal;
        CoordSys:   EdsSize;
        ZoomPos:    EdsPoint;
        ZoomRect:   EdsRect;
        histogram:  THistogram;
        end;

    TShooter = class(TBaseCamera)
      private
        FFilePath: string;
        FLastFile: EdsDirectoryItemRef;
        FOnProgress: TProgressEvent;
        FOrientation: TOrientation;
        FtempFileName: string;

        procedure downloadImage(directoryItem: EdsDirectoryItemRef);
        procedure SetfilePath(const Value: string);

      protected
        FZoomInfo: TZoomInfo;
        FOnNewFile: TFileEvent;
        function makeFileName(const proposedName: string): string; virtual;
        procedure ReadHistogram(const levels: Variant);
        procedure Progress(inPercent: Cardinal; var outCancel: EdsBool); override;
        procedure ObjectEvent(Event: Cardinal; objectRef: Pointer);      override;
        procedure StateEvent(Event: EdsStateEvent; inParamter: Cardinal);override;
      public
        constructor Create(connection: TConnection; WindowHandle: HWND);

        procedure ShutterRelease();
        function  ShutterTime(): Double;
        procedure StartBulb();
        procedure StopBulb();
        procedure JPegFromRaw(rawFileName, JPegFileName: TFileName);

        property onNewFile:  TFileEvent     read FOnNewFile  write FOnNewFile;
        property onProgress: TProgressEvent read FOnProgress write FOnProgress;
        property filePath: string  read FfilePath write SetfilePath;
        property tempFileName: string read FtempFileName write FtempFileName;
        property Orientation: TOrientation read FOrientation write FOrientation;
      end;



implementation

uses {standard lib:} Forms, Math, Variants,
     {custom units:} EDSDKapiEx, EDSDKError, StrUtils;

const NullPoint: EdsPoint = (x:0; y:0);
{ TShooter }

constructor TShooter.Create(connection: TConnection; WindowHandle: HWND);
begin
    inherited Create(connection, WindowHandle);
    FFilePath   := ExtractFilePath(Application.ExeName);
    FLastFile   := nil;
    FOnNewFile  := nil;
    FOnProgress := nil;
    FOrientation:= po0Degrees;
end;


procedure TShooter.ObjectEvent(Event: Cardinal; objectRef: Pointer);
    begin
    if (Event = kEdsObjectEvent_DirItemRequestTransfer) then
        downloadImage(EdsDirectoryItemRef(objectRef));

    if Assigned(objectRef) then
        Release(objectRef)
end;


procedure TShooter.downloadImage(directoryItem: EdsDirectoryItemRef);
var dirInfo: EdsDirectoryItemInfo;
    evfImage: EdsEvfImageRef;
    stream: EdsStreamRef;
    fileName: string;
begin
    dirInfo := GetDirectoryItemInfo(directoryItem);

    FLastFile   := directoryItem;
    fileName    := makeFileName(IncludeTrailingPathDelimiter(FFilePath) + string(dirInfo.szFileName));

    stream := CreateFileStream(PChar(fileName), kEdsFileCreateDisposition_CreateAlways, kEdsAccess_ReadWrite);
    try
        // set progress call back:
        SetProgressCallback(stream, FProgressHandler, kEdsProgressOption_Periodically, cardinal(Self));

        try
            evfImage:= CreateEvfImageRef(stream);
            Download(directoryItem, dirInfo.size, stream);
            DownloadComplete(directoryItem);
            FZoomInfo.Level     := 255;
            FZoomInfo.ZoomPos   := NullPoint;
        except
            DownloadCancel(directoryItem);
            raise
        end { try };
    finally
        Release(stream);
    end { try };

    if not FileExists(filename) then
        raiseError(EDS_ERR_FILE_NOT_FOUND);


    if LowerCase(RightStr(filename, 4)) = '.jpg' then
        jpegUtils.setOrientation(filename, FOrientation);

    if Assigned(FOnNewFile) then
        FOnNewFile(filename);
end;





procedure TShooter.ShutterRelease;
begin
//    SendCommand(kEdsCameraCommand_TakePicture);
    SendCommand(kEdsCameraCommand_PressShutterButton, kEdsCameraCommand_ShutterButton_Completely);
    SendCommand(kEdsCameraCommand_PressShutterButton, kEdsCameraCommand_ShutterButton_OFF);
end;


procedure TShooter.StartBulb;
begin
    SendCommand(kEdsCameraCommand_BulbStart);
end;


procedure TShooter.StopBulb;
begin
    SendCommand(kEdsCameraCommand_BulbEnd);
end;


procedure TShooter.Progress(inPercent: Cardinal; var outCancel: EdsBool);
begin
    inherited;
    if Assigned(FOnProgress) then
        outCancel := IfThen(FOnProgress(inPercent), 1, 0);
end;



procedure TShooter.SetfilePath(const Value: string);
var capacity: EdsCapacity;
begin
    FfilePath := Value;
    if Get['SaveTo'] = kEdsSaveTo_Camera then
        SetProperty(kEdsPropID_SaveTo, Integer(kEdsSaveTo_Host));

    capacity.numberOfFreeClusters := EdsInt32($7FFFFFFF);
    capacity.bytesPerSector := EdsInt32($1000);
    capacity.reset := EdsInt32(1);
    SetCapacity(Handle, capacity);
end;



procedure TShooter.StateEvent(Event: EdsStateEvent; inParamter: Cardinal);
begin
    case Event of
    kEdsStateEvent_JobStatusChanged:;
    //kEdsStateEvent_StateError:;
	kEdsStateEvent_AfResult:;
	kEdsStateEvent_BulbExposureTime:;
    else
        inherited;
    end { case };
end;

function TShooter.makeFileName(const proposedName: string): string;
var i:  Integer;
    p, n, x: string;
begin
    Result := proposedName;
    if FileExists(Result) then
        begin
        p := ExtractFilePath(proposedName);
        n := ChangeFileExt(ExtractFileName(proposedName), '');
        x := ExtractFileExt(proposedName);
        i := 0;
        while FileExists(Result) do
            begin
            Inc(i);
            Result := Format('%s%s_%d%s', [p, StringReplace(n, '.', '', []), i, x]);
            end { while };
        end { if };
end;


procedure   TShooter.JPegFromRaw(rawFileName, JPegFileName: TFileName);
var rawStream, jpgStream: EdsStreamRef;
    imgRef: EdsImageRef;
    imageInfo: EdsImageInfo;
    jpgQuality: EdsSaveImageSetting;
const iccProfile = 'C:\WINDOWS\system32\spool\drivers\color\AdobeRGB1998.icc';
begin

    try
        jpgQuality.JPEGQuality      := 8;
        (**)
        jpgQuality.iccProfileStream := nil;
        (*)
        jpgQuality.iccProfileStream := CreateFileStream(PChar(iccProfile),
                                      kEdsFileCreateDisposition_OpenExisting,
                                      kEdsAccess_Read);
        (**)
//        jpgQuality.reserved         := 0;

        rawStream := CreateFileStream(PChar(rawFileName),
                                      kEdsFileCreateDisposition_OpenExisting,
                                      kEdsAccess_Read);
        jpgStream := CreateFileStream(PChar(JPegFileName),
                                      kEdsFileCreateDisposition_CreateAlways,
                                      kEdsAccess_Write);

        imgRef    := CreateImageRef(rawStream);
        //imageInfo := GetImageInfo(imgRef, kEdsImageSrc_FullView);

        SaveImage(imgRef, kEdsTargetImageType_Jpeg, jpgQuality, jpgStream);

    finally
        Release(rawStream);
        Release(jpgStream);
//        Release(jpgQuality.iccProfileStream);
        Release(imgRef);
    end { try };
end;


function TShooter.ShutterTime: Double;
var tvCode: Byte;
    tv: Double absolute Result;
begin
    tvCode := Get[kEdsPropID_Tv];
    case tvCode of
    $00: tv := 0;           $0C: tv := 0;           $10: tv := 30.0;        $13: tv := 25.0;        $14: tv := 20.0;
    $15: tv := 20.0;        $18: tv := 15.0;        $1B: tv := 13.0;        $1C: tv := 10.0;        $1D: tv := 10.0;
    $20: tv := 8.0;         $23: tv := 6.0;         $24: tv := 6.0;         $25: tv := 5.0;         $28: tv := 4.0;
    $2B: tv := 3.2;         $2C: tv := 3.0;         $2D: tv := 2.5;         $30: tv := 2.0;         $33: tv := 1.6;
    $34: tv := 1.5;         $35: tv := 1.3;         $38: tv := 1.0;         $3B: tv := 0.8;         $3C: tv := 0.7;
    $3D: tv := 0.6;         $40: tv := 0.5;         $43: tv := 0.4;         $44: tv := 0.3;         $45: tv := 0.3;
    $48: tv := 0.25;        $4B: tv := 0.2;         $4C: tv := 0.166666;    $4D: tv := 0.166666;    $50: tv := 0.125;
    $53: tv := 0.1;         $54: tv := 0.1;         $55: tv := 0.076923;    $58: tv := 0.066666;    $5B: tv := 0.05;
    $5C: tv := 0.05;        $5D: tv := 0.04;        $60: tv := 0.033333;    $63: tv := 0.025;       $64: tv := 0.022222;
    $65: tv := 0.02;        $68: tv := 0.016666;    $6B: tv := 0.0125;      $6C: tv := 0.011111;    $6D: tv := 0.01;
    $70: tv := 0.008;       $73: tv := 0.00625;     $74: tv := 0.005555;    $75: tv := 0.005;       $78: tv := 0.004;
    $7B: tv := 0.003125;    $7C: tv := 0.002857;    $7D: tv := 0.0025;      $80: tv := 0.002;       $83: tv := 0.001562;
    $84: tv := 0.001333;    $85: tv := 0.00125;     $88: tv := 0.001;       $8B: tv := 0.0008;      $8C: tv := 0.000666;
    $8D: tv := 0.000625;    $90: tv := 0.0005;      $93: tv := 0.0004;      $94: tv := 0.000333;    $95: tv := 0.000312;
    $98: tv := 0.00025;     $9B: tv := 0.0002;      $9C: tv := 0.000166;    $9D: tv := 0.000156;    $A0: tv := 0.000125;
    end { case };
end;



procedure TShooter.ReadHistogram(const levels: Variant);
var i, s:  Integer;
    v: EdsUInt32;
begin
    s :=  1 + VarArrayHighBound(levels, 1) -  VarArrayLowBound(levels, 1);
    for i := 0 to High(THistogram) do
        begin
        v := levels[i];
        FZoomInfo.histogram[i] := {$IFDEF API_V_2}TRGB(v).Y{$ELSE}v and 255{$ENDIF};
        end { for };
end;




end.




