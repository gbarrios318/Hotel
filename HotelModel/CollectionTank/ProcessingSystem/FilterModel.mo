within HotelModel.CollectionTank.ProcessingSystem;
model FilterModel "Model of a filter including a simple pressure drop"
  Buildings.Fluid.FixedResistances.FixedResistanceDpM Fil
    "Representation of the pressure drop in the filter model"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,-40})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Buildings.Fluid.Sources.Boundary_pT sin(nPorts=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-70})));
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
  connect(val.port_a, port_b1) annotation (Line(
      points={{20,-30},{20,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val.port_b, sin.ports[1]) annotation (Line(
      points={{20,-50},{20,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics
        ={
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
