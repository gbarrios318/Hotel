within HotelModel.CollectionTank;
model CollectionTankSystem
  "Collection Tank System components not including control sequence"
  Modelica.Fluid.Vessels.ClosedVolume ColTan(nPorts=3) "Collection tank"
    annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
  Buildings.Fluid.Sources.Outside_Cp StoDra(nPorts=1) "Storm drainage "
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-140,82})));
  Buildings.Fluid.Sources.Boundary_pT OveFlo(nPorts=1) "Overflow, when "
    annotation (Placement(transformation(extent={{-150,0},{-130,20}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valF
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.Fluid.Sensors.Pressure senPre
    annotation (Placement(transformation(extent={{-38,30},{-18,50}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valE annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,68})));
  Modelica.Fluid.Interfaces.FluidPort_a CityWater
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valK
    annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valL
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Buildings.Fluid.Sources.Boundary_pT bou(nPorts=2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-16,-60})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Buildings.Fluid.Sensors.Pressure senPre1
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  Buildings.Fluid.Sensors.Pressure senPre2
    annotation (Placement(transformation(extent={{-6,50},{14,70}})));
equation
  connect(ColTan.ports[1], StoDra.ports[1]) annotation (Line(
      points={{-102.667,40},{-102,40},{-102,30},{-140,30},{-140,72}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ColTan.ports[2], OveFlo.ports[1]) annotation (Line(
      points={{-100,40},{-100,10},{-130,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ColTan.ports[3], valF.port_a) annotation (Line(
      points={{-97.3333,40},{-98,40},{-98,30},{-80,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valF.port_b, senPre.port) annotation (Line(
      points={{-60,30},{-28,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valE.port_a, CityWater) annotation (Line(
      points={{0,78},{0,98}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valE.port_b, senPre.port) annotation (Line(
      points={{0,58},{0,30},{-28,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valL.port_a, senPre.port) annotation (Line(
      points={{-60,-30},{-80,-30},{-80,0},{0,0},{0,30},{-28,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valK.port_a, senPre.port) annotation (Line(
      points={{-70,-70},{-80,-70},{-80,0},{0,0},{0,30},{-28,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valK.port_b, bou.ports[1]) annotation (Line(
      points={{-50,-70},{-14,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valL.port_b, val.port_a) annotation (Line(
      points={{-40,-30},{20,-30},{20,-70},{40,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[2], val.port_a) annotation (Line(
      points={{-18,-70},{40,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valK.port_b, senPre1.port) annotation (Line(
      points={{-50,-70},{-40,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(extent={{-160,-100},{160,100}},
          preserveAspectRatio=false), graphics), Icon(coordinateSystem(extent={
            {-160,-100},{160,100}})));
end CollectionTankSystem;
