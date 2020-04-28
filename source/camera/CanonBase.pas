unit CanonBase;
{ -------------------------------------------------------------------
  Unit:     canon Shooter
  Project:  CCCp
  group:    camera

  Purpose:  TBaseCamera represents a camera and its capabilities.
            Higher order functions, such as actualy taking the pictures
            and running live view, are dereferd to descendant classes.

  Author:   Wim° de Winter
  Date:     april 2020

  ----- copyright (C) WP. de Winter, Wageningen ---------------------
  ----- Free to use and change; all rights reserved ----------------- }

interface

uses {standard lib:} Windows, Messages, Classes, Sysutils, ExtCtrls,
     {Canon API:}    EDSDKType, cameraEvents,
     {custom units:} cameraProperties, canonObject, canonConnection;

const ERR_NOT_CONNECTED = $00009000;
const UM_ERROR = WM_USER + 1;

const
    kEdsPropID_MirrorUpSetting  = $01000438;
    kEdsPropID_MirrorLockUpState = $01000421;


type
    TBaseCamera = class(TCanonObject)
      protected
        FProgressHandler: Pointer;
        procedure PropertyEvent(Event: Cardinal; PropertyID: Cardinal; Param: Cardinal); virtual;
        procedure ObjectEvent(Event: Cardinal; objectRef: Pointer);                      virtual;
        procedure StateEvent(Event: EdsStateEvent; Paramter: Cardinal);                  virtual;
        procedure Progress(inPercent: Cardinal; var Cancel: EdsBool);                    virtual;

        procedure Lock;
        procedure Unlock;
        function  Locked: Boolean;
        procedure SendCommand(command: EdsCameraCommand; parameter: EdsUInt32 = 0);
        procedure SetEventHandlers();
        procedure afterConnection; virtual;

      private
        FHandle:            EdsCameraRef;
        FHWND:              HWND;
        FIsConnected:       Boolean;
        FIsLocked:          Boolean;
        FOldCamera:         Boolean;
        FProperties:        TCameraProperties;
        FModelName:         string;

        function  getProperty(index: variant): variant;
        procedure readDeviceInfo;
      public
        constructor Create(connection: TConnection; WindowHandle: HWND);
        destructor  Destroy ; override;
        function    Connect() : Boolean; virtual;
        function    Disconnect() : Boolean; virtual;
        procedure   GetAbilities(propertyID: EdsPropertyID; List: TStrings);
        procedure   SetProperty(propertyID: EdsPropertyID; propertyValue: EdsUInt32; aHandle: EdsBaseRef = nil);
        procedure   HandleMessage(var aMessage: TMessage);
        procedure   SetMirrorLockup(Value: Boolean);
        function    isMirrorLockupEnabled: boolean;
        property Handle: EdsCameraRef read FHandle;
        property ModelName: string read FModelName;
        property connected: Boolean read FIsConnected;

        property Get[index: variant]: variant read getProperty; default;
        property properties: TCameraProperties read FProperties;

    end;




implementation

uses Math, EDSDKError, canonStrings, EdSDKapiEx, Forms;

constructor TBaseCamera.Create(connection: TConnection; WindowHandle: HWND);
begin
    inherited Create;
    if Assigned(connection) then
        begin
        FHandle     := connection.SelectCamera();
        FHWND       := WindowHandle;
        FProperties := TCameraProperties.Create;
        FIsLocked   := False;
        FIsConnected:= False;
        readDeviceInfo();
        SetEventHandlers();
        FProgressHandler := @ProgressFunc
        end { if };
end;


destructor TBaseCamera.Destroy;
begin
    FProperties.Free;
    Disconnect();
    inherited;
end;


procedure TBaseCamera.readDeviceInfo();
var deviceInfo:        EdsDeviceInfo;
begin
    deviceInfo := GetDeviceInfo(self.Handle);
    with deviceInfo do
        begin
        FModelName := pChar(@szDeviceDescription);
        FOldCamera := (deviceSubType = 0);
        end { with };
end;



function TBaseCamera.Connect(): Boolean;
begin
    assert(not FIsConnected);
    try
        OpenSession(Self.FHandle);
        FIsConnected  := True;
    except on ECameraError do
        // pass
    end { try };
    Result      := FIsConnected;
    afterConnection();
end;



procedure TBaseCamera.afterConnection();
var id: EdsUInt32;
begin
    properties.AutoFill;
    properties.InitAll(Handle);
end;



function TBaseCamera.Disconnect(): Boolean;
begin
    if FIsConnected then
        begin
        CloseSession(FHandle);
        FIsConnected := False;
        end { if };
    Result := FIsConnected;
