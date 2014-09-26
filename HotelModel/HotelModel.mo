within HotelModel;
model HotelModel
     replaceable package MediumCW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal "Nominal pressure difference";
       replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal
    "Nominal mass flow rate";
      //The nominal flow rate of water for domestic flow rate is one I gave it
      //Need to look up actual values
   parameter Modelica.SIunits.Pressure dpDW_nominal
    "Nominal pressure difference";
  CoolingTowerSection.CoolingTowerSystem coolingTowerSystem(
    redeclare package MediumCW = MediumCW,
    P_nominal=2200,
    dTCW_nominal=273.15 - 12.22,
    dTApp_nominal=273.15 - 16.11,
    v_flow_rate={0.0441},
    eta={1},
    Motor_eta={0.85},
    Hydra_eta={1},
    GaiPi=1,
    tIntPi=1,
    mCW_flow_nominal=44.16,
    TWetBul_nominal=298.706,
    dP_nominal=29800,
    TSet=304.26)                                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,30})));
  HeatPumpSection.HeatPump heatPump(redeclare package MediumCW = MediumCW,
      redeclare package MediumDW = MediumDW,
    Q_flow_nominal=1024283390.2519,
    Q_floSet=819426712.20153,
    HeatPumpVol=2.599029318,
    HeaPumTRef=273.15 + 22.22,
    TSetBoiIn=273.15 + 20,
    mWater_flow_nominal=44.16,
    mDW_flow_nominal=12.62,
    MasFloHeaPumIn=44.16,
    dp_nominal=1500000,
    dpDW_nominal=1000000)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  ConnectingPackage.ConnectingLoop connectingLoop(redeclare package MediumDW =
        MediumDW,
    mDW_flow_nominal=12.62,
    dpDW_nominal=1000000)
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  DomesticHotWater.DomesticWaterControls domesticWaterControls(redeclare
      package MediumDW = MediumDW,
    VTan=3,
    hTan=3,
    Q_flow_DWnominal=230000000,
    MassFloDomIn=0.16,
    MassFloKitIn=0.03,
    TBoiSetIn=273.15 + 20,
    dIns=0.05,
    mDW_flow_nominal=12.62,
    dpDW_nominal=1000000)
    annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
  Control.SupervisoryControl supCon(
    timDel=10,
    TBoi1Set=333.15,
    TBoi2Set=289.26,
    T1Set=291.48,
    T2Set=298.15,
    T3Set=302.59,
    dT=273.7056,
    deaBan=275.15,
    masFloSet=700)
    annotation (Placement(transformation(extent={{-160,60},{-140,80}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        "C:/Users/German/Documents/HotelProject/HotelModel/HotelInput.mos")
    annotation (Placement(transformation(extent={{-160,14},{-140,34}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{160,60},{180,80}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{-120,14},{-100,34}})));
  Modelica.Blocks.Sources.Pulse pulse(period=3600)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
equation
  connect(heatPump.port_a2, connectingLoop.port_b2) annotation (Line(
      points={{20,16},{80,16},{80,-4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatPump.port_b2, connectingLoop.port_a2) annotation (Line(
      points={{20,4},{20,-16},{80,-16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_a1, domesticWaterControls.port_a1) annotation (
      Line(
      points={{100,-4},{140,-4},{140,-30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_b1, domesticWaterControls.port_a2) annotation (
      Line(
      points={{100.2,-16},{100,-16},{100,-50},{150,-50},{150,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_b, heatPump.port_a1) annotation (Line(
      points={{-70,20},{-70,4},{0.2,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_a, heatPump.port_b1) annotation (Line(
      points={{-70,39.8},{-70,40},{0,40},{0,16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(supCon.y, coolingTowerSystem.sta) annotation (Line(
      points={{-139,70},{-100,70},{-100,36},{-82,36}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y, heatPump.Sta) annotation (Line(
      points={{-139,70},{-20,70},{-20,12},{-1,12}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y, connectingLoop.sta1) annotation (Line(
      points={{-139,70},{86,70},{86,2}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.THeaPum, supCon.THeatPump) annotation (Line(
      points={{16,-1},{16,-20},{-180,-20},{-180,76},{-162,76}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticWaterControls.TBoi1, supCon.TBoiDW) annotation (Line(
      points={{161,-34},{180,-34},{180,-80},{-172,-80},{-172,68},{-162,68}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(connectingLoop.m_flow1, supCon.masFloHotWat) annotation (Line(
      points={{94,1},{94,86},{-168,86},{-168,64},{-162,64}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.Tboi, supCon.TBoiHP) annotation (Line(
      points={{16,21},{16,92},{-176,92},{-176,72},{-162,72}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-140,24},{-110,24}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.TWetBul, coolingTowerSystem.TWet) annotation (Line(
      points={{-110,24},{-94,24},{-94,24.2},{-81.2,24.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(pulse.y, heatPump.InSig1) annotation (Line(
      points={{-59,-50},{-20,-50},{-20,8},{-2,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-200,-100},{200,100}})));
end HotelModel;
