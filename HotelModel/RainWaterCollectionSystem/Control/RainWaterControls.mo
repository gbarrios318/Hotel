within HotelModel.RainWaterCollectionSystem.Control;
model RainWaterControls
  parameter Modelica.SIunits.Volume ColTanVol "Volume";
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=const.k)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealInput FluidVol "output fluid volume"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Interfaces.RealOutput ValCon "Valve controls "
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant const(k=ColTanVol*0.1)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation
  connect(lessThreshold.u, FluidVol) annotation (Line(
      points={{-62,0},{-120,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(lessThreshold.y, booleanToReal.u) annotation (Line(
      points={{-39,0},{-22,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanToReal.y, ValCon) annotation (Line(
      points={{1,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end RainWaterControls;
