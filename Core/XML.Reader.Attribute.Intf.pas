{-----------------------------------------------------------------------------
    XMLReader Lib
    Copyrigth (C) 2023-2030 Muzio Valeiro

    Unit Name: XML.Reader.Attribute.Intf
    Author:    muzio
    Date:      13-ott-2023

    Info:
    Purpose:
    History:

-----------------------------------------------------------------------------}

unit XML.Reader.Attribute.Intf;

interface

uses
  System.Classes, System.SysUtils, System.Variants;

type
  IXMLAttribute = interface
    ['{9ABACA38-3FBF-4107-8263-03E2AA87C3E6}']
    function GetAttributeName: string;
    function SetAttributeName(const aAttributeName: string): IXMLAttribute;
    function GetAttributeValue: Variant;
    function SetAttributeValue(const aAttributeValue: Variant): IXMLAttribute;
    function AsString: string;
    function AsInteger: Integer;
  end;

implementation

end.
