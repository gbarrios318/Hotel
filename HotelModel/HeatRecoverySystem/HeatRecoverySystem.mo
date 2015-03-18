within HotelModel.HeatRecoverySystem;
model HeatRecoverySystem "Full heat recovery set as a model"

//Parameters for the Cooling Tower System
     replaceable package MediumCW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.Power P_nominal
    "Nominal cooling tower component power (at y=1)";
  parameter Modelica.SIunits.TemperatureDifference dTCW_nominal
    "Temperature difference between the outlet and inlet of the module";
  parameter Modelica.SIunits.TemperatureDifference dTApp_nominal
    "Nominal approach temperature";
  parameter Modelica.SIunits.Temperature TWetBul_nominal
    "Nominal wet bulb temperature";
  parameter Modelica.SIunits.Pressure dp_nominal
    "Pressure difference between the outlet and inlet of the module ";
  parameter Modelica.SIunits.MassFlowRate mCW_flow_nominal
    "Nominal mass flow rate";
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  parameter Modelica.SIunits.MassFlowRate mRW_flow_nominal
    "Nominal mass flow rate";
  parameter Real GaiPi "Gain of the component PI controller";
  parameter Real tIntPi "Integration time of the component PI controller";
  parameter Real v_flow_rate[:] "Volume flow rate";
  parameter Real eta[:] "Fan efficiency";
  parameter Modelica.SIunits.Temperature TSet
    "Temperature set point for CW water leaving the cooling tower";
    parameter Real Motor_eta[:] "Motor efficiency";
    parameter Real Hydra_eta[:] "Hydraulic efficiency";

//Parameters for the HeatPump section

replaceable package MediumHW =
        Buildings.Media.ConstantPropertyLiquidWater
    "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dpHW_nominal
    "Nominal pressure difference";
replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal
    "Nominal mass flow rate";
    //Nominal flow rate is value I gave, probably different
   parameter Modelica.SIunits.Pressure dpDW_nominal
    "Nominal pressure difference";
  parameter Modelica.SIunits.Power Q_flow_nominal "Nominal heat flow";
  parameter Modelica.SIunits.Volume HeatPumpVol "Volume of the Heat Pump";
  parameter Modelica.SIunits.Temperature HeaPumTRef
    "Reference tempearture of heat pump";
  parameter Modelica.SIunits.Temp_K TSetBoiIn "Set temperature for boiler";

// Parameters for the Domestic Hot water

    parameter Modelica.SIunits.Volume VTan "Volume of the tank";
    parameter Modelica.SIunits.Height hTan "Height of the tank";
    parameter Modelica.SIunits.Thickness dIns "Thickness of the insulation";
    parameter Modelica.SIunits.HeatFlowRate Q_flow_DWnominal
    "Nominal heat flow rate";
    parameter Modelica.SIunits.MassFlowRate MassFloDomIn
    "Mass flow rate of water going into domestic water usage";
    parameter Modelica.SIunits.MassFlowRate MassFloKitIn
    "Mass flow rate of water going to kitchen";
    parameter Modelica.SIunits.Temp_K TBoiSetIn "Boiler setting";

