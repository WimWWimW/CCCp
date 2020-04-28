unit EDSDKerror;

// ------------------------------------------------------------------------------------
// NOTE: * this file has been converted automatically and might still contain mistakes.
//       * original file: EDSDKErrors.h 
//       * SDK-version:   2.7.1.1
// ------------------------------------------------------------------------------------



interface

(******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : EDSDKErros.h                                                    *
*                                                                             *
*   Description: ERROR DEFINITION FOR EDSDK                                   *
*                                                                             *
*******************************************************************************
*                                                                             *
*   Written and developed by Canon Inc.                                       *
*   Copyright Canon Inc. 2006-2007 All Rights Reserved                        *
*                                                                             *
*******************************************************************************
*   File Update Information:                                                  *
*     DATE      Identify    Comment                                           *
*   -----------------------------------------------------------------------   *
*   06-03-16    F-001       create first version.                             *
*                                                                             *
******************************************************************************)

// ifndef _EDS_ERRORS_H_
const


(*----------------------------------------------------------------------------*)


(******************************************************************************
 Definition of error Codes
******************************************************************************)
(*-----------------------------------------------------------------------
   ED-SDK Error Code Masks
------------------------------------------------------------------------*)
    EDS_ISSPECIFIC_MASK                                 = $80000000;
    EDS_COMPONENTID_MASK                                = $7F000000;
    EDS_RESERVED_MASK                                   = $00FF0000;
    EDS_ERRORID_MASK                                    = $0000FFFF;

(*-----------------------------------------------------------------------
   ED-SDK Base Component IDs
------------------------------------------------------------------------*)
    EDS_CMP_ID_CLIENT_COMPONENTID                       = $01000000;
    EDS_CMP_ID_LLSDK_COMPONENTID                        = $02000000;
    EDS_CMP_ID_HLSDK_COMPONENTID                        = $03000000;

(*-----------------------------------------------------------------------
   ED-SDK Functin Success Code
------------------------------------------------------------------------*)
    EDS_ERR_OK                                          = $00000000;

(*-----------------------------------------------------------------------
   ED-SDK Generic Error IDs
------------------------------------------------------------------------*)
(* Miscellaneous errors *)
    EDS_ERR_UNIMPLEMENTED                               = $00000001;  
    EDS_ERR_INTERNAL_ERROR                              = $00000002;
    EDS_ERR_MEM_ALLOC_FAILED                            = $00000003;
    EDS_ERR_MEM_FREE_FAILED                             = $00000004;
    EDS_ERR_OPERATION_CANCELLED                         = $00000005;
    EDS_ERR_INCOMPATIBLE_VERSION                        = $00000006;
    EDS_ERR_NOT_SUPPORTED                               = $00000007;
    EDS_ERR_UNEXPECTED_EXCEPTION                        = $00000008;
    EDS_ERR_PROTECTION_VIOLATION                        = $00000009;
    EDS_ERR_MISSING_SUBCOMPONENT                        = $0000000A;
    EDS_ERR_SELECTION_UNAVAILABLE                       = $0000000B;

(* File errors *)
    EDS_ERR_FILE_IO_ERROR                               = $00000020;
    EDS_ERR_FILE_TOO_MANY_OPEN                          = $00000021;
    EDS_ERR_FILE_NOT_FOUND                              = $00000022;
    EDS_ERR_FILE_OPEN_ERROR                             = $00000023;
    EDS_ERR_FILE_CLOSE_ERROR                            = $00000024;
    EDS_ERR_FILE_SEEK_ERROR                             = $00000025;
    EDS_ERR_FILE_TELL_ERROR                             = $00000026;
    EDS_ERR_FILE_READ_ERROR                             = $00000027;
    EDS_ERR_FILE_WRITE_ERROR                            = $00000028;
    EDS_ERR_FILE_PERMISSION_ERROR                       = $00000029;
    EDS_ERR_FILE_DISK_FULL_ERROR                        = $0000002A;
    EDS_ERR_FILE_ALREADY_EXISTS                         = $0000002B;
    EDS_ERR_FILE_FORMAT_UNRECOGNIZED                    = $0000002C;
    EDS_ERR_FILE_DATA_CORRUPT                           = $0000002D;
    EDS_ERR_FILE_NAMING_NA                              = $0000002E;

