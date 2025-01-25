{-----------------------------------------------------------------------------
 Project: Example3

 Copyrigth (C) 2023-2030 Muzio Valerio

 Unit Name: uFormMain
 Author:    muzio
 Date:      25-gen-2025
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

type
  TFormMain = class(TForm)
    TopPanel: TPanel;
    ButtonExit: TButton;
    Button1: TButton;
    mXMLView: TMemo;
    ActionList: TActionList;
    ActionExit: TAction;
    ActionExecute: TAction;
    ActionLoadFile: TAction;
    EditPath: TEdit;
    Button2: TButton;
    OpenDialog: TOpenDialog;
    procedure ActionExecuteExecute(Sender: TObject);
    procedure ActionExitExecute(Sender: TObject);
    procedure ActionLoadFileExecute(Sender: TObject);
  private
    FXMLReader: IXMLReader;
    procedure View(const aXMLReader: IXMLReader);
    procedure DoPrintNode(const aNode: IXMLNode);
    procedure DoPrintAttribute(const aAttribute: IXMLAttribute);
    procedure DoPrintElement(const aElement: IXMLElement);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.ActionExecuteExecute(Sender: TObject);
begin
  if Trim(EditPath.Text) = '' then
    raise Exception.Create('Error EditPath is Empty');

  FXMLReader := TXMLReader.New.LoadFromFile(EditPath.Text);
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

procedure TFormMain.View(const aXMLReader: IXMLReader);
begin
  DoPrintNode(aXMLReader.Node);
end;

end.
