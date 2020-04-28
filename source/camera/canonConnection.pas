unit canonConnection;

interface

uses {standard lib:} Classes, Sysutils,
     {Canon API:}    canonObject, EDSDKApiEx, EDSDKType, EDSDKError;

type
    TConnectionState = (csDisconnected, csSDKloaded, csReady, csCameraSelected);

    TConnection = class(TCanonObject)
      private
        FState: TConnectionState;
      protected
      public
        constructor Create;
        destructor  Destroy; override;
        function LoadSDK: Boolean;
        function SelectCamera: EdsCameraRef;
        property State: TConnectionState read FState;
      end;

implementation

{ TConnection }

constructor TConnection.Create;
begin
    inherited;
    Self.FState     := csDisconnected;
    LoadSDK();
    if FState = csSDKLoaded then
        try
            SelectCamera();
            FState := csReady;
        except
        end;
end;


destructor TConnection.Destroy;
begin
    if FState >= csSDKLoaded then
        TerminateSDK;

    inherited;
end;


function TConnection.LoadSDK(): Boolean;
begin
    assert (FState = csDisconnected);
    InitializeSDK();
    Self.FState := csSDKloaded;
    Result      := (Self.FState >= csSDKloaded);
end;


function TConnection.SelectCamera(): EdsCameraRef;
var cameraList: EdsCameraListRef;
    count: EdsUInt32;
    handle: EdsCameraRef;
begin
    assert (FState >= csSDKLOaded);

    cameraList := nil;
    count := 0;

    try
        cameraList  := GetCameraList();
        count       := GetChildCount(cameraList);

        if count = 0 then
            raiseError(EDS_ERR_DEVICE_NOT_FOUND);

        // get first Camera:
        handle := GetChildAtIndex(cameraList, 0);

        if not Assigned(handle) then
            raiseError(EDS_ERR_DEVICE_NOT_FOUND);

    finally
        // release camera list object:
        if Assigned(cameraList) then
            Release(cameraList);
    end { try };

    Fstate  := csCameraSelected;
    Result  := handle;

end;




end.
