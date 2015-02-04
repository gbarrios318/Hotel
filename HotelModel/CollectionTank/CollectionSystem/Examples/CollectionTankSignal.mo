within HotelModel.CollectionTank.CollectionSystem.Examples;
model CollectionTankSignal "Collection Tank Signal Example"
  import HotelModel;
 extends Modelica.Icons.Example;

  HotelModel.CollectionTank.CollectionSystem.CollectionTankSignal
    collectionTankSignal(area=10)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=4,
    offset=6,
    freqHz=1/3600) "Rain water simulation"
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
equation
  connect(collectionTankSignal.RaiWatIn, sine.y) annotation (Line(
      points={{-12,0},{-41,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end CollectionTankSignal;
