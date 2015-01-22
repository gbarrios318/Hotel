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
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Buildings.Fluid.Sources.Boundary_pT bou(nPorts=2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-16,-60})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val
    annotation (Placement(transformation(extent={{52,-80},{72,-60}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1
    annotation (Placement(transformation(extent={{10,-60},{30,-80}})));
  Modelica.Fluid.Vessels.ClosedVolume volume(nPorts=2)
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  Modelica.Fluid.Sources.FixedBoundary Irr(nPorts=1) "Irrigation" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={102,20})));
  Modelica.Fluid.Interfaces.FluidPort_b CooTow "Cooling Tower connection"
    annotation (Placement(transformation(extent={{30,88},{50,108}})));
  Buildings.Fluid.Movers.FlowMachine_dp fan
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
  Modelica.Fluid.Sources.FixedBoundary GarToi(nPorts=1) "Garage Toilets"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={146,-70})));
  Buildings.Fluid.Movers.FlowMachine_dp fan1
    annotation (Placement(transformation(extent={{104,-80},{124,-60}})));
equation
  connect(ColTan.ports[1], StoDra.ports[1]) annotation (Line(
      points={{-102.667,40},{-102,40},{-102,30},{-140,30},{-140,72}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ColTan.ports[2], OveFlo.ports[1]) annotation (Line(
      points={{-100,40},{-100,10},{-130,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ColTan.ports[3], valF.port_a) annotation (Line(
      points={{-97.3333,40},{-98,40},{-98,30},{-80,30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valF.port_b, senPre.port) annotation (Line(
      points={{-60,30},{-28,30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valE.port_a, CityWater) annotation (Line(
      points={{0,78},{0,98}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valE.port_b, senPre.port) annotation (Line(
      points={{0,58},{0,30},{-28,30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valL.port_a, senPre.port) annotation (Line(
      points={{-40,-30},{-80,-30},{-80,0},{0,0},{0,30},{-28,30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valK.port_a, senPre.port) annotation (Line(
      points={{-70,-70},{-80,-70},{-80,0},{0,0},{0,30},{-28,30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valK.port_b, bou.ports[1]) annotation (Line(
      points={{-50,-70},{-14,-70}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(bou.ports[2], val1.port_1) annotation (Line(
      points={{-18,-70},{10,-70}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val.port_a, val1.port_2) annotation (Line(
      points={{52,-70},{30,-70}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valL.port_b, val1.port_3) annotation (Line(
      points={{-20,-30},{20,-30},{20,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val1.port_2, CooTow) annotation (Line(
      points={{30,-70},{40,-70},{40,98}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fan.port_b, Irr.ports[1]) annotation (Line(
      points={{80,20},{92,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fan.port_a, CooTow) annotation (Line(
      points={{60,20},{40,20},{40,98}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val.port_b, volume.ports[1]) annotation (Line(
      points={{72,-70},{88,-70}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(fan1.port_b, GarToi.ports[1]) annotation (Line(
      points={{124,-70},{136,-70}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(volume.ports[2], fan1.port_a) annotation (Line(
      points={{92,-70},{104,-70}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(extent={{-160,-100},{160,100}},
          preserveAspectRatio=false), graphics), Icon(coordinateSystem(extent={
            {-160,-100},{160,100}})));
end CollectionTankSystem;
