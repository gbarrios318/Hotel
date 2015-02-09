within HotelModel.RainWaterCollectionSystem.ProcessingSystem.Examples;
model testValve
package MediumCityWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{70,-70},{90,-50}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valE(
                              redeclare package Medium = MediumCityWater,
    m_flow_nominal=10,
    dpValve_nominal=10)                              annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-2,0})));
  Buildings.Fluid.Sources.FixedBoundary sinc(nPorts=1,
    redeclare package Medium = MediumCityWater,
    p=100000)
    annotation (Placement(transformation(extent={{76,0},{56,20}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-84,32},{-70,46}})));
  Buildings.Fluid.Sources.FixedBoundary bou(
    redeclare package Medium = MediumCityWater,
    nPorts=1,
    p(displayUnit="bar") = 120000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,64})));
equation
  connect(valE.port_b, sinc.ports[1]) annotation (Line(
      points={{-2,-10},{20,-10},{20,0},{56,0},{56,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(const1.y, valE.y) annotation (Line(
      points={{-69.3,39},{-14,39},{-14,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(bou.ports[1], valE.port_a) annotation (Line(
      points={{10,54},{6,54},{6,10},{-2,10}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end testValve;
