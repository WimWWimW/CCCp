unit canonStrings;

interface

uses
  EDSDKType, contnrs, iniFiles,
Forms, classes,TypInfo, SysUtils;


type
    TCardinal = class(TObject)
      public
        value: Cardinal;
        constructor create(aValue: Cardinal);
      end;

    TTranslationItem = record
        strVal: string;
        numVal: TCardinal;
        end;

    TTranslationTable = class(TStringList)
      private
        FPropertyID: EdsPropertyID;
        FDefault: string;
        FObjects: TObjectList;
        procedure Load(const table: string); virtual;
        function  DefaultStr(aNumValue: Cardinal): string;
        procedure LoadFromStrings(const table: TStrings);
        function  getItems(index: Integer): TTranslationItem;
      protected
        procedure construct(propertyID: EdsPropertyID);
      public
        constructor Create(const table: string; propertyID: EdsPropertyID = 0); overload;
        constructor Create(table: TStrings; propertyID: EdsPropertyID = 0); overload;
        destructor  Destroy; override;

        procedure   GetAbilities(List: TStrings);
        function    indexOfObjectValue(objectValue: Cardinal): Integer;
        function    strValue(aNumValue: Cardinal): string; virtual;
        function    numValue(aStrValue: string): Cardinal; virtual;
        function    getItem(aNumValue: Cardinal): TTranslationItem;
        procedure   addTranslation(aNumValue: Cardinal; const strValue: string);
        property defaultTranslation: string read FDefault write FDefault;
        property Items[index: Integer]: TTranslationItem read getItems;
      end;



    TTranslators = class
      private
        FItems: TObjectList;
        FBasicIni: TIniFile;
        FStringsIni: TIniFile;
        FErrors: TTranslationTable;
        function Add(propertyID: EdsPropertyID; const table: string): TTranslationTable; overload;
        function Get(propertyID: EdsPropertyID): TTranslationTable;
      public
        constructor Create;
        destructor  Destroy; override;
        function    Add(table: TTranslationTable): TTranslationTable; overload;
        function    Add(const Section: string; propertyID: EdsPropertyID = 0): TTranslationTable; overload;
        property table[propertyID: EdsPropertyID]: TTranslationTable read get; default;
        property CameraErrors: TTranslationTable read FErrors;
      end;


var translators:  TTranslators;
    //cameraErrors: TTranslationTable;

implementation

uses EDSDKError;


{ TCardinal }

constructor TCardinal.create(aValue: Cardinal);
begin
    value := aValue;
end;



{ TTranslationTable }

constructor TTranslationTable.Create(const table: string; propertyID: EdsPropertyID);
begin
    inherited Create();
    construct(propertyID);
    Load(table);
end;


constructor TTranslationTable.Create(table: TStrings; propertyID: EdsPropertyID);
begin
    inherited Create();
    construct(propertyID);
    LoadFromStrings(table);
end;



procedure TTranslationTable.construct(propertyID: EdsPropertyID);
begin
    FPropertyID := propertyID;
    FDefault    := 'unknown';
    FObjects    := TObjectList.Create(True);
end;



destructor TTranslationTable.Destroy;
begin
    FObjects.Free;
    inherited;
end;


function TTranslationTable.DefaultStr(aNumValue: Cardinal): string;
begin
    if Pos('%', FDefault) < 0 then
        Result := FDefault
    else
        Result := Format(FDefault, [aNumValue]);
end;


procedure TTranslationTable.GetAbilities(List: TStrings);
begin
    List.Assign(self);
end;


procedure TTranslationTable.Load(const table: string);
var i:  Integer;
    v:  TCardinal;
