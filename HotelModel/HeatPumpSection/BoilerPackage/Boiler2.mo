within HotelModel.HeatPumpSection.BoilerPackage;
model Boiler2
  "Boiler system in the condenser water loop that provides heating in the cold winter"
 replaceable package MediumCW =
       Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
  Buildings.Fluid.Boilers.BoilerPolynomial boi(
    Q_flow_nominal=2000000,
    fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
    redeclare package Medium = MediumCW,
    m_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal) "Boiler that corresponds of the heat pump section"
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valBoi(
    redeclare package Medium = MediumCW,
    m_flow_nominal=mWater_flow_nominal,
    dpValve_nominal=dp_nominal) "Valve to control the flow into boiler"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valByp(
    m_flow_nominal=mWater_flow_nominal,
    dpValve_nominal=dp_nominal,
    redeclare package Medium = MediumCW) "Bypass valve"
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumCW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumCW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Blocks.Interfaces.RealInput boiCon "Control singal for boiler"
    annotation (Placement(transformation(extent={{-120,68},{-100,88}}),
        iconTransformation(extent={{-116,72},{-100,88}})));
  Modelica.Blocks.Interfaces.RealInput valCon
    "Control signal for valves in boiler loop" annotation (Placement(
        transformation(extent={{-120,30},{-100,50}}), iconTransformation(extent={{-116,34},
            {-100,50}})));
  Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-44,4},{-24,24}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-92,-22},{-72,-2}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1
    "Heat port, can be used to connect to ambient"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
equation
  connect(valBoi.port_b, boi.port_a) annotation (Line(
      points={{6.66134e-016,10},{6.66134e-016,40},{40,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valBoi.port_a, valByp.port_a) annotation (Line(
      points={{-4.44089e-016,-10},{-4.44089e-016,-40},{40,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valByp.port_b, port_b1) annotation (Line(
      points={{60,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boi.port_b, port_b1) annotation (Line(
      points={{60,40},{80,40},{80,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valByp.port_a, port_a1) annotation (Line(
      points={{40,-40},{-100,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boi.y, boiCon) annotation (Line(
      points={{38,48},{-20,48},{-20,78},{-110,78}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(valCon, add.u1) annotation (Line(
      points={{-110,40},{-60,40},{-60,20},{-46,20}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(const.y, add.u2) annotation (Line(
      points={{-71,-12},{-60,-12},{-60,8},{-46,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(boi.heatPort, heatPort1) annotation (Line(
      points={{50,47.2},{50,70},{0,70},{0,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(add.y, valBoi.y) annotation (Line(
      points={{-23,14},{-18,14},{-18,0},{-12,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(valByp.y, valCon) annotation (Line(
      points={{50,-28},{50,-20},{20,-20},{20,32},{-40,32},{-40,40},{-110,40}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-60,40},{60,-62}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-94,-32},{0,-48}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          pattern=LinePattern.None),
        Rectangle(
          extent={{0,-32},{96,-48}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-10,28},{12,-48}},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5,
          pattern=LinePattern.None),
        Line(
          points={{-90,40},{-80,40},{-80,-20},{-10,-20}},
          color={0,0,255},
          smooth=Smooth.None,
          thickness=0.5,
          pattern=LinePattern.DashDot),
        Line(
          points={{-90,80},{-60,80},{-60,20},{-10,20}},
          color={0,0,255},
          smooth=Smooth.None,
          thickness=0.5,
          pattern=LinePattern.DashDot),
        Line(
          points={{-60,-80},{60,-80},{42,-68}},
          color={0,128,255},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{60,-80},{44,-92}},
          color={0,128,255},
          thickness=0.5,
          smooth=Smooth.None),
        Text(
          extent={{-54,80},{54,60}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end Boiler2;
