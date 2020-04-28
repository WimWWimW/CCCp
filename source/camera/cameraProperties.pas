unit cameraProperties;

interface

uses {standard lib:} Contnrs, Classes,
     {custom units:} EDSDKType, canonStrings, EDSDKApi;

type
    TOptionSource = (osCamera, osTranslator, osAuto);
    TCameraPropertyStatus = (psUnknown, psOK, psUnavailable, psNotSupported);
    TCameraPropertyStatusSet = set of TCameraPropertyStatus;

    TCameraProperty = class
      private
        FHandle: EdsBaseRef;
        FID: EdsPropertyID;
        FName: string;
        FDataSize: EdsUInt32;
        FDataType: EdsUInt32;
        FStatus: TCameraPropertyStatus;
      protected
        function BufferToVariant(buffer: pointer; size, dType: EdsUInt32): variant; virtual;
      public
        constructor Create(propertyID: EdsPropertyID; propertyName: string);
        function    Initialize(handle: EdsBaseRef): EdsError;
        function    getValue(aHandle: EdsBaseRef = nil): variant;
        procedure   getAbilities(aList: TStrings; optionSource: TOptionSource = osCamera);
        property ID: EdsPropertyID read FID;
        property name: string read FName;
        property dataType: EdsUInt32 read FDataType;
        property dataSize: EdsUInt32 read FDataSize;
        property Handle: EdsBaseRef read FHandle write FHandle;
      end;




    TCameraPropertyProc = procedure(aProperty: TCameraProperty) of object;
    TCameraPropertyProc2 = procedure(aProperty: TCameraProperty);

    TCameraProperties = class(TObjectList)
      private
        FQuickIndex: array[0 .. $81F] of TCameraProperty;
        FDeleting: Boolean;
        function getProperty(index: variant): TCameraProperty;
        function prop(Index: Integer): TCameraProperty;
      protected
        procedure Notify(Ptr: Pointer; Action: TListNotification); override;
      public
        constructor Create;
        destructor  Destroy; override;

        procedure   AutoFill;
        procedure   InitAll(handle: EdsCameraRef);
        procedure   ForEach(callback: TCameraPropertyProc; included: TCameraPropertyStatusSet = [psOK, psUnavailable, psNotSupported]);
        procedure   ForEach2(callback: TCameraPropertyProc2; included: TCameraPropertyStatusSet = [psOK, psUnavailable, psNotSupported]);
        property Items[index: variant]: TCameraProperty read getProperty; default;
      end;



implementation

uses {standard lib:} variants, Types, SysUtils, Math,
     {custom units:} CanonObject, EDSDKError, EDSDKApiEx;




{ TCameraProperty }

constructor TCameraProperty.Create(propertyID: EdsPropertyID;  propertyName: string);
begin
    inherited Create;
    FID             := propertyID;
    FName           := propertyName;
    FHandle   := nil;
end;


function TCameraProperty.Initialize(handle: EdsBaseRef): EdsError;
begin
    FHandle := handle;
    Result := EdsGetPropertySize(handle, self.FID, 0, FDataType, FDataSize);
    case Result of
    EDS_ERR_OK:                     FStatus := psOK;
    EDS_ERR_NOT_SUPPORTED:          FStatus := psNotSupported;
    EDS_ERR_PROPERTIES_UNAVAILABLE: FStatus := psUnavailable;
    else                            FStatus := psNotSupported;
    end { case };
end;


function TCameraProperty.getValue(aHandle: EdsBaseRef): variant;
var buffer: array of byte;
    err:     EdsError;
    data:   ^Cardinal;
const msg: array[TCameraPropertyStatus] of string = ('* unknown *', '', '* not available *', '* not supported *');
begin
    if Assigned(aHandle) then
        self.Handle  := aHandle;
    Result := Null();
    err    := Initialize(Handle);
    if FStatus = psOK then
        begin
        SetLength(buffer, DataSize);
        GetPropertyData(Handle, FID, 0, DataSize, buffer[0]);

        Result := BufferToVariant(@buffer[0], DataSize, ord(DataType))
        end { if }
    else
        raise ECameraError.Create(err);
end;



function TCameraProperty.BufferToVariant(buffer: pointer; size, dType: EdsUInt32): variant;
type     RConversions = record
     case Byte of
     2:     (vPchar:     pChar);
     8:     (vInt32:     EdsInt32);
     9, 14: (vUInt32:    EdsUInt32);
//     21:    (vPoint:     array[0..1] of EdsInt32);
     23:    (vDateTime:  EdsTime);
     33:    (vIntArray:  array[0..$FFFF] of EdsInt32);
     36:    (vUIntArray: array[0..$FFFF] of EdsUInt32);
     102:   (vPicStyle:  EdsPictureStyleDesc);
     end;

var conversions: ^RConversions absolute buffer;
    i:  Integer;
