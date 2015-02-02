within HotelModel.HeatRecoverySystem.Control.Example;
model TestHex2Group2

  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
  Modelica.Blocks.Sources.CombiTimeTable sta(table=[0.0, 1; 40, 2; 80, 3; 120,
        4; 160, 5; 200, 6; 240, 7])
    annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
  Hex2ControlGroup2 hex2ConGro2(pum3MasFlo=10)
    annotation (Placement(transformation(extent={{-6,20},{14,40}})));
equation
  connect(realToInteger.u, sta.y[1]) annotation (Line(
      points={{-48,30},{-67,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realToInteger.y, hex2ConGro2.sta) annotation (Line(
      points={{-25,30},{-8,30}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end TestHex2Group2;
