within HotelModel.CollectionTank.UsageSystem;
model UsageSystemModel "Usage system model without signals"
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val
    annotation (Placement(transformation(extent={{-58,-50},{-38,-30}})));
  Modelica.Fluid.Vessels.ClosedVolume StoTan(nPorts=2) "Storage Tank"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Fluid.Sources.FixedBoundary Irr(nPorts=1) "Irrigation" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,40})));
  Buildings.Fluid.Movers.FlowMachine_dp fan
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Fluid.Sources.FixedBoundary GarToi(nPorts=1) "Garage Toilets"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,-40})));
  Buildings.Fluid.Movers.FlowMachine_dp fan1
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a CooTow
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(fan.port_b,Irr. ports[1]) annotation (Line(
      points={{0,40},{20,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val.port_b,StoTan. ports[1]) annotation (Line(
      points={{-38,-40},{-12,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fan1.port_b,GarToi. ports[1]) annotation (Line(
      points={{40,-40},{60,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(StoTan.ports[1],fan1. port_a) annotation (Line(
      points={{-12,-40},{20,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val.port_a, port_a1) annotation (Line(
      points={{-58,-40},{-80,-40},{-80,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fan.port_a, port_a1) annotation (Line(
      points={{-20,40},{-80,40},{-80,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fan.port_a, CooTow) annotation (Line(
      points={{-20,40},{-80,40},{-80,0},{100,0}},
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
          textString="%name")}));
end UsageSystemModel;
