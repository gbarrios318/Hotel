within HotelModel.RainWaterCollectionSystem.UsageSystem.Examples;
model UsageSystemModel "Example of the usage system being implemented"
  import HotelModel;
 extends Modelica.Icons.Example;
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  HotelModel.RainWaterCollectionSystem.UsageSystem.UsageSystemModel
    usageSystemModel(
    redeclare package MediumRainWater = MediumRainWater,
    StoTanVol=1,
    m_RWflow_nominal=7.89,
    dpRW_nominal(displayUnit="kPa") = 11682000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T sou(
    nPorts=1,
    redeclare package Medium = MediumRainWater,
    use_m_flow_in=true)
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Buildings.Fluid.Sources.FixedBoundary sinc(nPorts=1, redeclare package Medium
      = MediumRainWater)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloOUT(redeclare package Medium =
        MediumRainWater)
    "mass flow rate of the water going out of the usage system"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloIN(redeclare package Medium =
        MediumRainWater) "mass flow rate going into the usage system"
    annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=2000,
    freqHz=1/3600,
    offset=3000,
    startTime=0)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(usageSystemModel.CooTow, senMasFloOUT.port_a) annotation (Line(
      points={{10,0},{20,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sinc.ports[1], senMasFloOUT.port_b) annotation (Line(
      points={{60,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sou.ports[1], senMasFloIN.port_a) annotation (Line(
      points={{-50,20},{-46,20},{-46,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(usageSystemModel.port_a1, senMasFloIN.port_b) annotation (Line(
      points={{-10,0},{-26,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sou.m_flow_in, sine.y) annotation (Line(
      points={{-70,28},{-74,28},{-74,70},{-79,70}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(graphics));
end UsageSystemModel;
