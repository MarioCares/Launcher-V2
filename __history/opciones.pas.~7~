unit opciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids;

type
  TTheArray = array of array of Integer;
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    procedure formCierra(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

  var
  Form2: TForm2;
  LocalField: TTheArray;

implementation

{$R *.dfm}

  procedure TForm2.formCierra(Sender: TObject; var Action: TCloseAction);
    begin
      Action := caFree;
    end;

end.
