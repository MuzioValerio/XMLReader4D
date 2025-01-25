{-----------------------------------------------------------------------------
    XMLReader Lib
    Copyrigth (C) 2023-2030 Muzio Valerio

    Unit Name: XML.Reader.Intf
    Author:    muzio
    Date:      13-ott-2023

    Info:
    Purpose:
    History:

-----------------------------------------------------------------------------}

unit XML.Reader.Intf;

interface

uses
  System.Classes, System.SysUtils,
  XML.Reader.Node.Intf;

type
  IXMLReader = interface
    ['{B0700246-D6CF-4CA2-8AD8-5AAD0B317C8D}']
    function LoadFromStream(const aStream: TStream): IXMLReader;
    function LoadFromString(const aXML: string): IXMLReader;
    function LoadFromFile(const aPath: string): IXMLReader;
    function Node: IXMLNode;
    function GetVersion: string;
    function GetEncoding: string;
  end;

implementation

end.
