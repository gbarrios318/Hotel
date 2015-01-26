within HotelModel.CollectionTank.ProcessingSystem;
model ProcessingSystemModel
  "System model of the processing of collection tank model"
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valE annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,60})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valL
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1
    annotation (Placement(transformation(extent={{30,10},{50,-10}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valK
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  FilterModel SolSepFil "Solid Separator Filter"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_1
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a CitWat
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));
  FilterModel UVFil "UV Filter System"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(valK.port_b, SolSepFil.port_a1) annotation (Line(
      points={{-30,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val1.port_1, SolSepFil.port_b1) annotation (Line(
      points={{30,0},{10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valK.port_a, port_a1) annotation (Line(
      points={{-50,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valL.port_a, port_a1) annotation (Line(
      points={{-20,40},{-60,40},{-60,0},{-100,0}},
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
      points={{0,40},{40,40},{40,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val1.port_2, UVFil.port_a1) annotation (Line(
      points={{50,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(port_1, UVFil.port_b1) annotation (Line(
      points={{100,0},{80,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
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
