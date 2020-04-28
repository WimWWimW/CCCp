unit CanonCamera;
{ -------------------------------------------------------------------
  Unit:     canonCamera
  Project:  CCCp
  group:    camera interface

  Purpose:  TCamera is the ultimate descendant of TCanonBaseCamera
            and is no longer generic, but specially adapted to suit
            the application

  Author:   Wim° de Winter
  Date:     april 2020

  ----- copyright (C) WP. de Winter, Wageningen ---------------------
  ----- Free to use and change; all rights reserved ----------------- }

interface
uses {standard lib:} SysUtils, Graphics, Classes, Windows,
     {Canon API:}    EDSDKType, EDSDKError,
     {custom units:} canonLiveView, canonConnection;



type
    TPropertyEvent  = procedure (inPropertyID, inParam: Cardinal) of object;

    TCamera = class(TLiveViewer)
      private
        FOnPropertiesChanged: TPropertyEvent;
        FOnPropertyDescChanged: TPropertyEvent;
        FfileNameTemplate: string;
      protected
        function makeFileName(const proposedName: string): string; override;
        procedure PropertyEvent(Event: Cardinal; inPropertyID: Cardinal; inParam: Cardinal); override;
      public
        constructor Create(connection: TConnection; WindowHandle: HWND);

        property fileNameTemplate: string read FfileNameTemplate write FfileNameTemplate;
        property onPropertiesChanged:   TPropertyEvent read FOnPropertiesChanged  write FOnPropertiesChanged;
        property onPropertyDescChanged: TPropertyEvent read FOnPropertyDescChanged write FOnPropertyDescChanged;
      end;


implementation

uses {standard lib:} Math
     {custom units:} ;


{ TCamera }



constructor TCamera.Create(connection: TConnection; WindowHandle: HWND);
begin
    inherited;
    FfileNameTemplate := '######';
end;


function TCamera.makeFileName(const proposedName: string): string;
var tpl, nrs, ext:  string;
    i, j:  Integer;
begin
    ext := LowerCase(ExtractFileExt(proposedName));
    tpl := FormatDateTime(FfileNameTemplate, Now());
    for i := 10 downto 2 do
        begin
        nrs := StringOfChar('#', i);
        if pos(nrs, tpl) > 0 then
            begin
            tpl := StringReplace(tpl, nrs, Format('%%.%dd', [i]), []);
            for j := 1 to Round(IntPower(10, i))-1 do
                begin
                Result := self.filePath + Format(tpl, [j]) + ext;
                if not FileExists(Result) then
                    Exit;
                end { for };
            end { if };
        end { for };
    raise Exception.Create('cannot create output file');
end;


procedure TCamera.PropertyEvent(Event, inPropertyID, inParam: Cardinal);
begin
    inherited;
    case Event of
    kEdsPropertyEvent_PropertyChanged:
        if Assigned(FOnPropertiesChanged) then
            FOnPropertiesChanged(inPropertyID, inParam);

    kEdsPropertyEvent_PropertyDescChanged:
        if Assigned(FOnPropertyDescChanged) then
            FOnPropertyDescChanged(inPropertyID, inParam);
    end { case };        
end;




end.
