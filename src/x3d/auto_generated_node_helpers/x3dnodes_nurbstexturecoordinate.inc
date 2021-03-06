{ -*- buffer-read-only: t -*-

  Copyright 2015-2018 Michalis Kamburelis.

  This file is part of "Castle Game Engine".

  "Castle Game Engine" is free software; see the file COPYING.txt,
  included in this distribution, for details about the copyright.

  "Castle Game Engine" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  ----------------------------------------------------------------------------
}

{ Automatically generated node properties.

  Do not edit this file manually!
  To add new properties:
  - add them to the text files in tools/internal/x3d-nodes-to-pascal/nodes-specification/ ,
  - and regenerate include files by running x3d-nodes-to-pascal .

  The documentation for properties should go to x3dnodes_documentation.txt . }

{$ifdef read_interface}

  strict private
    function GetUDimension: Integer;
    procedure SetUDimension(const Value: Integer);
    function GetUOrder: Integer;
    procedure SetUOrder(const Value: Integer);
    function GetVDimension: Integer;
    procedure SetVDimension(const Value: Integer);
    function GetVOrder: Integer;
    procedure SetVOrder(const Value: Integer);
  public
    { Set X3D field "controlPoint". } { }
    procedure SetControlPoint(const Value: array of TVector2);
    { Set X3D field "controlPoint". } { }
    procedure SetControlPoint(const Value: TVector2List);
    { Set X3D field "weight". } { }
    procedure SetWeight(const Value: array of Single);
    { Set X3D field "weight". } { }
    procedure SetWeight(const Value: TSingleList);
    { X3D field "uDimension". } { }
    property UDimension: Integer read GetUDimension write SetUDimension;
    { Set X3D field "uKnot". } { }
    procedure SetUKnot(const Value: array of Double);
    { Set X3D field "uKnot". } { }
    procedure SetUKnot(const Value: TDoubleList);
    { X3D field "uOrder". } { }
    property UOrder: Integer read GetUOrder write SetUOrder;
    { X3D field "vDimension". } { }
    property VDimension: Integer read GetVDimension write SetVDimension;
    { Set X3D field "vKnot". } { }
    procedure SetVKnot(const Value: array of Double);
    { Set X3D field "vKnot". } { }
    procedure SetVKnot(const Value: TDoubleList);
    { X3D field "vOrder". } { }
    property VOrder: Integer read GetVOrder write SetVOrder;

{$endif read_interface}

{$ifdef read_implementation}

{ TNurbsTextureCoordinateNode ----------------------------------------------- }

procedure TNurbsTextureCoordinateNode.SetControlPoint(const Value: array of TVector2);
begin
  FdControlPoint.Send(Value);
end;

procedure TNurbsTextureCoordinateNode.SetControlPoint(const Value: TVector2List);
begin
  FdControlPoint.Send(Value);
end;

procedure TNurbsTextureCoordinateNode.SetWeight(const Value: array of Single);
begin
  FdWeight.Send(Value);
end;

procedure TNurbsTextureCoordinateNode.SetWeight(const Value: TSingleList);
begin
  FdWeight.Send(Value);
end;

function TNurbsTextureCoordinateNode.GetUDimension: Integer;
begin
  Result := FdUDimension.Value;
end;

procedure TNurbsTextureCoordinateNode.SetUDimension(const Value: Integer);
begin
  FdUDimension.Send(Value);
end;

procedure TNurbsTextureCoordinateNode.SetUKnot(const Value: array of Double);
begin
  FdUKnot.Send(Value);
end;

procedure TNurbsTextureCoordinateNode.SetUKnot(const Value: TDoubleList);
begin
  FdUKnot.Send(Value);
end;

function TNurbsTextureCoordinateNode.GetUOrder: Integer;
begin
  Result := FdUOrder.Value;
end;

procedure TNurbsTextureCoordinateNode.SetUOrder(const Value: Integer);
begin
  FdUOrder.Send(Value);
end;

function TNurbsTextureCoordinateNode.GetVDimension: Integer;
begin
  Result := FdVDimension.Value;
end;

procedure TNurbsTextureCoordinateNode.SetVDimension(const Value: Integer);
begin
  FdVDimension.Send(Value);
end;

procedure TNurbsTextureCoordinateNode.SetVKnot(const Value: array of Double);
begin
  FdVKnot.Send(Value);
end;

procedure TNurbsTextureCoordinateNode.SetVKnot(const Value: TDoubleList);
begin
  FdVKnot.Send(Value);
end;

function TNurbsTextureCoordinateNode.GetVOrder: Integer;
begin
  Result := FdVOrder.Value;
end;

procedure TNurbsTextureCoordinateNode.SetVOrder(const Value: Integer);
begin
  FdVOrder.Send(Value);
end;

{$endif read_implementation}
