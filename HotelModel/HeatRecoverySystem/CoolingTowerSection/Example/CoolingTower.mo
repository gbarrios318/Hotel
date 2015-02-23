within HotelModel.HeatRecoverySystem.CoolingTowerSection.Example;
model CoolingTower
  import HotelModel;
   extends Modelica.Icons.Example;
  extends
    HotelModel.HeatRecoverySystem.CoolingTowerSection.Example.BaseClass.PartialCoolingTower;

  Modelica.Blocks.Sources.Step On(
    height=-1,
    offset=1,
    startTime=1800)  annotation (Placement(transformation(extent={{-80,30},{-60,
            50}})));
  Modelica.Blocks.Sources.Constant TSet(k=273.15 + 29.44)
    annotation (Placement(transformation(extent={{-78,70},{-58,90}})));
  inner Modelica.Fluid.System system(T_ambient=288.15)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.Blocks.Sources.Sine TCWLeachi(
    amplitude=2.59,
    offset=273.15 + 32.03,
    freqHz=1/1800)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T souCW(
    use_T_in=true,
    m_flow=mCW_flow_nominal,
    redeclare package Medium = MediumCW,
    T=273.15 + 29.44,
    nPorts=1) "Source for CW"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Buildings.Fluid.Sources.FixedBoundary sinCW(redeclare package Medium =
               MediumCW, nPorts=1) "Sink for CW" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,0})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TCWLea(redeclare package Medium =
        MediumCW, m_flow_nominal=mCW_flow_nominal)
    annotation (Placement(transformation(extent={{24,-10},{44,10}})));
  Modelica.Blocks.Sources.Sine TWetBulb(
    amplitude=10,
    freqHz=1/1800,
    offset=297.4) "Changing TwetBulb data represented by sine wave"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  HotelModel.HeatRecoverySystem.CoolingTowerSection.CoolingTower coolingTower(
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
    eta=eta)
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
equation
  connect(TCWLeachi.y, souCW.T_in) annotation (Line(
      points={{-79,0},{-72,0},{-72,-16},{-62,-16}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TCWLea.port_b, sinCW.ports[1]) annotation (Line(
      points={{44,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(TWetBulb.y, coolingTower.TWetBul) annotation (Line(
      points={{-39,-50},{-20,-50},{-20,-4},{-14,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(On.y, coolingTower.On) annotation (Line(
      points={{-59,40},{-40,40},{-40,4},{-14,4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TSet.y, coolingTower.TSet) annotation (Line(
      points={{-57,80},{-20,80},{-20,8},{-14,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(souCW.ports[1], coolingTower.port_a_CW) annotation (Line(
      points={{-40,-20},{-30,-20},{-30,0},{-12,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTower.port_b_CW, TCWLea.port_a) annotation (Line(
      points={{8,0},{24,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), experiment(StopTime=360000));
end CoolingTower;
