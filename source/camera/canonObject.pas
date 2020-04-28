unit canonObject;

interface

uses {standard lib:} Classes, Sysutils,
     {Canon API:}    EDSDKType, EDSDKError;


type
    ECameraError = class(Exception)
      private
      public
        Error: EdsError;
        constructor Create(ErrorNumber: EdsError);
      end;


    TCanonObject = class
      private
        FLastError: EdsError;
        procedure setLastError(ErrorNr: EdsError; raiseException: Boolean);
      protected
        function  NoError: Boolean;
        function  HasError: Boolean;
        procedure raiseError(ErrorNr: EdsError);
        procedure dontRaiseError(ErrorNr: EdsError);
      public
        constructor Create;
        property LastError: EdsError read FLastError write dontRaiseError;
      end;



implementation

uses StrUtils, canonStrings;

{ ECameraError }

constructor ECameraError.Create(ErrorNumber: EdsError);
begin
    Self.Error := ErrorNumber;
    inherited Create(translators.cameraErrors.strValue(ErrorNumber));
end;



constructor TCanonObject.Create;
begin
    Self.LastError  := EDS_ERR_OK;
end;


procedure TCanonObject.setLastError(ErrorNr: EdsError; raiseException: Boolean);
begin
    FLastError := ErrorNr;
    if raiseException and not NoError then
        raise ECameraError.Create(FLastError);
end;


function TCanonObject.NoError: Boolean;
begin
    Result := (FLastError = EDS_ERR_OK);
end;


procedure TCanonObject.dontRaiseError(ErrorNr: EdsError);
begin
    setLastError(ErrorNr, False);
end;


procedure TCanonObject.raiseError(ErrorNr: EdsError);
begin
    setLastError(ErrorNr, True);
end;



function TCanonObject.HasError: Boolean;
begin
    Result := not NoError;
end;

end.
