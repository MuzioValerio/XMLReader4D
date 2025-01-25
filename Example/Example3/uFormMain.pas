{-----------------------------------------------------------------------------
 Project: Example2

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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls,
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
    OpenDialog: TOpenDialog;
    ActionList: TActionList;
    ActionExit: TAction;
    ActionExecute: TAction;
    ActionLoadFile: TAction;
    mXMLView: TMemo;
    TopPanel: TPanel;
    ButtonExit: TButton;
    Button1: TButton;
    EditPath: TEdit;
    Button2: TButton;
    Splitter1: TSplitter;
    mXMLSource: TMemo;
    procedure ActionExecuteExecute(Sender: TObject);
    procedure ActionExitExecute(Sender: TObject);
    procedure ActionLoadFileExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FXMLReader: IXMLReader;
    FXMLStream: TStream;
    procedure View(const aXMLReader: IXMLReader);
    procedure DoPrintAttribute(const aAttribute: IXMLAttribute);
    procedure DoPrintElement(const aElement: IXMLElement);
    procedure DoPrintNode(const aNode: IXMLNode);
    procedure ConvertStringToStream;
    procedure LoadFileToXMLSource;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.ActionExecuteExecute(Sender: TObject);
begin
  ConvertStringToStream;

  if FXMLStream.Size = 0 then
    raise Exception.Create('Error Stream is Empty');

  FXMLReader := TXMLReader.New.LoadFromStream(FXMLStream);
  View(FXMLReader);
end;

procedure TFormMain.ActionExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.ActionLoadFileExecute(Sender: TObject);
begin
  EditPath.Clear;
  if OpenDialog.Execute() then
  begin
    if OpenDialog.FileName <> '' then
      EditPath.Text := OpenDialog.FileName;
  end;

  if not Trim(EditPath.text).IsEmpty then
    LoadFileToXMLSource;
end;

procedure TFormMain.ConvertStringToStream;
begin
  FXMLStream := TStringStream.Create;
  mXMLSource.Lines.SaveToStream(FXMLStream);
  FXMLStream.Position := 0;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  mXMLView.Lines.Clear;
  mXMLSource.Lines.Text := XMLTxt;
end;

procedure TFormMain.LoadFileToXMLSource;
begin
  if Trim(EditPath.Text).IsEmpty then
    Exit;

  mXMLSource.Lines.Clear;
  mXMLView.Lines.Clear;
  mXMLSource.Lines.LoadFromFile(EditPath.Text);
end;

procedure TFormMain.View(const aXMLReader: IXMLReader);
begin
  DoPrintNode(aXMLReader.Node);
end;

procedure TFormMain.DoPrintAttribute(const aAttribute: IXMLAttribute);
begin
  mXMLView.Lines.Add(Format('Attribute Name: %s Value: %s', [aAttribute.GetAttributeName, aAttribute.GetAttributeValue]));
end;

procedure TFormMain.DoPrintElement(const aElement: IXMLElement);
begin
  mXMLView.Lines.Add(Format('Leaf Node Name: %s Value: %s', [aElement.GetElementName, aElement.AsString]));
end;

procedure TFormMain.DoPrintNode(const aNode: IXMLNode);
begin
  mXMLView.Lines.Add(Format('Node Name: %s', [aNode.GetNodeName]));

  for var lAttribute in aNode.Attributes do
    DoPrintAttribute(lAttribute);
  for var lElement in aNode.Elements do
    DoPrintElement(lElement);
  for var lNode in aNode.Nodes do
  begin
    DoPrintNode(lNode);
  end;
end;

end.
