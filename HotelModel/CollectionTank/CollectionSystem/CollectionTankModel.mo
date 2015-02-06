within HotelModel.CollectionTank.CollectionSystem;
model CollectionTankModel "Model of the collection tank system"
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  CollectionTankSignal collectionTankSignal(area=area)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealInput RaiWatIn1
    "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Fluid.Sources.MassFlowSource_h RainWater(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium = MediumRainWater)
    annotation (Placement(transformation(extent={{2,-18},{22,2}})));
  Modelica.Fluid.Interfaces.FluidPorts_b ports1[1](redeclare package Medium =
        MediumRainWater)
    annotation (Placement(transformation(extent={{88,-40},{108,40}})));
  parameter Real area "Constant output value";
  Modelica.Blocks.Interfaces.RealOutput MasRWFloRat "mass of the rainl"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
equation
  connect(collectionTankSignal.RaiWatIn, RaiWatIn1) annotation (Line(
      points={{-62,0},{-120,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(RainWater.ports[1:1], ports1) annotation (Line(
      points={{22,-8},{60,-8},{60,0},{98,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(collectionTankSignal.MasRai, RainWater.m_flow_in) annotation (Line(
      points={{-39,0},{2,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(collectionTankSignal.MasRai, MasRWFloRat) annotation (Line(
      points={{-39,0},{-20,0},{-20,60},{0,60},{0,110}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{70,40},{90,-40}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-100},{100,-140}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end CollectionTankModel;
