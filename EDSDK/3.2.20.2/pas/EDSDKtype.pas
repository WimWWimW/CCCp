unit EDSDKtype;

// ------------------------------------------------------------------------------------
// NOTE: * this file has been converted automatically and might still contain mistakes.
//       * original file: EDSDKTypes.h 
//       * SDK-version:   3.2.20.2
// ------------------------------------------------------------------------------------

(******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : EdsTypes.h                                                      *
*                                                                             *
*   Description: COMMON DEFINITION FOR EDSDK                                  *
*                                                                             *
*******************************************************************************
*                                                                             *
*   Written and developed by Canon Inc.                                       *
*   Copyright Canon Inc. 2006-2015 All Rights Reserved                        *
*                                                                             *
******************************************************************************)


interface


const EDS_MAX_NAME             = 256;
const EDS_TRANSFER_BLOCK_SIZE  = 512;

type
  EdsBool    = Integer;
  EdsInt     = Integer;
  EdsVoid    = Pointer;
  EdsChar    = Char;
  EdsInt8    = Shortint;
  EdsUInt8   = Byte;
  EdsInt16   = Smallint;
  EdsUInt16  = Word;
  EdsInt32   = Integer;
  EdsUInt32  = Cardinal;
  EdsInt64   = Int64;
  EdsUInt64  = Int64;
  EdsFloat   = single;
  EdsDouble  = double;
  
  WCHAR      = WideChar;
  
// -----------------------------------------------------------------------------
//  Error Types
// -----------------------------------------------------------------------------
type EdsError                         = EdsUInt32;


// -----------------------------------------------------------------------------
//  Reference Types
// -----------------------------------------------------------------------------
type EdsBaseRef                       = Pointer;

type EdsCameraListRef                 = EdsBaseRef;
type EdsCameraRef                     = EdsBaseRef;
type EdsVolumeRef                     = EdsBaseRef;
type EdsDirectoryItemRef              = EdsBaseRef;
type EdsStreamRef                     = EdsBaseRef;
type EdsImageRef                      = EdsStreamRef;
type EdsEvfImageRef                   = EdsBaseRef;


// -----------------------------------------------------------------------------
// Data Types
// -----------------------------------------------------------------------------

type EdsDataType = EdsUInt32; 
const
    kEdsDataType_Unknown             = 0;        
    kEdsDataType_Bool                = 1;        
    kEdsDataType_String              = 2;        
    kEdsDataType_Int8                = 3;        
    kEdsDataType_UInt8               = 6;        
    kEdsDataType_Int16               = 4;        
    kEdsDataType_UInt16              = 7;        
    kEdsDataType_Int32               = 8;        
    kEdsDataType_UInt32              = 9;        
    kEdsDataType_Int64               = 10;       
    kEdsDataType_UInt64              = 11;       
    kEdsDataType_Float               = 12;       
    kEdsDataType_Double              = 13;       
    kEdsDataType_ByteBlock           = 14;       
    kEdsDataType_Rational            = 20;       
    kEdsDataType_Point               = 21;       
    kEdsDataType_Rect                = 22;       
    kEdsDataType_Time                = 23;       
    kEdsDataType_Bool_Array          = 30;       
    kEdsDataType_Int8_Array          = 31;       
    kEdsDataType_Int16_Array         = 32;       
    kEdsDataType_Int32_Array         = 33;       
    kEdsDataType_UInt8_Array         = 34;       
    kEdsDataType_UInt16_Array        = 35;       
    kEdsDataType_UInt32_Array        = 36;       
    kEdsDataType_Rational_Array      = 37;       
    kEdsDataType_FocusInfo           = 101;      
    kEdsDataType_PictureStyleDesc    = 102;



// -----------------------------------------------------------------------------
// Property IDs
// -----------------------------------------------------------------------------
type EdsPropertyID                    = EdsUInt32;


// ----------------------------------
// Camera Setting Properties
// ----------------------------------
const kEdsPropID_Unknown                = $0000ffff;
      kEdsPropID_ProductName            = $00000002;
      kEdsPropID_OwnerName              = $00000004;
      kEdsPropID_MakerName              = $00000005;
      kEdsPropID_DateTime               = $00000006;
      kEdsPropID_FirmwareVersion        = $00000007;
      kEdsPropID_BatteryLevel           = $00000008;
      kEdsPropID_CFn                    = $00000009;
      kEdsPropID_SaveTo                 = $0000000b;
      kEdsPropID_CurrentStorage         = $0000000c;
      kEdsPropID_CurrentFolder          = $0000000d;
      kEdsPropID_MyMenu                  = $0000000e;
      kEdsPropID_BatteryQuality         = $00000010;
      kEdsPropID_BodyIDEx                  = $00000015;
      kEdsPropID_HDDirectoryStructure   = $00000020;


// ----------------------------------
// Image Properties
// ----------------------------------
      kEdsPropID_ImageQuality           = $00000100;
      kEdsPropID_JpegQuality            = $00000101;
      kEdsPropID_Orientation            = $00000102;
      kEdsPropID_ICCProfile             = $00000103;
      kEdsPropID_FocusInfo              = $00000104;
      kEdsPropID_DigitalExposure        = $00000105;
      kEdsPropID_WhiteBalance           = $00000106;
      kEdsPropID_ColorTemperature       = $00000107;
      kEdsPropID_WhiteBalanceShift      = $00000108;
      kEdsPropID_Contrast               = $00000109;
      kEdsPropID_ColorSaturation        = $0000010a;
      kEdsPropID_ColorTone              = $0000010b;
      kEdsPropID_Sharpness              = $0000010c;
      kEdsPropID_ColorSpace             = $0000010d;
      kEdsPropID_ToneCurve              = $0000010e;
      kEdsPropID_PhotoEffect            = $0000010f;
      kEdsPropID_FilterEffect           = $00000110;
      kEdsPropID_ToningEffect           = $00000111;
      kEdsPropID_ParameterSet           = $00000112;
      kEdsPropID_ColorMatrix            = $00000113;
      kEdsPropID_PictureStyle           = $00000114;
      kEdsPropID_PictureStyleDesc       = $00000115;
      kEdsPropID_PictureStyleCaption    = $00000200;


// ----------------------------------
// Image Processing Properties
// ----------------------------------
      kEdsPropID_Linear                 = $00000300;
      kEdsPropID_ClickWBPoint           = $00000301;
      kEdsPropID_WBCoeffs               = $00000302;


