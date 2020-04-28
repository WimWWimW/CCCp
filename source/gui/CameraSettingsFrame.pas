unit CameraSettingsFrame;
{ -------------------------------------------------------------------
  Unit:     Camera Settings Frame
  Project:  CCCp
  group:    GUI

  Purpose:  Frame to change basic camera settings

  Author:   Wim° de Winter
  Date:     april 2020

  ----- copyright (C) WP. de Winter, Wageningen ---------------------
  ----- Free to use and change; all rights reserved ----------------- }

interface

uses {custom units:} canonCamera, EDSDKType, canonStrings,
     {standard lib:} Windows, SysUtils, Variants, Classes, Controls, Forms,
  Contnrs, Buttons, StdCtrls, ExtCtrls;

type
  TControlClass = class of TControl;

  TStringsFilterProc = procedure (aList: TStrings) of object;
  TComboDescriptor = record
    component:  TCombobox;
    propertyID: EdsPropertyID;
    filterProc: TStringsFilterProc;
    name: string;
    end;

  TfraCameraSettings = class(TFrame)
    Panel3: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label20: TLabel;
    cmbAeMode: TComboBox;
    cmbExpTime: TComboBox;
    cmbAperture: TComboBox;
    cmbISO: TComboBox;
    cmbWhiteBalance: TComboBox;
    cmbDriveMode: TComboBox;
    cmbImgQual: TComboBox;
    chkMirror: TCheckBox;
    procedure comboSettingsChanged(Sender: TObject);
    procedure chkMirrorClick(Sender: TObject);
  private
    FCamera: TCamera;
    FInitialized: Boolean;
    FComboboxes: array of TComboDescriptor;
    procedure FilterItems(Items: TStrings; filter: array of Cardinal);
    procedure filterAEMode(aList: TStrings);
    procedure filterImgQual(aList: TStrings);
    procedure setComboItems(desc: TComboDescriptor);
    procedure setComboToValue(desc: TComboDescriptor);
    function getCombobox(PropertyID: EdsPropertyID): TComboDescriptor;
  public
    constructor Create(anOwner: TComponent); override;
    procedure SetCamera(const Value: TCamera);
    procedure propertyChanged(PropertyID: EdsPropertyID; Param: Cardinal);
    procedure propertyDescChanged(PropertyID: EdsPropertyID; Param: Cardinal);
  end;

implementation

uses Math, Graphics;


{$R *.dfm}

constructor TfraCameraSettings.Create(anOwner: TComponent);
    function describeCombobox(box: TComboBox; propID: EdsPropertyID; Filter: TStringsFilterProc = nil): TComboDescriptor;
    begin
        box.Tag             := propID;
        Result.component    := box;
        Result.propertyID   := propID;
        Result.filterProc   := Filter;
        Result.name         := box.Name;
    end;

begin
    inherited;
    SetLength(FComboboxes, 7);
    FComboboxes[0] := describeCombobox(cmbAeMode,       kEdsPropID_AeMode,      filterAEMode);
    FComboboxes[1] := describeCombobox(cmbExpTime,      kEdsPropID_Tv);
    FComboboxes[2] := describeCombobox(cmbAperture,     kEdsPropID_Av);
    FComboboxes[3] := describeCombobox(cmbISO,          kEdsPropID_ISOSpeed);
    FComboboxes[4] := describeCombobox(cmbWhiteBalance, kEdsPropID_WhiteBalance);
    FComboboxes[5] := describeCombobox(cmbDriveMode,    kEdsPropID_DriveMode);
    FComboboxes[6] := describeCombobox(cmbImgQual,      kEdsPropID_ImageQuality,filterImgQual);
    cmbImgQual.Tag := kEdsPropID_ImageQuality;
    FInitialized   := False;
end;


procedure TfraCameraSettings.SetCamera(const Value: TCamera);
var i:  Integer;
begin
    FCamera := Value;
    for i := 0 to High(FComboboxes) do
        with FComboboxes[i] do
            FCamera.GetAbilities(propertyID, component.Items);
    FInitialized := True;
end;



