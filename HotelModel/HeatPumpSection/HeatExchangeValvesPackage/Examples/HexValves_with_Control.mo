within HotelModel.HeatPumpSection.HeatExchangeValvesPackage.Examples;
model HexValves_with_Control
  "Examples for the heat exchange valves with the controls"
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
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal=20
    "Nominal mass flow rate";
      //The nominal flow rate of water for domestic flow rate is one I gave it
      //Need to look up actual values
  import HotelModel;
 extends Modelica.Icons.Example;
  HotelModel.HeatPumpSection.HeatExchangeValvesPackage.HexValves_with_Control
    hexValves_with_Control(
    redeclare package MediumCW = MediumCW,
    mWater_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal,
    redeclare package MediumDW = MediumDW,
    mDW_flow_nominal=mDW_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.Boundary_pT sin_2(
    use_p_in=true,
    T=273.15 + 10,
    redeclare package Medium = MediumDW,
    X={1},
    nPorts=1)             annotation (Placement(transformation(extent={{-50,-30},
            {-30,-10}},rotation=0)));
    Modelica.Blocks.Sources.Ramp TWat(
    height=10,
    offset=273.15 + 30,
    duration=5,
    startTime=5) "Water temperature"
                 annotation (Placement(transformation(extent={{-100,40},{-80,60}},
          rotation=0)));
    Modelica.Blocks.Sources.Constant POut(k=101325)
      annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
          rotation=0)));
  Buildings.Fluid.Sources.Boundary_pT sou_1(
    p=300000 + 5000,
    T=273.15 + 50,
    use_T_in=true,
    redeclare package Medium = MediumCW,
    nPorts=1)             annotation (Placement(transformation(extent={{-50,10},
            {-30,30}}, rotation=0)));
  Buildings.Fluid.Sources.Boundary_pT sin_1(
    use_p_in=true,
    T=273.15 + 25,
    redeclare package Medium = MediumCW,
    p=300000,
    nPorts=1)             annotation (Placement(transformation(extent={{70,10},{
            50,30}}, rotation=0)));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=5000,
    rising=10,
    width=100,
    falling=10,
    offset=300000,
    period=700)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
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
    nPorts=1)             annotation (Placement(transformation(extent={{70,-30},
            {50,-10}}, rotation=0)));
  Modelica.Blocks.Sources.Constant TDb(k=293.15) "Drybulb temperature"
    annotation (Placement(transformation(extent={{20,-90},{40,-70}}, rotation=0)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Sources.IntegerTable integerTable(table=[0,1; 100,2; 200,3; 300,
        4; 400,5; 500,6; 600,7])
    "Representation of all the states in the supervisory control"
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
equation

  connect(hexValves_with_Control.port_b1, sin_2.ports[1]) annotation (Line(
      points={{-10,-4},{-20,-4},{-20,-20},{-30,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou_1.ports[1], hexValves_with_Control.port_a1) annotation (Line(
      points={{-30,20},{-20,20},{-20,4},{-10,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TWat.y, sou_1.T_in) annotation (Line(
      points={{-79,50},{-60,50},{-60,24},{-52,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(POut.y, sin_2.p_in) annotation (Line(
      points={{-79,-50},{-60,-50},{-60,-12},{-52,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(trapezoid.y,sin_1. p_in) annotation (Line(
      points={{81,50},{90,50},{90,28},{72,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PIn.y, sou_2.p_in) annotation (Line(
      points={{41,-50},{90,-50},{90,-12},{72,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TDb.y, sou_2.T_in) annotation (Line(
      points={{41,-80},{80,-80},{80,-16},{72,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sin_1.ports[1], hexValves_with_Control.port_b2) annotation (Line(
      points={{50,20},{20,20},{20,4},{10,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou_2.ports[1], hexValves_with_Control.port_a2) annotation (Line(
      points={{50,-20},{20,-20},{20,-4},{10,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(integerTable.y, hexValves_with_Control.Sta) annotation (Line(
      points={{-19,80},{0,80},{0,11.2}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HexValves_with_Control;
