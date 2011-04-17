unit MainWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ActnList, ComCtrls, ExtCtrls, Menus,
  HotKeyManager, xmldom, Xmlxform, XMLIntf, msxmldom, XMLDoc, ShellAPI;

type
  TForm1 = class(TForm)
    edit_programa: TEdit;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Mostrar1: TMenuItem;
    Ocultar1: TMenuItem;
    Cerrar1: TMenuItem;
    HotKey1: THotKey;
    HotKeyManager1: THotKeyManager;
    XML: TXMLDocument;
    procedure fijarVentana(Sender: TObject);
    procedure mostrarVentana;
    procedure ocultarVentana;
    procedure Mostrar1Click(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure Cerrar1Click(Sender: TObject);
    procedure iniciar(Sender: TObject);
    procedure hotKeyAbrir(HotKey: Cardinal; Index: Word);
    procedure ejecutar(ind: Integer);
    function findInd(nombreApp: String): Integer;
    procedure abrirApp(Sender: TObject; var Key: Char);
  private
    HotKeyIndex1: Word;
    var abierto: Boolean;
    var ArrayProgramas: Array of Array of String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

  function TForm1.findInd(nombreApp: string): Integer;
    var
      i, id: Integer;
    begin
      for i := 0 to length(ArrayProgramas) -1 do
        if ArrayProgramas[i,0] = nombreApp then
          id := i;
      Result := id;
    end;

  procedure TForm1.ejecutar(ind: Integer);
    begin
      ShellExecute(Form1.Handle, 'open', PWideChar(ArrayProgramas[ind,1]),
        nil, nil, SW_SHOWNORMAL)
    end;

  procedure TForm1.abrirApp(Sender: TObject; var Key: Char);
    begin
      if key=#13 then
        ejecutar(findInd(edit_programa.Text));
    end;

  procedure TForm1.Cerrar1Click(Sender: TObject);
    begin
      Application.Terminate;
    end;

  procedure TForm1.fijarVentana(Sender: TObject);
      begin
        Form1.Left := Round(Screen.Width/2 - Form1.Width/2); Form1.Top := 5;
        ShowWindow(application.Handle, SW_HIDE)
      end;

  procedure TForm1.hotKeyAbrir(HotKey: Cardinal; Index: Word);
    begin
      if not abierto
      then mostrarVentana
      else ocultarVentana
    end;

  procedure TForm1.iniciar(Sender: TObject);
    var
      largo, i : Integer;
    begin
      largo := XML.DocumentElement.ChildNodes.Count;
      SetLength(ArrayProgramas, largo, 2);
      for i := 0 to largo-1 do
      begin
          ArrayProgramas[i,0] := XML.DocumentElement.ChildNodes[i].Attributes['nombre'];
          ArrayProgramas[i,1] := XML.DocumentElement.ChildNodes[i].Attributes['ruta'];
      end;
      HotKeyIndex1 := HotKeyManager1.AddHotKey(HotKey1.HotKey);
      abierto := False;
    end;

  procedure TForm1.ocultarVentana;
    begin
      Application.ShowMainForm := False;
      Form1.Visible := False;
      abierto := not abierto;
    end;

  procedure TForm1.Mostrar1Click(Sender: TObject);
    begin
      mostrarVentana;
    end;

  procedure Tform1.mostrarVentana;
      begin
        Application.ShowMainForm := True;
        Application.Restore;
        SetForegroundWindow(Self.Handle);
        Form1.Show;
        Form1.Visible := True;
        abierto := not abierto;
      end;

  procedure TForm1.Ocultar1Click(Sender: TObject);
    begin
      ocultarVentana;
    end;

end.
