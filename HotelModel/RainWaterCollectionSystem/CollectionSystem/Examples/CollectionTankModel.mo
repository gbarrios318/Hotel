within HotelModel.RainWaterCollectionSystem.CollectionSystem.Examples;
model CollectionTankModel "Collection tank model example "
  import HotelModel;
 extends Modelica.Icons.Example;
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  HotelModel.RainWaterCollectionSystem.CollectionSystem.CollectionTankModel
    ColTan(area=10, redeclare package MediumRainWater = MediumRainWater)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=4,
    offset=6,
    freqHz=1/3600) "Rain water simulation"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Buildings.Fluid.Sources.FixedBoundary bou(          redeclare package Medium
      = MediumRainWater, nPorts=1)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumRainWater)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation

  connect(bou.ports[1], senMasFlo.port_b) annotation (Line(
      points={{60,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ColTan.ports1[1], senMasFlo.port_a) annotation (Line(
      points={{-20.2,0},{20,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sine.y, ColTan.RaiWatIn1) annotation (Line(
      points={{-59,0},{-50,0},{-50,-4},{-42,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end CollectionTankModel;
