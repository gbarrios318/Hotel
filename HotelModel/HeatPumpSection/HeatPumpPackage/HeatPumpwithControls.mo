within HotelModel.HeatPumpSection.HeatPumpPackage;
model HeatPumpwithControls "Heat Pump with its controls"
replaceable package MediumCW =
      Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal "Nominal pressure difference";
  parameter Real MasFloHeaPumIn
    "Mass flow rate of water going through the heat pump";
  parameter Real Q_floSet "Heat flow into the heat pump";
  parameter Modelica.SIunits.Volume HeatPumpVol "Volume of the Heat Pump";
  parameter Modelica.SIunits.Temperature HeaPumTRef
    "Reference tempearture of heat pump";

  HeatPump HeaPum(
    redeclare package MediumCW = MediumCW,
    dp_nominal=dp_nominal,
    mWater_flow_nominal=mWater_flow_nominal,
    HeatPumpVol=HeatPumpVol,
    HeaPumTRef=HeaPumTRef)
    "Heat pump with all components directly interacting with it"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumCW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumCW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput THeaPum
    "Temperature of the passing fluid leaving the heat pump"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Sources.Constant MasFloHeaPum(k=MasFloHeaPumIn)
    "Mass flow rate of Heat Pump"
    annotation (Placement(transformation(extent={{-96,66},{-76,86}})));
  Modelica.Blocks.Sources.Constant Q_floIn(k=Q_floSet) "Heat flow input"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-60,44},{-40,64}})));
  Modelica.Blocks.Interfaces.RealInput InSig "Input signal by user"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput P1 "Electrical power consumed"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
equation
  connect(HeaPum.port_a1, port_a1) annotation (Line(
      points={{-20.4,0},{-102,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(HeaPum.port_b1, port_b1) annotation (Line(
      points={{20,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(Q_floIn.y, HeaPum.Q_flow) annotation (Line(
      points={{-59,-40},{-40,-40},{-40,-8},{-22.4,-8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(HeaPum.THeaPum, THeaPum) annotation (Line(
      points={{22,8},{60,8},{60,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(MasFloHeaPum.y, product.u1) annotation (Line(
      points={{-75,76},{-70,76},{-70,60},{-62,60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(product.y, HeaPum.masFloPum) annotation (Line(
      points={{-39,54},{-32,54},{-32,8},{-22.4,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(product.u2, InSig) annotation (Line(
      points={{-62,48},{-82,48},{-82,40},{-120,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(HeaPum.P, P1) annotation (Line(
      points={{22,-8},{62,-8},{62,-40},{110,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),        graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-96,8},{-60,0}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          fillColor={255,0,0},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-96,-8},{-60,0}},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,40},{60,-40}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,20},{60,-20}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,0,0}),
        Rectangle(
          extent={{60,8},{96,-8}},
          pattern=LinePattern.None,
          fillColor={95,0,127},
          fillPattern=FillPattern.Solid),
        Line(
          points={{60,30},{80,30},{80,40},{90,40}},
          color={0,0,0},
          pattern=LinePattern.DashDot,
          thickness=0.5,
          smooth=Smooth.None),
        Text(
          extent={{-40,80},{40,60}},
          lineColor={0,0,255},
          textString="%name")}));
end HeatPumpwithControls;
