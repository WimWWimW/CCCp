unit presetsFrame;

interface

uses {custom units:} canonCamera,
     {standard lib:} Windows, IniFiles, Classes, Controls, Forms,
                     ActnList, StdCtrls, Mask, AdvSpin, ExtCtrls;

type
  TPreset = record
    count:              Byte;
    step1, step2, step3:Byte;
    latency:            Word;
    end;

  TStackingState = (ssInactive, ssRunning, ssWaiting, ssBusy);

  TfraPresets = class(TFrame)
    cmbPresets: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    ActionList1: TActionList;
    radMode: TRadioGroup;
    edtStepCount: TAdvSpinEdit;
    actRunStop: TAction;
    chkShootLV: TCheckBox;
    Button2: TButton;
    actContinue: TAction;
    TimerFocusRun: TTimer;
    pnlProgress: TPanel;
    TimerPause: TTimer;
    procedure actRunStopUpdate(Sender: TObject);
    procedure loadPreset(Sender: TObject);
    procedure radModeClick(Sender: TObject);
    procedure actRunStopExecute(Sender: TObject);
    procedure TimerFocusRunTimer(Sender: TObject);
    procedure TimerPauseTimer(Sender: TObject);
    procedure actContinueExecute(Sender: TObject);
  private
    FCamera: TCamera;
    FPresets: TIniFile;
    FRunParams,
    FPreset: TPreset;
    FState: TStackingState;
    FWaiting: Boolean;
    procedure ShutterRelease;
    procedure StartRun;
    procedure executeStep;
    function  isRunning: Boolean;
    procedure setRunning(const Value: Boolean);
    procedure setProgress(step: Integer);
    function  getProgress: Integer;
    function isFinite: Boolean;
    procedure SetState(const Value: TStackingState);
    procedure ContinueRun;
  public
    constructor Create(anOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   SetCamera(const Value: TCamera);
    procedure   shotReady(Sender: TObject);
    property Running: Boolean read isRunning;
    property Finite: Boolean read isFinite;
    property Progress: Integer read getProgress  write setProgress;
    property State: TStackingState read FState write SetState;
  end;

implementation

{$R *.dfm}

uses {standard lib:} Math, strUtils, sysUtils,
     {custom units:} EdsdkType;

type TFoo = class(TControl) end;
{ TFrame1 }

constructor TfraPresets.Create(anOwner: TComponent);
begin
    inherited;
    State    := ssInactive;
    FCamera  := nil;

    FPresets := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'presets.ini');
    FPresets.ReadSection('presets', cmbPresets.Items);
end;


destructor TfraPresets.Destroy;
begin
    FPresets.Free;
    inherited;
end;


procedure TfraPresets.SetCamera(const Value: TCamera);
begin
    FCamera := Value;
    cmbPresets.ItemIndex := 0;
    radMode.ItemIndex    := 1;
    loadPreset(cmbPresets);
end;


procedure TfraPresets.actRunStopUpdate(Sender: TObject);
begin
    with (Sender as TAction) do
        begin
        Enabled := Assigned(FCamera) and FCamera.connected;
        Caption := ifThen(Running, 'Stop', 'Start');

        end { with };
end;


function TfraPresets.isRunning: Boolean;
begin
    Result := FState > ssInactive;
end;


procedure TfraPresets.setRunning(const Value: Boolean);
begin
    TimerFocusRun.Enabled := Value;
end;


function TfraPresets.isFinite: Boolean;
begin
    Result := (radMode.ItemIndex > 0)
end;


function TfraPresets.getProgress: Integer;
begin
    Result := pnlProgress.Tag;
end;


procedure TfraPresets.TimerFocusRunTimer(Sender: TObject);
begin
    State := ssWaiting;
end;


procedure TfraPresets.TimerPauseTimer(Sender: TObject);
begin
    if not FWaiting then
        executeStep;
end;


procedure TfraPresets.radModeClick(Sender: TObject);
begin
    edtStepCount.Enabled := Finite;
    FRunParams.count     := ifThen(Finite, edtStepCount.Value, 99);
end;


procedure TfraPresets.loadPreset(Sender: TObject);
var section:  string;
begin
    with cmbPresets do
        section := Items[ItemIndex];

    with FPresets, FPreset do
        begin
        count   := ReadInteger(section, 'count', 10);
        step1   := ReadInteger(section, 'step1', 0);
        step2   := ReadInteger(section, 'step2', 0);
        step3   := ReadInteger(section, 'step3', 0);
        latency := ReadInteger(section, 'latency', 100);

        edtStepCount.Value := count;
        end { with };
end;


procedure TfraPresets.actRunStopExecute(Sender: TObject);
begin
    with (Sender as TAction) do
        begin
        State                   := ssInactive;
        actContinue.Enabled     := not Checked;
        if Checked then
            StartRun;
        end { with };
end;


procedure TfraPresets.actContinueExecute(Sender: TObject);
begin
    if Finite then
        FRunParams.count := FRunParams.count + 10;
    ContinueRun();
end;


procedure TfraPresets.StartRun;
var cycle: Word;
begin
    FRunParams        := FPreset;
    FRunParams.count  := ifThen(Finite, edtStepCount.Value, 99);
    cycle             := Round(FCamera.ShutterTime * 1000) + 2 * FRunParams.latency;

    case FCamera[kEdsPropID_DriveMode] of
    $07, $10:   cycle := cycle + 10000;
    $11:        cycle := cycle + 2000;
    else
        cycle := 1000;
    end { case };

    setProgress(0);
    TimerFocusRun.Interval := cycle;
    ContinueRun;
end;


procedure TfraPresets.ContinueRun();
begin
    State   := ssRunning;
    ShutterRelease;
end;


procedure TfraPresets.executeStep;

    procedure driveLens(Count: Integer; stepSize: EdsEvfDriveLens);
    var i:  Integer;
    begin
        if (Count > 0) then
            for i := 0 to (Count - 1) do
                begin
                FCamera.DriveLens(StepSize);
                sleep(50);
                end { for };
    end;

begin
    State := ssBusy;

    FCamera.inLiveView := True;
    with FRunParams do
        begin
        sleep(latency);
        driveLens(step3, kEdsEvfDriveLens_Far3);
        driveLens(step2, kEdsEvfDriveLens_Far2);
        driveLens(step1, kEdsEvfDriveLens_Far1);
        end { with };

    ShutterRelease;

    if Finite and (Progress >= FRunParams.count) then
        actRunStop.Execute
    else
        State := ssRunning;
end;


procedure TfraPresets.setProgress(step: Integer);
begin
    if step < 0 then
        pnlProgress.Caption := '- / -'
    else if Finite then
        pnlProgress.Caption := Format('%d / %d', [step, FRunParams.Count])
    else
        pnlProgress.Caption := Format('%d / INF', [step]);

    pnlProgress.Tag := step;
end;


procedure TfraPresets.shotReady(Sender: TObject);
begin
    FWaiting := False;
end;


procedure TfraPresets.ShutterRelease;
begin
    if not chkShootLV.Checked then
        FCamera.inLiveView := False;

    sleep(FRunParams.latency);

    FCamera.ShutterRelease;

    Progress := Progress + 1;
    FWaiting := True;
end;


procedure TfraPresets.SetState(const Value: TStackingState);
begin
    FState := Value;
    TimerFocusRun.Enabled   := (FState = ssRunning);
    TimerPause.Enabled      := (FState = ssWaiting);
end;


end.
