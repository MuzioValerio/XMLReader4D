{-----------------------------------------------------------------------------
    XMLReader Lib
    Copyrigth (C) 2023-2030 Muzio Valerio

    Unit Name: XML.Reader.Attribute
    Author:    muzio
    Date:      13-ott-2023

    Info:
    Purpose:
    History:

-----------------------------------------------------------------------------}

unit XML.Reader.Attribute;

interface

uses
  system.Classes, system.SysUtils, system.Variants,
  XML.Reader.Attribute.Intf;

type
  TXMLAttribute = class(TInterfacedObject, IXMLAttribute)
  private
    FAttributeName: string;
    FAttributeValue: Variant;
    function GetAttributeName: string;
    function SetAttributeName(const aAttributeName: string): IXMLAttribute;
    function GetAttributeValue: Variant;
    function SetAttributeValue(const aAttributeValue: Variant): IXMLAttribute;
    function AsString: string;
    function AsInteger: Integer;
  public
    class function New: IXMLAttribute;
  end;

implementation

{ TXMLAttribute }

class function TXMLAttribute.New: IXMLAttribute;
begin
  Result := TXMLAttribute.Create;
end;

function TXMLAttribute.SetAttributeName(const aAttributeName: string): IXMLAttribute;
begin
  FAttributeName := aAttributeName;
  Result := Self;
end;

function TXMLAttribute.SetAttributeValue(const aAttributeValue: Variant): IXMLAttribute;
begin
  FAttributeValue := aAttributeValue;
  Result := Self;
end;

function TXMLAttribute.AsString: string;
begin
  Result := string.Empty;
  if VarIsStr(FAttributeValue) then
    Result := FAttributeValue;
end;

function TXMLAttribute.AsInteger: Integer;
begin
  Result := 0;
  if VarIsNumeric(FAttributeValue) then
    Result := FAttributeValue;
end;

function TXMLAttribute.GetAttributeName: string;
begin
  Result := FAttributeName;
end;

function TXMLAttribute.GetAttributeValue: Variant;
begin
  Result := FAttributeValue;
end;

end.
