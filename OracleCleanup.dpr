program OracleCleanup;

uses
  Forms,
  ufrmOracleCleanupMain in 'ufrmOracleCleanupMain.pas' {frmOracleCleanupMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Oracle Uninstall Cleanup';
  Application.CreateForm(TfrmOracleCleanupMain, frmOracleCleanupMain);
  Application.Run;
end.
