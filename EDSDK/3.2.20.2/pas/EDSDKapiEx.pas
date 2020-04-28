unit EDSDKapiEx;

// ------------------------------------------------------------------------------------
// NOTE: * tested with EOS7DMk1, Delphi-7, Windows XP
//       * original file: EDSDK.h 
//       * SDK-version:   3.2.20.2
// ------------------------------------------------------------------------------------



interface

uses
  EDSDKapi, EDSDKtype;


type
    TPropertySize = record
        dataType: EdsDataType;
        size: EdsUInt32
        end;

procedure CacheImage(imageRef: EdsImageRef; useCache: EdsBool);
procedure CloseSession(cameraRef: EdsCameraRef);
procedure CopyData(streamRef: EdsStreamRef; writeSize: EdsUInt32; tStreamRef: EdsStreamRef);
function  CreateEvfImageRef(streamRef: EdsStreamRef): EdsEvfImageRef;
function  CreateFileStream(fileName: pChar; createDisposition: EdsFileCreateDisposition; desiredAccess: EdsAccess): EdsStreamRef;
function  CreateFileStreamEx(fileName: pWideChar; createDisposition: EdsFileCreateDisposition; desiredAccess: EdsAccess): EdsStreamRef;
function  CreateImageRef(streamRef: EdsStreamRef): EdsImageRef;
function  CreateMemoryStream(bufferSize: EdsUInt32): EdsStreamRef;
function  CreateMemoryStreamFromPointer(var userBuffer; bufferSize: EdsUInt32): EdsStreamRef;
function  CreateStream(var stream: EdsIStream): EdsStreamRef;
procedure DeleteDirectoryItem(dirItemRef: EdsDirectoryItemRef);
procedure Download(dirItemRef: EdsDirectoryItemRef; readSize: EdsUInt32; tStream: EdsStreamRef);
procedure DownloadCancel(dirItemRef: EdsDirectoryItemRef);
procedure DownloadComplete(dirItemRef: EdsDirectoryItemRef);
procedure DownloadEvfImage(cameraRef: EdsCameraRef; evfImageRef: EdsEvfImageRef);
procedure DownloadThumbnail(dirItemRef: EdsDirectoryItemRef; tStream: EdsStreamRef);
procedure FormatVolume(volumeRef: EdsVolumeRef);
function  GetAttribute(dirItemRef: EdsDirectoryItemRef): EdsFileAttributes;
function  GetCameraList(): EdsCameraListRef;
function  GetChildAtIndex(inRef: EdsBaseRef; index: EdsInt32): EdsBaseRef;
function  GetChildCount(ref: EdsBaseRef): EdsUInt32;
function  GetDeviceInfo(cameraRef: EdsCameraRef): EdsDeviceInfo;
function  GetDirectoryItemInfo(dirItemRef: EdsDirectoryItemRef): EdsDirectoryItemInfo;
procedure GetEvent();
procedure GetImage(imageRef: EdsImageRef; imageSource: EdsImageSource; imageType: EdsTargetImageType; srcRect: EdsRect; dstSize: EdsSize; tStreamRef: EdsStreamRef);
function  GetImageInfo(imageRef: EdsImageRef; imageSource: EdsImageSource): EdsImageInfo;
function  GetLength(streamRef: EdsStreamRef): EdsUInt32;
function  GetParent(ref: EdsBaseRef): EdsBaseRef;
procedure GetPointer(stream: EdsStreamRef; var pointer: Pointer);
function  GetPosition(streamRef: EdsStreamRef): EdsUInt32;
procedure GetPropertyData(ref: EdsBaseRef; propertyID: EdsPropertyID; param: EdsInt32; propertySize: EdsUInt32; var propertyData);
function  GetPropertyDesc(ref: EdsBaseRef; propertyID: EdsPropertyID): EdsPropertyDesc;
function  GetPropertySize(ref: EdsBaseRef; propertyID: EdsPropertyID; param: EdsInt32): TPropertySize;
function  GetVolumeInfo(volumeRef: EdsVolumeRef): EdsVolumeInfo;
procedure InitializeSDK();
procedure OpenSession(cameraRef: EdsCameraRef);
function  Read(streamRef: EdsStreamRef; inReadSize: EdsUInt32; var buffer): EdsUInt32;
procedure ReflectImageProperty(imageRef: EdsImageRef);
procedure Release(ref: EdsBaseRef);
procedure Retain(ref: EdsBaseRef);
procedure SaveImage(imageRef: EdsImageRef; imageType: EdsTargetImageType; saveSetting: EdsSaveImageSetting; tStreamRef: EdsStreamRef);
procedure Seek(streamRef: EdsStreamRef; seekOffset: EdsInt32; seekOrigin: EdsSeekOrigin);
procedure SendCommand(cameraRef: EdsCameraRef; command: EdsCameraCommand; param: EdsInt32);
procedure SendStatusCommand(cameraRef: EdsCameraRef; statusCommand: EdsCameraStatusCommand; param: EdsInt32);
procedure SetAttribute(dirItemRef: EdsDirectoryItemRef; fileAttribute: EdsFileAttributes);
procedure SetCameraAddedHandler(cameraAddedHandler: EdsCameraAddedHandler; var context);
procedure SetCameraStateEventHandler(cameraRef: EdsCameraRef; evnet: EdsStateEvent; stateEventHandler: EdsStateEventHandler; var context);
procedure SetCapacity(cameraRef: EdsCameraRef; capacity: EdsCapacity);
procedure SetObjectEventHandler(cameraRef: EdsCameraRef; evnet: EdsObjectEvent; objectEventHandler: EdsObjectEventHandler; var context);
procedure SetProgressCallback(ref: EdsBaseRef; progressCallback: EdsProgressCallback; progressOption: EdsProgressOption; var context);
procedure SetPropertyData(ref: EdsBaseRef; propertyID: EdsPropertyID; param: EdsInt32; propertySize: EdsUInt32; var propertyData);
procedure SetPropertyEventHandler(cameraRef: EdsCameraRef; evnet: EdsPropertyEvent; propertyEventHandler: EdsPropertyEventHandler; var context);
procedure TerminateSDK();
function  Write(streamRef: EdsStreamRef; writeSize: EdsUInt32; var buffer): EdsUInt32;


