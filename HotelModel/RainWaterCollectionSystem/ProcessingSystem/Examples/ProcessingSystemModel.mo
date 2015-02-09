within HotelModel.RainWaterCollectionSystem.ProcessingSystem.Examples;
model ProcessingSystemModel "Example for the processing system model"
  import HotelModel;
 extends Modelica.Icons.Example;
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  replaceable package MediumCityWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  HotelModel.RainWaterCollectionSystem.ProcessingSystem.ProcessingSystemModel
    processingSystemModel(
    redeclare package MediumRainWater = MediumRainWater,
    redeclare package MediumCityWater = MediumCityWater,
    m_RWflow_nominal=7.89,
    dpSSFil_nominal(displayUnit="kPa") = 1000,
    dpUVFil_nominal(displayUnit="kPa") = 1000,
    m_CitWatflow_nominal=4.5,
    m_valveflow_nominal=0.39,
    dpRW_nominal(displayUnit="kPa") = 1103160,
    dpValve_nominal(displayUnit="kPa") = 1000,
    SSFilIn=0,
    UVFilIn=0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.FixedBoundary sinc(
    redeclare package Medium = MediumRainWater,
    nPorts=1,
    p(displayUnit="kPa") = 900000)
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumRainWater)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=1,
    width=50,
    nperiod=2,
    period=1800,
    startTime=0)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Blocks.Sources.Step step(
    height=1,
    offset=0,
    startTime=1800)
    annotation (Placement(transformation(extent={{-62,30},{-42,50}})));
  Buildings.Fluid.Sources.FixedBoundary bou(
    redeclare package Medium = MediumCityWater,
    nPorts=1,
    p(displayUnit="kPa") = 1110160) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,54})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = MediumRainWater,
    m_flow=8)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation

  connect(processingSystemModel.port_1, senMasFlo.port_a) annotation (Line(
      points={{10,0},{20,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sinc.ports[1], senMasFlo.port_b) annotation (Line(
      points={{50,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pulse.y, processingSystemModel.ValByP) annotation (Line(
      points={{-39,-40},{-20,-40},{-20,-6},{-12,-6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(step.y, processingSystemModel.ValE) annotation (Line(
      points={{-41,40},{-20,40},{-20,6},{-12,6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(bou.ports[1], processingSystemModel.CitWat) annotation (Line(
      points={{0,44},{0,9.8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(processingSystemModel.port_a1, boundary.ports[1]) annotation (Line(
      points={{-10,0},{-40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end ProcessingSystemModel;
