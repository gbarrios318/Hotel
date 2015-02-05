within HotelModel.CollectionTank.UsageSystem;
model UsageSystemModel "Usage system model without signals"
  import HotelModel;
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  parameter Modelica.SIunits.MassFlowRate m_RWflow_nominal
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dpRW_nominal "Nominal Pressure drop";

  Buildings.Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium =
        MediumRainWater, m_flow_nominal=m_RWflow_nominal,
    dpValve_nominal=dpRW_nominal)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Fluid.Vessels.ClosedVolume StoTan(
    redeclare package Medium = MediumRainWater,
    V=StoTanVol,
    use_portsData=false,
    nPorts=2) "Storage Tank"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Fluid.Sources.FixedBoundary Irr(          redeclare package Medium
      = MediumRainWater, nPorts=1) "Irrigation"                   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,40})));
  Buildings.Fluid.Movers.FlowMachine_dp pumIrr(redeclare package Medium =
        MediumRainWater, m_flow_nominal=m_RWflow_nominal)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Fluid.Sources.FixedBoundary GarToi(          redeclare package
      Medium = MediumRainWater, nPorts=1) "Garage Toilets"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-40})));
  Buildings.Fluid.Movers.FlowMachine_dp pumToi(redeclare package Medium =
        MediumRainWater, m_flow_nominal=m_RWflow_nominal)
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumRainWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a CooTow(redeclare package Medium =
        MediumRainWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-86,74},{-74,86}})));
  Modelica.Blocks.Sources.Constant dpIrr(k=413.7)
    "irrigation system pump input"
    annotation (Placement(transformation(extent={{-28,74},{-16,86}})));
  Modelica.Blocks.Sources.Constant dpGarToi(k=413.7) "garage toilet pump input"
    annotation (Placement(transformation(extent={{4,-26},{16,-14}})));
  parameter Modelica.SIunits.Volume StoTanVol "Volume";
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val1(
                                                    redeclare package Medium =
        MediumRainWater, m_flow_nominal=m_RWflow_nominal,
    dpValve_nominal=dpRW_nominal)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val2(
                                                    redeclare package Medium =
        MediumRainWater, m_flow_nominal=m_RWflow_nominal,
    dpValve_nominal=dpRW_nominal)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloToi(redeclare package Medium =
        MediumRainWater)
    "mass flow rate of the water going out of the usage system"
    annotation (Placement(transformation(extent={{52,-48},{68,-32}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFloIrr(redeclare package Medium =
        MediumRainWater)
    "mass flow rate of the water going out of the usage system"
    annotation (Placement(transformation(extent={{22,32},{38,48}})));
equation
  connect(val.port_a, port_a1) annotation (Line(
      points={{-60,-40},{-80,-40},{-80,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const.y, val.y) annotation (Line(
      points={{-73.4,80},{-70,80},{-70,-20},{-50,-20},{-50,-28}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(dpIrr.y, pumIrr.dp_in) annotation (Line(
      points={{-15.4,80},{-0.2,80},{-0.2,52}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(dpGarToi.y, pumToi.dp_in) annotation (Line(
      points={{16.6,-20},{29.8,-20},{29.8,-28}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(val.port_b, StoTan.ports[1]) annotation (Line(
      points={{-40,-40},{-12,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pumToi.port_a, StoTan.ports[2]) annotation (Line(
      points={{20,-40},{-8,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val1.port_b, pumIrr.port_a) annotation (Line(
      points={{-40,40},{-10,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val1.port_a, port_a1) annotation (Line(
      points={{-60,40},{-80,40},{-80,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const.y, val1.y) annotation (Line(
      points={{-73.4,80},{-50,80},{-50,52}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(CooTow, val2.port_b) annotation (Line(
      points={{100,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(port_a1, val2.port_a) annotation (Line(
      points={{-100,0},{-30,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const.y, val2.y) annotation (Line(
      points={{-73.4,80},{-40,80},{-40,60},{-20,60},{-20,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(pumToi.port_b, senMasFloToi.port_a) annotation (Line(
      points={{40,-40},{52,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(GarToi.ports[1], senMasFloToi.port_b) annotation (Line(
      points={{80,-40},{68,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pumIrr.port_b, senMasFloIrr.port_a) annotation (Line(
      points={{10,40},{22,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(Irr.ports[1], senMasFloIrr.port_b) annotation (Line(
      points={{50,40},{38,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-60,40},{60,-60}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-94,8},{-60,-8}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255}),
        Rectangle(
          extent={{60,8},{94,-8}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255}),
        Text(
          extent={{-60,80},{60,60}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}), graphics));
end UsageSystemModel;
