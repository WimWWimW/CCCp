unit navigatorFrame;

interface

uses {custom units:} canonShooter,
     {standard lib:} Windows, Controls, Forms, Classes, ExtCtrls;

type
    TPositionEvent = procedure (Left, Top: Integer) of object;

(*    TDragBox = class(TPaintbox)
      private
        FMoving: Boolean;
        FImageInfo: TZoomInfo;
        FScale:     Double;
        FLastPos:   TPoint;
        FOnReposition: TPositionEvent;
      protected
        procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
        procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
        procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
        procedure Paint; override;
      public
        property  onReposition: TPositionEvent read FOnReposition write FOnReposition;
      end;
*)

  TfraNavigator = class(TFrame)
    pnlFull: TPanel;
    pnlZoom: TPanel;
    procedure pnlZoomMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlZoomMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlZoomMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FMoving: Boolean;
    FImageInfo: TZoomInfo;
    FScale:     Double;
    FLastPos:   TPoint;
    FOnReposition: TPositionEvent;
    function getPosition: TPoint;
    procedure setPosition(const Value: TPoint);
    function imageChanged(info: TZoomInfo): Boolean;
  public
    procedure SetSize(FullSize, Zoomed: TPoint);
    procedure UpdatePosition(info: TZoomInfo);
    property  Position: TPoint read getPosition write setPosition;
    property  onReposition: TPositionEvent read FOnReposition write FOnReposition;
  end;

implementation

uses {standard lib:} Math, SysUtils, graphics
     {custom units:} ;

{$R *.dfm}

procedure TfraNavigator.pnlZoomMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    FLastPos    := pnlZoom.ClientToScreen(Point(x, y));
    FMoving     := True;
end;


procedure TfraNavigator.pnlZoomMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var p: TPoint;
begin
    if ssLeft in Shift then
        with pnlZoom do
            begin
            p       := pnlZoom.ClientToScreen(Point(x, y));
            Left    := Max(0, Min(Left + p.X - FLastPos.X, pnlFull.Width - pnlZoom.Width));
            Top     := Max(0, Min(Top  + p.Y - FLastPos.Y, pnlFull.Height - pnlZoom.Height));
            FLastPos:= p;
            end { with };
end;


procedure TfraNavigator.pnlZoomMouseUp(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin
    if Assigned(FOnReposition) then
        FOnReposition(Position.X, Position.Y);
    FMoving := False;
end;


function TfraNavigator.getPosition: TPoint;
begin
    Result.X := Round(FScale * pnlZoom.Left);
    Result.Y := Round(FScale * pnlZoom.Top);
end;


procedure TfraNavigator.setPosition(const Value: TPoint);
begin
    pnlZoom.Left  := Round(Value.X / FScale);
    pnlZoom.Top   := Round(Value.Y / FScale);
end;


procedure TfraNavigator.SetSize(FullSize, Zoomed: TPoint);
var f: Double;
    FFullSize,
    FZoomedSize: TPoint;
begin
    FFullSize   := FullSize;
    FZoomedSize := Zoomed;

    f           := Max(FFullSize.X / ClientWidth,
                       FFullSize.Y / ClientHeight);
    FScale      := f;

    pnlFull.Width := Round(FFullSize.X / f);
    pnlFull.Height:= Round(FFullSize.Y / f);
    pnlZoom.Width := Round(FZoomedSize.X / f);
    pnlZoom.Height:= Round(FZoomedSize.Y / f);
end;



procedure TfraNavigator.UpdatePosition(info: TZoomInfo);
begin
    if imageChanged(info) and not FMoving then
        try
            self.Updating;
            SetSize(TPoint(info.CoordSys), TPoint(info.ZoomRect.size));
            setPosition(TPoint(info.ZoomPos));
            pnlFull.Color       := ifThen(info.Level = 1, clWhite, clGray);
            pnlZoom.Font.Color  := ifThen(info.Level = 1, clRed, clBlack);
            FImageInfo          := info;
        finally
            Self.Updated;
        end;
end;



function TfraNavigator.imageChanged(info: TZoomInfo): Boolean;
var b1, b2: pByteArray;
    i: Integer;
begin
    b1 := @info;
    b2 := @FImageInfo;
    Result := True;
    for i := 0 to (sizeOf(TZoomInfo) - 1) do
        if b1^[i] <> b2^[i] then
            Exit;
    Result := False;
end;

{ TDragBox }
      (*
procedure TDragBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    FLastPos    := self.ClientToScreen(Point(x, y));
    FMoving     := True;
end;



procedure TDragBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var p: TPoint;
begin
    if ssLeft in Shift then
        begin
        p       := Self.ClientToScreen(Point(x, y));
        Left    := Max(0, Min(Left + p.X - FLastPos.X, parent.Width - self.Width));
        Top     := Max(0, Min(Top  + p.Y - FLastPos.Y, parent.Height - Self.Height));
        FLastPos:= p;
        end { with };
end;



procedure TDragBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Assigned(FOnReposition) then
        FOnReposition(Left, Top);
    FMoving := False;
end;



procedure TDragBox.Paint;
begin
    Canvas.Font := Font;
    Canvas.Brush.Color := Color;
    if Assigned(OnPaint) then OnPaint(Self);
end;
    *)
end.
