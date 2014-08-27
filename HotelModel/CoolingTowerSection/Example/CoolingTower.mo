within HotelModel.CoolingTowerSection.Example;
model CoolingTower
  import HotelModel;
   extends Modelica.Icons.Example;
  extends HotelModel.CoolingTowerSection.Example.BaseClass.PartialCoolingTower;

  HotelModel.CoolingTowerSection.CoolingTower cooTow(
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
    eta=eta) annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Modelica.Blocks.Sources.Step On(
    height=-1,
    offset=1,
    startTime=43200) annotation (Placement(transformation(extent={{-80,30},{-60,
            50}})));
  Modelica.Blocks.Sources.Constant TSet(k=273.15 + 29.44)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Sources.Constant TWetBul(k=273.15 + 25)   annotation (Placement(transformation(extent={{-80,-60},
            {-60,-40}})));
  inner Modelica.Fluid.System system(T_ambient=288.15)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.Blocks.Sources.Sine TCWLeachi(
    freqHz=1/86400,
    amplitude=2.59,
    offset=273.15 + 32.03)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T souCW(
    nPorts=1,
    use_T_in=true,
    m_flow=mCW_flow_nominal,
    redeclare package Medium = MediumCW,
    T=273.15 + 29.44) "Source for CW"
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
equation
  connect(On.y, cooTow.On) annotation (Line(
      points={{-59,40},{-38,40},{-38,4},{-14,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSet.y, cooTow.TSet) annotation (Line(
      points={{-59,80},{-24,80},{-24,8},{-14,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TWetBul.y, cooTow.TWetBul) annotation (Line(
      points={{-59,-50},{-22,-50},{-22,-4},{-14,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TCWLeachi.y, souCW.T_in) annotation (Line(
      points={{-79,0},{-72,0},{-72,-16},{-62,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(souCW.ports[1], cooTow.port_a_CW) annotation (Line(
      points={{-40,-20},{-30,-20},{-30,0},{-12,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cooTow.port_b_CW, TCWLea.port_a) annotation (Line(
      points={{8,0},{24,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TCWLea.port_b, sinCW.ports[1]) annotation (Line(
      points={{44,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), experiment(StopTime=360000));
end CoolingTower;
