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
  public
  end;

  var
  Form2: TForm2;

implementation

uses MainWindow;

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
    end;

  procedure TForm2.formCierra(Sender: TObject; var Action: TCloseAction);
    begin
      CDS.ApplyUpdates(-1);
      MainWindow.Form1.carga;
      Action := caFree;
    end;

end.