(* Directory errors *)          
    EDS_ERR_DIR_NOT_FOUND                               = $00000040;
    EDS_ERR_DIR_IO_ERROR                                = $00000041;
    EDS_ERR_DIR_ENTRY_NOT_FOUND                         = $00000042;
    EDS_ERR_DIR_ENTRY_EXISTS                            = $00000043;
    EDS_ERR_DIR_NOT_EMPTY                               = $00000044;

(* Property errors *)
    EDS_ERR_PROPERTIES_UNAVAILABLE                      = $00000050;
    EDS_ERR_PROPERTIES_MISMATCH                         = $00000051;
    EDS_ERR_PROPERTIES_NOT_LOADED                       = $00000053;

(* Function Parameter errors *)     
    EDS_ERR_INVALID_PARAMETER                           = $00000060;
    EDS_ERR_INVALID_HANDLE                              = $00000061;
    EDS_ERR_INVALID_POINTER                             = $00000062;
    EDS_ERR_INVALID_INDEX                               = $00000063;
    EDS_ERR_INVALID_LENGTH                              = $00000064;
    EDS_ERR_INVALID_FN_POINTER                          = $00000065;
    EDS_ERR_INVALID_SORT_FN                             = $00000066;

(* Device errors *)
    EDS_ERR_DEVICE_NOT_FOUND                            = $00000080;
    EDS_ERR_DEVICE_BUSY                                 = $00000081;
    EDS_ERR_DEVICE_INVALID                              = $00000082;
    EDS_ERR_DEVICE_EMERGENCY                            = $00000083;
    EDS_ERR_DEVICE_MEMORY_FULL                          = $00000084;
    EDS_ERR_DEVICE_INTERNAL_ERROR                       = $00000085;
    EDS_ERR_DEVICE_INVALID_PARAMETER                    = $00000086;
    EDS_ERR_DEVICE_NO_DISK                              = $00000087;
    EDS_ERR_DEVICE_DISK_ERROR                           = $00000088;
    EDS_ERR_DEVICE_CF_GATE_CHANGED                      = $00000089;
    EDS_ERR_DEVICE_DIAL_CHANGED                         = $0000008A;
    EDS_ERR_DEVICE_NOT_INSTALLED                        = $0000008B;
    EDS_ERR_DEVICE_STAY_AWAKE                           = $0000008C;
    EDS_ERR_DEVICE_NOT_RELEASED                         = $0000008D;


(* Stream errors *)
    EDS_ERR_STREAM_IO_ERROR                             = $000000A0;
    EDS_ERR_STREAM_NOT_OPEN                             = $000000A1;
    EDS_ERR_STREAM_ALREADY_OPEN                         = $000000A2;
    EDS_ERR_STREAM_OPEN_ERROR                           = $000000A3;
    EDS_ERR_STREAM_CLOSE_ERROR                          = $000000A4;
    EDS_ERR_STREAM_SEEK_ERROR                           = $000000A5;
    EDS_ERR_STREAM_TELL_ERROR                           = $000000A6;
    EDS_ERR_STREAM_READ_ERROR                           = $000000A7;
    EDS_ERR_STREAM_WRITE_ERROR                          = $000000A8;
    EDS_ERR_STREAM_PERMISSION_ERROR                     = $000000A9;
    EDS_ERR_STREAM_COULDNT_BEGIN_THREAD                 = $000000AA;
    EDS_ERR_STREAM_BAD_OPTIONS                          = $000000AB;
    EDS_ERR_STREAM_END_OF_STREAM                        = $000000AC;

(* Communications errors *)
    EDS_ERR_COMM_PORT_IS_IN_USE                         = $000000C0;
    EDS_ERR_COMM_DISCONNECTED                           = $000000C1;
    EDS_ERR_COMM_DEVICE_INCOMPATIBLE                    = $000000C2;
    EDS_ERR_COMM_BUFFER_FULL                            = $000000C3;
    EDS_ERR_COMM_USB_BUS_ERR                            = $000000C4;

