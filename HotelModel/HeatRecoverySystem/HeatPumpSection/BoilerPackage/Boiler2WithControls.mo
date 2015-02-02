within HotelModel.HeatRecoverySystem.HeatPumpSection.BoilerPackage;
model Boiler2WithControls "Heat Pump boiler with controls included"
replaceable package MediumHW =
         Buildings.Media.ConstantPropertyLiquidWater
    "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dpHW_nominal
    "Nominal pressure difference";
  parameter Modelica.SIunits.Power Q_flow_nominal "Nominal heat flow";
  parameter Real TSetBoiIn "Set temperature for boiler";
  Boiler2 boi(
    redeclare package MediumHW = MediumHW,
    mHW_flow_nominal=mHW_flow_nominal,
    dpHW_nominal=dpHW_nominal,
    Q_flow_nominal=Q_flow_nominal)
    "Boiler to heat the condenser water in a cold winter"
    annotation (Placement(transformation(extent={{-10,-6},{10,14}})));
  BolierControls bolCon(TSetBoiIn=TSetBoiIn) "Boiler Control"
    annotation (Placement(transformation(extent={{-60,46},{-40,66}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort BoiTSen(redeclare package Medium
      =        MediumHW, m_flow_nominal=mHW_flow_nominal)
    "Finds the temperature of the water after it has been through the boiler"
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumHW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumHW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.IntegerInput Sta
    "States commanded by the supervisory control" annotation (Placement(
        transformation(extent={{-120,50},{-100,70}}), iconTransformation(
          extent={{-116,54},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput HPTSen
    "Heat pump temperature sensor signal"  annotation (Placement(
        transformation(extent={{-120,30},{-100,50}}), iconTransformation(
          extent={{-116,34},{-100,50}})));
  Modelica.Blocks.Interfaces.RealOutput TBoi
    "Signal of the output temperature after it has gone through the boiler"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{104,34},{120,50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1
    "Heat port, can be used to connect to ambient"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
equation
  connect(boi.port_b1, BoiTSen.port_a) annotation (Line(
      points={{10,0},{50,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(BoiTSen.port_b, port_b1) annotation (Line(
      points={{70,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(port_a1, port_a1) annotation (Line(
      points={{-100,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Sta, bolCon.sta) annotation (Line(
      points={{-110,60},{-62,60}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(HPTSen, bolCon.TMea) annotation (Line(
      points={{-110,40},{-80,40},{-80,50},{-62,50}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(bolCon.Val4Ctr, boi.valCon) annotation (Line(
      points={{-39,60},{-24,60},{-24,8.2},{-10.8,8.2}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(bolCon.BoiCtr, boi.boiCon) annotation (Line(
      points={{-39,54},{-20,54},{-20,12},{-10.8,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(BoiTSen.T, TBoi) annotation (Line(
      points={{60,11},{60,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(boi.port_a1, port_a1) annotation (Line(
      points={{-10,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boi.heatPort1, heatPort1) annotation (Line(
      points={{0,14},{0,100}},
      color={191,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-60,60},{60,-40}},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-80,-60},{-60,-40},{60,-40},{80,-60},{-80,-60}},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,40},{20,-50}},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-94,8},{-20,-8}},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,8},{96,-8}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-90,40},{-80,40},{-80,20},{-20,20}},
          pattern=LinePattern.DashDot,
          smooth=Smooth.None,
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-90,60},{-70,60},{-70,30},{-20,30}},
          color={0,0,0},
          pattern=LinePattern.DashDot,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{20,24},{80,24},{80,40},{94,40}},
          color={0,0,0},
          pattern=LinePattern.DashDot,
          thickness=0.5,
          smooth=Smooth.None),
        Text(
          extent={{-40,90},{38,70}},
          lineColor={0,0,255},
          textString="%name")}));
end Boiler2WithControls;
