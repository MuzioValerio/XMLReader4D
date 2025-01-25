{-----------------------------------------------------------------------------
    XMLReader Lib
    Copyrigth (C) 2023-2030 Muzio Valerio

    Unit Name: XML.Reader.Element
    Author:    muzio
    Date:      13-ott-2023

    Info:
    Purpose:
    History:

-----------------------------------------------------------------------------}

unit XML.Reader.Element;

interface

uses
  System.Classes, System.Variants, System.SysUtils,
  XML.Reader.Element.Intf;

type
  TXMLElement = class(TInterfacedObject, IXMLElement)
  private
    FElementName: string;
    FElementValue: Variant;
    function GetElementName: string;
    function SetElementName(const aElementName: string): IXMLElement;
    function GetElementValue: Variant;
    function SetElementValue(const aElementValue: Variant): IXMLElement;
    function AsString: string;
    function AsInteger: Integer;
  public
    class function New: IXMLElement;
  end;

implementation

{ TXMLElement }

class function TXMLElement.New: IXMLElement;
begin
  Result := TXMLElement.Create;
end;

function TXMLElement.SetElementName(const aElementName: string): IXMLElement;
begin
  FElementName := aElementName;
  Result := Self;
end;

function TXMLElement.SetElementValue(const aElementValue: Variant): IXMLElement;
begin
  FElementValue := aElementValue;
  Result := Self;
end;

function TXMLElement.AsInteger: Integer;
begin
  Result := 0;
  if VarIsNumeric(FElementValue) then
    Result := FElementValue;
end;

function TXMLElement.AsString: string;
begin
  Result := EmptyStr;
  if VarIsStr(FElementValue) then
    Result := FElementValue;
end;

function TXMLElement.GetElementName: string;
begin
  Result := FElementName;
end;

function TXMLElement.GetElementValue: Variant;
begin
  Result := FElementValue;
end;

end.
