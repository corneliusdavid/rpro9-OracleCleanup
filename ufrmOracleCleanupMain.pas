unit ufrmOracleCleanupMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmOracleCleanupMain = class(TForm)
    btnStep1: TButton;
    Label1: TLabel;
    lbLog: TListBox;
    btnStep2: TButton;
    btnStep3: TButton;
    procedure btnStep1Click(Sender: TObject);
    procedure btnStep2Click(Sender: TObject);
    procedure btnStep3Click(Sender: TObject);
  private
    procedure Log(const LogMsg: string);
    procedure DeleteSoftwareOracleKey;
    procedure DeleteSystemCtrlSetOracleKeys;
    procedure DeleteOracleFolders;
    procedure DeleteNamedFolder(folder: string);
  end;

var
  frmOracleCleanupMain: TfrmOracleCleanupMain;


implementation

uses
  Registry, StrUtils, IOUtils;

{$R *.dfm}

procedure TfrmOracleCleanupMain.btnStep1Click(Sender: TObject);
begin
  DeleteSoftwareOracleKey;
  DeleteSystemCtrlSetOracleKeys;
end;

procedure TfrmOracleCleanupMain.Log(const LogMsg: string);
begin
  lbLog.Items.Add(LogMsg);
  lbLog.ItemIndex := lbLog.Items.Count;
end;

procedure TfrmOracleCleanupMain.btnStep2Click(Sender: TObject);
begin
  MessageBox(Handle, PChar('Close this program and reboot the computer.  Restart this program when you''ve logged back in.'),
                     PChar(Application.Title), MB_OK + MB_ICONINFORMATION + MB_TASKMODAL);
end;

procedure TfrmOracleCleanupMain.btnStep3Click(Sender: TObject);
begin
  DeleteOracleFolders;
end;

procedure TfrmOracleCleanupMain.DeleteSoftwareOracleKey;
const
  key_name = 'HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE';
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  try
    reg.OpenKey('SOFTWARE', False);
    if MessageBox(Handle, PChar('Delete the ' + key_name + ' registry key?'), PChar(Application.Title),
              MB_YESNO + MB_ICONQUESTION + MB_TASKMODAL) = ID_YES then begin
      reg.DeleteKey('Oracle');
      Log('Deleted the registry key: ' + key_name);
    end;
    reg.CloseKey;
  except
    Log(key_name + '  key was not found in the registry.');
  end;
end;

procedure TfrmOracleCleanupMain.DeleteSystemCtrlSetOracleKeys;
const
  key_name = 'SYSTEM\CurrentControlSet\Services';
var
  reg: TRegistry;
  key: string;
  keys_found: TStringList;
  keys_delete: TStringList;
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  try
    keys_found := TStringList.Create;
    keys_delete := TStringList.Create;
    try
      reg.OpenKey(key_name, False);

      reg.GetKeyNames(keys_found);
      for key in keys_found do
        if SameText(LeftStr(Key, 3), 'Ora') then
          keys_delete.Add(key);

      if keys_delete.Count > 0 then begin
        if MessageBox(Handle, PChar('Delete the following keys?'+#10#13 + keys_delete.GetText),
           PChar(Application.Title), MB_YESNO + MB_ICONQUESTION + MB_TASKMODAL) = ID_YES then
          for key in keys_delete do begin
            reg.DeleteKey(key_name + '\' + key);
            Log('Deleted HKEY_LOCAL_MACHINE\' + key_name + '\' + key);
          end;
      end else
        Log('There were no Oracle keys found under HKEY_LOCAL_MACHINE\' + key_name);
    finally
      keys_found.Free;
      keys_delete.Free;
    end;

    reg.CloseKey;
    Log('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ora* keys were not found in the registry.');
  except
    Log('Could not open the key: ' + key_name);
  end;
end;

procedure TfrmOracleCleanupMain.DeleteOracleFolders;
var
  folder: string;
begin
  if MessageBox(Handle, PChar('Delete Oracle folders under Program Files?'), PChar(Application.Title),
                       MB_YESNO + MB_ICONQUESTION + MB_TASKMODAL) = ID_YES then

  folder := IncludeTrailingPathDelimiter(GetEnvironmentVariable('ProgramFiles')) + 'Oracle';
  DeleteNamedFolder(folder);

  if Length(GetEnvironmentVariable('ProgramW6432')) > 0 then begin
    folder := IncludeTrailingPathDelimiter(GetEnvironmentVariable('ProgramW6432')) + 'Oracle';
    DeleteNamedFolder(folder);
  end;
end;

procedure TfrmOracleCleanupMain.DeleteNamedFolder(folder: string);
begin
  if TDirectory.Exists(folder) then
  begin
    TDirectory.Delete(folder);
    Log('Deleted ' + folder);
  end
  else
    Log(folder + ' not found.');
end;

end.
