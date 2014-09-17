within HotelModel.HeatPumpSection.HeatExchangeValvesPackage;
model HexValves_with_Control "Control for the heat exchange and valves"
replaceable package MediumCW =
      Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
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
  HeatEx_and_valves Hex(
    redeclare package MediumCW = MediumCW,
    mWater_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal,
    redeclare package MediumDW = MediumDW,
    mDW_flow_nominal=mDW_flow_nominal) "Hex with the valves included"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumCW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumDW)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        MediumDW)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        MediumCW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  HeatExchangeControls heatExchangeControls annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,58})));
  Modelica.Blocks.Interfaces.IntegerInput Sta
    "States decided by supervisory control" annotation (Placement(
        transformation(
        extent={{-12,12},{12,-12}},
        rotation=-90,
        origin={0,112})));
equation

  connect(Hex.port_a1, port_a1) annotation (Line(
      points={{-10,4},{-60,4},{-60,40},{-100,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(Hex.port_b2, port_b1) annotation (Line(
      points={{-10,-4},{-60,-4},{-60,-40},{-100,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(Hex.port_a2, port_a2) annotation (Line(
      points={{10,-4},{60,-4},{60,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(Hex.port_b1, port_b2) annotation (Line(
      points={{10,4},{60,4},{60,40},{100,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatExchangeControls.u1, Sta) annotation (Line(
      points={{0,70},{0,112}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatExchangeControls.ValCtrlByp, Hex.BypValCtrl) annotation (Line(
      points={{4,47},{6,47},{6,11.2}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatExchangeControls.ValCtrl2, Hex.ValCtrl2) annotation (Line(
      points={{0,47},{0,11.2}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatExchangeControls.ValCtrl1, Hex.ValCtrl1) annotation (Line(
      points={{-4,47},{-6,47},{-6,11.2}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),        graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-94,48},{-60,32}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,48},{94,32}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,-32},{94,-48}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-94,-32},{-60,-48}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,60},{60,-60}},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,90},{0,60},{0,60}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          smooth=Smooth.None,
          thickness=0.5),
        Text(
          extent={{-40,-70},{40,-92}},
          lineColor={255,128,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end HexValves_with_Control;