// ----------------------------------
// Image GPS Properties
// ----------------------------------
      kEdsPropID_GPSVersionID              = $00000800;
      kEdsPropID_GPSLatitudeRef          = $00000801;
      kEdsPropID_GPSLatitude              = $00000802;
      kEdsPropID_GPSLongitudeRef          = $00000803;
      kEdsPropID_GPSLongitude              = $00000804;
      kEdsPropID_GPSAltitudeRef          = $00000805;
      kEdsPropID_GPSAltitude              = $00000806;
      kEdsPropID_GPSTimeStamp              = $00000807;
      kEdsPropID_GPSSatellites          = $00000808;
      kEdsPropID_GPSStatus              = $00000809;
      kEdsPropID_GPSMapDatum              = $00000812;
      kEdsPropID_GPSDateStamp              = $0000081D;


// ----------------------------------
// Property Mask
// ----------------------------------
      kEdsPropID_AtCapture_Flag         = $80000000;


// ----------------------------------
// Capture Properties
// ----------------------------------
      kEdsPropID_AEMode                 = $00000400;
      kEdsPropID_DriveMode              = $00000401;
      kEdsPropID_ISOSpeed               = $00000402;
      kEdsPropID_MeteringMode           = $00000403;
      kEdsPropID_AFMode                 = $00000404;
      kEdsPropID_Av                     = $00000405;
      kEdsPropID_Tv                     = $00000406;
      kEdsPropID_ExposureCompensation   = $00000407;
      kEdsPropID_FlashCompensation      = $00000408;
      kEdsPropID_FocalLength            = $00000409;
      kEdsPropID_AvailableShots         = $0000040a;
      kEdsPropID_Bracket                = $0000040b;
      kEdsPropID_WhiteBalanceBracket    = $0000040c;
      kEdsPropID_LensName               = $0000040d;
      kEdsPropID_AEBracket              = $0000040e;
      kEdsPropID_FEBracket              = $0000040f;
      kEdsPropID_ISOBracket             = $00000410;
      kEdsPropID_NoiseReduction         = $00000411;
      kEdsPropID_FlashOn                = $00000412;
      kEdsPropID_RedEye                 = $00000413;
      kEdsPropID_FlashMode              = $00000414;
      kEdsPropID_LensStatus             = $00000416;
      kEdsPropID_Artist                  = $00000418;
      kEdsPropID_Copyright              = $00000419;
      kEdsPropID_DepthOfField              = $0000041b;
      kEdsPropID_EFCompensation         = $0000041e;
      kEdsPropID_AEModeSelect           = $00000436;


// ----------------------------------
// EVF Properties
// ----------------------------------
      kEdsPropID_Evf_OutputDevice        = $00000500;
      kEdsPropID_Evf_Mode                = $00000501;
      kEdsPropID_Evf_WhiteBalance        = $00000502;
      kEdsPropID_Evf_ColorTemperature    = $00000503;
      kEdsPropID_Evf_DepthOfFieldPreview = $00000504;
// EVF IMAGE DATA Properties
const kEdsPropID_Evf_Zoom                = $00000507;
      kEdsPropID_Evf_ZoomPosition        = $00000508;
      kEdsPropID_Evf_FocusAid            = $00000509;
      kEdsPropID_Evf_Histogram           = $0000050A;
      kEdsPropID_Evf_ImagePosition       = $0000050B;
      kEdsPropID_Evf_HistogramStatus     = $0000050C;
      kEdsPropID_Evf_AFMode              = $0000050E;
      kEdsPropID_Record                  = $00000510;
      kEdsPropID_Evf_HistogramY          = $00000515;
      kEdsPropID_Evf_HistogramR          = $00000516;
      kEdsPropID_Evf_HistogramG          = $00000517;
      kEdsPropID_Evf_HistogramB          = $00000518;
      kEdsPropID_Evf_CoordinateSystem    = $00000540;
      kEdsPropID_Evf_ZoomRect            = $00000541;
      kEdsPropID_Evf_ImageClipRect       = $00000545;


// -----------------------------------------------------------------------------
// Camera Commands
// -----------------------------------------------------------------------------
type EdsCameraCommand                 = EdsUInt32;


// ----------------------------------
// Send Commands
// ----------------------------------
const kEdsCameraCommand_TakePicture                     = $00000000;
      kEdsCameraCommand_ExtendShutDownTimer             = $00000001;
      kEdsCameraCommand_BulbStart                          = $00000002;
      kEdsCameraCommand_BulbEnd                          = $00000003;
      kEdsCameraCommand_DoEvfAf                         = $00000102;
      kEdsCameraCommand_DriveLensEvf                    = $00000103;
      kEdsCameraCommand_DoClickWBEvf                    = $00000104;
      kEdsCameraCommand_PressShutterButton              = $00000004;

type EdsEvfAf = EdsUInt32; 
const
    kEdsCameraCommand_EvfAf_OFF      = 0;        
    kEdsCameraCommand_EvfAf_ON       = 1;        


type EdsShutterButton = EdsUInt32; 
const
    kEdsCameraCommand_ShutterButton_OFF = $00000000;
    kEdsCameraCommand_ShutterButton_Halfway = $00000001;
    kEdsCameraCommand_ShutterButton_Completely = $00000003;
    kEdsCameraCommand_ShutterButton_Halfway_NonAF = $00010001;
    kEdsCameraCommand_ShutterButton_Completely_NonAF = $00010003;

type EdsCameraStatusCommand           = EdsUInt32;


// ----------------------------------
// Camera Status Commands
// ----------------------------------
const kEdsCameraStatusCommand_UILock                    = $00000000;
      kEdsCameraStatusCommand_UIUnLock                  = $00000001;
      kEdsCameraStatusCommand_EnterDirectTransfer       = $00000002;
      kEdsCameraStatusCommand_ExitDirectTransfer        = $00000003;


// -----------------------------------------------------------------------------
// Camera Events
// -----------------------------------------------------------------------------
type EdsPropertyEvent                 = EdsUInt32;


// ----------------------------------
// Property Event
// ----------------------------------


// Notifies all property events.
const kEdsPropertyEvent_All                       = $00000100;


// Notifies that a camera property value has been changed.
// The changed property can be retrieved from event data.
// The changed value can be retrieved by means of EdsGetPropertyData.
// In the case of type 1 protocol standard cameras,
// notification of changed properties can only be issued for custom functions (CFn).
// If the property type is $0000FFFF, the changed property cannot be identified.
// Thus, retrieve all required properties repeatedly.
      kEdsPropertyEvent_PropertyChanged           = $00000101;