//Connecting loop parameters just used the same as the domestic water

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{150,70},{170,90}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = MediumCW,
    redeclare package Medium2 = MediumHW,
    m1_flow_nominal=mCW_flow_nominal,
    dp2_nominal=dpHW_nominal,
    m2_flow_nominal=mHW_flow_nominal,
    dp1_nominal=dp_nominal)                                annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-38,2})));
  Buildings.Fluid.Storage.ExpansionVessel exp3(
    redeclare package Medium = MediumCW,
    V_start=1)
              annotation (Placement(transformation(extent={{-12,-24},{-4,-16}})));
  Buildings.Fluid.Storage.ExpansionVessel exp1(
    redeclare package Medium = MediumCW,
    V_start=1)
              annotation (Placement(transformation(extent={{68,-22},{76,-14}})));
  Buildings.Fluid.Storage.ExpansionVessel exp4(
    redeclare package Medium = MediumCW,
    V_start=1)
              annotation (Placement(transformation(extent={{-82,40},{-74,48}})));
  Modelica.Blocks.Sources.CombiTimeTable KitHotWatDem(
    fileName="Twb1.txt",
    tableName="table1",
    tableOnFile=false,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table=[0,0.21; 3600,0.21; 7200,0.21; 10800,0.21; 14400,0.21; 18000,0.21;
        21600,0.21; 25200,0.21; 28800,0.21; 32400,0.21; 36000,0.21; 39600,1.15;
        43200,0.21; 46800,0.21; 50400,0.21; 54000,0.21; 57600,0.21; 61200,0.21;
        64800,0.21; 68400,1.15; 72000,0.21; 75600,0.21; 79200,0.21; 82800,0.21;
        86400,0.21],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{62,-68},{70,-60}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=if supCon.y > 4 then
        max((connectingLoop.senTem.T - 273.15 - 20)*(connectingLoop.MasFloRatCloWat.m_flow)
        *4.2*(1 - heatPump.BypValPos)/((connectingLoop.MasFloRatCloWat.m_flow)*
        (60 - 20)*4.2 + 0.00001), 0) else 0)
    annotation (Placement(transformation(extent={{120,42},{140,62}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=if supCon.y > 4
         then max((connectingLoop.senTem.T - 273.15 - 20)*(connectingLoop.MasFloRatCloWat.m_flow)
        *4.2*(1 - heatPump.BypValPos), 0) else 0)
    annotation (Placement(transformation(extent={{120,62},{140,82}})));
  Buildings.Fluid.Storage.ExpansionVessel exp2(
    redeclare package Medium = MediumCW, V_start=10)
              annotation (Placement(transformation(extent={{132,8},{140,16}})));
  Modelica.Blocks.Sources.CombiTimeTable GueRooDomWatDem(
    fileName="Twb1.txt",
    tableName="table1",
    tableOnFile=false,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,0.0; 3600,0.0; 7200,0.0; 10800,0.0; 14400,0.0; 18000,0; 21600,0;
        25200,1.5; 28800,1.5; 32400,1.5; 36000,0; 39600,0; 43200,0.0; 46800,0.0;
        50400,0.0; 54000,0; 57600,0; 61200,1.5; 64800,1.5; 68400,1.5; 72000,0.0;
        75600,0.0; 79200,0.0; 82800,0.0; 86400,0.0])
    annotation (Placement(transformation(extent={{60,-44},{68,-36}})));
  CoolingTowerSection.CoolingTowerSystem coolingTowerSystem(
    redeclare package MediumCW = MediumCW,
    P_nominal=P_nominal,
    dTCW_nominal=dTCW_nominal,
    dTApp_nominal=TWetBul_nominal,
    TWetBul_nominal=TWetBul_nominal,
    dp_nominal=dp_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    redeclare package MediumRainWater = MediumRainWater,
    mRW_flow_nominal=mRW_flow_nominal,
    GaiPi=GaiPi,
    tIntPi=tIntPi,
    v_flow_rate=v_flow_rate,
    eta=eta,
    TSet=TSet,
    Motor_eta=Motor_eta,
    Hydra_eta=Hydra_eta)
    annotation (Placement(transformation(extent={{-88,6},{-68,26}})));
  HeatPumpSection.HeatPump heatPump(
    redeclare package MediumHW = MediumHW,
    mHW_flow_nominal=mHW_flow_nominal,
    dpHW_nominal=dpHW_nominal,
    redeclare package MediumDW = MediumDW,
    mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=dpDW_nominal,
    Q_flow_nominal=Q_flow_nominal,
    HeatPumpVol=HeatPumpVol,
    HeaPumTRef=HeaPumTRef,
    TSetBoiIn=TSetBoiIn)
    annotation (Placement(transformation(extent={{10,14},{30,-6}})));
  Control.SupervisoryControl supCon
    annotation (Placement(transformation(extent={{-156,50},{-136,70}})));
  Load.Load TDryBul
    annotation (Placement(transformation(extent={{-56,-56},{-48,-44}})));
  ConnectingPackage.ConnectingLoop connectingLoop(
    redeclare package MediumDW = MediumDW,
    mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=dpDW_nominal)
    annotation (Placement(transformation(extent={{92,-28},{112,-8}})));
  DomesticHotWater.DomesticWaterControls domesticWaterControls(
    redeclare package MediumDW = MediumDW,
    mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=dpDW_nominal,
    VTan=VTan,
    hTan=hTan,
    dIns=dIns,
    Q_flow_DWnominal=Q_flow_DWnominal,
    MassFloDomIn=MassFloDomIn,
    MassFloKitIn=MassFloKitIn,
    TBoiSetIn=TBoiSetIn)
    annotation (Placement(transformation(extent={{146,-22},{166,-2}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus
    annotation (Placement(transformation(extent={{-210,-50},{-190,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumRainWater) "fluid connector from the rain water collection"
    annotation (Placement(transformation(extent={{-210,30},{-190,50}})));
  Modelica.Fluid.Interfaces.FluidPort_a CitWat1(redeclare package Medium =
        MediumDW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b DomHotWat1(redeclare package Medium =
        MediumDW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{190,-70},{210,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b KitWat1(redeclare package Medium =
        MediumDW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{190,50},{210,70}})));
equation
  connect(exp4.port_a,hex. port_b1) annotation (Line(
      points={{-78,40},{-78,32},{-44,32},{-44,12}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_a,hex. port_b1) annotation (Line(
      points={{-78,25.8},{-78,32},{-44,32},{-44,12}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_b,hex. port_a1) annotation (Line(
      points={{-78,6},{-78,-28},{-44,-28},{-44,-8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.TWet,weaBus. TWetBul) annotation (Line(
      points={{-89.2,10.2},{-144,10.2},{-144,10},{-200,10},{-200,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TDryBul.TDryBul,weaBus. TDryBul) annotation (Line(
      points={{-56.8,-50},{-108,-50},{-108,-40},{-200,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TDryBul.Loa,heatPump. Q_flow1) annotation (Line(
      points={{-47.6,-50},{8,-50},{8,6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y,coolingTowerSystem. sta) annotation (Line(
      points={{-135,60},{-118,60},{-118,22},{-90,22}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y,heatPump. Sta) annotation (Line(
      points={{-135,60},{-8,60},{-8,2},{9,2}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.port_b1,hex. port_a2) annotation (Line(
      points={{10,10},{10,32},{-32,32},{-32,12}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(hex.port_b2,heatPump. port_a1) annotation (Line(
      points={{-32,-8},{-32,-28},{10,-28},{10,-2}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp3.port_a,heatPump. port_a1) annotation (Line(
      points={{-8,-24},{-8,-28},{10,-28},{10,-2}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatPump.THeaPum,supCon. THeatPump) annotation (Line(
      points={{26,15},{26,80},{-168,80},{-168,72},{-158,72}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.BypValPos,supCon. BypasValPos) annotation (Line(
      points={{24,-7},{24,-62},{-102,-62},{-102,52},{-134,52}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.Tboi,supCon. TBoiHP) annotation (Line(
      points={{26,-7},{26,-68},{-168,-68},{-168,48},{-158,48}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.port_b2,connectingLoop. port_a2) annotation (Line(
      points={{30,-2},{30,-28},{92,-28},{92,-24}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp1.port_a,connectingLoop. port_a2) annotation (Line(
      points={{72,-22},{72,-28},{92,-28},{92,-24}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(KitHotWatDem.y[1],domesticWaterControls. m_flow_in_kit) annotation (
      Line(
      points={{70.4,-64},{130,-64},{130,-8},{144,-8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(GueRooDomWatDem.y[1],domesticWaterControls. m_flow_in_dom)
    annotation (Line(
      points={{68.4,-40},{126,-40},{126,-4},{144,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticWaterControls.Pum3_flow,connectingLoop. m_flow_in)
    annotation (Line(
      points={{167,-8},{172,-8},{172,22},{84,22},{84,-20},{90,-20}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.TBoiDW,domesticWaterControls. TBoi1) annotation (Line(
      points={{-158,56},{-178,56},{-178,-88},{172,-88},{172,-16},{167,-16}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(connectingLoop.m_flow1,supCon. masFloHotWat) annotation (Line(
      points={{106,-7},{104,-7},{104,88},{-180,88},{-180,64},{-158,64}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(connectingLoop.sta1,heatPump. Sta) annotation (Line(
      points={{98,-6},{98,60},{-8,60},{-8,2},{9,2}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(coolingTowerSystem.port_a1, port_a1) annotation (Line(
      points={{-88.2,16},{-188,16},{-188,40},{-200,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.CitWat, CitWat1) annotation (Line(
      points={{92,-16},{80,-16},{80,70},{0,70},{0,100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticWaterControls.DomHotWat1, DomHotWat1) annotation (Line(
      points={{166,-12},{180,-12},{180,-60},{200,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticWaterControls.KitWat1, KitWat1) annotation (Line(
      points={{156,-2},{156,60},{200,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticWaterControls.port_b1, exp2.port_a) annotation (Line(
      points={{146,-12},{136,-12},{136,8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_b1, heatPump.port_a2) annotation (Line(
      points={{92,-12},{92,32},{30,32},{30,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_b2, domesticWaterControls.port_a1) annotation (
      Line(
      points={{112,-24},{112,-56},{156,-56},{156,-22}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_a1, domesticWaterControls.port_b1) annotation (
      Line(
      points={{112,-12},{146,-12}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(extent={{-200,-100},{200,100}},
          preserveAspectRatio=false), graphics), Icon(coordinateSystem(extent={
            {-200,-100},{200,100}}, preserveAspectRatio=false), graphics={
          Ellipse(
          extent={{-160,-80},{160,80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,128,255}), Text(
          extent={{-160,80},{160,-80}},
          lineColor={255,0,0},
          lineThickness=1,
          textString="HR",
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255})}));
end HeatRecoverySystem;
