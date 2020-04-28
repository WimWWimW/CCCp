unit histogramFunctions;
//Author: testest http://www.delphibasics.info/home/delphibasicsprojects/imagehistogramcorrectionbytestest
interface

uses Math, Graphics, JPeg;

type
    THistogram = array[Byte] of Cardinal;

function histogram(Bmp: TBitmap): THistogram;           overload;
function histogram(Jpg: TJPEGImage): THistogram;        overload;
function histogram(const fileName: string): THistogram; overload;
procedure smooth(var histogram: THistogram);


implementation

uses SysUtils;

type
    TRGB = array[0..2] of Byte;



function histogram(Bmp: TBitmap): THistogram;
var rgb: ^TRGB;
    temp: array[Byte] of Integer;
    x, y, i, mx: Integer;
begin
    FillChar(temp, 4*256, #0);

    if Bmp.PixelFormat <> pf24bit then
        Bmp.PixelFormat := pf24bit;

    for y := 0 to Bmp.Height - 1 do
        begin
        rgb := Bmp.ScanLine[Y];
        for x := 0 to Bmp.Width - 1 do
            begin
            Inc(temp[(rgb^[0] + rgb^[1] + rgb^[2]) div 3]);
            Inc(rgb)
            end { for x };
        end { for y };

    mx := 0;
    for i := 0 to High(temp) do
        if temp[i] > mx then mx := temp[i];

    for i := 0 to High(Result) do
        Result[i] := Ceil(255 * temp[i] / mx);
end;


function histogram(Jpg: TJPEGImage): THistogram;
var bmp: TBitmap;
begin
    bmp := TBitmap.Create;
    try
        bmp.Assign(Jpg);
        Result := histogram(bmp);
    finally
        bmp.Free;
    end;
end;


function histogram(const fileName: string): THistogram; overload;
var Jpg: TJPEGImage;
var bmp: TBitmap;
begin
    if LowerCase(ExtractFileExt(fileName)) = '.jpg' then
        try
            Jpg := TJPEGImage.Create;
            Jpg.LoadFromFile(fileName);
            Result := histogram(jpg);
        finally
            Jpg.Free;
        end { try }
    else
        try
            bmp := TBitmap.Create;
            bmp.LoadFromFile(fileName);
            Result := histogram(bmp);
        finally
            bmp.Free;
        end { try };
end;


procedure smooth(var histogram: THistogram);
var i, n:  Integer;
    est, prev: Double;
begin
    n     := 0;
    prev  := 0;
    for i := 0 to High(histogram) do
        begin
        if n < 5 then
            inc(n);

        est          := ((n-1) * prev + histogram[i]) / n;
        histogram[i] := Ceil(est);
        prev         := est;
        end { for };
end;

end.

