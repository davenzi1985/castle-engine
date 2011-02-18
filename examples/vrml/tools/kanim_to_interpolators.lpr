{
  Copyright 2009-2010 Michalis Kamburelis.

  This file is part of "Kambi VRML game engine".

  "Kambi VRML game engine" is free software; see the file COPYING.txt,
  included in this distribution, for details about the copyright.

  "Kambi VRML game engine" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  ----------------------------------------------------------------------------
}

{ Convert kanim animation (sequence of 3D files) to a single VRML/X3D
  file using VRML/X3D interpolator.

  This works only for animations where only *one* mesh (VRML/X3D Coordinate
  node) changes during animation!
  It's not a general kanim -> interpolators converter.
  (And I don't know if I'll ever want to implement general converter,
  kanim is just an obsolete hack only to work with poor Blender exporter.)

  Call with params:
  $1 - coordinate node name in VRML/X3D file
  $2 - animation input filename (usually kanim filename, also md3 would be sensible)
  $3 - vrml/x3d output filename

  For example:
    kanim_to_interpolators coord_MOD_Plane \
    ../../../../kambi_vrml_test_suite/water/water.kanim \
    ../../../../kambi_vrml_test_suite/water/water_converted.wrl
}
program kanim_to_interpolators;

uses SysUtils, Classes, KambiUtils, KambiClassUtils, VRMLNodes, VRMLGLAnimation,
  KambiStringUtils, ProgressUnit, ProgressConsole;

var
  CoordinateNodeName: string;

procedure SaveFile(Node: TVRMLNode; const Filename: string);
const
  SceneSuffix = {$I kanim_to_interpolators_suffix.inc};
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(Filename, fmCreate);
  try
    SaveVRMLClassic(Node, Stream, '');
    WritelnStr(Stream, StringReplace(SceneSuffix, '$(CoordinateNodeName)',
      CoordinateNodeName, [rfReplaceAll, rfIgnoreCase]));
  finally Stream.Free end;
end;

var
  InputFileName, OutputFileName: string;
  Anim: TVRMLGLAnimation;
  Vrml: TVRMLNode;
  Interp: TNodeCoordinateInterpolator;
  Coord: TNodeCoordinate;
  I: Integer;
  CoordCount: Cardinal;
begin
  Parameters.CheckHigh(3);

  CoordinateNodeName := Parameters[1];
  InputFileName := Parameters[2];
  OutputFileName := Parameters[3];

  Anim := TVRMLGLAnimation.Create(nil);
  try
    Writeln('Reading ', InputFileName, ' ...');
    Anim.LoadFromFile(InputFileName, false, false);
    Vrml := Anim.Scenes[0].RootNode.DeepCopy;
    try
      { find Coordinate node for the 1st time, to calculate CoordCount }
      Coord := Anim.Scenes[0].RootNode.FindNodeByName(
        TNodeCoordinate, CoordinateNodeName, false) as TNodeCoordinate;
      CoordCount := Coord.FdPoint.Count;
      Writeln('Coordinate node ', CoordinateNodeName, ' found OK (', CoordCount, ' vertexes).');

      Interp := TNodeCoordinateInterpolator.Create('Interp', '');
      Vrml.SmartAddChild(Interp);

      Interp.FdKeyValue.Items.Count := 0;
      Interp.FdKeyValue.Items.AllowedCapacityOverflow := CoordCount * Anim.ScenesCount;

      Progress.UserInterface := ProgressConsoleInterface;
      Progress.Init(Anim.ScenesCount, 'Converting to interpolators');
      try

        for I := 0 to Anim.ScenesCount - 1 do
        begin
          Coord := Anim.Scenes[I].RootNode.FindNodeByName(
            TNodeCoordinate, CoordinateNodeName, false) as TNodeCoordinate;
          Interp.FdKeyValue.Items.AppendDynArray(Coord.FdPoint.Items);
          Interp.FdKey.Items.Add(I / (Anim.ScenesCount - 1));
          Progress.Step;

          { check, in case kanim is not "structurally equal" on every frame }
          if Coord.FdPoint.Count <> CoordCount then
            raise Exception.CreateFmt('Coordinate node in frame %d has %d vertexes, while in frame 0 it had %d vertexes. Such animation cannot be converted to CoordinateInterpolator',
              [I, Coord.FdPoint.Count, CoordCount]);
        end;

        Assert(Interp.FdKeyValue.Items.Count = CoordCount * Anim.ScenesCount);

      finally Progress.Fini end;

      Writeln('Writing ', OutputFileName, '...');
      SaveFile(Vrml, OutputFileName);
    finally FreeAndNil(Vrml) end;
  finally FreeAndNil(Anim) end;
end.
