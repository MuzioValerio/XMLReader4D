{-----------------------------------------------------------------------------
    XMLReader Lib
    Copyrigth (C) 2023-2030 Muzio Valerio

    Unit Name: XML.Reader
    Author:    muzio
    Date:      13-ott-2023

    Info:
    Purpose:
    History:

-----------------------------------------------------------------------------}

unit XML.Reader;

interface

uses 
	System.Classes, System.SysUtils, System.Generics.Collections,
  XML.Reader.Types;

type
  TXMLReader = class(TInterfacedObject, IXMLReader)
  strict private
    function SanitizeXML(const aXML: string): string;
  private
    FVersion: string;
    FEncoding: string;
    FNode: IXMLNode;
    function Node: IXMLNode;
    procedure ReadXMLInfo(const aXMLRow: string);
    procedure ParseNode(const aNode: IXMLNode; const aXMLRow: string);
    procedure ParseXML(const aXML: TStringList);
    function ExtractNameTo(const aXMLRow: string): string;
    function GetAttributes(const aXMLRow: string): TDictionary<string, string>;

    function LoadFromStream(const aStream: TStream): IXMLReader;
		function LoadFromString(const aXML: string): IXMLReader;
    function LoadFromFile(const aPath: string): IXMLReader;
    function GetVersion: string;
    function GetEncoding: string;
  public
    constructor Create;
    class function New: IXMLReader;
  end;

implementation

uses
  System.IOUtils,
  XML.Reader.Attribute,
	XML.Reader.Element,
	XML.Reader.Node;

{ TXMLReader }

constructor TXMLReader.Create;
begin
  FNode := TXMLNode.New;
end;

class function TXMLReader.New: IXMLReader;
begin
  Result := TXMLReader.Create;
end;

function TXMLReader.GetEncoding: string;
begin
  Result := FEncoding;
end;

function TXMLReader.GetVersion: string;
begin
  Result := FVersion;
end;

function TXMLReader.LoadFromFile(const aPath: string): IXMLReader;
begin
  if not TFile.Exists(aPath) then
		raise Exception.Create('il file non esiste');

	var lXML := TStringList.Create;
  try
    lXML.LoadFromFile(aPath);
    Result := LoadFromString(lXML.Text);
  finally
    lXML.Free;
  end;
end;

function TXMLReader.LoadFromStream(const aStream: TStream): IXMLReader;
begin
  var lStringStream := TStringStream.Create;
  aStream.Position := 0;
  try
    lStringStream.CopyFrom(aStream);
    Result := LoadFromString(lStringStream.DataString);
  finally
    FreeAndNil(lStringStream);
  end;
end;

function TXMLReader.LoadFromString(const aXML: string): IXMLReader;
begin
  var lXML := TStringList.Create;
  var lCleanXML := SanitizeXML(aXML);
  var lLine := string.Empty;
  var lTrimmedLine := string.Empty;
  try
    for var I: Int64 := 1 to lCleanXML.Length do
    begin
      lLine := lLine + lCleanXML[I];
      lTrimmedLine := lLine.Trim;
      if lTrimmedLine.StartsWith('<') and lTrimmedLine.EndsWith('>') then
      begin
        lXML.Add(lTrimmedLine);
        lLine := string.Empty;
      end
      else if lTrimmedLine.EndsWith('<') and (lTrimmedLine.Length > 1) then
      begin
        lXML.Add(lTrimmedLine.Replace('<', string.Empty));
        lLine := '<';
      end;
    end;
    ParseXML(lXML);
  finally
    lXML.Free;
  end;
  Result := Self;
end;

function TXMLReader.Node: IXMLNode;
begin
  Result := FNode;
end;

{$REGION 'XML Parser'}

procedure TXMLReader.ParseXML(const aXML: TStringList);
var
  lLastNode: IXMLNode;
  lLastElement: IXMLElement;
	lLine: string;
