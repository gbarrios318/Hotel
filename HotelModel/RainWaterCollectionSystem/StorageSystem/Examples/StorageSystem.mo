within HotelModel.RainWaterCollectionSystem.StorageSystem.Examples;
model StorageSystem "Storage System example"
 extends Modelica.Icons.Example;
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  StorageSystemModel storageSystemModel(
    redeclare package MediumRainWater = MediumRainWater,
    m_RWflow_nominal=7.89,
    dpRW_nominal(displayUnit="kPa") = 1103160,
    ColTanVol=10,
    dp_OFnominal(displayUnit="kPa") = 1000,
    m_OFflow_nominal=0.5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = MediumRainWater,
    use_m_flow_in=true)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=2000,
    freqHz=1/3600,
    offset=3000)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Buildings.Fluid.Sources.FixedBoundary bou(redeclare package Medium =
        MediumRainWater, nPorts=1)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumRainWater)
    annotation (Placement(transformation(extent={{20,-6},{32,6}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Buildings.Fluid.Movers.FlowMachine_m_flow pum(redeclare package Medium =
        MediumRainWater, m_flow_nominal=5.0)
    "Pump to simulate control of water to the sinc"
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
equation

  connect(storageSystemModel.port_a1, boundary.ports[1]) annotation (Line(
      points={{-10,0},{-40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary.m_flow_in, sine.y) annotation (Line(
      points={{-60,8},{-64,8},{-64,0},{-69,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senMasFlo.port_a, storageSystemModel.port_b1) annotation (Line(
      points={{20,0},{10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(bou.ports[1], pum.port_b) annotation (Line(
      points={{70,0},{62,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pum.port_a, senMasFlo.port_b) annotation (Line(
      points={{42,0},{32,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end StorageSystem;