// Notifies of changes in the list of camera properties with configurable values.
// The list of configurable values for property IDs indicated in event data
// can be retrieved by means of EdsGetPropertyDesc.
// For type 1 protocol standard cameras, the property ID is identified as "Unknown"
// during notification.
// Thus, you must retrieve a list of configurable values for all properties and
// retrieve the property values repeatedly.
// (For details on properties for which you can retrieve a list of configurable
// properties,
// see the description of EdsGetPropertyDesc).
      kEdsPropertyEvent_PropertyDescChanged       = $00000102;
type EdsObjectEvent                   = EdsUInt32;


// ----------------------------------
// Object Event
// ----------------------------------


// Notifies all object events.
const kEdsObjectEvent_All                         = $00000200;


// Notifies that the volume object (memory card) state (VolumeInfo)
// has been changed.
// Changed objects are indicated by event data.
// The changed value can be retrieved by means of EdsGetVolumeInfo.
// Notification of this event is not issued for type 1 protocol standard cameras.
      kEdsObjectEvent_VolumeInfoChanged           = $00000201;


// Notifies if the designated volume on a camera has been formatted.
// If notification of this event is received, get sub-items of the designated
// volume again as needed.
// Changed volume objects can be retrieved from event data.
// Objects cannot be identified on cameras earlier than the D30
// if files are added or deleted.
// Thus, these events are subject to notification.
      kEdsObjectEvent_VolumeUpdateItems           = $00000202;


// Notifies if many images are deleted in a designated folder on a camera.
// If notification of this event is received, get sub-items of the designated
// folder again as needed.
// Changed folders (specifically, directory item objects) can be retrieved
// from event data.
      kEdsObjectEvent_FolderUpdateItems           = $00000203;


// Notifies of the creation of objects such as new folders or files
// on a camera compact flash card or the like.
// This event is generated if the camera has been set to store captured
// images simultaneously on the camera and a computer,
// for example, but not if the camera is set to store images
// on the computer alone.
// Newly created objects are indicated by event data.
// Because objects are not indicated for type 1 protocol standard cameras,
// (that is, objects are indicated as NULL),
// you must again retrieve child objects under the camera object to
// identify the new objects.
      kEdsObjectEvent_DirItemCreated              = $00000204;


// Notifies of the deletion of objects such as folders or files on a camera
// compact flash card or the like.
// Deleted objects are indicated in event data.
// Because objects are not indicated for type 1 protocol standard cameras,
// you must again retrieve child objects under the camera object to
// identify deleted objects.
      kEdsObjectEvent_DirItemRemoved              = $00000205;


// Notifies that information of DirItem objects has been changed.
// Changed objects are indicated by event data.
// The changed value can be retrieved by means of EdsGetDirectoryItemInfo.
// Notification of this event is not issued for type 1 protocol standard cameras.
      kEdsObjectEvent_DirItemInfoChanged          = $00000206;


// Notifies that header information has been updated, as for rotation information
// of image files on the camera.
// If this event is received, get the file header information again, as needed.
// This function is for type 2 protocol standard cameras only.
      kEdsObjectEvent_DirItemContentChanged       = $00000207;


// Notifies that there are objects on a camera to be transferred to a computer.
// This event is generated after remote release from a computer or local release
// from a camera.
// If this event is received, objects indicated in the event data must be downloaded.
// Furthermore, if the application does not require the objects, instead
// of downloading them,
// execute EdsDownloadCancel and release resources held by the camera.
// The order of downloading from type 1 protocol standard cameras must be the order
// in which the events are received.
      kEdsObjectEvent_DirItemRequestTransfer      = $00000208;


// Notifies if the camera's direct transfer button is pressed.
// If this event is received, objects indicated in the event data must be downloaded.
// Furthermore, if the application does not require the objects, instead of
// downloading them,
// execute EdsDownloadCancel and release resources held by the camera.
// Notification of this event is not issued for type 1 protocol standard cameras.
      kEdsObjectEvent_DirItemRequestTransferDT    = $00000209;


// Notifies of requests from a camera to cancel object transfer
// if the button to cancel direct transfer is pressed on the camera.
// If the parameter is 0, it means that cancellation of transfer is requested for
// objects still not downloaded,
// with these objects indicated by kEdsObjectEvent_DirItemRequestTransferDT.
// Notification of this event is not issued for type 1 protocol standard cameras.
      kEdsObjectEvent_DirItemCancelTransferDT     = $0000020a;
      kEdsObjectEvent_VolumeAdded                 = $0000020c;
      kEdsObjectEvent_VolumeRemoved               = $0000020d;
type EdsStateEvent                    = EdsUInt32;


// ----------------------------------
// State Event
// ----------------------------------


// Notifies all state events.
const kEdsStateEvent_All                          = $00000300;


// Indicates that a camera is no longer connected to a computer,
// whether it was disconnected by unplugging a cord, opening
// the compact flash compartment,
// turning the camera off, auto shut-off, or by other means.
      kEdsStateEvent_Shutdown                     = $00000301;


// Notifies of whether or not there are objects waiting to
// be transferred to a host computer.
// This is useful when ensuring all shot images have been transferred
// when the application is closed.
// Notification of this event is not issued for type 1 protocol
// standard cameras.
      kEdsStateEvent_JobStatusChanged             = $00000302;


// Notifies that the camera will shut down after a specific period.
// Generated only if auto shut-off is set.
// Exactly when notification is issued (that is, the number of
// seconds until shutdown) varies depending on the camera model.
// To continue operation without having the camera shut down,
// use EdsSendCommand to extend the auto shut-off timer.
// The time in seconds until the camera shuts down is returned
// as the initial value.
      kEdsStateEvent_WillSoonShutDown             = $00000303;


// As the counterpart event to kEdsStateEvent_WillSoonShutDown,
// this event notifies of updates to the number of seconds until
// a camera shuts down.
// After the update, the period until shutdown is model-dependent.
      kEdsStateEvent_ShutDownTimerUpdate          = $00000304;


// Notifies that a requested release has failed, due to focus
// failure or similar factors.
      kEdsStateEvent_CaptureError                 = $00000305;


// Notifies of internal SDK errors.
// If this error event is received, the issuing device will probably
// not be able to continue working properly,
// so cancel the remote connection.
      kEdsStateEvent_InternalError                = $00000306;
      kEdsStateEvent_AfResult                     = $00000309;
      kEdsStateEvent_BulbExposureTime             = $00000310;


// -----------------------------------------------------------------------------
// Drive Lens
// -----------------------------------------------------------------------------

