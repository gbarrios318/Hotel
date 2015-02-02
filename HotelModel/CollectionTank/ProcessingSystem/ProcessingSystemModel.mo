within HotelModel.CollectionTank.ProcessingSystem;
model ProcessingSystemModel
  "System model of the processing of collection tank model"
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  replaceable package MediumCityWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valE(m_flow_nominal=
        m_CitWatflow_nominal)                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,60})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valL
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1
    annotation (Placement(transformation(extent={{40,10},{60,-10}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valK(redeclare package Medium
      = MediumRainWater)
    annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
  FilterModel SolSepFil "Solid Separator Filter"
    annotation (Placement(transformation(extent={{8,-10},{28,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumRainWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_1
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a CitWat
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));
  FilterModel UVFil "UV Filter System"
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Blocks.Interfaces.RealInput ValE
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput ValByP
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-140,-90},{-100,-50}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  parameter Modelica.SIunits.MassFlowRate m_CitWatflow_nominal
    "Nominal mass flow rate";
equation
  connect(valK.port_b, SolSepFil.port_a1) annotation (Line(
      points={{-2,0},{8,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val1.port_1, SolSepFil.port_b1) annotation (Line(
      points={{40,0},{28,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valL.port_a, port_a1) annotation (Line(
      points={{10,40},{-40,40},{-40,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valE.port_b, port_a1) annotation (Line(
      points={{-80,50},{-80,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valE.port_a, CitWat) annotation (Line(
      points={{-80,70},{-80,88},{0,88},{0,98}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valL.port_b, val1.port_3) annotation (Line(
      points={{30,40},{50,40},{50,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val1.port_2, UVFil.port_a1) annotation (Line(
      points={{60,0},{70,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(port_1, UVFil.port_b1) annotation (Line(
      points={{100,0},{90,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const.y, val1.y) annotation (Line(
      points={{41,-50},{50,-50},{50,-12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(valE.y, ValE) annotation (Line(
      points={{-68,60},{-60,60},{-60,-40},{-120,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(valK.y, ValByP) annotation (Line(
      points={{-12,12},{-12,20},{-30,20},{-30,-70},{-120,-70}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(valK.port_a, port_a1) annotation (Line(
      points={{-22,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const1.y, add.u1) annotation (Line(
      points={{-29,70},{-26,70},{-26,66},{-22,66}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(add.u2, ValByP) annotation (Line(
      points={{-22,54},{-30,54},{-30,-70},{-120,-70}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(add.y, valL.y) annotation (Line(
      points={{1,60},{20,60},{20,52}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-8,92},{8,40}},
          lineColor={0,127,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-94,8},{-60,-8}},
          lineColor={0,127,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,8},{94,-8}},
          lineColor={0,127,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,40},{60,-40}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}));
end ProcessingSystemModel;