end;


procedure TBaseCamera.SetProperty(propertyID: EdsPropertyID; propertyValue: EdsUInt32; aHandle: EdsBaseRef);
begin
  { When setting properties in type 1 protocol standard cameras, take steps to
    prevent contention with camera operations, such as by locking the UI. On the
    other hand, for type 2 protocol standard cameras, the UI can be locked or
    unlocked on the camera itself, so do not lock the UI. }
    Lock();
    try
        if not Assigned(aHandle) then
            aHandle := self.Handle;
        SetPropertyData(aHandle, propertyID, 0, sizeof(propertyValue), propertyValue);
    finally
        Unlock();
    end { try };
end;


procedure TBaseCamera.GetAbilities(propertyID: EdsPropertyID; List: TStrings);
var item: TCameraProperty;
begin
    item := properties[propertyID];
    item.getAbilities(List, osAuto);
end;


procedure TBaseCamera.Lock;
begin
    if FIsLocked or not FOldCamera then Exit;

    SendStatusCommand(FHandle, kEdsCameraStatusCommand_UILock, 0);
    FIsLocked  := True;
end;


procedure TBaseCamera.Unlock;
begin
    if not FIsLocked then Exit;
    SendStatusCommand(FHandle, kEdsCameraStatusCommand_UIUnLock, 0);
    FIsLocked  := False;
end;


function TBaseCamera.Locked: Boolean;
begin
    Result := FIsLocked;
end;


function TBaseCamera.getProperty(index: variant): variant;
begin
    Result := FProperties[Index].getValue();
end;


procedure TBaseCamera.SendCommand(command: EdsCameraCommand; parameter: EdsUInt32);
begin
    Lock();
    try
        EdSDKapiEx.SendCommand(Handle, command, parameter);
    finally
        Unlock();
    end { try };
end;




procedure TBaseCamera.SetEventHandlers();
begin
    SetPropertyEventHandler(   Handle, kEdsPropertyEvent_All, @handlePropertyEvent,   FHWND);
    SetObjectEventHandler(     Handle, kEdsObjectEvent_All,   @handleObjectEvent,     FHWND);
    SetCameraStateEventHandler(Handle, kEdsStateEvent_All,    @handleStateEvent,      FHWND);
end;



procedure TBaseCamera.ObjectEvent(Event: Cardinal; objectRef: Pointer);
begin
    // void
end;

procedure TBaseCamera.PropertyEvent(Event, PropertyID, Param: Cardinal);
begin
    // void
end;

procedure TBaseCamera.StateEvent(Event: EdsStateEvent; Paramter: Cardinal);
begin
    case Event of
    kEdsStateEvent_ShutDown:;
    kEdsStateEvent_JobStatusChanged:;
    kEdsStateEvent_WillSoonShutDown:;
    kEdsStateEvent_ShutDownTimerUpdate:;
    kEdsStateEvent_CaptureError:;
    kEdsStateEvent_InternalError:;
	kEdsStateEvent_AfResult:;
	kEdsStateEvent_BulbExposureTime:;
    end { case };
end;

procedure TBaseCamera.Progress(inPercent: Cardinal; var Cancel: EdsBool);
begin
    // void
end;

procedure TBaseCamera.HandleMessage(var aMessage: TMessage);
begin
    with aMessage do
        case Msg of

        CM_PROPERTY:
            PropertyEvent(kEdsPropertyEvent_PropertyChanged, wParam, lParam);

        CM_ABILITY:
            PropertyEvent(kEdsPropertyEvent_PropertyDescChanged, wParam, lParam);

        CM_OBJECT:
            ObjectEvent(wParam, EdsBaseRef(lParam));

        CM_STATE:
            StateEvent(wParam, lParam);

        CM_PROGRESS:
            Progress(wParam, Result);

        end { case };
end;



procedure TBaseCamera.SetMirrorLockup(Value: Boolean);
var mlu: EdsUInt32;
begin
    mlu := ifThen(value, 1, 0);
    SetPropertyData(Handle, kEdsPropID_CFn, $60F, 4, mlu);
end;


function TBaseCamera.isMirrorLockupEnabled(): boolean;
var retval: EdsUInt32;
begin
    getPropertyData(Handle, kEdsPropID_CFn, $60F, 4, retVal);
    result := (retval <> 0);
end;


initialization
    translators.cameraErrors.addTranslation(ERR_NOT_CONNECTED, 'Camera not connected');

finalization

end.