type EdsEvfDriveLens = EdsUInt32; 
const
    kEdsEvfDriveLens_Near1           = $00000001;
    kEdsEvfDriveLens_Near2           = $00000002;
    kEdsEvfDriveLens_Near3           = $00000003;
    kEdsEvfDriveLens_Far1            = $00008001;
    kEdsEvfDriveLens_Far2            = $00008002;
    kEdsEvfDriveLens_Far3            = $00008003;



// -----------------------------------------------------------------------------
// Depth of Field Preview
// -----------------------------------------------------------------------------

type EdsEvfDepthOfFieldPreview = EdsUInt32; 
const
    kEdsEvfDepthOfFieldPreview_OFF   = $00000000;
    kEdsEvfDepthOfFieldPreview_ON    = $00000001;



// -----------------------------------------------------------------------------
// Stream Seek Origins
// -----------------------------------------------------------------------------

type EdsSeekOrigin = EdsUInt32; 
const
    kEdsSeek_Cur                     = 0;        
    kEdsSeek_Begin                   = 1;
    kEdsSeek_End                     = 2;



// -----------------------------------------------------------------------------
// File and Propaties Access
// -----------------------------------------------------------------------------

type EdsAccess = EdsUInt32; 
const
    kEdsAccess_Read                  = 0;        
    kEdsAccess_Write                 = 1;
    kEdsAccess_ReadWrite             = 2;
    kEdsAccess_Error                 = $FFFFFFFF;



// -----------------------------------------------------------------------------
// File Create Disposition
// -----------------------------------------------------------------------------

type EdsFileCreateDisposition = EdsUInt32; 
const
    kEdsFileCreateDisposition_CreateNew = 0;        
    kEdsFileCreateDisposition_CreateAlways = 1;
    kEdsFileCreateDisposition_OpenExisting = 2;
    kEdsFileCreateDisposition_OpenAlways = 3;
    kEdsFileCreateDisposition_TruncateExsisting = 4;



// -----------------------------------------------------------------------------
// Image Types
// -----------------------------------------------------------------------------

type EdsImageType = EdsUInt32; 
const
    kEdsImageType_Unknown            = $00000000;
    kEdsImageType_Jpeg               = $00000001;
    kEdsImageType_CRW                = $00000002;
    kEdsImageType_RAW                = $00000004;
    kEdsImageType_CR2                = $00000006;



// -----------------------------------------------------------------------------
// Image Size
// -----------------------------------------------------------------------------

type EdsImageSize = EdsUInt32; 
const
    kEdsImageSize_Large              = 0;        
    kEdsImageSize_Middle             = 1;        
    kEdsImageSize_Small              = 2;        
    kEdsImageSize_Middle1            = 5;        
    kEdsImageSize_Middle2            = 6;        
    kEdsImageSize_Small1             = 14;       
    kEdsImageSize_Small2             = 15;       
    kEdsImageSize_Small3             = 16;       
    kEdsImageSize_Unknown            = $ffffffff;



// -----------------------------------------------------------------------------
// Image Compress Quality
// -----------------------------------------------------------------------------

type EdsCompressQuality = EdsUInt32; 
const
    kEdsCompressQuality_Normal       = 2;        
    kEdsCompressQuality_Fine         = 3;        
    kEdsCompressQuality_Lossless     = 4;        
    kEdsCompressQuality_SuperFine    = 5;        
    kEdsCompressQuality_Unknown      = $ffffffff;



// -----------------------------------------------------------------------------
// Image Quality
// -----------------------------------------------------------------------------

