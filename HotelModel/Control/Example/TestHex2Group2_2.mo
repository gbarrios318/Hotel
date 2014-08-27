within HotelModel.Control.Example;
model TestHex2Group2_2

  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
  Modelica.Blocks.Sources.CombiTimeTable Stage(table=[0.0, 1; 40, 2; 80, 3; 120,
        4; 160, 5; 200, 6; 240, 7])
    annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
  Hex2ControlGroup2_2 hex2ControlGroup2_2_1(pum3_mass_flow=20)
    annotation (Placement(transformation(extent={{12,16},{32,36}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-46,-12},{-26,8}})));
equation
  connect(realToInteger.u, Stage.y[1]) annotation (Line(
      points={{-48,30},{-67,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realToInteger.y, hex2ControlGroup2_2_1.sta) annotation (Line(
      points={{-25,30},{10,30}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(const.y, hex2ControlGroup2_2_1.masFloMV2) annotation (Line(
      points={{-25,-2},{-6,-2},{-6,24},{10,24}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end TestHex2Group2_2;
