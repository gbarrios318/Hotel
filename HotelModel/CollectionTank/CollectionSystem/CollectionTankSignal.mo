within HotelModel.CollectionTank.CollectionSystem;
model CollectionTankSignal "Collection Tank Model"

  Modelica.Blocks.Sources.Constant Area(k=area)
    "area of the roof collecting water"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Math.Product VolRat "outputs meters^3 per second"
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Interfaces.RealInput RaiWatIn
    "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Math.Product MasFloRat "outputs kg per sec"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Math.Product InTom "outputs meters per second"
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Modelica.Blocks.Sources.Constant Intom(k=0.0254) "inches to meter converter"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Sources.Constant WatDen(k=999.97) "Water Density"
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Modelica.Blocks.Interfaces.RealOutput MasRai "mass of the rainl"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Real area "Constant output value";
  Modelica.Blocks.Math.Product HouToSec "Outputs inches per second"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant hotosec(k=1/3600)
    "hours to second conversion factor"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
equation
  connect(Area.y, VolRat.u2) annotation (Line(
      points={{1,0},{10,0},{10,24},{18,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(VolRat.y, MasFloRat.u1) annotation (Line(
      points={{41,30},{50,30},{50,6},{58,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(InTom.u1, Intom.y) annotation (Line(
      points={{-22,66},{-40,66},{-40,80},{-59,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MasFloRat.u2, WatDen.y) annotation (Line(
      points={{58,-6},{50,-6},{50,-20},{41,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MasFloRat.y, MasRai) annotation (Line(
      points={{81,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(VolRat.u1, InTom.y) annotation (Line(
      points={{18,36},{10,36},{10,60},{1,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HouToSec.u1, hotosec.y) annotation (Line(
      points={{-62,36},{-70,36},{-70,50},{-79,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(RaiWatIn, HouToSec.u2) annotation (Line(
      points={{-120,0},{-80,0},{-80,24},{-62,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HouToSec.y, InTom.u2) annotation (Line(
      points={{-39,30},{-34,30},{-34,54},{-22,54}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics));
end CollectionTankSignal;