begin
    Clear;
    Text := StringReplace(table, ';', #13, [rfReplaceAll]);
    for i := (Count - 1) downto 0 do
        if Trim(Strings[i]) = '' then
            Delete(i);

    for i := 0 to (Count - 1) do
        begin
        v          := TCardinal.create(StrToInt(Trim(names[i])));
        FObjects.Add(v); // take ownership
        Objects[i] := v;
        strings[i] := Trim(values[names[i]]);
        end { for };
end;



procedure TTranslationTable.LoadFromStrings(const table: TStrings);
var i:  Integer;
    v:  TCardinal;
begin
    Self.Assign(table);

    for i := 0 to (Count - 1) do
        begin
        v          := TCardinal.create(StrToInt(Trim(names[i])));
        FObjects.Add(v); // take ownership
        Objects[i] := v;
        strings[i] := Trim(values[names[i]]);
        end { for };
end;



function TTranslationTable.numValue(aStrValue: string): Cardinal;
var i:  Integer;
begin
    i := IndexOf(aStrValue);
    if i >= 0 then
        result := (Objects[i] as TCardinal).value
    else
        result := $FFFFFFFF;
end;


function TTranslationTable.strValue(aNumValue: Cardinal): string;
var i:  Integer;
begin
     i := indexOfObjectValue(aNumValue);
     if i >= 0 then
        Result := Strings[i]
     else
        Result := DefaultStr(i)
end;



function TTranslationTable.indexOfObjectValue(objectValue: Cardinal): Integer;
begin
    for Result := 0 to (Count - 1) do
        if (Objects[Result] as TCardinal).value = objectValue then
            Exit;
    Result := -1;
end;


function TTranslationTable.getItems(index: Integer): TTranslationItem;
begin
    Result.numVal := nil;
    if index >= 0 then
        begin
        Result.strVal := Strings[index];
        Result.numVal := Objects[index] as TCardinal;
        end { if };
end;



function TTranslationTable.getItem(aNumValue: Cardinal): TTranslationItem;
begin
    Result := getItems(indexOfObjectValue(aNumValue));
end;



procedure TTranslationTable.addTranslation(aNumValue: Cardinal; const strValue: string);
var v: TCardinal;
begin
    v := TCardinal.create(aNumValue);
    FObjects.Add(v); // take ownership
    self.AddObject(strValue, v)
end;



{ TTranslators }

function TTranslators.Add(propertyID: EdsPropertyID; const table: string): TTranslationTable;
begin
    Result := Self.Add(TTranslationTable.Create(table, propertyID));
end;



function TTranslators.Add(table: TTranslationTable): TTranslationTable;
begin
    FItems.Add(table);
    Result := table;
end;



function TTranslators.Add(const Section: string; propertyID: EdsPropertyID): TTranslationTable;
var i:          Integer;
    strings:    TStringList;
    ini:        TIniFile;
begin
    if FBasicIni.SectionExists(Section) then
        ini := FBasicIni
    else
        ini := FStringsIni;

    if propertyID = 0 then
        propertyID := ini.ReadInteger(Section, 'propertyID', 0);

    strings := TStringlist.Create;
    try
        ini.ReadSectionValues(Section, strings);
        i := strings.IndexOfName('propertyID');
        if i >= 0 then
            strings.Delete(i);
        Result := self.Add(TTranslationTable.Create(strings, propertyID));
    finally
        strings.Free;
    end { try };

end;



constructor TTranslators.Create;
    function iniFile(const fileName: string): TIniFile;
    var fn: string;
    begin
        fn := ExtractFilePath(Application.ExeName) + fileName;
        if not FileExists(fn) then
            raise Exception.Create(Format('"%s" not found', [fn]));
        Result := TIniFile.Create(fn);
    end;

begin
    FItems      := TObjectList.Create(True);
    FStringsIni := IniFile('EDSDKStrings.ini');
    FBasicIni   := IniFile('basicSettings.ini');
    FErrors     := Add('ErrorMessages');
end;



destructor TTranslators.Destroy;
begin
    FItems.Free;
    FBasicIni.Free;
    FStringsIni.Free;
    inherited;
end;



function TTranslators.Get(propertyID: EdsPropertyID): TTranslationTable;
var i:  Integer;
begin
    with FItems do
        for i := 0 to (Count - 1) do
            if TTranslationTable(Items[i]).FPropertyID = propertyID then
                begin
                Result := TTranslationTable(Items[i]);
                Exit;
                end;
    raise Exception.Create(Format('no translation table fr propertyID %x', [propertyID]))
end;



initialization
    translators := TTranslators.Create;
    translators.Add('ImageQuality');
    translators.Add('AEMode');
    translators.Add('WhiteBalance');
//  translators.Add('SaveTo');
    translators.Add('Tv');
    translators.Add('Av');
    translators.Add('ISO');
    translators.Add('DriveMode');




finalization
    translators.Free;

end.