begin
    case dType of
    ord(kEdsDataType_String):   Result  := pChar(buffer) + '';
    ord(kEdsDataType_Int32):    Result := conversions^.vInt32;

    ord(kEdsDataType_UInt32):   Result := conversions^.vUInt32;
//    ord(kEdsDataType_ByteBlock):Result := conversions^.vUInt32;// alleen bij kEdsPropID_LensStatus ...

    ord(kEdsDataType_Point),
    ord(kEdsDataType_Int32_Array):
        begin
        size    := size div 4;
        Result  := VarArrayCreate([0, size-1], varInteger);
        for i := 0 to (size- 1) do Result[i] := conversions^.vIntArray[i];
        end;

    ord(kEdsDataType_ByteBlock),
    ord(kEdsDataType_UInt32_Array):
        begin
        size    := size div 4;
        Result  := VarArrayCreate([0, size-1], varLongWord);
        for i := 0 to (size- 1) do Result[i] := conversions^.vUIntArray[i];
        end;

    ord(kEdsDataType_Time):
        with conversions^.vDateTime do
            Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', EncodeDate(year, month, day) + EncodeTime(hour, minute, second, milliseconds));

    ord(kEdsDataType_PictureStyleDesc):     Result := '* not implemented *';
    else                                    Result := '* error *';
    end { case };
end;



procedure TCameraProperty.getAbilities(aList: TStrings; optionSource: TOptionSource);
var desc: EdsPropertyDesc;
    val: EdsUInt32;
    i:  Integer;
begin
    aList.Clear;
    if optionSource in [osAuto, osCamera] then
        begin
        desc := GetPropertyDesc(self.FHandle, self.ID);

        if desc.numElements > 0 then    // camera successful
            for i := 0 to desc.numElements - 1 do
                begin
                val := desc.propDesc[i];
                with translators[self.ID].getItem(val) do
                    aList.AddObject(strVal, numVal);
                end { for }

        else // camera not successful:
            if optionSource = osAuto then
                // try translator next
                getAbilities(aList, osTranslator);
        end { if }

    else // translator:
        translators[self.ID].getAbilities(aList);
end;

{ TCameraProperties }

constructor TCameraProperties.Create;
var i:  Integer;
begin
    inherited;
    FDeleting := False;
    for i := 0 to High(FQuickIndex) do
        FQuickIndex[i] := nil;
end;


destructor TCameraProperties.Destroy;
begin
    FDeleting := True;
    inherited;
end;


procedure TCameraProperties.AutoFill;
const propnames = {$INCLUDE PropNames.inc}
var i:  Integer;
begin
    self.Clear;
    with TTranslationTable.Create(PROPNAMES) do
        try
            for i := 0 to (Count - 1) do
                with Items[i] do
                    Self.Add(TCameraProperty.Create(numVal.value, strVal));
        finally
            Free;
        end { try };
end;



procedure TCameraProperties.ForEach(callback: TCameraPropertyProc; included: TCameraPropertyStatusSet);
var i:  Integer;
begin
    for i := 0 to (Count - 1) do
            try
                if prop(i).FStatus in included then
                    callback(prop(i));
            except on EAbort do
                break;
            end { try };
end;


procedure TCameraProperties.ForEach2(callback: TCameraPropertyProc2; included: TCameraPropertyStatusSet);
var i:  Integer;
begin
    for i := 0 to (Count - 1) do
            try
                if prop(i).FStatus in included then
                    callback(prop(i));
            except on EAbort do
                break;
            end { try };
end;


function TCameraProperties.getProperty(index: variant): TCameraProperty;
var i, iindex:  Integer;
begin
    Result := nil;
    if varType(index) = varString then
        begin
        for i := 0 to (count-1) do
            if LowerCase(prop(i).name) = LowerCase(index) then
                begin
                Result := prop(i);
                break;
                end { if };
        end { if }
    else
        begin
        iindex  := index;  // implicit conversion
        Result  := FQuickIndex[iindex];
        end;


    if not Assigned(Result) then
        raise ECameraError.Create(EDS_ERR_PROPERTIES_UNAVAILABLE);
end;


procedure TCameraProperties.Notify(Ptr: Pointer; Action: TListNotification);
var item: TCameraProperty absolute Ptr;
begin
    inherited;

    if FDeleting then Exit;

    if inRange(item.ID, 0, high(FQuickIndex)) then
        case Action of
        lnAdded:    FQuickIndex[item.ID] := item;
        lnDeleted:  FQuickIndex[item.ID] := nil;
        end { case };
end;



procedure TCameraProperties.InitAll(handle: EdsCameraRef);
var i:  Integer;
begin
    for i := 0 to (Count - 1) do
        prop(i).Initialize(handle);
end;


function TCameraProperties.prop(Index: Integer): TCameraProperty;
begin
    Result := (inherited Items[Index] as TCameraProperty);
end;



end.
