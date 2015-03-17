within HotelModel.HeatRecoverySystem.CoolingTowerSection.Example;
model CoolingTowerSystem
  import HotelModel;
  extends Modelica.Icons.Example;
  extends
    HotelModel.HeatRecoverySystem.CoolingTowerSection.Example.BaseClass.PartialCoolingTower;
  parameter Modelica.SIunits.Temperature TSet = 273.15+20
    "Temperture set point for CW water";
  parameter Real Motor_eta[:] = {1} "Motor efficiency";
  parameter Real Hydra_eta[:] = {1} "Hydraulic efficiency";
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  parameter Modelica.SIunits.MassFlowRate m_RWflow_nominal
    "Nominal mass flow rate";
  Modelica.Blocks.Sources.Sine TCWLeachi(
    freqHz=1/86400,
    amplitude=2.59,
    offset=273.15 + 32.03)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant TWetBul(k=273.15 + 25)   annotation (Placement(transformation(extent={{-80,-40},
            {-60,-20}})));
  inner Modelica.Fluid.System system(T_ambient=288.15)
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TCWLea(redeclare package Medium =
        MediumCW, m_flow_nominal=mCW_flow_nominal)
    annotation (Placement(transformation(extent={{38,-10},{58,10}})));
  Buildings.Fluid.Sources.FixedBoundary sinCW(redeclare package Medium =
               MediumCW, nPorts=1) "Sink for CW" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={86,0})));

  HotelModel.HeatRecoverySystem.CoolingTowerSection.CoolingTowerSystem
    cooTow(
    redeclare package MediumCW = MediumCW,
    P_nominal=P_nominal,
    dTCW_nominal=dTCW_nominal,
    dTApp_nominal=dTApp_nominal,
    TWetBul_nominal=TWetBul_nominal,
    dP_nominal=dP_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    GaiPi=GaiPi,
    tIntPi=tIntPi,
    v_flow_rate=v_flow_rate,
    eta=eta,
    TSet=TSet,
    Motor_eta=Motor_eta,
    Hydra_eta=Hydra_eta,
    redeclare package MediumRainWater = MediumRainWater,
    m_RWflow_nominal=m_RWflow_nominal,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.CombiTimeTable sta(table=[0.0, 1; 40, 2; 80, 3; 120,
        4; 160, 5; 200, 6; 240, 7])
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Buildings.Fluid.Sources.Boundary_pT bou(
    use_T_in=true,
    redeclare package Medium = MediumCW,
    nPorts=1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = MediumRainWater,
    use_m_flow_in=true)
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=7.89,
    duration=900,
    startTime=900)
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
equation
  connect(TCWLea.port_b, sinCW.ports[1]) annotation (Line(
      points={{58,0},{76,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sta.y[1], realToInteger.u) annotation (Line(
      points={{-79,50},{-62,50}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TCWLeachi.y, bou.T_in) annotation (Line(
      points={{-79,10},{-72,10},{-72,4},{-62,4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(bou.ports[1], cooTow.port_a) annotation (Line(
      points={{-40,0},{-20,0},{-20,20},{0,20},{0,9.8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(cooTow.port_b, TCWLea.port_a) annotation (Line(
      points={{0,-10},{0,-20},{20,-20},{20,0},{38,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(TWetBul.y, cooTow.TWet) annotation (Line(
      points={{-59,-30},{-20,-30},{-20,-5.8},{-11.2,-5.8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(realToInteger.y, cooTow.sta) annotation (Line(
      points={{-39,50},{-28,50},{-28,6},{-12,6}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(boundary.ports[1], cooTow.port_a1) annotation (Line(
      points={{-30,-70},{-16,-70},{-16,0},{-10.2,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary.m_flow_in, ramp.y) annotation (Line(
      points={{-50,-62},{-60,-62},{-60,-70},{-69,-70}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end CoolingTowerSystem;
