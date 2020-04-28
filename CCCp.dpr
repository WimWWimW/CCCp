program CCCp;


uses
  Forms,
  Main in 'source\gui\Main.pas' {frmCamera},
  EDSDKApi in 'EDSDK\3.2.20.2\pas\EDSDKApi.pas',
  EDSDKapiEx in 'EDSDK\3.2.20.2\pas\EDSDKapiEx.pas',
  EDSDKError in 'EDSDK\3.2.20.2\pas\EDSDKError.pas',
  EDSDKType in 'EDSDK\3.2.20.2\pas\EDSDKtype.pas',
  canonStrings in 'source\camera\canonStrings.pas',
  cameraEvents in 'source\camera\cameraEvents.pas',
  cameraProperties in 'source\camera\cameraProperties.pas',
  CanonBase in 'source\camera\CanonBase.pas',
  CanonCamera in 'source\camera\CanonCamera.pas',
  canonConnection in 'source\camera\canonConnection.pas',
  canonLiveView in 'source\camera\canonLiveView.pas',
  canonObject in 'source\camera\canonObject.pas',
  canonShooter in 'source\camera\canonShooter.pas',
  CameraSettingsFrame in 'source\gui\CameraSettingsFrame.pas' {fraCameraSettings: TFrame},
  cameraStateframe in 'source\gui\cameraStateframe.pas' {fraCameraState: TFrame},
  navigatorFrame in 'source\gui\navigatorFrame.pas' {fraNavigator: TFrame},
  photoFrame in 'source\gui\photoFrame.pas' {fraPhoto: TFrame},
  presetsFrame in 'source\gui\presetsFrame.pas' {fraPresets: TFrame},
  jpegUtils in 'source\other\jpegUtils.pas',
  histogramFrame in 'other projects\histogram\histogramFrame.pas' {fraHistogram: TFrame},
  histogramFunctions in 'source\other\histogramFunctions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCamera, frmCamera);
  Application.Run;
end.
