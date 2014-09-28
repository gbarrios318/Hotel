within HotelModel.HeatPumpSection.HeatPumpPackage;
model HeatPump "Base class representation of the Heat Pump"
replaceable package MediumCW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mCW_flow_nominal
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal "Nominal pressure difference";
  parameter Modelica.SIunits.Volume HeatPumpVol "Volume of the Heat Pump";
  parameter Modelica.SIunits.Temperature HeaPumTRef
    "Reference tempearture of heat pump";

  Buildings.Fluid.MixingVolumes.MixingVolume HeaPumTan(
    redeclare package Medium = MediumCW,
    m_flow_nominal=mCW_flow_nominal,
    V=HeatPumpVol,
    nPorts=2) "Volume control of the Heat Pump"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    prescribedHeatFlow(T_ref=HeaPumTRef)
    "Prescribed Heat flow of the Heat Pump"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow "Heat Flow input "
    annotation (Placement(transformation(extent={{-124,-52},{-100,-28}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort HeaPumTemp(redeclare package
      Medium = MediumCW, m_flow_nominal=mCW_flow_nominal)
    "Tempearture after Heat Pump"
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumCW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumCW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput THeaPum
    "Signal of temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
equation
  connect(prescribedHeatFlow.Q_flow, Q_flow) annotation (Line(
      points={{-80,-40},{-112,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(prescribedHeatFlow.port, HeaPumTan.heatPort) annotation (Line(
      points={{-60,-40},{-40,-40},{-40,10}},
      color={191,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(HeaPumTemp.port_b, port_b1) annotation (Line(
      points={{70,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HeaPumTemp.T, THeaPum) annotation (Line(
      points={{60,11},{60,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(THeaPum, THeaPum) annotation (Line(
      points={{110,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HeaPumTan.ports[1], port_a1) annotation (Line(
      points={{-32,0},{-102,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HeaPumTemp.port_a, HeaPumTan.ports[2]) annotation (Line(
      points={{50,0},{-28,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-96,8},{-60,0}},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
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
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}),
        Rectangle(
          extent={{60,8},{94,-8}},
          fillPattern=FillPattern.Solid,
          fillColor={80,0,127},
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-100,40},{-80,40},{-80,30},{-60,30}},
          color={0,0,0},
          smooth=Smooth.None,
          pattern=LinePattern.DashDot,
          thickness=0.5),
        Line(
          points={{-100,-40},{-80,-40},{-80,-30},{-60,-30}},
          color={0,0,0},
          pattern=LinePattern.DashDot,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{60,28}},
          color={0,0,0},
          pattern=LinePattern.DashDot,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{60,30},{80,30},{80,40},{100,40}},
          color={0,0,0},
          pattern=LinePattern.DashDot,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-60,-70},{60,-70}},
          color={0,255,255},
          smooth=Smooth.None),
        Line(
          points={{40,-60},{60,-70},{40,-80}},
          color={0,255,255},
          smooth=Smooth.None),
        Text(
          extent={{-60,80},{60,60}},
          lineColor={0,0,255},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0},
          textString="%name")}));
end HeatPump;