type EdsImageQuality = EdsUInt32; 
const
    EdsImageQuality_LJ               = $0010ff0f;    // Jpeg Large
    EdsImageQuality_M1J              = $0510ff0f;    // Jpeg Middle1
    EdsImageQuality_M2J              = $0610ff0f;    // Jpeg Middle2
    EdsImageQuality_SJ               = $0210ff0f;    // Jpeg Small
    EdsImageQuality_LJF              = $0013ff0f;    // Jpeg Large Fine
    EdsImageQuality_LJN              = $0012ff0f;    // Jpeg Large Normal
    EdsImageQuality_MJF              = $0113ff0f;    // Jpeg Middle Fine
    EdsImageQuality_MJN              = $0112ff0f;    // Jpeg Middle Normal
    EdsImageQuality_SJF              = $0213ff0f;    // Jpeg Small Fine
    EdsImageQuality_SJN              = $0212ff0f;    // Jpeg Small Normal
    EdsImageQuality_S1JF             = $0E13ff0f;    // Jpeg Small1 Fine
    EdsImageQuality_S1JN             = $0E12ff0f;    // Jpeg Small1 Normal
    EdsImageQuality_S2JF             = $0F13ff0f;    // Jpeg Small2
    EdsImageQuality_S3JF             = $1013ff0f;    // Jpeg Small3
    EdsImageQuality_LR               = $0064ff0f;    // RAW
    EdsImageQuality_LRLJF            = $00640013;    // RAW + Jpeg Large Fine
    EdsImageQuality_LRLJN            = $00640012;    // RAW + Jpeg Large Normal
    EdsImageQuality_LRMJF            = $00640113;    // RAW + Jpeg Middle Fine
    EdsImageQuality_LRMJN            = $00640112;    // RAW + Jpeg Middle Normal
    EdsImageQuality_LRSJF            = $00640213;    // RAW + Jpeg Small Fine
    EdsImageQuality_LRSJN            = $00640212;    // RAW + Jpeg Small Normal
    EdsImageQuality_LRS1JF           = $00640E13;    // RAW + Jpeg Small1 Fine
    EdsImageQuality_LRS1JN           = $00640E12;    // RAW + Jpeg Small1 Normal
    EdsImageQuality_LRS2JF           = $00640F13;    // RAW + Jpeg Small2
    EdsImageQuality_LRS3JF           = $00641013;    // RAW + Jpeg Small3
    EdsImageQuality_LRLJ             = $00640010;    // RAW + Jpeg Large
    EdsImageQuality_LRM1J            = $00640510;    // RAW + Jpeg Middle1
    EdsImageQuality_LRM2J            = $00640610;    // RAW + Jpeg Middle2
    EdsImageQuality_LRSJ             = $00640210;    // RAW + Jpeg Small
    EdsImageQuality_MR               = $0164ff0f;    // MRAW(SRAW1)
    EdsImageQuality_MRLJF            = $01640013;    // MRAW(SRAW1) + Jpeg Large Fine
    EdsImageQuality_MRLJN            = $01640012;    // MRAW(SRAW1) + Jpeg Large Normal
    EdsImageQuality_MRMJF            = $01640113;    // MRAW(SRAW1) + Jpeg Middle Fine
    EdsImageQuality_MRMJN            = $01640112;    // MRAW(SRAW1) + Jpeg Middle Normal
    EdsImageQuality_MRSJF            = $01640213;    // MRAW(SRAW1) + Jpeg Small Fine
    EdsImageQuality_MRSJN            = $01640212;    // MRAW(SRAW1) + Jpeg Small Normal
    EdsImageQuality_MRS1JF           = $01640E13;    // MRAW(SRAW1) + Jpeg Small1 Fine
    EdsImageQuality_MRS1JN           = $01640E12;    // MRAW(SRAW1) + Jpeg Small1 Normal
    EdsImageQuality_MRS2JF           = $01640F13;    // MRAW(SRAW1) + Jpeg Small2
    EdsImageQuality_MRS3JF           = $01641013;    // MRAW(SRAW1) + Jpeg Small3
    EdsImageQuality_MRLJ             = $01640010;    // MRAW(SRAW1) + Jpeg Large
    EdsImageQuality_MRM1J            = $01640510;    // MRAW(SRAW1) + Jpeg Middle1
    EdsImageQuality_MRM2J            = $01640610;    // MRAW(SRAW1) + Jpeg Middle2
    EdsImageQuality_MRSJ             = $01640210;    // MRAW(SRAW1) + Jpeg Small
    EdsImageQuality_SR               = $0264ff0f;    // SRAW(SRAW2)
    EdsImageQuality_SRLJF            = $02640013;    // SRAW(SRAW2) + Jpeg Large Fine
    EdsImageQuality_SRLJN            = $02640012;    // SRAW(SRAW2) + Jpeg Large Normal
    EdsImageQuality_SRMJF            = $02640113;    // SRAW(SRAW2) + Jpeg Middle Fine
    EdsImageQuality_SRMJN            = $02640112;    // SRAW(SRAW2) + Jpeg Middle Normal
    EdsImageQuality_SRSJF            = $02640213;    // SRAW(SRAW2) + Jpeg Small Fine
    EdsImageQuality_SRSJN            = $02640212;    // SRAW(SRAW2) + Jpeg Small Normal
    EdsImageQuality_SRS1JF           = $02640E13;    // SRAW(SRAW2) + Jpeg Small1 Fine
    EdsImageQuality_SRS1JN           = $02640E12;    // SRAW(SRAW2) + Jpeg Small1 Normal
    EdsImageQuality_SRS2JF           = $02640F13;    // SRAW(SRAW2) + Jpeg Small2
    EdsImageQuality_SRS3JF           = $02641013;    // SRAW(SRAW2) + Jpeg Small3
    EdsImageQuality_SRLJ             = $02640010;    // SRAW(SRAW2) + Jpeg Large
    EdsImageQuality_SRM1J            = $02640510;    // SRAW(SRAW2) + Jpeg Middle1
    EdsImageQuality_SRM2J            = $02640610;    // SRAW(SRAW2) + Jpeg Middle2
    EdsImageQuality_SRSJ             = $02640210;    // SRAW(SRAW2) + Jpeg Small
    EdsImageQuality_Unknown          = $ffffffff;


type EdsImageQualityForLegacy = EdsUInt32; 
const
    kEdsImageQualityForLegacy_LJ     = $001f000f;    // Jpeg Large
    kEdsImageQualityForLegacy_M1J    = $051f000f;    // Jpeg Middle1
    kEdsImageQualityForLegacy_M2J    = $061f000f;    // Jpeg Middle2
    kEdsImageQualityForLegacy_SJ     = $021f000f;    // Jpeg Small
    kEdsImageQualityForLegacy_LJF    = $00130000;    // Jpeg Large Fine
    kEdsImageQualityForLegacy_LJN    = $00120000;    // Jpeg Large Normal
    kEdsImageQualityForLegacy_MJF    = $01130000;    // Jpeg Middle Fine
    kEdsImageQualityForLegacy_MJN    = $01120000;    // Jpeg Middle Normal
    kEdsImageQualityForLegacy_SJF    = $02130000;    // Jpeg Small Fine
    kEdsImageQualityForLegacy_SJN    = $02120000;    // Jpeg Small Normal
    kEdsImageQualityForLegacy_LR     = $00240000;    // RAW
    kEdsImageQualityForLegacy_LRLJF  = $00240013;    // RAW + Jpeg Large Fine
    kEdsImageQualityForLegacy_LRLJN  = $00240012;    // RAW + Jpeg Large Normal
    kEdsImageQualityForLegacy_LRMJF  = $00240113;    // RAW + Jpeg Middle Fine
    kEdsImageQualityForLegacy_LRMJN  = $00240112;    // RAW + Jpeg Middle Normal
    kEdsImageQualityForLegacy_LRSJF  = $00240213;    // RAW + Jpeg Small Fine
    kEdsImageQualityForLegacy_LRSJN  = $00240212;    // RAW + Jpeg Small Normal
    kEdsImageQualityForLegacy_LR2    = $002f000f;    // RAW
    kEdsImageQualityForLegacy_LR2LJ  = $002f001f;    // RAW + Jpeg Large
    kEdsImageQualityForLegacy_LR2M1J = $002f051f;    // RAW + Jpeg Middle1
    kEdsImageQualityForLegacy_LR2M2J = $002f061f;    // RAW + Jpeg Middle2
    kEdsImageQualityForLegacy_LR2SJ  = $002f021f;    // RAW + Jpeg Small
    kEdsImageQualityForLegacy_Unknown = $ffffffff;



// -----------------------------------------------------------------------------
// Image Source
// -----------------------------------------------------------------------------

type EdsImageSource = EdsUInt32; 
const
    kEdsImageSrc_FullView            = 0;        
    kEdsImageSrc_Thumbnail           = 1;
    kEdsImageSrc_Preview             = 2;
    kEdsImageSrc_RAWThumbnail        = 3;
    kEdsImageSrc_RAWFullView         = 4;



// -----------------------------------------------------------------------------
// Target Image Types
// -----------------------------------------------------------------------------

type EdsTargetImageType = EdsUInt32; 
const
    kEdsTargetImageType_Unknown      = $00000000;
    kEdsTargetImageType_Jpeg         = $00000001;
    kEdsTargetImageType_TIFF         = $00000007;
    kEdsTargetImageType_TIFF16       = $00000008;
    kEdsTargetImageType_RGB          = $00000009;
    kEdsTargetImageType_RGB16        = $0000000A;
    kEdsTargetImageType_DIB          = $0000000B;



