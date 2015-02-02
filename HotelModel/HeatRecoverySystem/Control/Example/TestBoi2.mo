within HotelModel.HeatRecoverySystem.Control.Example;
model TestBoi2

  Modelica.Blocks.Sources.Constant Tem2(k=273.15 + 17)
    annotation (Placement(transformation(extent={{-46,-16},{-26,4}})));
  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
  Modelica.Blocks.Sources.CombiTimeTable sta(table=[0.0, 1; 40, 2; 80, 3; 120,
        4; 160, 5; 200, 6; 240, 7])
    annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
  Boi2Control boi2Con(kPCon=0.5, TBoi2Set=289.48)
    annotation (Placement(transformation(extent={{6,16},{26,36}})));
equation
  connect(realToInteger.u, sta.y[1]) annotation (Line(
      points={{-48,30},{-67,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realToInteger.y, boi2Con.sta) annotation (Line(
      points={{-25,30},{4,30}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(Tem2.y, boi2Con.Tem2) annotation (Line(
      points={{-25,-6},{-4,-6},{-4,24},{4,24}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end TestBoi2;
