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
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Buildings.Fluid.Sources.Boundary_pT sin_2(
    use_p_in=true,
    T=273.15 + 10,
    nPorts=1,
    redeclare package Medium = MediumDW,
    X={1})                annotation (Placement(transformation(extent={{-46,-62},
            {-26,-42}},rotation=0)));
    Modelica.Blocks.Sources.Ramp TWat(
    height=10,
    duration=60,
    offset=273.15 + 30,
    startTime=60) "Water temperature"
                 annotation (Placement(transformation(extent={{-94,6},{-74,26}},
          rotation=0)));
    Modelica.Blocks.Sources.Constant POut(k=101325)
      annotation (Placement(transformation(extent={{-90,-82},{-70,-62}},
          rotation=0)));
  Buildings.Fluid.Sources.Boundary_pT sou_1(
    p=300000 + 5000,
    T=273.15 + 50,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = MediumCW)
                          annotation (Placement(transformation(extent={{-62,-22},
            {-42,-2}}, rotation=0)));
  Buildings.Fluid.Sources.Boundary_pT sin_1(
    use_p_in=true,
    T=273.15 + 25,
    nPorts=1,
    redeclare package Medium = MediumCW,
    p=300000)             annotation (Placement(transformation(extent={{74,8},{54,
            28}},    rotation=0)));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=5000,
    rising=10,
    width=100,
    falling=10,
    period=3600,
    offset=300000)
    annotation (Placement(transformation(extent={{58,44},{78,64}})));
    Modelica.Blocks.Sources.Ramp PIn(
    height=200,
    duration=60,
    offset=101325,
    startTime=50)
                 annotation (Placement(transformation(extent={{-10,-40},{10,-20}},
          rotation=0)));
  Buildings.Fluid.Sources.Boundary_pT sou_2(
                                T=273.15 + 5,
    use_p_in=true,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = MediumDW)
                          annotation (Placement(transformation(extent={{50,-68},
            {70,-48}}, rotation=0)));
  Modelica.Blocks.Sources.Constant TDb(k=293.15) "Drybulb temperature"
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}},rotation=0)));
  Modelica.Blocks.Sources.Step step(startTime=1800)
    annotation (Placement(transformation(extent={{-48,36},{-28,56}})));
  Modelica.Blocks.Sources.Pulse pulse(period=3600)
    annotation (Placement(transformation(extent={{-42,68},{-22,88}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation

  connect(TWat.y,sou_1. T_in)
    annotation (Line(points={{-73,16},{-74,16},{-70,16},{-70,-8},{-64,-8}},
                                                 color={0,0,127}));
  connect(POut.y,sin_2. p_in) annotation (Line(
      points={{-69,-72},{-60,-72},{-60,-44},{-48,-44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sin_2.ports[1], heatEx_and_valves.port_b2) annotation (Line(
      points={{-26,-52},{-20,-52},{-20,-4},{-12,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou_1.ports[1], heatEx_and_valves.port_a1) annotation (Line(
      points={{-42,-12},{-28,-12},{-28,4},{-12,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(trapezoid.y,sin_1. p_in) annotation (Line(
      points={{79,54},{88,54},{88,26},{76,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sin_1.ports[1], heatEx_and_valves.port_b1) annotation (Line(
      points={{54,18},{44,18},{44,4},{8,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(PIn.y,sou_2. p_in) annotation (Line(
      points={{11,-30},{30,-30},{30,-50},{48,-50}},
      color={0,0,127},
      pattern=LinePattern.None));
  connect(TDb.y,sou_2. T_in) annotation (Line(points={{11,-70},{30,-70},{30,-54},
          {48,-54}}, color={0,0,127}));
  connect(sou_2.ports[1], heatEx_and_valves.port_a2) annotation (Line(
      points={{70,-58},{78,-58},{78,-4},{8,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(step.y, heatEx_and_valves.ValCtrl1) annotation (Line(
      points={{-27,46},{-8,46},{-8,11.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, heatEx_and_valves.ValCtrl2) annotation (Line(
      points={{-27,46},{-2,46},{-2,11.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pulse.y, heatEx_and_valves.BypValCtrl) annotation (Line(
      points={{-21,78},{4,78},{4,11.2}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatEx_and_valves;
