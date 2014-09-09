within HotelModel.HeatPumpSection.HeatExchangeValvesPackage.Examples;
model HeatEx_and_valves "Example for the HeatEx and valves"
     replaceable package MediumCW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
       replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal=15
    "Nominal mass flow rate";
      //The nominal flow rate of water for domestic flow rate is one I gave it
      //Need to look up actual values
  import HotelModel;
 extends Modelica.Icons.Example;
  HotelModel.HeatPumpSection.HeatExchangeValvesPackage.HeatEx_and_valves
    heatEx_and_valves(
    redeclare package MediumCW = MediumCW,
    mWater_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal,
    redeclare package MediumDW = MediumDW,
    mDW_flow_nominal=mDW_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.Boundary_pT sin_2(
    use_p_in=true,
    T=273.15 + 10,
    nPorts=1,
    redeclare package Medium = MediumDW,
    X={1})                annotation (Placement(transformation(extent={{-60,-30},
            {-40,-10}},rotation=0)));
    Modelica.Blocks.Sources.Ramp TWat(
    height=10,
    duration=60,
    offset=273.15 + 30,
    startTime=60) "Water temperature"
                 annotation (Placement(transformation(extent={{-100,40},{-80,60}},
          rotation=0)));
    Modelica.Blocks.Sources.Constant POut(k=101325)
      annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
          rotation=0)));
  Buildings.Fluid.Sources.Boundary_pT sou_1(
    p=300000 + 5000,
    T=273.15 + 50,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = MediumCW)
                          annotation (Placement(transformation(extent={{-60,10},
            {-40,30}}, rotation=0)));
  Buildings.Fluid.Sources.Boundary_pT sin_1(
    use_p_in=true,
    T=273.15 + 25,
    nPorts=1,
    redeclare package Medium = MediumCW,
    p=300000)             annotation (Placement(transformation(extent={{60,10},
            {40,30}},rotation=0)));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=5000,
    rising=10,
    width=100,
    falling=10,
    period=3600,
    offset=300000)
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
    Modelica.Blocks.Sources.Ramp PIn(
    height=200,
    duration=60,
    offset=101325,
    startTime=50)
                 annotation (Placement(transformation(extent={{20,-60},{40,-40}},
          rotation=0)));
  Buildings.Fluid.Sources.Boundary_pT sou_2(
                                T=273.15 + 5,
    use_p_in=true,
    use_T_in=true,
    redeclare package Medium = MediumDW,
    nPorts=1)             annotation (Placement(transformation(extent={{60,-30},
            {40,-10}}, rotation=0)));
  Modelica.Blocks.Sources.Constant TDb(k=293.15) "Drybulb temperature"
    annotation (Placement(transformation(extent={{20,-90},{40,-70}}, rotation=0)));
  Modelica.Blocks.Sources.Step step(startTime=1800)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.Pulse pulse(period=3600)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
equation

  connect(TWat.y,sou_1. T_in)
    annotation (Line(points={{-79,50},{-70,50},{-70,36},{-70,24},{-62,24}},
                                                 color={0,0,127},
      pattern=LinePattern.Dash));
  connect(POut.y,sin_2. p_in) annotation (Line(
      points={{-79,-50},{-70,-50},{-70,-12},{-62,-12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sin_2.ports[1], heatEx_and_valves.port_b2) annotation (Line(
      points={{-40,-20},{-20,-20},{-20,-4},{-10,-4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sou_1.ports[1], heatEx_and_valves.port_a1) annotation (Line(
      points={{-40,20},{-20,20},{-20,4},{-10,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(trapezoid.y,sin_1. p_in) annotation (Line(
      points={{81,60},{88,60},{88,28},{62,28}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sin_1.ports[1], heatEx_and_valves.port_b1) annotation (Line(
      points={{40,20},{20,20},{20,4},{10,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(step.y, heatEx_and_valves.ValCtrl1) annotation (Line(
      points={{-19,50},{-6,50},{-6,11.2}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(step.y, heatEx_and_valves.ValCtrl2) annotation (Line(
      points={{-19,50},{0,50},{0,11.2}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(pulse.y, heatEx_and_valves.BypValCtrl) annotation (Line(
      points={{-19,80},{6,80},{6,11.2}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sou_2.ports[1], heatEx_and_valves.port_a2) annotation (Line(
      points={{40,-20},{20,-20},{20,-4},{10,-4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(PIn.y, sou_2.p_in) annotation (Line(
      points={{41,-50},{80,-50},{80,-12},{62,-12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TDb.y, sou_2.T_in) annotation (Line(
      points={{41,-80},{70,-80},{70,-16},{62,-16}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatEx_and_valves;
