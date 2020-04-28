unit jpegUtils;

interface

type
    TOrientation    = (po0Degrees, po90Degrees, po180Degrees, po270Degrees);

procedure setOrientation(const FileName: string; angle: TOrientation);

implementation

uses {standard lib:} Classes, SysUtils,
     {simLib: }      NativeJpg;


const
    PictureOrientation: array[TOrientation] of byte = (1, 6, 3, 8);

(****
     {dExif: }       dMetaData;
procedure EXIFsetOrientation(const aFileName: string; angle: TOrientation; const outFileName: string);
var imgData: TImgData;
begin
    with TImgData.Create do
        try
            if ProcessFile(aFileName) and HasExif then
                begin
                ExifObj.TagValue['Orientation'] := pictureOrientation[angle];
                WriteEXIFJPegTo(outFileName);
                end { if };
        finally
            Free;
        end { try };
end;
****)

procedure setOrientation(const FileName: string; angle: TOrientation);
var s:  TStream;
    jpg: TsdJpegGraphic;
begin
    jpg := TsdJpegGraphic.Create;
    try
        s := TFileStream.Create(FileName, fmOpenRead);
        try
            jpg.LoadFromStream(s);
        finally
            FreeAndNil(s);
        end { try };

        case angle of
        po0Degrees:     Exit;
        po90Degrees:    jpg.Image.Lossless.Rotate90;
        po180Degrees:   jpg.Image.Lossless.Rotate180;
        po270Degrees:   jpg.Image.Lossless.Rotate270;
        end { case };

        s := TFileStream.Create(FileName, fmOpenWrite);
        try
            jpg.SaveToStream(s);
        finally
            FreeAndNil(s);
        end { try };        
    finally
        jpg.Free;
    end { try };
end;


end.