// -----------------------------------------------------------------------------
// Progress Option
// -----------------------------------------------------------------------------

type EdsProgressOption = EdsUInt32; 
const
    kEdsProgressOption_NoReport      = 0;        
    kEdsProgressOption_Done          = 1;
    kEdsProgressOption_Periodically  = 2;



// -----------------------------------------------------------------------------
// File attribute
// -----------------------------------------------------------------------------

type EdsFileAttributes = EdsUInt32; 
const
    kEdsFileAttribute_Normal         = $00000000;
    kEdsFileAttribute_ReadOnly       = $00000001;
    kEdsFileAttribute_Hidden         = $00000002;
    kEdsFileAttribute_System         = $00000004;
    kEdsFileAttribute_Archive        = $00000020;



// -----------------------------------------------------------------------------
// Battery level
// -----------------------------------------------------------------------------

type EdsBatteryLevel2 = EdsUInt32; 
const
    kEdsBatteryLevel2_Empty          = 0;        
    kEdsBatteryLevel2_Low            = 9;        
    kEdsBatteryLevel2_Half           = 49;       
    kEdsBatteryLevel2_Normal         = 80;       
    kEdsBatteryLevel2_Hi             = 69;       
    kEdsBatteryLevel2_Quarter        = 19;       
    kEdsBatteryLevel2_Error          = 0;        
    kEdsBatteryLevel2_BCLevel        = 0;        
    kEdsBatteryLevel2_AC             = $FFFFFFFF;



// -----------------------------------------------------------------------------
// Save To
// -----------------------------------------------------------------------------

type EdsSaveTo = EdsUInt32; 
const
    kEdsSaveTo_Camera                = 1;        
    kEdsSaveTo_Host                  = 2;        
    kEdsSaveTo_Both                  = kEdsSaveTo_Camera OR kEdsSaveTo_Host;



// -----------------------------------------------------------------------------
// StorageType
// -----------------------------------------------------------------------------

type EdsStorageType = EdsUInt32; 
const
    kEdsStorageType_Non              = 0;        
    kEdsStorageType_CF               = 1;        
    kEdsStorageType_SD               = 2;        
    kEdsStorageType_HD               = 4;        



// -----------------------------------------------------------------------------
// White Balance
// -----------------------------------------------------------------------------

type EdsWhiteBalance = EdsUInt32; 
const
    kEdsWhiteBalance_Auto            = 0;        
    kEdsWhiteBalance_Daylight        = 1;        
    kEdsWhiteBalance_Cloudy          = 2;        
    kEdsWhiteBalance_Tangsten        = 3;        
    kEdsWhiteBalance_Fluorescent     = 4;        
    kEdsWhiteBalance_Strobe          = 5;        
    kEdsWhiteBalance_WhitePaper      = 6;        
    kEdsWhiteBalance_Shade           = 8;        
    kEdsWhiteBalance_ColorTemp       = 9;        
    kEdsWhiteBalance_PCSet1          = 10;       
    kEdsWhiteBalance_PCSet2          = 11;       
    kEdsWhiteBalance_PCSet3          = 12;       
    kEdsWhiteBalance_WhitePaper2     = 15;       
    kEdsWhiteBalance_WhitePaper3     = 16;       
    kEdsWhiteBalance_WhitePaper4     = 18;       
    kEdsWhiteBalance_WhitePaper5     = 19;       
    kEdsWhiteBalance_PCSet4          = 20;       
    kEdsWhiteBalance_PCSet5          = 21;       
    kEdsWhiteBalance_Click           = -1;       
    kEdsWhiteBalance_Pasted          = -2;       



// -----------------------------------------------------------------------------
// Photo Effects
// -----------------------------------------------------------------------------

type EdsPhotoEffect = EdsUInt32; 
const
    kEdsPhotoEffect_Off              = 0;        
    kEdsPhotoEffect_Monochrome       = 5;        



// -----------------------------------------------------------------------------
// Color Matrix
// -----------------------------------------------------------------------------

type EdsColorMatrix = EdsUInt32; 
const
    kEdsColorMatrix_Custom           = 0;        
    kEdsColorMatrix_1                = 1;        
    kEdsColorMatrix_2                = 2;        
    kEdsColorMatrix_3                = 3;        
    kEdsColorMatrix_4                = 4;        
    kEdsColorMatrix_5                = 5;        
    kEdsColorMatrix_6                = 6;        
    kEdsColorMatrix_7                = 7;        



// -----------------------------------------------------------------------------
// Filter Effects
// -----------------------------------------------------------------------------

type EdsFilterEffect = EdsUInt32; 
const
    kEdsFilterEffect_None            = 0;        
    kEdsFilterEffect_Yellow          = 1;        
    kEdsFilterEffect_Orange          = 2;        
    kEdsFilterEffect_Red             = 3;        
    kEdsFilterEffect_Green           = 4;        



// -----------------------------------------------------------------------------
// Toning Effects
// -----------------------------------------------------------------------------

type EdsTonigEffect = EdsUInt32; 
const
    kEdsTonigEffect_None             = 0;        
    kEdsTonigEffect_Sepia            = 1;        
    kEdsTonigEffect_Blue             = 2;        
    kEdsTonigEffect_Purple           = 3;        
    kEdsTonigEffect_Green            = 4;        



// -----------------------------------------------------------------------------
// Color Space
// -----------------------------------------------------------------------------

type EdsColorSpace = EdsUInt32; 
const
    kEdsColorSpace_sRGB              = 1;        
    kEdsColorSpace_AdobeRGB          = 2;        
    kEdsColorSpace_Unknown           = $ffffffff;



// -----------------------------------------------------------------------------
// PictureStyle
// -----------------------------------------------------------------------------

type EdsPictureStyle = EdsUInt32; 
const
    kEdsPictureStyle_Standard        = $0081;    
    kEdsPictureStyle_Portrait        = $0082;    
    kEdsPictureStyle_Landscape       = $0083;    
    kEdsPictureStyle_Neutral         = $0084;    
    kEdsPictureStyle_Faithful        = $0085;    
    kEdsPictureStyle_Monochrome      = $0086;    
    kEdsPictureStyle_Auto            = $0087;    
    kEdsPictureStyle_FineDetail      = $0088;    
    kEdsPictureStyle_User1           = $0021;    
    kEdsPictureStyle_User2           = $0022;    
    kEdsPictureStyle_User3           = $0023;    
    kEdsPictureStyle_PC1             = $0041;    
    kEdsPictureStyle_PC2             = $0042;    
    kEdsPictureStyle_PC3             = $0043;    



