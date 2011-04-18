unit opciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBClient, xmldom, Provider, Xmlxform;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    XMLTP: TXMLTransformProvider;
    DS: TDataSource;
    CDS: TClientDataSet;
    procedure formCierra(Sender: TObject; var Action: TCloseAction);
    procedure cargaArchivos(Sender: TObject);
  private
    hDrop: THandle;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  public
  end;

  var
  Form2: TForm2;

implementation

uses MainWindow, ShellAPI;

{$R *.dfm}

procedure TForm2.cargaArchivos(Sender: TObject);
    var ruta: String;
    begin
      ruta := ExtractFilePath(Application.ExeName);
      XMLTP.TransformRead.TransformationFile := ruta+'programasToDp.xtr';
      XMLTP.TransformWrite.TransformationFile := ruta+'programasToXml.xtr';
      XMLTP.XMLDataFile := ruta+'programas.xml';
      CDS.ProviderName := 'XMLTP';
      DS.DataSet := CDS;
      DBGrid1.DataSource := DS;
      CDS.Active := True;
      DragAcceptFiles(handle, true);
    end;

  procedure TForm2.WMDropFiles(var Msg: TWMDropFiles);
    var
      CFileName: array[0..MAX_PATH] of Char;
    begin
      try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
    begin
      DBGrid1.DataSource.DataSet.Insert;
      CDS.Edit;
      CDS.FieldByName('nombre').AsString :=
        ChangeFileExt(ExtractFileName(CFileName), '');
      CDS.FieldByName('ruta').AsString := CFileName;
      CDS.Post;
      Msg.Result := 0;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
    end;

  procedure TForm2.formCierra(Sender: TObject; var Action: TCloseAction);
    begin
      CDS.ApplyUpdates(-1);
      DragFinish(hDrop);
      Form1.carga;
      Action := caFree;
    end;

end.
