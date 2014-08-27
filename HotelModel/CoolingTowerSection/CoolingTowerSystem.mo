within HotelModel.CoolingTowerSection;
model CoolingTowerSystem
  "Components directly interacting with the Cooling Tower"
 replaceable package MediumCW =
      Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";

  Buildings.Fluid.Sources.Boundary_pT bou(          redeclare package Medium =
               MediumCW, nPorts=1) "Boundry for realistic circumstances"
                                                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-50,30})));
  Buildings.Fluid.HeatExchangers.CoolingTowers.FixedApproach CooTow(
      redeclare package Medium = MediumCW,
    m_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal,
    m_flow(start=mWater_flow_nominal),
    dp(start=dp_nominal)) "Cooling Tower"
    annotation (Placement(transformation(extent={{-28,10},{-8,-10}})));
  Buildings.Fluid.Movers.FlowMachine_y      Pum(
    addPowerToMedium=false,
    redeclare package Medium = MediumCW,
    m_flow_nominal=mWater_flow_nominal,
    dp(start=dp_nominal),
    m_flow(start=gain.k) = gain.k) "pump corresponding to the cooling tower"
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TemSen(m_flow_nominal=
        mWater_flow_nominal, redeclare package Medium = MediumCW)
    "Temperature sensor of water after going through cooling tower"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumCW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{92,-70},{112,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumCW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
        iconTransformation(extent={{-110,30},{-90,50}})));
  Modelica.Blocks.Interfaces.RealInput TWea
    "Entering air dry or wet bulb temperature" annotation (Placement(
        transformation(extent={{-128,-74},{-100,-46}}), iconTransformation(
          extent={{-124,-70},{-100,-46}})));
  Modelica.Blocks.Interfaces.RealOutput TWeaOut
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Math.Gain gain(k=mWater_flow_nominal)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Interfaces.RealInput CooTowOnOff "Input signal connector"
    annotation (Placement(transformation(extent={{-128,46},{-100,74}}),
        iconTransformation(extent={{-124,50},{-100,74}})));
equation
  connect(CooTow.port_b, Pum.port_a) annotation (Line(
      points={{-8,0},{22,0}},
      color={0,127,255},
      thickness=1,
      smooth=Smooth.None));
  connect(Pum.port_b, TemSen.port_a) annotation (Line(
      points={{42,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(TemSen.port_b, port_b1) annotation (Line(
      points={{80,0},{80,-60},{102,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(CooTow.TAir, TWea) annotation (Line(
      points={{-30,-4},{-40,-4},{-40,-60},{-114,-60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(port_a1, CooTow.port_a) annotation (Line(
      points={{-100,40},{-80,40},{-80,0},{-28,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(bou.ports[1], CooTow.port_a) annotation (Line(
      points={{-50,20},{-50,0},{-28,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(TemSen.T, TWeaOut) annotation (Line(
      points={{70,11},{70,60},{110,60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(gain.y, Pum.y) annotation (Line(
      points={{-59,60},{32,60},{32,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(gain.u, CooTowOnOff) annotation (Line(
      points={{-82,60},{-114,60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-40,76},{48,50}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-50,50},{60,-78}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-94,62}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-96,64}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-94,62}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-88,40},{32,40},{42,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{6,40},{0,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{32,40},{24,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{6,38},{14,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-20,40},{-28,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-20,40},{-10,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Ellipse(
          extent={{-36,64},{2,64}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-36,70},{2,58}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,70},{44,58}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,-56},{98,-64}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-60,100},{60,80}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end CoolingTowerSystem;