function TfraCameraSettings.getCombobox(PropertyID: EdsPropertyID): TComboDescriptor;
var i:  Integer;
begin
    Result.component := nil;
    for i := 0 to High(FComboboxes) do
        if FComboboxes[i].propertyID = PropertyID then
            Result := FComboboxes[i];
end;



procedure TfraCameraSettings.comboSettingsChanged(Sender: TObject);
var propertyID:     EdsPropertyID;
    propertValue:   EdsUInt32;
    combox:         TComboBox;
begin
    if not FInitialized then
        Exit;
    combox          := Sender as TCombobox;
    propertyID      := EdsPropertyID(combox.Tag);
    propertValue    := (combox.Items.Objects[combox.ItemIndex] as TCardinal).value;
    FCamera.SetProperty(propertyID, propertValue);
    setComboToValue(getCombobox(combox.Tag));
end;



procedure TfraCameraSettings.setComboItems(desc: TComboDescriptor);
var s:  string;
    i:  Integer;
begin
    if Assigned(desc.component) then
        with desc.component do
            begin
            s := Text;
            FCamera.GetAbilities(desc.propertyID, Items);
            if Assigned(desc.filterProc) then
                desc.filterProc(Items);
            i := Items.IndexOf(s);
            if i < 0 then
                ItemIndex := 0
            else
                Text := s;
            end { if };
end;



procedure TfraCameraSettings.setComboToValue(desc: TComboDescriptor);
var i, index, v:  Integer;
    value: Variant;
    sender: TComboBox;
begin
    sender := desc.component;
    if not Assigned(Sender) then Exit;

    value           := FCamera[sender.Tag];
    Sender.Enabled  := (Sender.Items.Count > 0);
    Sender.Color    := ifThen(Sender.enabled, clWindow, cl3DLight);

    if (varType(value) <> varString) then
        begin
        v := value;
        index := -1;
        with Sender.Items do
            for i := 0 to (Count - 1) do
                if Assigned(Objects[i]) then
                    if (Objects[i] as TCardinal).value = v then
                        begin
                        index := i;
                        break;
                        end;

        if index >= 0 then
            Sender.Text := Sender.Items[index]
        else    // item not in list...
            Sender.Text := translators[desc.propertyID].strValue(v);
        end { if };
end;


procedure TfraCameraSettings.FilterItems(Items: TStrings; filter: array of Cardinal);

    function inFilter(const n: Cardinal): boolean;
    var i:  Integer;
    begin
        result := false;
        for i := 0 to High(filter) do
            if n = filter[i] then Result := True;
    end;

var i:  Integer;
begin
    with Items do
        for i := (Count - 1) downto 0 do
            if not inFilter((Objects[i] as TCardinal).value) then
                Delete(i);
end;



procedure TfraCameraSettings.propertyChanged(PropertyID: EdsPropertyID; Param: Cardinal);
begin
    if PropertyID = kEdsPropID_CFn then
        chkMirror.Checked := FCamera.isMirrorLockupEnabled
    else
        setComboToValue(getCombobox(propertyID));
end;



procedure TfraCameraSettings.propertyDescChanged(PropertyID: EdsPropertyID; Param: Cardinal);
var cmb: TComboDescriptor;
begin
    cmb := getCombobox(propertyID);
    if Assigned(cmb.component) then
        setComboItems(cmb);
end;



procedure TfraCameraSettings.chkMirrorClick(Sender: TObject);
begin
    with (Sender as TCheckBox) do
        begin
        FCamera.SetMirrorLockup(Checked);
        setComboItems(getCombobox(kEdsPropID_DriveMode));
        end { with };
end;



procedure TfraCameraSettings.filterAEMode(aList: TStrings);
begin
    FilterItems(aList, [kEdsAEMode_Program, kEdsAEMode_Tv,
                        kEdsAEMode_Av,      kEdsAEMode_Manual]);

end;



procedure TfraCameraSettings.filterImgQual(aList: TStrings);
begin
    FilterItems(aList, [EdsImageQuality_LR, EdsImageQuality_LJF, EdsImageQuality_SJF]);
end;



end.
