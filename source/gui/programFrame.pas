unit programFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ActnList, StdCtrls, Mask, AdvSpin, ExtCtrls;

type
  TFrame1 = class(TFrame)
    cmbPresets: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    ActionList1: TActionList;
    radMode: TRadioGroup;
    edtStepCount: TAdvSpinEdit;
    actRunStop: TAction;
    procedure EnabledIfConnected(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TFrame1.EnabledIfConnected(Sender: TObject);
begin
    (Sender as TAction).Enabled := Assigned(FCamera) and FCamera.connected;
end;

end.
