within HotelModel.HeatPumpSection.BoilerPackage.Example;
model Boiler "Example for the boiler and its components"
   replaceable package MediumCW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
  import HotelModel;
 extends Modelica.Icons.Example;
  HotelModel.HeatPumpSection.BoilerPackage.Boiler2 boiler2_1(
    redeclare package MediumCW = MediumCW,
    mWater_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{-10,-46},{10,-26}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    p(displayUnit="Pa") = 300000,
    nPorts=1,
    redeclare package Medium = MediumCW,
    T=333.15) "Sink"
    annotation (Placement(transformation(extent={{74,-50},{54,-30}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    nPorts=1,
    p=300000 + dp_nominal,
    redeclare package Medium = MediumCW,
    T=303.15)
    annotation (Placement(transformation(extent={{-78,-50},{-58,-30}})));
  Modelica.Blocks.Sources.TimeTable y(table=[0,0; 1800,1; 1800,0; 2400,0; 2400,
        1; 3600,1])
    annotation (Placement(transformation(extent={{-76,18},{-56,38}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
      Medium = MediumCW)
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Buildings.HeatTransfer.Sources.FixedTemperature TAmb2(      T=288.15)
    "Ambient temperature in boiler room"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.Pulse pulse(amplitude=1, period=1800)
    annotation (Placement(transformation(extent={{-76,-18},{-56,2}})));
equation

  connect(sou.ports[1], boiler2_1.port_a1) annotation (Line(
      points={{-58,-40},{-10,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(y.y, boiler2_1.boiCon) annotation (Line(
      points={{-55,28},{-30,28},{-30,-28},{-10.8,-28}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(temperature.port_b, sin.ports[1]) annotation (Line(
      points={{40,-40},{54,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(temperature.port_a, boiler2_1.port_b1) annotation (Line(
      points={{20,-40},{10,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(TAmb2.port, boiler2_1.heatPort1) annotation (Line(
      points={{-20,50},{0,50},{0,-26}},
      color={191,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(pulse.y, boiler2_1.valCon) annotation (Line(
      points={{-55,-8},{-34,-8},{-34,-31.8},{-10.8,-31.8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics));
end Boiler;
