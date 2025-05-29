unit histogramFrame;

interface

uses {custom units:} histogramFunctions,
     {standard lib:} Windows, Messages, SysUtils, ExtCtrls, Classes, Forms,
  Controls, graphics, Dialogs;


type

  TfraHistogram = class(TFrame)
    Image1: TImage;
  private
    Fbmp: TBitmap;
    FCanvas: TCanvas;
    procedure prepare();
  public
    procedure AfterConstruction; override;
    destructor  Destroy; override;

    procedure updateData(histogram: THistogram);
    procedure updateLiveData(histogram: THistogram);
  end;

implementation

{$R *.dfm}

{ TFrame2 }

procedure TfraHistogram.AfterConstruction;
begin
    inherited;
    Prepare;
end;

destructor TfraHistogram.Destroy;
begin
    FBmp.Free;
    inherited;
end;

procedure TfraHistogram.prepare;
begin
    Fbmp := TBitmap.Create;
    Fbmp.Width   := 257;
    Fbmp.Height  := 100;

    FCanvas := Fbmp.Canvas;
    FCanvas.pen.color := clBlack;
    FCanvas.Brush.Style := bsSolid;
    FCanvas.Brush.Color := clWhite;
end;



procedure TfraHistogram.updateLiveData(histogram: THistogram);
begin
    try
        histogramFunctions.smooth(histogram);
        updateData(histogram);
    except on e: Exception do
        MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
end;



procedure TfraHistogram.updateData(histogram: THistogram);
var i, h, x, w5:  Integer;

begin
    h := Fbmp.Height;
    w5:= Fbmp.Width div 5;

    FCanvas.FillRect(Rect(0, 0, 256, h));
    for i := 0 to High(histogram) do
        begin
        FCanvas.MoveTo(i, h);
        FCanvas.LineTo(i, h- Round(h * histogram[i] / 255));
        end { for };

    FCanvas.Pen.Mode := pmNot;
    FCanvas.Pen.Width := 2;
    for i := 1 to 4 do
        begin
        x := i * w5;
        FCanvas.MoveTo(x, h);
        FCanvas.LineTo(x, 0);
        end { for };

    FCanvas.Pen.Width := 1;

    Image1.Picture.Assign(Fbmp);

end;

end.
