within HotelModel;
model HotelModel
     replaceable package MediumCW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
       replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal=15
    "Nominal mass flow rate";
      //The nominal flow rate of water for domestic flow rate is one I gave it
      //Need to look up actual values
   parameter Modelica.SIunits.Pressure dpDW_nominal=100
    "Nominal pressure difference";
  CoolingTowerSection.CoolingTowerSystem coolingTowerSystem(redeclare package
      MediumCW = MediumCW)                                  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,30})));
  HeatPumpSection.HeatPump heatPump(redeclare package MediumCW = MediumCW,
      redeclare package MediumDW = MediumDW)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  ConnectingPackage.ConnectingLoop connectingLoop(redeclare package MediumDW =
        MediumDW)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  DomesticHotWater.DomesticWaterControls domesticWaterControls(redeclare
      package MediumDW = MediumDW)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Control.SupervisoryControl supCon
    annotation (Placement(transformation(extent={{-80,68},{-60,88}})));
equation
  connect(heatPump.port_a2, connectingLoop.port_b2) annotation (Line(
      points={{-20,16},{0,16},{0,-4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatPump.port_b2, connectingLoop.port_a2) annotation (Line(
      points={{-20,4},{-20,-16},{0,-16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_a1, domesticWaterControls.port_a1) annotation (
      Line(
      points={{20,-4},{40,-4},{40,-30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_b1, domesticWaterControls.port_a2) annotation (
      Line(
      points={{20.2,-16},{20,-16},{20,-50},{50,-50},{50,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_b, heatPump.port_a1) annotation (Line(
      points={{-70,20},{-70,4},{-39.8,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_a, heatPump.port_b1) annotation (Line(
      points={{-70,39.8},{-70,40},{-40,40},{-40,16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(supCon.y, coolingTowerSystem.sta) annotation (Line(
      points={{-59,78},{-60,78},{-60,60},{-92,60},{-92,36},{-82,36}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(supCon.y, heatPump.Sta) annotation (Line(
      points={{-59,78},{-50,78},{-50,10},{-41,10}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(supCon.y, connectingLoop.sta1) annotation (Line(
      points={{-59,78},{6,78},{6,2}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(connectingLoop.m_flow1, supCon.masFloHotWat) annotation (Line(
      points={{14,1},{14,96},{-98,96},{-98,72},{-82,72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPump.THeaPum, supCon.THeatPump) annotation (Line(
      points={{-24,-1},{-24,-10},{-96,-10},{-96,84},{-82,84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatPump.Tboi, supCon.Tem3) annotation (Line(
      points={{-24,21},{-24,64},{-86,64},{-86,80},{-82,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(domesticWaterControls.TBoi1, supCon.TBoiDW) annotation (Line(
      points={{61,-34},{70,-34},{70,-80},{-90,-80},{-90,76},{-82,76}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HotelModel;
