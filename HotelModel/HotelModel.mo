within HotelModel;
model HotelModel
     replaceable package MediumCW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mCW_flow_nominal=44.16
    "Nominal mass flow rate of condenser water";
  parameter Modelica.SIunits.Pressure dp_nominal=29889.8
    "Nominal pressure difference for condenser water";
       replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for domestic water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal=1.62
    "Nominal mass flow rate for domestic water";
      //The nominal flow rate of water for domestic flow rate is one I gave it
      //Need to look up actual values
   parameter Modelica.SIunits.Pressure dpDW_nominal=29889.8
    "Nominal pressure difference for domestic water";
  replaceable package MediumHW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for hot water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal=44.16
    "Nominal mass flow rate of hot water";
  parameter Modelica.SIunits.Pressure dpHW_nominal=29889.8
    "Nominal pressure difference of hot water";
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
    dP_nominal(displayUnit="bar") = dp_nominal)             annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,30})));
  HeatPumpSection.HeatPump heatPump(
      redeclare package MediumDW = MediumDW,
    HeaPumTRef=273.15 + 22.22,
    TSetBoiIn=273.15 + 20,
    HeatPumpVol=25.99029318,
    dpDW_nominal=dpDW_nominal,
    redeclare package MediumHW = MediumHW,
    mHW_flow_nominal=mHW_flow_nominal,
    dpHW_nominal=dpDW_nominal,
    mDW_flow_nominal=mHW_flow_nominal,
    Q_flow_nominal=1024283.3902519,
    Q_floSet=819426.71220153)
    annotation (Placement(transformation(extent={{20,-12},{40,8}})));
  ConnectingPackage.ConnectingLoop connectingLoop(redeclare package MediumDW =
        MediumDW,
    dpDW_nominal=dpDW_nominal,
    mDW_flow_nominal=mHW_flow_nominal)
    annotation (Placement(transformation(extent={{80,-38},{100,-18}})));
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
    timDel=300,
    TBoi1Set=333.15,
    TBoi2Set=289.26,
    T1Set=291.48,
    T2Set=298.15,
    T3Set=302.59,
    dT=273.7056,
    deaBan=275.15)
    annotation (Placement(transformation(extent={{-160,60},{-140,80}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{160,60},{180,80}})));
  Buildings.Fluid.Storage.ExpansionVessel exp(
    redeclare package Medium = MediumCW,
    V_start=1)
              annotation (Placement(transformation(extent={{-100,44},{-80,64}})));
  Modelica.Blocks.Sources.CombiTimeTable TwetBulbData(
    tableOnFile=true,
    fileName="Twb1.txt",
    tableName="table1",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-160,0},{-140,20}})));
  Buildings.Fluid.Storage.ExpansionVessel exp1(
    redeclare package Medium = MediumDW,
    V_start=1)
              annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Buildings.Fluid.Storage.ExpansionVessel exp2(
    redeclare package Medium = MediumDW,
    V_start=1)
              annotation (Placement(transformation(extent={{130,-10},{150,10}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = MediumCW,
    redeclare package Medium2 = MediumHW,
    m1_flow_nominal=mCW_flow_nominal,
    dp1_nominal=dp_nominal,
    dp2_nominal=dpHW_nominal,
    m2_flow_nominal=mHW_flow_nominal)                      annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,10})));
  Modelica.Blocks.Sources.Constant const(k=819426.71220153)
    annotation (Placement(transformation(extent={{-64,-48},{-44,-28}})));
  Buildings.Fluid.Storage.ExpansionVessel exp3(
    redeclare package Medium = MediumDW,
    V_start=1)
              annotation (Placement(transformation(extent={{-118,-6},{-98,14}})));
equation
  connect(connectingLoop.port_a1, domesticWaterControls.port_a1) annotation (
      Line(
      points={{100,-22},{140,-22},{140,-50}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_b1, domesticWaterControls.port_a2) annotation (
      Line(
      points={{100.2,-34},{100,-34},{100,-60},{150,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(supCon.y, coolingTowerSystem.sta) annotation (Line(
      points={{-139,70},{-120,70},{-120,36},{-102,36}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y, heatPump.Sta) annotation (Line(
      points={{-139,70},{-10,70},{-10,0},{19,0}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y, connectingLoop.sta1) annotation (Line(
      points={{-139,70},{86,70},{86,-16}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.THeaPum, supCon.THeatPump) annotation (Line(
      points={{36,-13},{36,-20},{-180,-20},{-180,76},{-162,76}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticWaterControls.TBoi1, supCon.TBoiDW) annotation (Line(
      points={{161,-54},{180,-54},{180,-80},{-172,-80},{-172,68},{-162,68}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(connectingLoop.m_flow1, supCon.masFloHotWat) annotation (Line(
      points={{94,-17},{94,86},{-168,86},{-168,64},{-162,64}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.Tboi, supCon.TBoiHP) annotation (Line(
      points={{36,9},{36,92},{-176,92},{-176,72},{-162,72}},
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
      points={{10,-50},{10,-60},{40,-60},{40,-34},{80,-34}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp2.port_a, domesticWaterControls.port_a1) annotation (Line(
      points={{140,-10},{140,-50}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(hex.port_b2, heatPump.port_a1) annotation (Line(
      points={{-24,0},{-24,-8},{20.2,-8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(hex.port_a2, heatPump.port_b1) annotation (Line(
      points={{-24,20},{20,20},{20,4}},
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
  connect(heatPump.port_a2, connectingLoop.port_b2) annotation (Line(
      points={{40,4},{80,4},{80,-22}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatPump.port_b2, connectingLoop.port_a2) annotation (Line(
      points={{40,-8},{40,-34},{80,-34}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const.y, heatPump.Q_flow1) annotation (Line(
      points={{-43,-38},{-14,-38},{-14,-4},{18,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(exp3.port_a, heatPump.port_a1) annotation (Line(
      points={{-108,-6},{-108,-8},{20.2,-8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-200,-100},{200,100}})),
    experiment(StopTime=1.0332e+006),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>The purpose of the model is to compare the HVAC system design of a heat recovery system (HR) versus a conventional system that does not use heat recovery and evaluate both systems total energy consumption, peak energy and system stability. </p>
<p>The models and controls are being implemented in Dymola using the Modelica Building Library which is an open source library for building environment simulation. </p>
<p>The specific system being used for experimentation is a the Grand Beach Hotel in Miami Beach, Florida</p>
<h4><span style=\"color:#008000\">System Stages</span></h4>
<p><br><img src=\"modelica://HotelModel/../../HotelData/Stage.PNG\"/></p>
<h4><span style=\"color:#008000\">Unit Conversions</span></h4>
<p>mCW_flow_nominal = 699 GPM [44.10 kg/s]</p>
<p>dp_nominal = 4.335 psi [29889.8 Pa]</p>
<p>mDW_flow_nominal = 25.68 GPM [1.62 kg/s]</p>
<p>dpDW_flow_nominal = 4.335 psi [29889.8 Pa]</p>
<p>mHW_flow_nominal =  699 GPM [44.10 kg/s]</p>
<p>dpHW_flow_nominal = 4.335 psi [29889.8 Pa]</p>
</html>"));
end HotelModel;
