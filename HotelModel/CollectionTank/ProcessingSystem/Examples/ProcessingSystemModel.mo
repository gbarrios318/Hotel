within HotelModel.CollectionTank.ProcessingSystem.Examples;
model ProcessingSystemModel "Example for the processing system model"
  import HotelModel;
 extends Modelica.Icons.Example;
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  replaceable package MediumCityWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  HotelModel.CollectionTank.ProcessingSystem.ProcessingSystemModel
    processingSystemModel(
    redeclare package MediumRainWater = MediumRainWater,
    redeclare package MediumCityWater = MediumCityWater,
    m_RWflow_nominal=7.89,
    dpSSFil_nominal(displayUnit="kPa") = 1000,
    dpUVFil_nominal(displayUnit="kPa") = 1000,
    dpRW_nominal(displayUnit="kPa") = 11782000,
    m_CitWatflow_nominal=4.5,
    m_valveflow_nominal=0.39,
    dpValve_nominal(displayUnit="kPa") = 1000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(nPorts=1,
    redeclare package Medium = MediumRainWater,
    use_m_flow_in=true)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Fluid.Sources.FixedBoundary bou(redeclare package Medium =
        MediumRainWater, nPorts=1)
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T Sou1(
    nPorts=1,
    redeclare package Medium = MediumCityWater,
    use_m_flow_in=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,50})));
  Modelica.Blocks.Sources.Constant const(k=1000)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumRainWater)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=1,
    width=50,
    period=1/1800,
    nperiod=2)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=2000,
    freqHz=1/3600,
    offset=3000,
    startTime=0)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Step step(
    height=1,
    offset=0,
    startTime=1800)
    annotation (Placement(transformation(extent={{-62,30},{-42,50}})));
equation

  connect(boundary.ports[1], processingSystemModel.port_a1) annotation (Line(
      points={{-40,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(processingSystemModel.CitWat, Sou1.ports[1]) annotation (Line(
      points={{0,9.8},{0,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const.y, Sou1.m_flow_in) annotation (Line(
      points={{-19,70},{8,70},{8,60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(processingSystemModel.port_1, senMasFlo.port_a) annotation (Line(
      points={{10,0},{20,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(bou.ports[1], senMasFlo.port_b) annotation (Line(
      points={{50,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pulse.y, processingSystemModel.ValByP) annotation (Line(
      points={{-39,-40},{-20,-40},{-20,-6},{-12,-6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(boundary.m_flow_in, sine.y) annotation (Line(
      points={{-60,8},{-70,8},{-70,0},{-79,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(step.y, processingSystemModel.ValE) annotation (Line(
      points={{-41,40},{-20,40},{-20,6},{-12,6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end ProcessingSystemModel;