// -----------------------------------------------------------------------------
// Transfer Option
// -----------------------------------------------------------------------------

type EdsTransferOption = EdsUInt32; 
const
    kEdsTransferOption_ByDirectTransfer = 1;        
    kEdsTransferOption_ByRelease     = 2;        
    kEdsTransferOption_ToDesktop     = $00000100;



// -----------------------------------------------------------------------------
// AE Mode
// -----------------------------------------------------------------------------

type EdsAEMode = EdsUInt32; 
const
    kEdsAEMode_Program               = 0;        
    kEdsAEMode_Tv                    = 1;        
    kEdsAEMode_Av                    = 2;        
    kEdsAEMode_Manual                = 3;        
    kEdsAEMode_Bulb                  = 4;        
    kEdsAEMode_A_DEP                 = 5;        
    kEdsAEMode_DEP                   = 6;        
    kEdsAEMode_Custom                = 7;        
    kEdsAEMode_Lock                  = 8;        
    kEdsAEMode_Green                 = 9;        
    kEdsAEMode_NightPortrait         = 10;       
    kEdsAEMode_Sports                = 11;       
    kEdsAEMode_Portrait              = 12;       
    kEdsAEMode_Landscape             = 13;       
    kEdsAEMode_Closeup               = 14;       
    kEdsAEMode_FlashOff              = 15;       
    kEdsAEMode_CreativeAuto          = 19;       
    kEdsAEMode_Movie                 = 20;       
    kEdsAEMode_PhotoInMovie          = 21;       
    kEdsAEMode_SceneIntelligentAuto  = 22;       
    kEdsAEMode_SCN                   = 25;       
    kEdsAEMode_NightScenes           = 23;       
    kEdsAEMode_BacklitScenes         = 24;       
    kEdsAEMode_Children              = 26;       
    kEdsAEMode_Food                  = 27;       
    kEdsAEMode_CandlelightPortraits  = 28;       
    kEdsAEMode_Unknown               = $ffffffff;



// -----------------------------------------------------------------------------
// Bracket
// -----------------------------------------------------------------------------

type EdsBracket = EdsUInt32; 
const
    kEdsBracket_AEB                  = $01;      
    kEdsBracket_ISOB                 = $02;      
    kEdsBracket_WBB                  = $04;      
    kEdsBracket_FEB                  = $08;      
    kEdsBracket_Unknown              = $ffffffff;



// -----------------------------------------------------------------------------
// EVF Output Device [Flag]
// -----------------------------------------------------------------------------

type EdsEvfOutputDevice = EdsUInt32; 
const
    kEdsEvfOutputDevice_TFT          = 1;        
    kEdsEvfOutputDevice_PC           = 2;        
    kEdsEvfOutputDevice_MOBILE       = 4;        
    kEdsEvfOutputDevice_MOBILE2      = 8;        



// -----------------------------------------------------------------------------
// EVF Zoom
// -----------------------------------------------------------------------------

type EdsEvfZoom = EdsUInt32; 
const
    kEdsEvfZoom_Fit                  = 1;        
    kEdsEvfZoom_x5                   = 5;        
    kEdsEvfZoom_x10                  = 10;       



// -----------------------------------------------------------------------------
// EVF AF Mode
// -----------------------------------------------------------------------------

type EdsEvfAFMode = EdsUInt32; 
const
    Evf_AFMode_Quick                 = 0;        
    Evf_AFMode_Live                  = 1;        
    Evf_AFMode_LiveFace              = 2;        
    Evf_AFMode_LiveMulti             = 3;        



// -----------------------------------------------------------------------------
// Strobo Mode
// -----------------------------------------------------------------------------

type EdsStroboMode = EdsUInt32; 
const
    kEdsStroboModeInternal           = 0;        
    kEdsStroboModeExternalETTL       = 1;        
    kEdsStroboModeExternalATTL       = 2;        
    kEdsStroboModeExternalTTL        = 3;        
    kEdsStroboModeExternalAuto       = 4;        
    kEdsStroboModeExternalManual     = 5;        
    kEdsStroboModeManual             = 6;        



// -----------------------------------------------------------------------------
// ETTL-II Mode
// -----------------------------------------------------------------------------

type EdsETTL2Mode = EdsUInt32; 
const
    kEdsETTL2ModeEvaluative          = 0;        
    kEdsETTL2ModeAverage             = 1;        



// *****************************************************************************
// Definition of base Structures
// *****************************************************************************


// -----------------------------------------------------------------------------
// Point
// -----------------------------------------------------------------------------
type
    EdsPoint = record
        x:                                EdsInt32;
        y:                                EdsInt32;
        end;



// -----------------------------------------------------------------------------
// Size
// -----------------------------------------------------------------------------
type
    EdsSize = record
        width:                            EdsInt32;
        height:                           EdsInt32;
        end;



// -----------------------------------------------------------------------------
// Rectangle
// -----------------------------------------------------------------------------
type
    EdsRect = record
        point:                            EdsPoint;
        size:                             EdsSize;
        end;



// -----------------------------------------------------------------------------
// Rational
// -----------------------------------------------------------------------------
type
    EdsRational = record
        numerator:                        EdsInt32;
        denominator:                      EdsUInt32;
        end;



// -----------------------------------------------------------------------------
// Time
// -----------------------------------------------------------------------------
type
    EdsTime = record
        year:                             EdsUInt32;
        month:                            EdsUInt32;
        day:                              EdsUInt32;
        hour:                             EdsUInt32;
        minute:                           EdsUInt32;
        second:                           EdsUInt32;
        milliseconds:                     EdsUInt32;
        end;



// -----------------------------------------------------------------------------
// Device Info
// -----------------------------------------------------------------------------
type
    EdsDeviceInfo = record
        szPortName:                       array [0 .. EDS_MAX_NAME -1] of EdsChar;
        szDeviceDescription:              array [0 .. EDS_MAX_NAME -1] of EdsChar;
        deviceSubType:                    EdsUInt32;
        reserved:                         EdsUInt32;
        end;



