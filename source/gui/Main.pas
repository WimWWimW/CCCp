unit Main;
{ -------------------------------------------------------------------
  Unit:     Main
  Project:  CCCp - Canon Camera Control program

  Doel:     focus stacking by driving the focus motor

  Auteur:   Wim° de Winter
  Datum:    april 2020

  ----- copyright (C) WP. de Winter, Wageningen ---------------------
  ----- Free to use and change; all rights reserved ----------------- }

interface

uses {custom units:} canonCamera, EDSDKType, CameraSettingsFrame, cameraStateframe, canonConnection,
     {standard lib:}   Classes, Messages, ActnList, ExtCtrls, AppEvnts, Forms, StdCtrls, Controls,
  Windows, ComCtrls, photoFrame, presetsFrame, AdvPanel;

type
    TfrmCamera = class(TForm)
        ApplicationEvents1: TApplicationEvents;
        fraCameraSettings1: TfraCameraSettings;
        fraCameraState1: TfraCameraState;
        Panel1: TPanel;
        fraPhoto1: TfraPhoto;
        fraPresets1: TfraPresets;
        TimerMain: TTimer;
        procedure FormCreate(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
        procedure actTakePictUpdate(Sender: TObject);
        procedure actTakePictExecute(Sender: TObject);
        procedure actAutoFocusExecute(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure TimerMainTimer(Sender: TObject);
      private
        FConnection: TConnection;
        FCamera: TCamera;
        function doProgress(inPercent: Cardinal): boolean;
        procedure ConnectCamera;
      protected
        procedure WndProc(var aMessage: TMessage); override;
      public
        procedure initialize;
        function Camera: TCamera;
    end;

var
    frmCamera: TfrmCamera;

function ShellExecute(hWnd: HWND; Operation, FileName, Parameters,
    Directory: PChar; ShowCmd: Integer): HINST; stdcall;

implementation

uses {standard lib:} SysUtils, Math, Dialogs, IniFiles,
     {custom units:} CanonObject, CanonBase, cameraEvents, EDSDKError;

{$R *.dfm}

function ShellExecute; external 'shell32.dll' name 'ShellExecuteA';


procedure TfrmCamera.FormCreate(Sender: TObject);
begin
    FConnection := TConnection.Create();
    FCamera     := nil;
end;


procedure TfrmCamera.FormDestroy(Sender: TObject);
begin
    FCamera.Free;
    FConnection.Free;
end;


procedure TfrmCamera.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if Assigned(FCamera) then
        try
            TimerMain.Enabled := False;
            Camera.Disconnect();
        except on E: ECameraError do
            MessageDlg(E.message, mtError, [mbOK], 0);
        end { try };
end;


procedure TfrmCamera.ConnectCamera();
begin
    FreeAndNil(FCamera);
    if FConnection.state = csReady then
        try
            FCamera := TCamera.Create(FConnection, self.Handle);
            FCamera.Connect();
            initialize();
        except

        end { try };
end;


procedure TfrmCamera.initialize();
begin
    Camera.filePath := 'r:\';

    fraCameraSettings1.setCamera(Camera);
    fraCameraState1.setCamera(Camera);
    fraPhoto1.SetCamera(Camera);
    fraPresets1.setCamera(Camera);

    Camera.onNewFile            := fraPhoto1.imageDownloaded;
    fraPhoto1.OnNewFile         := fraPresets1.shotReady;
    Camera.onPropertiesChanged  := self.fraCameraSettings1.propertyChanged;
    Camera.onPropertyDescChanged:= self.fraCameraSettings1.propertyDescChanged;
    Camera.onProgress           := self.doProgress;

    with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'presets.ini') do
        try
            Camera.fileNameTemplate := readString('files', 'outputFile', '"IMG_####"');
            Camera.filePath         := readString('files', 'outputFolder', ExtractFilePath(Application.ExeName));
            Camera.tempFileName     := readString('files', 'tempFile',   'IMG_TEMP.JPG');
        finally
            Free;
        end { try };
end;





function TfrmCamera.doProgress(inPercent: Cardinal): boolean;
begin
    Result := False;
end;


procedure TfrmCamera.actTakePictUpdate(Sender: TObject);
begin
    (sender as TAction).Enabled := Camera.connected;
end;


procedure TfrmCamera.actTakePictExecute(Sender: TObject);
begin
    Camera.ShutterRelease;
end;


procedure TfrmCamera.actAutoFocusExecute(Sender: TObject);
begin
(*    try
        if Camera.SetLiveViewAF(Evf_AFMode_Live) then // Quick does not seem to work
            Log('Live AutoFocus successfull')
        else
              Log('Error #' + IntToStr(Camera.LastError) + ' while Live AutoFocus in LiveView - ' + ErrToStr(Camera.LastError));
    except
        Log('Unhandled Exception - Error #' + IntToStr(Camera.LastError) + ' while Live AutoFocus in LiveView - ' + ErrToStr(Camera.LastError));
    end { try };
    if chkAutoReget.Checked then
        actLVgetJpegExecute(nil);   *)
end;


procedure TfrmCamera.WndProc(var aMessage: TMessage);
begin
    case aMessage.Msg of

    UM_ERROR:
        raise ECameraError.Create(aMessage.wParam);

    CM_PROGRESS .. CM_PROPERTY:
        FCamera.HandleMessage(aMessage);

    else inherited;

    end { case };
end;

function TfrmCamera.Camera: TCamera;
begin
    if Assigned(FCamera) then
        Result := FCamera
    else
        raise ECameraError.Create(EDS_ERR_DEVICE_NOT_FOUND);
end;


procedure TfrmCamera.TimerMainTimer(Sender: TObject);
begin
    if not Assigned(FCamera) or not FCamera.connected then
        ConnectCamera(); // werkt niet
end;

end.

