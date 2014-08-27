within HotelModel.CoolingTowerSection.Example;
model CoolingTowerSystem
  import HotelModel;
  extends Modelica.Icons.Example;
  extends HotelModel.CoolingTowerSection.Example.BaseClass.PartialCoolingTower;
  parameter Modelica.SIunits.Temperature TSet = 273.15+20
    "Temperture set point for CW water";
  parameter Real Motor_eta[:] = {1} "Motor efficiency";
  parameter Real Hydra_eta[:] = {1} "Hydraulic efficiency";

  Modelica.Blocks.Sources.Sine TCWLeachi(
    freqHz=1/86400,
    amplitude=2.59,
    offset=273.15 + 32.03)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Buildings.Fluid.Sources.MassFlowSource_T souCW(
    use_T_in=true,
    m_flow=mCW_flow_nominal,
    redeclare package Medium = MediumCW,
    T=273.15 + 29.44,
    nPorts=1) "Source for CW"
    annotation (Placement(transformation(extent={{-56,-10},{-36,10}})));
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
  HotelModel.CoolingTowerSection.CoolingTowerSystem cooTow(
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
    Hydra_eta=Hydra_eta)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.CombiTimeTable sta(table=[0.0, 1; 40, 2; 80, 3; 120,
        4; 160, 5; 200, 6; 240, 7])
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
equation
  connect(TCWLeachi.y, souCW.T_in) annotation (Line(
      points={{-79,10},{-64,10},{-64,4},{-58,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TCWLea.port_b, sinCW.ports[1]) annotation (Line(
      points={{58,0},{76,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TWetBul.y, cooTow.TWet) annotation (Line(
      points={{-59,-30},{-20,-30},{-20,-5.8},{-11.2,-5.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cooTow.port_b, TCWLea.port_a) annotation (Line(
      points={{10,0},{38,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sta.y[1], realToInteger.u) annotation (Line(
      points={{-79,50},{-62,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realToInteger.y, cooTow.sta) annotation (Line(
      points={{-39,50},{-28,50},{-28,6},{-12,6}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(souCW.ports[1], cooTow.port_a) annotation (Line(
      points={{-36,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end CoolingTowerSystem;
