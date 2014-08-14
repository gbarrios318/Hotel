within HotelModel.HeatPumpSection;
model HeatPump "Complete heat pump section with everything put together"
replaceable package MediumCW =
      Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
  BoilerPackage.Boiler2WithControls HeaPumBoi(
    redeclare package MediumCW = MediumCW,
    mWater_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal) "Boiler corresponding to the heat pump section"
    annotation (Placement(transformation(extent={{-40,42},{-80,78}})));
  HeatPumpPackage.HeatPumpwithControls HeaPum(
    redeclare package MediumCW = MediumCW,
    mWater_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal) "Heat Pump"
    annotation (Placement(transformation(extent={{-60,-80},{-20,-40}})));
  HeatExchangeValvesPackage.HexValves_with_Control HexVal(
    redeclare package MediumCW = MediumCW,
    mWater_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal) "Heat exchange valves with controls" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={40,0})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-108,-70},{-88,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Blocks.Interfaces.IntegerInput Sta
    "States controlled by the supervisory control"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Buildings.Fluid.Sources.Boundary_pT BouHeaPum(nPorts=4, redeclare package
      Medium = MediumCW) "Boundry that allows for realistic circumstances"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,70})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.RealOutput Tboi
    "Temperature of the passing fluid in the boiler" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,110})));
  Modelica.Blocks.Interfaces.RealOutput THeaPum
    "Temperature of the passing fluid leaving from the heat pumps"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-110})));
equation
  connect(HeaPum.port_a1, port_a1) annotation (Line(
      points={{-60.4,-60},{-98,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HeaPumBoi.port_b1, port_b1) annotation (Line(
      points={{-80,60},{-100,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HexVal.port_a1, HeaPum.port_b1) annotation (Line(
      points={{32,-20},{32,-60},{-20,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HeaPumBoi.port_a1, HexVal.port_b2) annotation (Line(
      points={{-40,60},{32,60},{32,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_b1, port_b1) annotation (Line(
      points={{-100,60},{-100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HexVal.SuperCtrl, Sta) annotation (Line(
      points={{17.6,1.33227e-015},{-40,1.33227e-015},{-40,0},{-110,0}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(BouHeaPum.ports[1], HeaPumBoi.port_a1) annotation (Line(
      points={{13,60},{-40,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(BouHeaPum.ports[2], HexVal.port_b2) annotation (Line(
      points={{11,60},{32,60},{32,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HeaPumBoi.port_a1, BouHeaPum.ports[3]) annotation (Line(
      points={{-40,60},{9,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HexVal.port_a2, port_a2) annotation (Line(
      points={{48,20},{48,60},{100,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HexVal.port_b1, port_b2) annotation (Line(
      points={{48,-20},{48,-60},{100,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HeaPumBoi.Sta, Sta) annotation (Line(
      points={{-38.4,71.16},{-38.4,72},{-24,72},{-24,0},{-110,0}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(HeaPumBoi.port_a1, BouHeaPum.ports[4]) annotation (Line(
      points={{-40,60},{7,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HeaPum.THeaPum, THeaPum) annotation (Line(
      points={{-18,-52},{-10,-52},{-10,-40},{60,-40},{60,-110}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(HeaPum.THeaPum, HeaPumBoi.HPTSen) annotation (Line(
      points={{-18,-52},{-10,-52},{-10,67.56},{-38.4,67.56}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(HeaPumBoi.TBoi, Tboi) annotation (Line(
      points={{-82.4,67.56},{-82.4,68},{-90,68},{-90,40},{60,40},{60,110}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Ellipse(
          extent={{-80,80},{80,-80}},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,85},
          pattern=LinePattern.None), Polygon(
          points={{-32,42},{-32,-38},{48,2},{-32,42}},
          smooth=Smooth.None,
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}));
end HeatPump;
