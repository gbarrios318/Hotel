within HotelModel.HeatPumpSection.BoilerPackage.Example;
model BoilerSystem "Example for boiler system"
  import HotelModel;
  extends Modelica.Icons.Example;
 package MediumCW = Buildings.Media.ConstantPropertyLiquidWater
    "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
  Boiler2WithControls boiler2WithControls(
    redeclare package MediumCW = MediumCW,
    mWater_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal,
    boi(add(k1=+1, k2=-1)))
    annotation (Placement(transformation(extent={{-20,-80},{20,-40}})));
  inner Modelica.Fluid.System system(T_ambient=283.15)
    annotation (Placement(transformation(extent={{40,61},{60,81}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = MediumCW,
    p=0)
    annotation (Placement(transformation(extent={{82,-70},{62,-50}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 22.22)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    T=273.15 + 22.22,
    redeclare package Medium = MediumCW,
    m_flow=mWater_flow_nominal)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Blocks.Sources.IntegerTable integerTable(table=[0,1; 100,2; 200,3; 300,
        4; 400,5; 500,6; 600,7])
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation
  connect(boiler2WithControls.port_b1, bou1.ports[1]) annotation (Line(
      points={{20,-60},{62,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const.y, boiler2WithControls.HPTSen) annotation (Line(
      points={{-59,40},{-40,40},{-40,-51.6},{-21.6,-51.6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(boundary.ports[1], boiler2WithControls.port_a1) annotation (Line(
      points={{-60,-60},{-20,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(integerTable.y, boiler2WithControls.Sta) annotation (Line(
      points={{-59,70},{-34,70},{-34,-47.6},{-21.6,-47.6}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=2700, __Dymola_NumberOfIntervals=1000),
    __Dymola_experimentSetupOutput);
end BoilerSystem;
