within HotelModel.CoolingTowerSection;
model CoolingTowerWithControls
  "Cooling tower components with controls included"
 replaceable package MediumCW =
      Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";

  CoolingTowerSystem CooTowSys(
    redeclare package MediumCW = MediumCW,
    mWater_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal) "Cooling Tower System"
    annotation (Placement(transformation(extent={{-30,-28},{26,30}})));
  Modelica.Blocks.Sources.Constant TWea(k=273.15 + 23.5) "Weather temperature"
    annotation (Placement(transformation(extent={{-92,-50},{-72,-30}})));
  Modelica.Blocks.Interfaces.RealInput m_flo_in "Prescribed mass flow rate"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-126,54},{-100,80}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumCW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,10},{-90,30}}),
        iconTransformation(extent={{-110,10},{-90,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumCW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
        iconTransformation(extent={{90,-90},{110,-70}})));
equation
  connect(CooTowSys.port_a1, port_a1) annotation (Line(
      points={{-30,12.6},{-80.72,12.6},{-80.72,20},{-100,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(CooTowSys.port_b1, port_b1) annotation (Line(
      points={{26.56,-16.4},{59.28,-16.4},{59.28,-80},{100,-80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(m_flo_in, CooTowSys.m_flo_in) annotation (Line(
      points={{-120,60},{-60,60},{-60,20.72},{-33.36,20.72}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TWea.y, CooTowSys.TWea) annotation (Line(
      points={{-71,-40},{-60,-40},{-60,-14.08},{-33.36,-14.08}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Text(
          extent={{-60,86},{60,66}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Rectangle(
          extent={{-46,60},{42,34}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-56,34},{54,-94}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-94,24},{26,24},{36,4}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,24},{-6,4}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{26,24},{18,4}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,22},{8,4}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-26,24},{-34,4}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-26,24},{-16,4}},
          color={255,0,0},
          smooth=Smooth.None),
        Ellipse(
          extent={{-42,48},{-4,48}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-42,54},{-4,42}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{0,54},{38,42}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{54,-76},{92,-84}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-76,78},{-88,56}},
          lineColor={255,0,0},
          lineThickness=1,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-72,76},{-82,58}},
          lineColor={255,0,0},
          lineThickness=1,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,74},{-70,60}},
          lineColor={255,0,0},
          lineThickness=1,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-68,62},{-72,72}},
          lineColor={255,0,0},
          lineThickness=1,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}));
end CoolingTowerWithControls;
