{-----------------------------------------------------------------------------
    XMLReader Lib
    Copyrigth (C) 2023-2030 Muzio Valerio

    Unit Name: XML.Reader.Element.Intf
    Author:    muzio
    Date:      13-ott-2023

    Info:
    Purpose:
    History:

-----------------------------------------------------------------------------}

unit XML.Reader.Element.Intf;

interface

uses
  System.Classes, System.SysUtils, System.Variants;

type
  IXMLElement = interface
    ['{920ADF7E-DB8C-4A9A-919A-02C49BD618F4}']
    function GetElementName: string;
    function SetElementName(const aElementName: string): IXMLElement;
    function GetElementValue: Variant;
    function SetElementValue(const aElementValue: Variant): IXMLElement;
    function AsString: string;
    function AsInteger: Integer;
  end;

implementation

end.
