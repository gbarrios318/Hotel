within HotelModel.HotelSection.Control.Example;
model TestAddColdWater
  package Water = Buildings.Media.ConstantPropertyLiquidWater;
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=1
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
  Buildings.Fluid.Sources.Boundary_pT bou(
    nPorts=1,
    redeclare package Medium = Water,
    use_T_in=true)
    annotation (Placement(transformation(extent={{-152,-10},{-132,10}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(nPorts=1, redeclare package Medium
      = Water)
    annotation (Placement(transformation(extent={{148,-10},{128,10}})));
  Buildings.Fluid.Movers.FlowMachine_m_flow fan(redeclare package Medium =
        Water, m_flow_nominal=mWater_flow_nominal)
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  Buildings.Fluid.Movers.FlowMachine_m_flow fan1(redeclare package Medium =
        Water, m_flow_nominal=mWater_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-28,88})));
  Buildings.Fluid.Sources.Boundary_pT bou2(
    nPorts=1,
    redeclare package Medium = Water,
    T=293.15) annotation (Placement(transformation(extent={{36,152},{16,172}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Water, m_flow_nominal=mWater_flow_nominal)
    annotation (Placement(transformation(extent={{14,-10},{34,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Water) annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        Water) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-28,144})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo2(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Sources.Ramp ramp(height=20, duration=500)
    annotation (Placement(transformation(extent={{70,82},{90,102}})));
  Modelica.Blocks.Sources.Constant const(k=20)
    annotation (Placement(transformation(extent={{70,116},{90,136}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=10,
    offset=10,
    freqHz=0.005)
    annotation (Placement(transformation(extent={{70,50},{90,70}})));
  Modelica.Blocks.Sources.Step step(
    offset=273.15 + 60,
    startTime=500,
    height=-10)
    annotation (Placement(transformation(extent={{-190,-6},{-170,14}})));
  CoolingWaterControl CooWatCon(kPCon=0.5, TDomHotWatSet=316.48)
    annotation (Placement(transformation(extent={{-92,78},{-72,98}})));
equation

  connect(bou1.ports[1], fan.port_b) annotation (Line(
      points={{128,0},{116,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fan1.port_b, senTem.port_a) annotation (Line(
      points={{-28,78},{-28,0},{14,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, senMasFlo.port_a) annotation (Line(
      points={{34,0},{52,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo.port_b, fan.port_a) annotation (Line(
      points={{72,0},{96,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou2.ports[1], senMasFlo1.port_a) annotation (Line(
      points={{16,162},{-28,162},{-28,154}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo1.port_b, fan1.port_a) annotation (Line(
      points={{-28,134},{-28,98}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], senMasFlo2.port_a) annotation (Line(
      points={{-132,0},{-120,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo2.port_b, senTem.port_a) annotation (Line(
      points={{-100,0},{14,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sine.y, fan.m_flow_in) annotation (Line(
      points={{91,60},{105.8,60},{105.8,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(bou.T_in, step.y) annotation (Line(
      points={{-154,4},{-169,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fan1.m_flow_in, CooWatCon.y) annotation (Line(
      points={{-40,88.2},{-56,88.2},{-56,88},{-71,88}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senMasFlo.m_flow, CooWatCon.masFlow) annotation (Line(
      points={{62,11},{62,54},{-106,54},{-106,84},{-94,84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senTem.T, CooWatCon.Tem) annotation (Line(
      points={{24,11},{24,42},{-122,42},{-122,92},{-94,92}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-200,-200},{200,200}})));
end TestAddColdWater;
