{-----------------------------------------------------------------------------
    XMLReader Lib
    Copyrigth (C) 2023-2030 Muzio Valerio

    Unit Name: XML.Reader.Node.Intf
    Author:    muzio
    Date:      13-ott-2023

    Info:
    Purpose:
    History:

-----------------------------------------------------------------------------}

unit XML.Reader.Node.Intf;

interface

uses
	System.Classes, System.SysUtils, System.Generics.Collections,
	XML.Reader.Element.Intf,
	XML.Reader.Attribute.Intf;

type
  IXMLNode = interface
    ['{4E1C725C-EFF4-43AB-820D-C3438A41D140}']
    function GetAttribute(const aAttributeName: string): IXMLAttribute;
    function GetNode(const aNodeName: string): IXMLNode;
    function GetElement(const AElementName: string): IXMLElement;
    function Attributes: TList<IXMLAttribute>;
    function Nodes: TList<IXMLNode>;
    function Elements: TList<IXMLElement>;
    function ContainsAttribute(const aAttributeName: string): Boolean;
    function ContainsNode(const aNodeName: string): Boolean;
    function ContainsElement(const aElementName: string): Boolean;
    function GetNodeName: string;
    function SetNodeName(const aName: string): IXMLNode;
  end;

implementation

end.
