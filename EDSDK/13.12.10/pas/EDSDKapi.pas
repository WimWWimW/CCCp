unit EDSDKapi;

// ------------------------------------------------------------------------------------
// NOTE: * this file has been converted automatically and might still contain mistakes.
//       * original file: EDSDK.h 
//       * SDK-version:   13.12.1.0
// ------------------------------------------------------------------------------------

(******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : EDSDK.h                                                         *
*                                                                             *
*   Description: DEFINITION OF EDSDK API                                      *
*                                                                             *
*******************************************************************************
*                                                                             *
*   Written and developed by Canon Inc.                                          *
*   Copyright Canon Inc. 2006-2019 All Rights Reserved                        *
*                                                                             *
******************************************************************************)


interface

uses
  EDSDKtype;


const
  edsdk = 'D:/Delphi/Canon Remote/EDSDK/13.12.10/dll/EDSDK.dll';


(*-----------------------------------------------------------------------------
//
//  Function:   EdsInitializeSDK
//
//  Description:
//      Initializes the libraries. 
//      When using the EDSDK libraries, you must call this API once  
//          before using EDSDK APIs.
//
//  Parameters:
//       In:    None
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsInitializeSDK(): EdsError; stdcall; external edsdk;


(*-----------------------------------------------------------------------------
//
//  Function:   EdsTerminateSDK
//
//  Description:
//      Terminates use of the libraries. 
//      This function muse be called when ending the SDK.
//      Calling this function releases all resources allocated by the libraries.
//
//  Parameters:
//       In:    None
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsTerminateSDK(): EdsError; stdcall; external edsdk;



(******************************************************************************
*******************************************************************************
//
//  Reference-counter operating functions
//
*******************************************************************************
******************************************************************************/


(*-----------------------------------------------------------------------------
//
//  Function:   EdsRetain
//
//  Description:
//      Increments the reference counter of existing objects.
//
//  Parameters:
//       In:    inRef - The reference for the item.
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsRetain(ref: EdsBaseRef): EdsUInt32; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsRelease
//
//  Description:
//      Decrements the reference counter to an object. 
//      When the reference counter reaches 0, the object is released.
//
//  Parameters:
//       In:    inRef - The reference of the item.
//      Out:    None
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsRelease(ref: EdsBaseRef): EdsUInt32; stdcall; external edsdk;



(******************************************************************************
*******************************************************************************
//
//  Item-tree operating functions
//
*******************************************************************************
******************************************************************************/


(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetChildCount
//
//  Description:
//      Gets the number of child objects of the designated object.
//      Example: Number of files in a directory
//
//  Parameters:
//       In:    inRef - The reference of the list.
//      Out:    outCount - Number of elements in this list.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetChildCount(ref: EdsBaseRef;
                          var count: EdsUInt32): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetChildAtIndex
//
//  Description:
//       Gets an indexed child object of the designated object. 
//
//  Parameters:
//       In:    inRef - The reference of the item.
//              inIndex -  The index that is passed in, is zero based.
//      Out:    outRef - The pointer which receives reference of the 
//                           specified index .
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetChildAtIndex(inRef: EdsBaseRef;
                                index: EdsInt32;
                            var outRef: EdsBaseRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetParent
//
//  Description:
//      Gets the parent object of the designated object.
//
//  Parameters:
//       In:    inRef        - The reference of the item.
//      Out:    outParentRef - The pointer which receives reference.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetParent(ref: EdsBaseRef;
                      var parentRef: EdsBaseRef): EdsError; stdcall; external edsdk;



(******************************************************************************
*******************************************************************************
//
//  Property operating functions
//
*******************************************************************************
******************************************************************************/


(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetPropertySize
//
//  Description:
//      Gets the byte size and data type of a designated property 
//          from a camera object or image object.
//
//  Parameters:
//       In:    inRef - The reference of the item.
//              inPropertyID - The ProprtyID
//              inParam - Additional information of property.
//                   We use this parameter in order to specify an index
//                   in case there are two or more values over the same ID.
//      Out:    outDataType - Pointer to the buffer that is to receive the property
//                        type data.
//              outSize - Pointer to the buffer that is to receive the property
//                        size.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetPropertySize(ref: EdsBaseRef;
                                propertyID: EdsPropertyID;
                                param: EdsInt32;
                            var dataType: EdsDataType;
                            var size: EdsUInt32): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetPropertyData
//
//  Description:
//      Gets property information from the object designated in inRef.
//
//  Parameters:
//       In:    inRef - The reference of the item.
//              inPropertyID - The ProprtyID
//              inParam - Additional information of property.
//                   We use this parameter in order to specify an index
//                   in case there are two or more values over the same ID.
//              inPropertySize - The number of bytes of the prepared buffer
//                  for receive property-value.
//       Out:   outPropertyData - The buffer pointer to receive property-value.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetPropertyData(ref: EdsBaseRef;
                                propertyID: EdsPropertyID;
                                param: EdsInt32;
                                propertySize: EdsUInt32;
                            var propertyData): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsSetPropertyData
//
//  Description:
//      Sets property data for the object designated in inRef. 
//
//  Parameters:
//       In:    inRef - The reference of the item.
//              inPropertyID - The ProprtyID
//              inParam - Additional information of property.
//              inPropertySize - The number of bytes of the prepared buffer
//                  for set property-value.
//              inPropertyData - The buffer pointer to set property-value.
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsSetPropertyData(ref: EdsBaseRef;
                                propertyID: EdsPropertyID;
                                param: EdsInt32;
                                propertySize: EdsUInt32;
                            var propertyData): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//  
//  Function:   EdsGetPropertyDesc
//
//  Description:
//      Gets a list of property data that can be set for the object 
//          designated in inRef, as well as maximum and minimum values. 
//      This API is intended for only some shooting-related properties.
//
//  Parameters:
//       In:    inRef - The reference of the camera.
//              inPropertyID - The Property ID.
//       Out:   outPropertyDesc - Array of the value which can be set up.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetPropertyDesc(ref: EdsBaseRef;
                                propertyID: EdsPropertyID;
                            var propertyDesc: EdsPropertyDesc): EdsError; stdcall; external edsdk;



(******************************************************************************
*******************************************************************************
//
//  Device-list and device operating functions
//
*******************************************************************************
******************************************************************************/


(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetCameraList
//
//  Description:
//      Gets camera list objects.
//
//  Parameters:
//       In:    None
//      Out:    outCameraListRef - Pointer to the camera-list.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetCameraList(var cameraListRef: EdsCameraListRef): EdsError; stdcall; external edsdk;



(******************************************************************************
*******************************************************************************
//
//  Camera operating functions
//
*******************************************************************************
******************************************************************************/


(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetDeviceInfo
//
//  Description:
//      Gets device information, such as the device name.  
//      Because device information of remote cameras is stored 
//          on the host computer, you can use this API 
//          before the camera object initiates communication
//          (that is, before a session is opened). 
//
//  Parameters:
//       In:    inCameraRef - The reference of the camera.
//      Out:    outDeviceInfo - Information as device of camera.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetDeviceInfo(cameraRef: EdsCameraRef;
                          var deviceInfo: EdsDeviceInfo): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsOpenSession
//
//  Description:
//      Establishes a logical connection with a remote camera. 
//      Use this API after getting the camera's EdsCamera object.
//
//  Parameters:
//       In:    inCameraRef - The reference of the camera 
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsOpenSession(cameraRef: EdsCameraRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsCloseSession
//
//  Description:
//       Closes a logical connection with a remote camera.
//
//  Parameters:
//       In:    inCameraRef - The reference of the camera 
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsCloseSession(cameraRef: EdsCameraRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsSendCommand
//
//  Description:
//       Sends a command such as "Shoot" to a remote camera. 
//
//  Parameters:
//       In:    inCameraRef - The reference of the camera which will receive the 
//                      command.
//              inCommand - Specifies the command to be sent.
//              inParam -     Specifies additional command-specific information.
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsSendCommand(cameraRef: EdsCameraRef;
                            command: EdsCameraCommand;
                            param: EdsInt32): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsSendStatusCommand
//
//  Description:
//       Sets the remote camera state or mode.
//
//  Parameters:
//       In:    inCameraRef - The reference of the camera which will receive the 
//                      command.
//              inStatusCommand - Specifies the command to be sent.
//              inParam -     Specifies additional command-specific information.
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsSendStatusCommand(cameraRef: EdsCameraRef;
                                  statusCommand: EdsCameraStatusCommand;
                                  param: EdsInt32): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsSetCapacity
//
//  Description:
//      Sets the remaining HDD capacity on the host computer
//          (excluding the portion from image transfer),
//          as calculated by subtracting the portion from the previous time. 
//      Set a reset flag initially and designate the cluster length 
//          and number of free clusters.
//      Some type 2 protocol standard cameras can display the number of shots 
//          left on the camera based on the available disk capacity 
//          of the host computer. 
//      For these cameras, after the storage destination is set to the computer, 
//          use this API to notify the camera of the available disk capacity 
//          of the host computer.
//
//  Parameters:
//       In:    inCameraRef - The reference of the camera which will receive the 
//                      command.
//              inCapacity -  The remaining capacity of a transmission place.
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsSetCapacity(cameraRef: EdsCameraRef;
                            capacity: EdsCapacity): EdsError; stdcall; external edsdk;



(******************************************************************************
*******************************************************************************
//
//  Volume operating functions
//
*******************************************************************************
******************************************************************************/


(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetVolumeInfo
//
//  Description:
//      Gets volume information for a memory card in the camera.
//
//  Parameters:
//       In:    inVolumeRef - The reference of the volume.
//      Out:    outVolumeInfo - information of  the volume.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetVolumeInfo(volumeRef: EdsVolumeRef;
                          var volumeInfo: EdsVolumeInfo): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsFormatVolume
//
//  Description:
//       Formats volumes of memory cards in a camera. 
//
//  Parameters:
//       In:    inVolumeRef - The reference of volume .
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsFormatVolume(volumeRef: EdsVolumeRef): EdsError; stdcall; external edsdk;



(******************************************************************************
*******************************************************************************
//
//  Directory-item operating functions
//
*******************************************************************************
******************************************************************************/


(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetDirectoryItemInfo
//
//  Description:
//      Gets information about the directory or file objects 
//          on the memory card (volume) in a remote camera.
//
//  Parameters:
//       In:    inDirItemRef - The reference of the directory item.
//      Out:    outDirItemInfo - information of the directory item.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetDirectoryItemInfo(dirItemRef: EdsDirectoryItemRef;
                                 var dirItemInfo: EdsDirectoryItemInfo): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsDeleteDirectoryItem
//
//  Description:
//      Deletes a camera folder or file.
//      If folders with subdirectories are designated, all files are deleted 
//          except protected files. 
//      EdsDirectoryItem objects deleted by means of this API are implicitly 
//          released by the EDSDK. Thus, there is no need to release them 
//          by means of EdsRelease.
//
//  Parameters:
//       In:    inDirItemRef - The reference of the directory item.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsDeleteDirectoryItem(dirItemRef: EdsDirectoryItemRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsDownload
//
//  Description:
//       Downloads a file on a remote camera 
//          (in the camera memory or on a memory card) to the host computer. 
//      The downloaded file is sent directly to a file stream created in advance. 
//      When dividing the file being retrieved, call this API repeatedly. 
//      Also in this case, make the data block size a multiple of 512 (bytes), 
//          excluding the final block.
//
//  Parameters:
//       In:    inDirItemRef - The reference of the directory item.
//              inReadSize   - 
//
//      Out:    outStream    - The reference of the stream.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsDownload(dirItemRef: EdsDirectoryItemRef;
                         readSize: EdsUInt64;
                         tStream: EdsStreamRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsDownloadCancel
//
//  Description:
//       Must be executed when downloading of a directory item is canceled. 
//      Calling this API makes the camera cancel file transmission.
//      It also releases resources. 
//      This operation need not be executed when using EdsDownloadThumbnail. 
//
//  Parameters:
//       In:    inDirItemRef - The reference of the directory item.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsDownloadCancel(dirItemRef: EdsDirectoryItemRef): EdsError; stdcall; external edsdk;
 


(*-----------------------------------------------------------------------------
//
//  Function:   EdsDownloadComplete
//
//  Description:
//       Must be called when downloading of directory items is complete. 
//          Executing this API makes the camera 
//              recognize that file transmission is complete. 
//          This operation need not be executed when using EdsDownloadThumbnail.
//
//  Parameters:
//       In:    inDirItemRef - The reference of the directory item.
//
//      Out:    outStream    - None.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsDownloadComplete(dirItemRef: EdsDirectoryItemRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsDownloadThumbnail
//
//  Description:
//      Extracts and downloads thumbnail information from image files in a camera. 
//      Thumbnail information in the camera's image files is downloaded 
//          to the host computer. 
//      Downloaded thumbnails are sent directly to a file stream created in advance.
//
//  Parameters:
//       In:    inDirItemRef - The reference of the directory item.
//
//      Out:    outStream - The reference of the stream.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsDownloadThumbnail(dirItemRef: EdsDirectoryItemRef;
                                  tStream: EdsStreamRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetAttribute
//
//  Description:
//      Gets attributes of files on a camera.
//  
//  Parameters:
//       In:    inDirItemRef - The reference of the directory item.
//      Out:    outFileAttribute  - Indicates the file attributes. 
//                  As for the file attributes, OR values of the value defined
//                  by enum EdsFileAttributes can be retrieved. Thus, when 
//                  determining the file attributes, you must check 
//                  if an attribute flag is set for target attributes. 
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetAttribute(dirItemRef: EdsDirectoryItemRef;
                         var fileAttribute: EdsFileAttributes): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsSetAttribute
//
//  Description:
//      Changes attributes of files on a camera.
//  
//  Parameters:
//       In:    inDirItemRef - The reference of the directory item.
//              inFileAttribute  - Indicates the file attributes. 
//                      As for the file attributes, OR values of the value 
//                      defined by enum EdsFileAttributes can be retrieved. 
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsSetAttribute(dirItemRef: EdsDirectoryItemRef;
                             fileAttribute: EdsFileAttributes): EdsError; stdcall; external edsdk;



(******************************************************************************
*******************************************************************************
//
//  Stream operating functions
//
*******************************************************************************
******************************************************************************/


(*-----------------------------------------------------------------------------
//
//  Function:   EdsCreateFileStream
//
//  Description:
//      Creates a new file on a host computer (or opens an existing file) 
//          and creates a file stream for access to the file. 
//      If a new file is designated before executing this API, 
//          the file is actually created following the timing of writing 
//          by means of EdsWrite or the like with respect to an open stream.
//
//  Parameters:
//       In:    inFileName - Pointer to a null-terminated string that specifies
//                           the file name.
//              inCreateDisposition - Action to take on files that exist, 
//                                and which action to take when files do not exist.  
//              inDesiredAccess - Access to the stream (reading, writing, or both).
//      Out:    outStream - The reference of the stream.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsCreateFileStream(fileName: pChar;
                                 createDisposition: EdsFileCreateDisposition;
                                 desiredAccess: EdsAccess;
                             var stream: EdsStreamRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsCreateMemoryStream
//
//  Description:
//      Creates a stream in the memory of a host computer. 
//      In the case of writing in excess of the allocated buffer size, 
//          the memory is automatically extended.
//
//  Parameters:
//       In:    inBufferSize - The number of bytes of the memory to allocate.
//      Out:    outStream - The reference of the stream.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsCreateMemoryStream(bufferSize: EdsUInt64;
                               var stream: EdsStreamRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsCreateStreamEx
//
//  Description:
//      An extended version of EdsCreateStreamFromFile. 
//      Use this function when working with Unicode file names.
//
//  Parameters:
//       In:    inURL (for Macintosh) - Designate CFURLRef. 
//              inFileName (for Windows) - Designate the file name. 
//              inCreateDisposition - Action to take on files that exist, 
//                                and which action to take when files do not exist.  
//              inDesiredAccess - Access to the stream (reading, writing, or both).
//
//      Out:    outStream - The reference of the stream.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsCreateFileStreamEx(fileName: pWideChar;
                                   createDisposition: EdsFileCreateDisposition;
                                   desiredAccess: EdsAccess;
                               var stream: EdsStreamRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsCreateMemoryStreamFromPointer
//
//  Description:
//      Creates a stream from the memory buffer you prepare. 
//      Unlike the buffer size of streams created by means of EdsCreateMemoryStream, 
//      the buffer size you prepare for streams created this way does not expand.
//
//  Parameters:
//       In:    inUserBuffer - Pointer to the buffer you have prepared.
//                    Streams created by means of this API lead to this buffer. 
//              inBufferSize - The number of bytes of the memory to allocate.
//      Out:    outStream - The reference of the stream.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsCreateMemoryStreamFromPointer(var userBuffer;
                                              bufferSize: EdsUInt64;
                                          var stream: EdsStreamRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetPointer                   
//
//  Description:
//      Gets the pointer to the start address of memory managed by the memory stream. 
//      As the EDSDK automatically resizes the buffer, the memory stream provides 
//          you with the same access methods as for the file stream. 
//      If access is attempted that is excessive with regard to the buffer size
//          for the stream, data before the required buffer size is allocated 
//          is copied internally, and new writing occurs. 
//      Thus, the buffer pointer might be switched on an unknown timing. 
//      Caution in use is therefore advised. 
//
//  Parameters:
//       In:    inStream - Designate the memory stream for the pointer to retrieve. 
//      Out:    outPointer - If successful, returns the pointer to the buffer 
//                  written in the memory stream.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetPointer(stream: EdsStreamRef;
                       var pointer: Pointer): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsRead
//
//  Description:
//      Reads data the size of inReadSize into the outBuffer buffer, 
//          starting at the current read or write position of the stream. 
//      The size of data actually read can be designated in outReadSize.
//
//  Parameters:
//       In:    inStreamRef - The reference of the stream or image.
//              inReadSize -  The number of bytes to read.
//      Out:    outBuffer - Pointer to the user-supplied buffer that is to receive
//                          the data read from the stream. 
//              outReadSize - The actually read number of bytes.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsRead(streamRef: EdsStreamRef;
                     inReadSize: EdsUInt64;
                 var buffer;
                 var outReadSize: EdsUInt64): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsWrite
//
//  Description:
//      Writes data of a designated buffer 
//          to the current read or write position of the stream. 
//
//  Parameters:
//       In:    inStreamRef  - The reference of the stream or image.
//              inWriteSize - The number of bytes to write.
//              inBuffer - A pointer to the user-supplied buffer that contains 
//                         the data to be written to the stream.
//      Out:    outWrittenSize - The actually written-in number of bytes.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsWrite(streamRef: EdsStreamRef;
                      writeSize: EdsUInt64;
                  var buffer;
                  var writtenSize: EdsUInt64): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsSeek
//
//  Description:
//      Moves the read or write position of the stream
            (that is, the file position indicator).
//
//  Parameters:
//       In:    inStreamRef  - The reference of the stream or image. 
//              inSeekOffset - Number of bytes to move the pointer. 
//              inSeekOrigin - Pointer movement mode. Must be one of the following 
//                             values.
//                  kEdsSeek_Cur     Move the stream pointer inSeekOffset bytes 
//                                   from the current position in the stream. 
//                  kEdsSeek_Begin   Move the stream pointer inSeekOffset bytes
//                                   forward from the beginning of the stream. 
//                  kEdsSeek_End     Move the stream pointer inSeekOffset bytes
//                                   from the end of the stream. 
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsSeek(streamRef: EdsStreamRef;
                     seekOffset: EdsInt64;
                     seekOrigin: EdsSeekOrigin): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetPosition
//
//  Description:
//       Gets the current read or write position of the stream
//          (that is, the file position indicator).
//
//  Parameters:
//       In:    inStreamRef - The reference of the stream or image.
//      Out:    outPosition - The current stream pointer.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetPosition(streamRef: EdsStreamRef;
                        var position: EdsUInt64): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetLength
//
//  Description:
//      Gets the stream size.
//
//  Parameters:
//       In:    inStreamRef - The reference of the stream or image.
//      Out:    outLength - The length of the stream.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetLength(streamRef: EdsStreamRef;
                      var length: EdsUInt64): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsCopyData
//
//  Description:
//      Copies data from the copy source stream to the copy destination stream. 
//      The read or write position of the data to copy is determined from 
//          the current file read or write position of the respective stream. 
//      After this API is executed, the read or write positions of the copy source 
//          and copy destination streams are moved an amount corresponding to 
//          inWriteSize in the positive direction. 
//
//  Parameters:
//       In:    inStreamRef - The reference of the stream or image.
//              inWriteSize - The number of bytes to copy.
//      Out:    outStreamRef - The reference of the stream or image.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsCopyData(streamRef: EdsStreamRef;
                         writeSize: EdsUInt64;
                         tStreamRef: EdsStreamRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsSetProgressCallback
//
//  Description:
//      Register a progress callback function. 
//      An event is received as notification of progress during processing that 
//          takes a relatively long time, such as downloading files from a
//          remote camera. 
//      If you register the callback function, the EDSDK calls the callback
//          function during execution or on completion of the following APIs. 
//      This timing can be used in updating on-screen progress bars, for example.
//
//  Parameters:
//       In:    inRef - The reference of the stream or image.
//              inProgressCallback - Pointer to a progress callback function.
//              inProgressOption - The option about progress is specified.
//                              Must be one of the following values.
//                         kEdsProgressOption_Done 
//                             When processing is completed,a callback function
//                             is called only at once.
//                         kEdsProgressOption_Periodically
//                             A callback function is performed periodically.
//              inContext - Application information, passed in the argument 
//                      when the callback function is called. Any information 
//                      required for your program may be added. 
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsSetProgressCallback(ref: EdsBaseRef;
                                    progressCallback: EdsProgressCallback;
                                    progressOption: EdsProgressOption;
                                var context): EdsError; stdcall; external edsdk;



(******************************************************************************
*******************************************************************************
//
//  Image operating functions
//
*******************************************************************************
******************************************************************************/


(*-----------------------------------------------------------------------------
//
//  Function:   EdsCreateImageRef
//
//  Description:
//      Creates an image object from an image file. 
//      Without modification, stream objects cannot be worked with as images. 
//      Thus, when extracting images from image files, 
//          you must use this API to create image objects. 
//      The image object created this way can be used to get image information 
//          (such as the height and width, number of color components, and
//           resolution), thumbnail image data, and the image data itself.
//
//  Parameters:
//       In:    inStreamRef - The reference of the stream.
//
//       Out:    outImageRef - The reference of the image.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsCreateImageRef(streamRef: EdsStreamRef;
                           var imageRef: EdsImageRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetImageInfo
//
//  Description:
//      Gets image information from a designated image object. 
//      Here, image information means the image width and height, 
//          number of color components, resolution, and effective image area.
//
//  Parameters:
//       In:    inStreamRef - Designate the object for which to get image information. 
//              inImageSource - Of the various image data items in the image file,
//                  designate the type of image data representing the 
//                  information you want to get. Designate the image as
//                  defined in Enum EdsImageSource. 
//
//                      kEdsImageSrc_FullView
//                                  The image itself (a full-sized image) 
//                      kEdsImageSrc_Thumbnail
//                                  A thumbnail image 
//                      kEdsImageSrc_Preview
//                                  A preview image
//       Out:    outImageInfo - Stores the image data information designated 
//                      in inImageSource. 
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetImageInfo(imageRef: EdsImageRef;
                             imageSource: EdsImageSource;
                         var imageInfo: EdsImageInfo): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetImage                         
//
//  Description:
//      Gets designated image data from an image file, in the form of a
//          designated rectangle. 
//      Returns uncompressed results for JPEGs and processed results 
//          in the designated pixel order (RGB, Top-down BGR, and so on) for
//           RAW images. 
//      Additionally, by designating the input/output rectangle, 
//          it is possible to get reduced, enlarged, or partial images. 
//      However, because images corresponding to the designated output rectangle 
//          are always returned by the SDK, the SDK does not take the aspect 
//          ratio into account. 
//      To maintain the aspect ratio, you must keep the aspect ratio in mind 
//          when designating the rectangle. 
//
//  Parameters:
//      In:     
//              inImageRef - Designate the image object for which to get 
//                      the image data.
//              inImageSource - Designate the type of image data to get from
//                      the image file (thumbnail, preview, and so on). 
//                      Designate values as defined in Enum EdsImageSource. 
//              inImageType - Designate the output image type. Because
//                      the output format of EdGetImage may only be RGB, only
//                      kEdsTargetImageType_RGB or kEdsTargetImageType_RGB16
//                      can be designated. 
//                      However, image types exceeding the resolution of 
//                      inImageSource cannot be designated. 
//              inSrcRect - Designate the coordinates and size of the rectangle
//                      to be retrieved (processed) from the source image. 
//              inDstSize - Designate the rectangle size for output. 
//
//      Out:    
//              outStreamRef - Designate the memory or file stream for output of
//                      the image.
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetImage(imageRef: EdsImageRef;
                         imageSource: EdsImageSource;
                         imageType: EdsTargetImageType;
                         srcRect: EdsRect;
                         dstSize: EdsSize;
                         tStreamRef: EdsStreamRef): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsCreateEvfImageRef         
//  Description:
//       Creates an object used to get the live view image data set. 
//
//  Parameters:
//      In:     inStreamRef - The stream reference which opened to get EVF JPEG image.
//      Out:    outEvfImageRef - The EVFData reference.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsCreateEvfImageRef(streamRef: EdsStreamRef;
                              var evfImageRef: EdsEvfImageRef): EdsError; stdcall; external edsdk;




(*-----------------------------------------------------------------------------
//
//  Function:   EdsDownloadEvfImage         
//  Description:
//        Downloads the live view image data set for a camera currently in live view mode.
//        Live view can be started by using the property ID:kEdsPropertyID_Evf_OutputDevice and
//        data:EdsOutputDevice_PC to call EdsSetPropertyData.
//        In addition to image data, information such as zoom, focus position, and histogram data
//        is included in the image data set. Image data is saved in a stream maintained by EdsEvfImageRef.
//        EdsGetPropertyData can be used to get information such as the zoom, focus position, etc.
//        Although the information of the zoom and focus position can be obtained from EdsEvfImageRef,
//        settings are applied to EdsCameraRef.
//
//  Parameters:
//      In:     inCameraRef - The Camera reference.
//      In:     inEvfImageRef - The EVFData reference.
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsDownloadEvfImage(cameraRef: EdsCameraRef;
                                 evfImageRef: EdsEvfImageRef): EdsError; stdcall; external edsdk;


    
    
(******************************************************************************
*******************************************************************************
//
//  Event handler registering functions
//
*******************************************************************************
******************************************************************************/


(*-----------------------------------------------------------------------------
//
//  Function:   EdsSetCameraAddedHandler
//
//  Description:
//      Registers a callback function for when a camera is detected.
//
//  Parameters:
//       In:    inCameraAddedHandler - Pointer to a callback function
//                          called when a camera is connected physically
//              inContext - Specifies an application-defined value to be sent to
//                          the callback function pointed to by CallBack parameter.
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsSetCameraAddedHandler(cameraAddedHandler: EdsCameraAddedHandler;
                                  var context): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsSetPropertyEventHandler
//              
//  Description:
//       Registers a callback function for receiving status 
//          change notification events for property states on a camera.
//
//  Parameters:
//       In:    inCameraRef - Designate the camera object. 
//              inEvent - Designate one or all events to be supplemented.
//              inPropertyEventHandler - Designate the pointer to the callback
//                      function for receiving property-related camera events.
//              inContext - Designate application information to be passed by 
//                      means of the callback function. Any data needed for
//                      your application can be passed. 
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsSetPropertyEventHandler(cameraRef: EdsCameraRef;
                                        evnet: EdsPropertyEvent;
                                        propertyEventHandler: EdsPropertyEventHandler;
                                    var context): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:   EdsSetObjectEventHandler
//              
//  Description:
//       Registers a callback function for receiving status 
//          change notification events for objects on a remote camera. 
//      Here, object means volumes representing memory cards, files and directories, 
//          and shot images stored in memory, in particular. 
//
//  Parameters:
//       In:    inCameraRef - Designate the camera object. 
//              inEvent - Designate one or all events to be supplemented.
//                  To designate all events, use kEdsObjectEvent_All. 
//              inObjectEventHandler - Designate the pointer to the callback function
//                  for receiving object-related camera events.
//              inContext - Passes inContext without modification,
//                  as designated as an EdsSetObjectEventHandler argument. 
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsSetObjectEventHandler(cameraRef: EdsCameraRef;
                                      evnet: EdsObjectEvent;
                                      objectEventHandler: EdsObjectEventHandler;
                                  var context): EdsError; stdcall; external edsdk;



(*-----------------------------------------------------------------------------
//
//  Function:  EdsSetCameraStateEventHandler
//              
//  Description:
//      Registers a callback function for receiving status 
//          change notification events for property states on a camera.
//
//  Parameters:
//       In:    inCameraRef - Designate the camera object. 
//              inEvent - Designate one or all events to be supplemented.
//                  To designate all events, use kEdsStateEvent_All. 
//              inStateEventHandler - Designate the pointer to the callback function
//                  for receiving events related to camera object states.
//              inContext - Designate application information to be passed
//                  by means of the callback function. Any data needed for
//                  your application can be passed. 
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsSetCameraStateEventHandler(cameraRef: EdsCameraRef;
                                           evnet: EdsStateEvent;
                                           stateEventHandler: EdsStateEventHandler;
                                       var context): EdsError; stdcall; external edsdk;



(*----------------------------------------------------------------------------*)

function EdsCreateStream(var stream: EdsIStream;
                         var streamRef: EdsStreamRef): EdsError; stdcall; external edsdk;


(*-----------------------------------------------------------------------------
//
//  Function:   EdsGetEvent
//
//  Description:
//      This function acquires an event. 
//      In console application, please call this function regularly to acquire
//      the event from a camera.
//
//  Parameters:
//       In:    None
//      Out:    None
//
//  Returns:    Any of the sdk errors.
-----------------------------------------------------------------------------*)

function EdsGetEvent(): EdsError; stdcall; external edsdk;


implementation




end.
