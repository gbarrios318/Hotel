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
    dP_nominal=29800,
    TSet=273.15 + 29.44)                                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-68,22})));
  HeatPumpSection.HeatPump heatPump(redeclare package MediumCW = MediumCW,
      redeclare package MediumDW = MediumDW,
    HeaPumTRef=273.15 + 22.22,
    TSetBoiIn=273.15 + 20,
    mCW_flow_nominal=mCW_flow_nominal,
    mDW_flow_nominal=mDW_flow_nominal,
    HeatPumpVol=25.99029318,
    dp_nominal=1500000,
    dpDW_nominal=1000000,
    Q_flow_nominal=1024283390.2519,
    Q_floSet=819426712.20153)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  ConnectingPackage.ConnectingLoop connectingLoop(redeclare package MediumDW =
        MediumDW,
    mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=1000000)
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  DomesticHotWater.DomesticWaterControls domesticWaterControls(redeclare
      package MediumDW = MediumDW,
    VTan=3,
    hTan=3,
    Q_flow_DWnominal=230000000,
    MassFloKitIn=0.03,
    TBoiSetIn=273.15 + 20,
    dIns=0.05,
    mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=1000000,
    MassFloDomIn=mDW_flow_nominal - 0.03,
    domesticHotWaterSystem(cooWatCon(TDomHotWatSet=358.15)))
    annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
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
    p=100000) annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    fileName="Twb1.txt",
    tableName="table1",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-146,-2},{-126,18}})));
  Buildings.Fluid.Storage.ExpansionVessel exp1(
    redeclare package Medium = MediumDW,
    V_start=1,
    p=100000) annotation (Placement(transformation(extent={{46,-44},{66,-24}})));
  Buildings.Fluid.Storage.ExpansionVessel exp2(
    redeclare package Medium = MediumDW,
    V_start=1,
    p=100000) annotation (Placement(transformation(extent={{130,26},{150,46}})));
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
      points={{-68,12},{-68,4},{0.2,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_a, heatPump.port_b1) annotation (Line(
      points={{-68,31.8},{-68,40},{0,40},{0,16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(supCon.y, coolingTowerSystem.sta) annotation (Line(
      points={{-139,70},{-100,70},{-100,28},{-80,28}},
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
  connect(coolingTowerSystem.port_a, exp.port_a) annotation (Line(
      points={{-68,31.8},{-80,31.8},{-80,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(combiTimeTable.y[1], coolingTowerSystem.TWet) annotation (Line(
      points={{-125,8},{-102,8},{-102,16.2},{-79.2,16.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(exp1.port_a, connectingLoop.port_a2) annotation (Line(
      points={{56,-44},{56,-58},{80,-58},{80,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(exp2.port_a, domesticWaterControls.port_a1) annotation (Line(
      points={{140,26},{140,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-200,-100},{200,100}})),
    experiment(StopTime=100),
    __Dymola_experimentSetupOutput);
end HotelModel;
