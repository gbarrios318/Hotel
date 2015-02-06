within HotelModel.CollectionTank.StorageSystem;
model StorageSystemModel "Storage System Model "
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  parameter Modelica.SIunits.MassFlowRate m_RWflow_nominal
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dpRW_nominal "Nominal Pressure drop";
  parameter Modelica.SIunits.Pressure dp_OFnominal
    "Pressure drop at nominal mass flow rate";
  Modelica.Fluid.Vessels.ClosedVolume ColTan(nPorts=3,
    redeclare package Medium = MediumRainWater,
    V=ColTanVol,
    use_portsData=false) "Collection tank"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Buildings.Fluid.Sources.Boundary_pT OveFlo(          redeclare package Medium
      = MediumRainWater, nPorts=1) "Overflow, when "
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-80})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valF(redeclare package Medium
      = MediumRainWater, m_flow_nominal=m_RWflow_nominal,
    dpValve_nominal=dpRW_nominal)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumRainWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valB(redeclare package Medium
      = MediumRainWater, m_flow_nominal=m_RWflow_nominal,
    dpValve_nominal=dpRW_nominal)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumRainWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloIn(redeclare package Medium =
        MediumRainWater)
    "Mass flow rate of water going into the collection tank"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloOut(redeclare package Medium =
        MediumRainWater)
    "Mass flow rate of water going into the collection tank"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  parameter Modelica.SIunits.Volume ColTanVol "Volume";

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Buildings.Fluid.FixedResistances.FixedResistanceDpM Fil(
                          redeclare package Medium = MediumRainWater,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_OFnominal)
    "Representation of the pressure drop in the filter model"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-30})));

equation
  connect(valF.port_b, port_b1) annotation (Line(
      points={{80,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valB.port_a, port_a1) annotation (Line(
      points={{-70,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const.y, valB.y) annotation (Line(
      points={{-69,50},{-60,50},{-60,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(const.y, valF.y) annotation (Line(
      points={{-69,50},{70,50},{70,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(valB.port_b, senMasFloIn.port_a) annotation (Line(
      points={{-50,0},{-40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ColTan.ports[1], senMasFloIn.port_b) annotation (Line(
      points={{-2.66667,0},{-20,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valF.port_a, senMasFloOut.port_b) annotation (Line(
      points={{60,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(Fil.port_b, OveFlo.ports[1]) annotation (Line(
      points={{0,-40},{0,-70}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senMasFloOut.port_a, ColTan.ports[2]) annotation (Line(
      points={{20,0},{2.22045e-016,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(Fil.port_a, ColTan.ports[3]) annotation (Line(
      points={{0,-20},{0,0},{2.66667,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-60,60},{60,-80}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255}),
        Ellipse(
          extent={{-60,20},{-20,60}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,20},{20,60}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,20},{60,60}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,60},{60,38}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-60,38},{-60,60},{-36,60},{60,60},{60,36}},
          pattern=LinePattern.None,
          smooth=Smooth.None),
        Text(
          extent={{-100,100},{100,60}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name",
          lineColor={0,0,255})}));
end StorageSystemModel;
