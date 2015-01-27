within HotelModel.CollectionTank.StorageSystem;
model StorageSystemModel "Storage System Model "
  Modelica.Fluid.Vessels.ClosedVolume ColTan(nPorts=3) "Collection tank"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Buildings.Fluid.Sources.Boundary_pT OveFlo(nPorts=1) "Overflow, when "
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-64})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valF
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valB
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  connect(valF.port_b, port_b1) annotation (Line(
      points={{60,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valF.port_a, ColTan.ports[1]) annotation (Line(
      points={{40,0},{-2.66667,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(OveFlo.ports[1], ColTan.ports[2]) annotation (Line(
      points={{0,-54},{0,-28},{0,0},{2.22045e-016,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ColTan.ports[3], valB.port_b) annotation (Line(
      points={{2.66667,0},{-40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valB.port_a, port_a1) annotation (Line(
      points={{-60,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics
        ={
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
          extent={{-40,90},{40,70}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name",
          lineColor={0,0,255})}));
end StorageSystemModel;
