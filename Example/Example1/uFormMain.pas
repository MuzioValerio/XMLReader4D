{-----------------------------------------------------------------------------
 Project: Example1

 Copyrigth (C) 2025-2030 Muzio Valerio

 Unit Name: uFormMain
 Author:    muzio
 Date:      25-gen-2025

 Info:
 Purpose:
 History:
-----------------------------------------------------------------------------}

unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  XML.Reader,
  XML.Reader.Types;

const
  XMLTxt = '<?xml version="1.0" encoding="UTF8"?>' + sLineBreak +
           '<Developer Rule="Senior Developer">' + sLineBreak +
           ' <FirstName>Muzio</FirstName>' + sLineBreak +
           ' <LastName>Valerio</LastName>' + sLineBreak +
           ' <Age>60</Age>' + sLineBreak +
           ' <Projects>' + sLineBreak +
           '   <Language>Delphi</Language>' + sLineBreak +
           '   <ProjectName>' + sLineBreak +
           '     <XMLWriter Written="True" Tested="in progress"/>' + sLineBreak +
           '     <XMLReader Written="True" Tested="False"/>' + sLineBreak +
           '   </ProjectName>' + sLineBreak +
           ' </Projects>' + sLineBreak +
           '</Developer>';

type
  TFormMain = class(TForm)
    TopPanel: TPanel;
    mXMLSource: TMemo;
    ButtonExecute: TButton;
    ButtonExit: TButton;
    ActionList: TActionList;
    ActionExit: TAction;
    ActionExecute: TAction;
    mXMLView: TMemo;
    Button1: TButton;
    ActionReadVersionEncoding: TAction;
    procedure ActionExecuteExecute(Sender: TObject);
    procedure ActionExitExecute(Sender: TObject);
    procedure ActionReadVersionEncodingExecute(Sender: TObject);
    procedure ActionReadVersionEncodingUpdate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FXMLReader: IXMLReader;
    procedure Read(const aXMLReader: IXMLReader);
  public
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.ActionExecuteExecute(Sender: TObject);
begin
  FXMLReader := TXMLReader.New.LoadFromString(mXMLSource.Lines.Text);
end;

procedure TFormMain.ActionExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.ActionReadVersionEncodingExecute(Sender: TObject);
begin
  Read(FXMLReader);
end;

procedure TFormMain.ActionReadVersionEncodingUpdate(Sender: TObject);
begin
  ActionReadVersionEncoding.Enabled := Assigned(FXMLReader);
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  mXMLView.Lines.Clear;
  mXMLSource.Lines.Text := XMLTxt;
end;

procedure TFormMain.Read(const aXMLReader: IXMLReader);
begin
  mXMLView.Lines.Add(Format('Verione: %s', [aXMLReader.GetVersion]));
  mXMLView.Lines.Add(Format('Encode: %s', [aXMLreader.GetEncoding]));
end;

end.
