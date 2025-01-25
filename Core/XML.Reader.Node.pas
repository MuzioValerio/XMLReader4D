{-----------------------------------------------------------------------------
    XMLReader Lib
    Copyrigth (C) 2023-2030 Muzio Valerio

    Unit Name: XML.Reader.Node
    Author:    muzio
    Date:      13-ott-2023

    Info:
    Purpose:
    History:

-----------------------------------------------------------------------------}

unit XML.Reader.Node;

interface

uses
	System.Classes, System.SysUtils, System.Generics.Collections,
	XML.Reader.Node.Intf,
	XML.Reader.Attribute.Intf,
	XML.Reader.Element.Intf;

type
  TXMLNode = class(TInterfacedObject, IXMLNode)
  private
    FNodeName: string;
    FAttributes: TList<IXMLAttribute>;
    FNodes: TList<IXMLNode>;
    FElements: TList<IXMLElement>;
    function GetAttribute(const aAttributeName: string): IXMLAttribute;
    function GetNode(const aNodeName: string): IXMLNode;
    function GetElement(const aElementName: string): IXMLElement;
    function Attributes: TList<IXMLAttribute>;
    function Nodes: TList<IXMLNode>;
    function Elements: TList<IXMLElement>;
    function ContainsAttribute(const aAttributeName: string): Boolean;
    function ContainsNode(const aNodeName: string): Boolean;
    function ContainsElement(const aElementName: string): Boolean;
    function GetNodeName: string;
    function SetNodeName(const aNodeName: string): IXMLNode;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IXMLNode;
  end;

implementation

{ TXMLNode }

uses 
	XML.Reader.Element, 
	XML.Reader.Attribute;

constructor TXMLNode.Create;
begin
  inherited Create;
	FAttributes := TList<IXMLAttribute>.Create;
  FNodes := TList<IXMLNode>.Create;
  FElements := TList<IXMLElement>.Create;
end;

destructor TXMLNode.Destroy;
begin
  if Assigned(FAttributes) then
    FreeAndNil(FAttributes);
  if Assigned(FNodes) then
    FreeAndNil(FNodes);
  if Assigned(FElements) then
    FreeAndNil(FElements);
  inherited Destroy;
end;

class function TXMLNode.New: IXMLNode;
begin
  Result := TXMLNode.Create;
end;

function TXMLNode.GetNodeName: string;
begin
  Result := FNodeName;
end;

function TXMLNode.SetNodeName(const aNodeName: string): IXMLNode;
begin
  FNodeName := aNodeName;
  Result := Self;
end;

function TXMLNode.Attributes: TList<IXMLAttribute>;
begin
  Result := FAttributes;
end;

function TXMLNode.Elements: TList<IXMLElement>;
begin
  Result := FElements;
end;

function TXMLNode.Nodes: TList<IXMLNode>;
begin
  Result := FNodes;
end;

function TXMLNode.ContainsNode(const aNodeName: string): Boolean;
begin
  Result := False;
  for var lNode in FNodes do
  begin
    Result := lNode.GetNodeName = aNodeName;
    if Result then
      Break;
  end;
end;

function TXMLNode.ContainsAttribute(const aAttributeName: string): Boolean;
begin
  Result := False;
  for var lAttribute in FAttributes do
  begin
    Result := lAttribute.GetAttributeName = aAttributeName;
    if Result then
      Break;
  end;
end;

function TXMLNode.ContainsElement(const aElementName: string): Boolean;
begin
  Result := False;
  for var lElement in FElements do
  begin
    Result := lElement.GetElementName = aElementName;
    if Result then
      Break;
  end;
end;

function TXMLNode.GetNode(const aNodeName: string): IXMLNode;
begin
  for var lNode in FNodes do
  begin
    if lNode.GetNodeName = aNodeName then
    begin
      Result := lNode;
      Break;
    end;
  end;
  if Result = nil then
    Result := TXMLNode.New;
end;

function TXMLNode.GetAttribute(const aAttributeName: string): IXMLAttribute;
begin
  for var lAttribute in FAttributes do
  begin
    if lAttribute.GetAttributeName = aAttributeName then
    begin
      Result := lAttribute;
      Break;
    end;
  end;
  if Result = nil then
    Result := TXMLAttribute.New;
end;

function TXMLNode.GetElement(const aElementName: string): IXMLElement;
begin
  for var lElement in FElements do
  begin
    if lElement.GetElementName = aElementName then
    begin
      Result := lElement;
      Break;
    end;
  end;
  if Result = nil then
    Result := TXMLElement.New;
end;

end.
