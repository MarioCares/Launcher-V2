object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Opciones Launcher'
  ClientHeight = 495
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  GlassFrame.Enabled = True
  GlassFrame.Left = 5
  GlassFrame.Top = 7
  GlassFrame.Right = 5
  GlassFrame.Bottom = 178
  OldCreateOrder = False
  OnClose = formCierra
  OnCreate = cargaArchivos
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 559
    Height = 305
    Caption = 'Programas'
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 3
      Top = 16
      Width = 553
      Height = 286
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object XMLTP: TXMLTransformProvider
    Left = 528
    Top = 16
  end
  object DS: TDataSource
    Left = 448
    Top = 16
  end
  object CDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 16
  end
end
