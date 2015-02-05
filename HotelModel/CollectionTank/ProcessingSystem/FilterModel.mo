within HotelModel.CollectionTank.ProcessingSystem;
model FilterModel "Model of a filter including a simple pressure drop"
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  parameter Modelica.SIunits.Pressure dpfilter_nominal
    "Pressure drop at nominal mass flow rate";
    parameter Modelica.SIunits.MassFlowRate m_valveflow_nominal
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dpRW_nominal "Nominal Pressure drop";
  Buildings.Fluid.FixedResistances.FixedResistanceDpM Fil(
                          redeclare package Medium = MediumRainWater,
    dp_nominal=dpfilter_nominal,
    m_flow_nominal=m_flow_nominal)
    "Representation of the pressure drop in the filter model"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium =
        MediumRainWater,
    m_flow_nominal=m_valveflow_nominal,
    dpValve_nominal=dpValve_nominal)                annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={20,-30})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumRainWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumRainWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Buildings.Fluid.Sources.Boundary_pT sin(          redeclare package Medium =
        MediumRainWater, nPorts=1)                  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-70})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  parameter Modelica.SIunits.Pressure dpValve_nominal
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint";
equation
  connect(Fil.port_a, port_a1) annotation (Line(
      points={{-60,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(Fil.port_b, port_b1) annotation (Line(
      points={{-40,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(Fil.port_b, val.port_a) annotation (Line(
      points={{-40,0},{20,0},{20,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sin.ports[1], val.port_b) annotation (Line(
      points={{20,-60},{20,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const.y, val.y) annotation (Line(
      points={{-9,-30},{8,-30}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-40,-20},{40,60}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,20},{40,-80}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-94,8},{-40,-8}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,8},{94,-8}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,88},{60,64}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Line(
          points={{-60,-90},{60,-90},{48,-84}},
          color={0,128,255},
          smooth=Smooth.None)}));
end FilterModel;
