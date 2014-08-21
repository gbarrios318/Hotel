within HotelModel.HeatPumpSection.HeatPumpPackage;
model HeatPumpwithControls "Heat Pump with its controls"
replaceable package MediumCW =
      Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
  HeatPump HeaPum(
    redeclare package MediumCW = MediumCW,
    dp_nominal=dp_nominal,
    mWater_flow_nominal=mWater_flow_nominal)
    "Heat pump with all components directly interacting with it"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput THeaPum
    "Temperature of the passing fluid leaving the heat pump"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Sources.Constant MasFloHeaPum(k=40)
    "Mass flow rate of Heat Pump"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Sources.Constant Q_floIn(k=-2300000) "Heat flow input"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
equation
  connect(HeaPum.port_a1, port_a1) annotation (Line(
      points={{-20.4,0},{-102,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HeaPum.port_b1, port_b1) annotation (Line(
      points={{20,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(MasFloHeaPum.y, HeaPum.masFloPum) annotation (Line(
      points={{-59,40},{-40,40},{-40,8},{-22.4,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Q_floIn.y, HeaPum.Q_flow) annotation (Line(
      points={{-59,-40},{-40,-40},{-40,-8},{-22.4,-8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(HeaPum.THeaPum, THeaPum) annotation (Line(
      points={{22,8},{60,8},{60,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),        graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-96,8},{-60,0}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          fillColor={255,0,0},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-96,-8},{-60,0}},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,40},{60,-40}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,20},{60,-20}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,0,0}),
        Rectangle(
          extent={{60,8},{96,-8}},
          pattern=LinePattern.None,
          fillColor={95,0,127},
          fillPattern=FillPattern.Solid),
        Line(
          points={{60,30},{80,30},{80,40},{90,40}},
          color={0,0,0},
          pattern=LinePattern.DashDot,
          thickness=0.5,
          smooth=Smooth.None),
        Text(
          extent={{-40,80},{40,60}},
          lineColor={0,0,255},
          textString="%name")}));
end HeatPumpwithControls;
