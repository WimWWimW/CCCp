unit cameraEvents;

// The SDK uses callback function that are not 'of object'.
// Context is a pointer to the Window-Handle of the form that is to handle the messages.

interface

uses EDSDKType, EDSDKError, Messages;

type pEdsUINT32 = ^EdsUInt32;


const CM_PROPERTY   = WM_USER + 999;
      CM_ABILITY    = WM_USER + 998;
      CM_OBJECT     = WM_USER + 997;
      CM_STATE      = WM_USER + 996;
      CM_PROGRESS   = WM_USER + 995;



function handlePropertyEvent(   Event,
                                PropertyID,
                                Parameter:  EdsUInt32;
                                Context:    pEdsUInt32): EdsError; stdcall;

function handleObjectEvent(     Event:      EdsObjectEvent;
                                Reference:  EdsBaseRef;
                                Context:    pEdsUInt32): EdsError; stdcall;

function handleStateEvent(      Event:      EdsStateEvent;
                                Parameter:  EdsUInt32;
                                Context:    pEdsUInt32): EdsError; stdcall;

function ProgressFunc(          Percent:    EdsUInt32;
                                Context:    pEdsUInt32;
                            var outCancel:  EdsBool):   EdsError; stdcall;

implementation

uses Windows;


function handlePropertyEvent(   Event,
                                PropertyID,
                                Parameter:  EdsUInt32;
                                Context:    pEdsUInt32): EdsError; stdcall;
begin
    case Event of
    kEdsPropertyEvent_PropertyChanged:
        PostMessage(Context^, CM_PROPERTY, PropertyID, Parameter);

    kEdsPropertyEvent_PropertyDescChanged:
        PostMessage(Context^, CM_ABILITY, PropertyID, Parameter);
    end { case };

    Result := EDS_ERR_OK;
end;



function handleObjectEvent(     Event:      EdsObjectEvent;
                                Reference:  EdsBaseRef;
                                Context:    pEdsUInt32): EdsError; stdcall;
begin
    PostMessage(Context^, CM_OBJECT, Event, Integer(Reference));
    Result := EDS_ERR_OK;
end;



function handleStateEvent(      Event:      EdsStateEvent;
                                Parameter:  EdsUInt32;
                                Context:    pEdsUInt32): EdsError; stdcall;
begin
    PostMessage(Context^, CM_STATE, Event, Parameter);
    Result := EDS_ERR_OK;
end;



function ProgressFunc(          Percent:    EdsUInt32;
                                Context:    pEdsUInt32;
                            var outCancel:  EdsBool):   EdsError; stdcall;
begin
    PostMessage(Context^, CM_PROGRESS, Percent, 0);
    Result := EDS_ERR_OK;
end;





end.