implementation


uses
  EdSDKError, canonObject;



procedure CacheImage(imageRef: EdsImageRef; useCache: EdsBool);
var retVal: EdsError;
begin
    retVal := EdsCacheImage(imageRef, useCache);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure CloseSession(cameraRef: EdsCameraRef);
var retVal: EdsError;
begin
    retVal := EdsCloseSession(cameraRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure CopyData(streamRef: EdsStreamRef; writeSize: EdsUInt32; tStreamRef: EdsStreamRef);
var retVal: EdsError;
begin
    retVal := EdsCopyData(streamRef, writeSize, tStreamRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


function  CreateEvfImageRef(streamRef: EdsStreamRef): EdsEvfImageRef;
var retVal: EdsError;
    evfImageRef: EdsEvfImageRef;
begin
    retVal := EdsCreateEvfImageRef(streamRef, evfImageRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := evfImageRef;
end;
                

function  CreateFileStream(fileName: pChar; createDisposition: EdsFileCreateDisposition; desiredAccess: EdsAccess): EdsStreamRef;
var retVal: EdsError;
    stream: EdsStreamRef;
begin
    retVal := EdsCreateFileStream(fileName, createDisposition, desiredAccess, stream);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := stream;
end;
                

function  CreateFileStreamEx(fileName: pWideChar; createDisposition: EdsFileCreateDisposition; desiredAccess: EdsAccess): EdsStreamRef;
var retVal: EdsError;
    stream: EdsStreamRef;
begin
    retVal := EdsCreateFileStreamEx(fileName, createDisposition, desiredAccess, stream);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := stream;
end;
                

function  CreateImageRef(streamRef: EdsStreamRef): EdsImageRef;
var retVal: EdsError;
    imageRef: EdsImageRef;
begin
    retVal := EdsCreateImageRef(streamRef, imageRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := imageRef;
end;
                

function  CreateMemoryStream(bufferSize: EdsUInt32): EdsStreamRef;
var retVal: EdsError;
    stream: EdsStreamRef;
begin
    retVal := EdsCreateMemoryStream(bufferSize, stream);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := stream;
end;
                

function  CreateMemoryStreamFromPointer(var userBuffer; bufferSize: EdsUInt32): EdsStreamRef;
var retVal: EdsError;
    stream: EdsStreamRef;
begin
    retVal := EdsCreateMemoryStreamFromPointer(userBuffer, bufferSize, stream);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := stream;
end;
                

function  CreateStream(var stream: EdsIStream): EdsStreamRef;
var retVal: EdsError;
    streamRef: EdsStreamRef;
begin
    retVal := EdsCreateStream(stream, streamRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := streamRef;
end;
                

procedure DeleteDirectoryItem(dirItemRef: EdsDirectoryItemRef);
var retVal: EdsError;
begin
    retVal := EdsDeleteDirectoryItem(dirItemRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure Download(dirItemRef: EdsDirectoryItemRef; readSize: EdsUInt32; tStream: EdsStreamRef);
var retVal: EdsError;
begin
    retVal := EdsDownload(dirItemRef, readSize, tStream);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure DownloadCancel(dirItemRef: EdsDirectoryItemRef);
var retVal: EdsError;
begin
    retVal := EdsDownloadCancel(dirItemRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure DownloadComplete(dirItemRef: EdsDirectoryItemRef);
var retVal: EdsError;
begin
    retVal := EdsDownloadComplete(dirItemRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure DownloadEvfImage(cameraRef: EdsCameraRef; evfImageRef: EdsEvfImageRef);
var retVal: EdsError;
begin
    retVal := EdsDownloadEvfImage(cameraRef, evfImageRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure DownloadThumbnail(dirItemRef: EdsDirectoryItemRef; tStream: EdsStreamRef);
var retVal: EdsError;
begin
    retVal := EdsDownloadThumbnail(dirItemRef, tStream);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure FormatVolume(volumeRef: EdsVolumeRef);
var retVal: EdsError;
begin
    retVal := EdsFormatVolume(volumeRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


function  GetAttribute(dirItemRef: EdsDirectoryItemRef): EdsFileAttributes;
var retVal: EdsError;
    fileAttribute: EdsFileAttributes;
begin
    retVal := EdsGetAttribute(dirItemRef, fileAttribute);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := fileAttribute;
end;
                

function  GetCameraList(): EdsCameraListRef;
var retVal: EdsError;
    cameraListRef: EdsCameraListRef;
begin
    retVal := EdsGetCameraList(cameraListRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := cameraListRef;
end;
                

function  GetChildAtIndex(inRef: EdsBaseRef; index: EdsInt32): EdsBaseRef;
var retVal: EdsError;
    outRef: EdsBaseRef;
begin
    retVal := EdsGetChildAtIndex(inRef, index, outRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := outRef;
end;
                

function  GetChildCount(ref: EdsBaseRef): EdsUInt32;
var retVal: EdsError;
    count: EdsUInt32;
begin
    retVal := EdsGetChildCount(ref, count);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := count;
end;
                

function  GetDeviceInfo(cameraRef: EdsCameraRef): EdsDeviceInfo;
var retVal: EdsError;
    deviceInfo: EdsDeviceInfo;
begin
    retVal := EdsGetDeviceInfo(cameraRef, deviceInfo);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := deviceInfo;
end;
                

function  GetDirectoryItemInfo(dirItemRef: EdsDirectoryItemRef): EdsDirectoryItemInfo;
var retVal: EdsError;
    dirItemInfo: EdsDirectoryItemInfo;
begin
    retVal := EdsGetDirectoryItemInfo(dirItemRef, dirItemInfo);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := dirItemInfo;
end;
                

procedure GetEvent();
var retVal: EdsError;
begin
    retVal := EdsGetEvent();
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure GetImage(imageRef: EdsImageRef; imageSource: EdsImageSource; imageType: EdsTargetImageType; srcRect: EdsRect; dstSize: EdsSize; tStreamRef: EdsStreamRef);
var retVal: EdsError;
begin
    retVal := EdsGetImage(imageRef, imageSource, imageType, srcRect, dstSize, tStreamRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


function  GetImageInfo(imageRef: EdsImageRef; imageSource: EdsImageSource): EdsImageInfo;
var retVal: EdsError;
    imageInfo: EdsImageInfo;
begin
    retVal := EdsGetImageInfo(imageRef, imageSource, imageInfo);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := imageInfo;
end;
                

function  GetLength(streamRef: EdsStreamRef): EdsUInt32;
var retVal: EdsError;
    length: EdsUInt32;
begin
    retVal := EdsGetLength(streamRef, length);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := length;
end;
                

function  GetParent(ref: EdsBaseRef): EdsBaseRef;
var retVal: EdsError;
    parentRef: EdsBaseRef;
begin
    retVal := EdsGetParent(ref, parentRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := parentRef;
end;
                

procedure GetPointer(stream: EdsStreamRef; var pointer: Pointer);
var retVal: EdsError;
begin
    retVal := EdsGetPointer(stream, pointer);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


function  GetPosition(streamRef: EdsStreamRef): EdsUInt32;
var retVal: EdsError;
    position: EdsUInt32;
begin
    retVal := EdsGetPosition(streamRef, position);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := position;
end;
                

procedure GetPropertyData(ref: EdsBaseRef; propertyID: EdsPropertyID; param: EdsInt32; propertySize: EdsUInt32; var propertyData);
var retVal: EdsError;
begin
    retVal := EdsGetPropertyData(ref, propertyID, param, propertySize, propertyData);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


function  GetPropertyDesc(ref: EdsBaseRef; propertyID: EdsPropertyID): EdsPropertyDesc;
var retVal: EdsError;
    propertyDesc: EdsPropertyDesc;
begin
    retVal := EdsGetPropertyDesc(ref, propertyID, propertyDesc);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := propertyDesc;
end;
                

function  GetPropertySize(ref: EdsBaseRef; propertyID: EdsPropertyID; param: EdsInt32): TPropertySize;
var retVal: EdsError;
begin
    retVal := EdsGetPropertySize(ref, propertyID, param, Result.dataType, Result.size);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


function  GetVolumeInfo(volumeRef: EdsVolumeRef): EdsVolumeInfo;
var retVal: EdsError;
    volumeInfo: EdsVolumeInfo;
begin
    retVal := EdsGetVolumeInfo(volumeRef, volumeInfo);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := volumeInfo;
end;
                

procedure InitializeSDK();
var retVal: EdsError;
begin
    retVal := EdsInitializeSDK();
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure OpenSession(cameraRef: EdsCameraRef);
var retVal: EdsError;
begin
    retVal := EdsOpenSession(cameraRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


function  Read(streamRef: EdsStreamRef; inReadSize: EdsUInt32; var buffer): EdsUInt32;
var retVal: EdsError;
    outReadSize: EdsUInt32;
begin
    retVal := EdsRead(streamRef, inReadSize, buffer, outReadSize);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := outReadSize;
end;
                

procedure ReflectImageProperty(imageRef: EdsImageRef);
var retVal: EdsError;
begin
    retVal := EdsReflectImageProperty(imageRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure Release(ref: EdsBaseRef);
var retVal: EdsUInt32;
begin
    retVal := EdsRelease(ref);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure Retain(ref: EdsBaseRef);
var retVal: EdsUInt32;
begin
    retVal := EdsRetain(ref);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure SaveImage(imageRef: EdsImageRef; imageType: EdsTargetImageType; saveSetting: EdsSaveImageSetting; tStreamRef: EdsStreamRef);
var retVal: EdsError;
begin
    retVal := EdsSaveImage(imageRef, imageType, saveSetting, tStreamRef);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure Seek(streamRef: EdsStreamRef; seekOffset: EdsInt32; seekOrigin: EdsSeekOrigin);
var retVal: EdsError;
begin
    retVal := EdsSeek(streamRef, seekOffset, seekOrigin);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure SendCommand(cameraRef: EdsCameraRef; command: EdsCameraCommand; param: EdsInt32);
var retVal: EdsError;
begin
    retVal := EdsSendCommand(cameraRef, command, param);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure SendStatusCommand(cameraRef: EdsCameraRef; statusCommand: EdsCameraStatusCommand; param: EdsInt32);
var retVal: EdsError;
begin
    retVal := EdsSendStatusCommand(cameraRef, statusCommand, param);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure SetAttribute(dirItemRef: EdsDirectoryItemRef; fileAttribute: EdsFileAttributes);
var retVal: EdsError;
begin
    retVal := EdsSetAttribute(dirItemRef, fileAttribute);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure SetCameraAddedHandler(cameraAddedHandler: EdsCameraAddedHandler; var context);
var retVal: EdsError;
begin
    retVal := EdsSetCameraAddedHandler(cameraAddedHandler, context);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure SetCameraStateEventHandler(cameraRef: EdsCameraRef; evnet: EdsStateEvent; stateEventHandler: EdsStateEventHandler; var context);
var retVal: EdsError;
begin
    retVal := EdsSetCameraStateEventHandler(cameraRef, evnet, stateEventHandler, context);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure SetCapacity(cameraRef: EdsCameraRef; capacity: EdsCapacity);
var retVal: EdsError;
begin
    retVal := EdsSetCapacity(cameraRef, capacity);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure SetObjectEventHandler(cameraRef: EdsCameraRef; evnet: EdsObjectEvent; objectEventHandler: EdsObjectEventHandler; var context);
var retVal: EdsError;
begin
    retVal := EdsSetObjectEventHandler(cameraRef, evnet, objectEventHandler, context);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure SetProgressCallback(ref: EdsBaseRef; progressCallback: EdsProgressCallback; progressOption: EdsProgressOption; var context);
var retVal: EdsError;
begin
    retVal := EdsSetProgressCallback(ref, progressCallback, progressOption, context);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure SetPropertyData(ref: EdsBaseRef; propertyID: EdsPropertyID; param: EdsInt32; propertySize: EdsUInt32; var propertyData);
var retVal: EdsError;
begin
    retVal := EdsSetPropertyData(ref, propertyID, param, propertySize, propertyData);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure SetPropertyEventHandler(cameraRef: EdsCameraRef; evnet: EdsPropertyEvent; propertyEventHandler: EdsPropertyEventHandler; var context);
var retVal: EdsError;
begin
    retVal := EdsSetPropertyEventHandler(cameraRef, evnet, propertyEventHandler, context);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


procedure TerminateSDK();
var retVal: EdsError;
begin
    retVal := EdsTerminateSDK();
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
end;


function  Write(streamRef: EdsStreamRef; writeSize: EdsUInt32; var buffer): EdsUInt32;
var retVal: EdsError;
    writtenSize: EdsUInt32;
begin
    retVal := EdsWrite(streamRef, writeSize, buffer, writtenSize);
    if retVal <> EDS_ERR_OK then
        raise ECameraError.Create(retVal);
    Result := writtenSize;
end;
                


end.