// -----------------------------------------------------------------------------
// Volume Info
// -----------------------------------------------------------------------------
type
    EdsVolumeInfo = record
        storageType:                      EdsUInt32;
        access:                           EdsAccess;
        maxCapacity:                      EdsUInt64;
        freeSpaceInBytes:                 EdsUInt64;
        szVolumeLabel:                    array [0 .. EDS_MAX_NAME -1] of EdsChar;
        end;



// -----------------------------------------------------------------------------
// DirectoryItem Info
// -----------------------------------------------------------------------------
type
    EdsDirectoryItemInfo = record
        size:                             EdsUInt32;
        isFolder:                         EdsBool;
        groupID:                          EdsUInt32;
        option:                           EdsUInt32;
        szFileName:                       array [0 .. EDS_MAX_NAME -1] of EdsChar;
        format:                           EdsUInt32;
        dateTime:                         EdsUInt32;
        end;



// -----------------------------------------------------------------------------
// Image Info
// -----------------------------------------------------------------------------
type
    EdsImageInfo = record
        width:                            EdsUInt32;
        height:                           EdsUInt32;
        numOfComponents:                  EdsUInt32;
        componentDepth:                   EdsUInt32;
        effectiveRect:                    EdsRect;
        reserved1:                        EdsUInt32;
        reserved2:                        EdsUInt32;
        end;



// -----------------------------------------------------------------------------
// SaveImage Setting
// -----------------------------------------------------------------------------
type
    EdsSaveImageSetting = record
        JPEGQuality:                      EdsUInt32;
        iccProfileStream:                 EdsStreamRef;
        reserved:                         EdsUInt32;
        end;



// -----------------------------------------------------------------------------
// Property Desc
// -----------------------------------------------------------------------------
type
    EdsPropertyDesc = record
        form:                             EdsInt32;
        access:                           EdsInt32;
        numElements:                      EdsInt32;
        propDesc:                         array [0 .. 128 -1] of EdsInt32;
        end;



// -----------------------------------------------------------------------------
// Picture Style Desc
// -----------------------------------------------------------------------------
type
    EdsPictureStyleDesc = record
        contrast:                         EdsInt32;
        sharpness:                        EdsUInt32;
        saturation:                       EdsInt32;
        colorTone:                        EdsInt32;
        filterEffect:                     EdsUInt32;
        toningEffect:                     EdsUInt32;
        sharpFineness:                    EdsUInt32;
        sharpThreshold:                   EdsUInt32;
        end;



// -----------------------------------------------------------------------------
// Focus Info
// -----------------------------------------------------------------------------
type
    EdsFocusPoint = record
        valid:                            EdsUInt32;
        selected:                         EdsUInt32;
        justFocus:                        EdsUInt32;
        rect:                             EdsRect;
        reserved:                         EdsUInt32;
        end;

type
    EdsFocusInfo = record
        imageRect:                        EdsRect;
        pointNumber:                      EdsUInt32;
        focusPoint:                       array [0 .. 128 -1] of EdsFocusPoint;
        executeMode:                      EdsUInt32;
        end;



// -----------------------------------------------------------------------------
// User WhiteBalance (PC set1,2,3)/ User ToneCurve / User PictureStyle dataset
// -----------------------------------------------------------------------------
type
    EdsUsersetData = record
        valid:                            EdsUInt32;
        dataSize:                         EdsUInt32;
        szCaption:                        array [0 .. 32 -1] of EdsChar;
        data:                             array [0 .. 1 -1] of EdsUInt8;
        end;



// -----------------------------------------------------------------------------
// Capacity
// -----------------------------------------------------------------------------
type
    EdsCapacity = record
        numberOfFreeClusters:             EdsInt32;
        bytesPerSector:                   EdsInt32;
        reset:                            EdsBool;
        end;



// -----------------------------------------------------------------------------
// FramePoint
// -----------------------------------------------------------------------------
type
    EdsFramePoint = record
        x:                                EdsInt32;
        y:                                EdsInt32;
        end;



// *****************************************************************************
// Callback Functions
// *****************************************************************************


// -----------------------------------------------------------------------------
// EdsProgressCallback
// -----------------------------------------------------------------------------
type
    EdsProgressCallback = function(percent: EdsUInt32;
                             var context;
                             var cancel: EdsBool): EdsError; stdcall;


// -----------------------------------------------------------------------------
// EdsCameraAddedHandler
// -----------------------------------------------------------------------------
type
    EdsCameraAddedHandler = function(var context): EdsError; stdcall;


// -----------------------------------------------------------------------------
// EdsPropertyEventHandler
// -----------------------------------------------------------------------------
type
    EdsPropertyEventHandler = function(event: EdsPropertyEvent;
                                     propertyID: EdsPropertyID;
                                     param: EdsUInt32;
                                 var context): EdsError; stdcall;


// -----------------------------------------------------------------------------
// EdsObjectEventHandler
// -----------------------------------------------------------------------------
type
    EdsObjectEventHandler = function(event: EdsObjectEvent;
                                   ref: EdsBaseRef;
                               var context): EdsError; stdcall;


// -----------------------------------------------------------------------------
// EdsStateEventHandler
// -----------------------------------------------------------------------------
type
    EdsStateEventHandler = function(event: EdsStateEvent;
                                  eventData: EdsUInt32;
                              var context): EdsError; stdcall;


// ----------------------------------------------------------------------------
// ???? typedef EdsError EDSSTDCALL EdsReadStream (void *inContext, EdsUInt32 inReadSize, EdsVoid* outBuffer, EdsUInt32* outReadSize)
// ???? typedef EdsError EDSSTDCALL EdsWriteStream (void *inContext, EdsUInt32 inWriteSize, const EdsVoid* inBuffer, EdsUInt32* outWrittenSize)
// ???? typedef EdsError EDSSTDCALL EdsSeekStream (void *inContext, EdsInt32 inSeekOffset, EdsSeekOrigin inSeekOrigin)
// ???? typedef EdsError EDSSTDCALL EdsTellStream (void *inContext, EdsInt32 *outPosition)
// ???? typedef EdsError EDSSTDCALL EdsGetStreamLength (void *inContext, EdsUInt32 *outLength)
type
    EdsIStream = record
        // ???? void              *context
        // ???? EdsReadStream       *read
        // ???? EdsWriteStream      *write
        // ???? EdsSeekStream       *seek
        // ???? EdsTellStream       *tell
        // ???? EdsGetStreamLength  *getLength
        end;

// ifdef __MACOS__
    // if PRAGMA_STRUCT_ALIGN
        // pragma options align=reset
    // endif
// else
    // pragma pack (pop)
// endif 


// endif //  _EDS_TYPES_H_


implementation




end.
