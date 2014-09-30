within HotelModel;
model HotelModel
     replaceable package MediumCW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mCW_flow_nominal=44.16
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=1
    "Nominal pressure difference";
       replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal=12.62
    "Nominal mass flow rate";
      //The nominal flow rate of water for domestic flow rate is one I gave it
      //Need to look up actual values
   parameter Modelica.SIunits.Pressure dpDW_nominal=1
    "Nominal pressure difference";
  replaceable package MediumHW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal=44.16
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dpHW_nominal=1
    "Nominal pressure difference";
  CoolingTowerSection.CoolingTowerSystem coolingTowerSystem(
    redeclare package MediumCW = MediumCW,
    P_nominal=2200,
    Motor_eta={0.85},
    Hydra_eta={1},
    GaiPi=1,
    mCW_flow_nominal=mCW_flow_nominal,
    v_flow_rate={0,0.1,0.3,0.6,1},
    eta={0,0.1^3,0.3^3,0.6^3,1},
    tIntPi=60,
    dTCW_nominal(displayUnit="degC") = 5.56,
    dTApp_nominal(displayUnit="degC") = 3.89,
    TWetBul_nominal=273.15 + 25.55,
    TSet=273.15 + 29.44,
    dP_nominal=29800)                                       annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,30})));
  HeatPumpSection.HeatPump heatPump(
      redeclare package MediumDW = MediumDW,
    HeaPumTRef=273.15 + 22.22,
    TSetBoiIn=273.15 + 20,
    mDW_flow_nominal=mDW_flow_nominal,
    HeatPumpVol=25.99029318,
    Q_flow_nominal=1024283390.2519,
    Q_floSet=819426712.20153,
    redeclare package MediumCW = MediumHW,
    mCW_flow_nominal=mHW_flow_nominal,
    dp_nominal=dpHW_nominal,
    dpDW_nominal=dpDW_nominal)
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  ConnectingPackage.ConnectingLoop connectingLoop(redeclare package MediumDW =
        MediumDW,
    mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=1000000)
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  DomesticHotWater.DomesticWaterControls domesticWaterControls(redeclare
      package MediumDW = MediumDW,
    VTan=3,
    hTan=3,
    Q_flow_DWnominal=230000000,
    MassFloKitIn=0.03,
    TBoiSetIn=273.15 + 20,
    dIns=0.05,
    mDW_flow_nominal=mDW_flow_nominal,
    MassFloDomIn=mDW_flow_nominal - 0.03,
    domesticHotWaterSystem(cooWatCon(TDomHotWatSet=358.15)),
    dpDW_nominal=dpDW_nominal)
    annotation (Placement(transformation(extent={{140,-60},{160,-40}})));
  Control.SupervisoryControl supCon(
    masFloSet=700,
    TBoi1Set=333.15,
    TBoi2Set=289.26,
    T1Set=291.48,
    T2Set=298.15,
    T3Set=302.59,
    dT=273.7056,
    deaBan=275.15,
    timDel=300)
    annotation (Placement(transformation(extent={{-160,60},{-140,80}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{160,60},{180,80}})));
  Buildings.Fluid.Storage.ExpansionVessel exp(
    redeclare package Medium = MediumCW,
    V_start=1,
    p=100000) annotation (Placement(transformation(extent={{-100,44},{-80,64}})));
  Modelica.Blocks.Sources.CombiTimeTable TwetBulbData(
    tableOnFile=true,
    fileName="Twb1.txt",
    tableName="table1",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-160,0},{-140,20}})));
  Buildings.Fluid.Storage.ExpansionVessel exp1(
    redeclare package Medium = MediumDW,
    V_start=1,
    p=100000) annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Buildings.Fluid.Storage.ExpansionVessel exp2(
    redeclare package Medium = MediumDW,
    V_start=1,
    p=100000) annotation (Placement(transformation(extent={{130,-10},{150,10}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = MediumCW,
    redeclare package Medium2 = MediumHW,
    m1_flow_nominal=mCW_flow_nominal,
    m2_flow_nominal=mDW_flow_nominal,
    dp1_nominal=dp_nominal,
    dp2_nominal=dpHW_nominal)                              annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,10})));
  Modelica.Blocks.Sources.CombiTimeTable LoadData(
    tableOnFile=true,
    fileName="Twb1.txt",
    tableName="table1",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
equation
  connect(connectingLoop.port_a1, domesticWaterControls.port_a1) annotation (
      Line(
      points={{100,-24},{140,-24},{140,-50}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_b1, domesticWaterControls.port_a2) annotation (
      Line(
      points={{100.2,-36},{100,-36},{100,-60},{150,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(supCon.y, coolingTowerSystem.sta) annotation (Line(
      points={{-139,70},{-120,70},{-120,36},{-102,36}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y, heatPump.Sta) annotation (Line(
      points={{-139,70},{-10,70},{-10,-8},{19,-8}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y, connectingLoop.sta1) annotation (Line(
      points={{-139,70},{86,70},{86,-18}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.THeaPum, supCon.THeatPump) annotation (Line(
      points={{36,-21},{36,-20},{-180,-20},{-180,76},{-162,76}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticWaterControls.TBoi1, supCon.TBoiDW) annotation (Line(
      points={{161,-54},{180,-54},{180,-80},{-172,-80},{-172,68},{-162,68}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(connectingLoop.m_flow1, supCon.masFloHotWat) annotation (Line(
      points={{94,-19},{94,86},{-168,86},{-168,64},{-162,64}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.Tboi, supCon.TBoiHP) annotation (Line(
      points={{36,1},{36,92},{-176,92},{-176,72},{-162,72}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(coolingTowerSystem.port_a, exp.port_a) annotation (Line(
      points={{-90,39.8},{-90,44}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(TwetBulbData.y[1], coolingTowerSystem.TWet) annotation (Line(
      points={{-139,10},{-120,10},{-120,24.2},{-101.2,24.2}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(exp1.port_a, connectingLoop.port_a2) annotation (Line(
      points={{10,-50},{10,-60},{40,-60},{40,-36},{80,-36}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp2.port_a, domesticWaterControls.port_a1) annotation (Line(
      points={{140,-10},{140,-50}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(hex.port_b2, heatPump.port_a1) annotation (Line(
      points={{-24,0},{-24,-16},{20.2,-16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(hex.port_a2, heatPump.port_b1) annotation (Line(
      points={{-24,20},{20,20},{20,-4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_a, hex.port_b1) annotation (Line(
      points={{-90,39.8},{-36,39.8},{-36,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_b, hex.port_a1) annotation (Line(
      points={{-90,20},{-90,0},{-36,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(LoadData.y[1], heatPump.Q_flow1) annotation (Line(
      points={{-79,-50},{-40,-50},{-40,-12},{18,-12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.port_a2, connectingLoop.port_b2) annotation (Line(
      points={{40,-4},{80,-4},{80,-24}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatPump.port_b2, connectingLoop.port_a2) annotation (Line(
      points={{40,-16},{40,-36},{80,-36}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-200,-100},{200,100}})),
    experiment(StopTime=100),
    __Dymola_experimentSetupOutput);
end HotelModel;