(* Lock/Unlock *)
    EDS_ERR_USB_DEVICE_LOCK_ERROR                       = $000000D0;
    EDS_ERR_USB_DEVICE_UNLOCK_ERROR                     = $000000D1;

(* STI/WIA *)
    EDS_ERR_STI_UNKNOWN_ERROR                           = $000000E0;
    EDS_ERR_STI_INTERNAL_ERROR                          = $000000E1;
    EDS_ERR_STI_DEVICE_CREATE_ERROR                     = $000000E2;
    EDS_ERR_STI_DEVICE_RELEASE_ERROR                    = $000000E3;
    EDS_ERR_DEVICE_NOT_LAUNCHED                         = $000000E4;
    
    EDS_ERR_ENUM_NA                                     = $000000F0;
    EDS_ERR_INVALID_FN_CALL                             = $000000F1;
    EDS_ERR_HANDLE_NOT_FOUND                            = $000000F2;
    EDS_ERR_INVALID_ID                                  = $000000F3;
    EDS_ERR_WAIT_TIMEOUT_ERROR                          = $000000F4;

(* PTP *)
    EDS_ERR_SESSION_NOT_OPEN                            = $00002003;
    EDS_ERR_INVALID_TRANSACTIONID                       = $00002004;
    EDS_ERR_INCOMPLETE_TRANSFER                         = $00002007;
    EDS_ERR_INVALID_STRAGEID                            = $00002008;
    EDS_ERR_DEVICEPROP_NOT_SUPPORTED                    = $0000200A;
    EDS_ERR_INVALID_OBJECTFORMATCODE                    = $0000200B;
    EDS_ERR_SELF_TEST_FAILED                            = $00002011;
    EDS_ERR_PARTIAL_DELETION                            = $00002012;
    EDS_ERR_SPECIFICATION_BY_FORMAT_UNSUPPORTED         = $00002014;
    EDS_ERR_NO_VALID_OBJECTINFO                         = $00002015;
    EDS_ERR_INVALID_CODE_FORMAT                         = $00002016;
    EDS_ERR_UNKNOWN_VENDOR_CODE                         = $00002017;
    EDS_ERR_CAPTURE_ALREADY_TERMINATED                  = $00002018;
    EDS_ERR_INVALID_PARENTOBJECT                        = $0000201A;
    EDS_ERR_INVALID_DEVICEPROP_FORMAT                   = $0000201B;
    EDS_ERR_INVALID_DEVICEPROP_VALUE                    = $0000201C;
    EDS_ERR_SESSION_ALREADY_OPEN                        = $0000201E;
    EDS_ERR_TRANSACTION_CANCELLED                       = $0000201F;
    EDS_ERR_SPECIFICATION_OF_DESTINATION_UNSUPPORTED    = $00002020;

(* PTP Vendor *)
    EDS_ERR_UNKNOWN_COMMAND                             = $0000A001;
    EDS_ERR_OPERATION_REFUSED                           = $0000A005;
    EDS_ERR_LENS_COVER_CLOSE                            = $0000A006;
    EDS_ERR_LOW_BATTERY                                    = $0000A101;
    EDS_ERR_OBJECT_NOTREADY                                = $0000A102;




    EDS_ERR_TAKE_PICTURE_AF_NG                          = $00008D01;
    EDS_ERR_TAKE_PICTURE_RESERVED                       = $00008D02;
    EDS_ERR_TAKE_PICTURE_MIRROR_UP_NG                   = $00008D03;
    EDS_ERR_TAKE_PICTURE_SENSOR_CLEANING_NG             = $00008D04;
    EDS_ERR_TAKE_PICTURE_SILENCE_NG                     = $00008D05;
    EDS_ERR_TAKE_PICTURE_NO_CARD_NG                     = $00008D06;
    EDS_ERR_TAKE_PICTURE_CARD_NG                        = $00008D07;
    EDS_ERR_TAKE_PICTURE_CARD_PROTECT_NG                = $00008D08;


    EDS_ERR_LAST_GENERIC_ERROR_PLUS_ONE                 = $000000F5;


(*----------------------------------------------------------------------------*)


// endif (* _EDS_ERRORS_H_ *)


implementation




end.
