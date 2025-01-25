{-----------------------------------------------------------------------------
   XMLReader Lib
   Copyrigth (C) 2023-2030 Muzio Valerio

   Unit Name: XML.Reader.Types
   Author:    muzio
   Date:      18-ott-2023

   Info:
   Purpose:
   History:

-----------------------------------------------------------------------------}

unit XML.Reader.Types;

interface

uses 
	XML.Reader.Intf, 
	XML.Reader.Attribute.Intf, 
	XML.Reader.Element.Intf, 
	XML.Reader.Node.Intf;
	
type
  IXMLReader = XML.Reader.Intf.IXMLReader;
  IXMLNode = XML.Reader.Node.Intf.IXMLNode;
  IXMLElement = XML.Reader.Element.Intf.IXMLElement;
  IXMLAttribute = XML.Reader.Attribute.Intf.IXMLAttribute;

implementation

end.	

