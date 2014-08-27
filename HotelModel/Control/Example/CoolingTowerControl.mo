within HotelModel.Control.Example;
model CoolingTowerControl

  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.CombiTimeTable sta(table=[0.0, 1; 40, 2; 80, 3; 120,
        4; 160, 5; 200, 6; 240, 7])
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  .HotelModel.Control.CoolingTowerControl cooTowCon(pum1MasFlo=10)
    annotation (Placement(transformation(extent={{6,20},{26,40}})));
equation
  connect(realToInteger.u, sta.y[1]) annotation (Line(
      points={{-42,30},{-59,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realToInteger.y, cooTowCon.sta) annotation (Line(
      points={{-19,30},{4,30}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end CoolingTowerControl;