begin
  for var I := 0 to Pred(aXML.Count) do
  begin
    lLine := aXML[I];
		
		if lLine.StartsWith('</') then
      Continue;
			
    if lLine.StartsWith('<?') then
      ReadXMLInfo(lLine)
    else if lLine.EndsWith('/>') then
    begin
      lLastElement := TXMLElement.New.SetElementName(ExtractNameTo(lLine));
      lLastNode.Elements.Add(lLastElement);
    end
    else if lLine.StartsWith('<') and lLine.EndsWith('>') then
    begin
      if aXML[Succ(I)].StartsWith('<') then
      begin
        if FNode.GetNodeName.Trim.IsEmpty then
          lLastNode := FNode
        else
        begin
          lLastNode.Nodes.Add(TXMLNode.New);
          lLastNode := lLastNode.Nodes.Last;
        end;
        ParseNode(lLastNode, lLine);
      end
      else
      begin
        lLastElement := TXMLElement.New.SetElementName(ExtractNameTo(lLine));
        lLastNode.Elements.Add(lLastElement);
      end;
    end
    else
      lLastElement.SetElementValue(lLine);
  end;
end;

procedure TXMLReader.ParseNode(const aNode: IXMLNode; const aXMLRow: string);
var
  lAttribute: TPair<string, string>;
  lAttributes: TDictionary<string, string>;
begin
  lAttributes := GetAttributes(aXMLRow);
  try
    aNode.SetNodeName(ExtractNameTo(aXMLRow));
    for lAttribute in lAttributes do
      aNode.Attributes.Add(TXMLAttribute.New.SetAttributeName(lAttribute.Key).SetAttributeValue(lAttribute.Value));
  finally
    lAttributes.Free;
  end;
end;

procedure TXMLReader.ReadXMLInfo(const aXMLRow: string);
var
  lAttribute: TPair<string, string>;
  lAttributes: TDictionary<string, string>;
begin
  lAttributes := GetAttributes(aXMLRow);
  try
    for lAttribute in lAttributes do
    begin
      if lAttribute.Key.ToLower.Equals('version') then
        FVersion := lAttribute.Value
      else if lAttribute.Key.ToLower.Equals('encoding') then
        FEncoding := lAttribute.Value;
    end;
  finally
    lAttributes.Free;
  end;
end;

function TXMLReader.GetAttributes(const aXMLRow: string): TDictionary<string, string>;
var
  lKey: string;
	lValue: string;
  lReadedValue: Boolean;
	lActualChar: string;
begin
	var lLineInWork := aXMLRow;
  lReadedValue := False;
  Result := TDictionary<string, string>.Create();
	lActualChar := '';
	
	for var I := 1 to lLineInWork.Length do
  begin
		lActualChar := lLineInWork[I];

    if lReadedValue then
    begin
      if lActualChar = '"' then
      begin
        if lValue.IsEmpty then
          Continue;
					
        Result.Add(lKey, lValue);
        lReadedValue := False;
        lValue := string.Empty;
        lKey := string.Empty;
        Continue;
      end;
      lValue := lValue + lActualChar;
      Continue;
    end;
		
    lReadedValue := lActualChar = '=';
    if lReadedValue then
      Continue;
   
		if lActualChar = ' ' then
      lKey := string.Empty
		else
      lKey := lKey + lActualChar;
  end;
end;

function TXMLReader.ExtractNameTo(const aXMLRow: string): string;
begin
  Result := string.Empty;
	var lLineInWork := aXMLRow;
	
  for var I := 1 to lLineInWork.Length do
  begin
    if (lLineInWork[I] = '<') or (lLineInWork[I] = '>') then
      Continue;
			
    if (lLineInWork[I] = '/') and (lLineInWork[Pred(I)] = '<') then
      Continue;
			
    if (lLineInWork[I] = ' ') and (not Result.Trim.IsEmpty) then
      Break;
			
    Result := Result + lLineInWork[I];
  end;
  Result := Result.Trim;
end;

{$ENDREGION}

{$REGION 'Services'}

function TXMLReader.SanitizeXML(const aXML: string): string;
begin
  Result := aXML.Replace(#0, string.Empty);
end;

{$ENDREGION}

end.
