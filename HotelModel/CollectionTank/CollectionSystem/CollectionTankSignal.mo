within HotelModel.CollectionTank.CollectionSystem;
model CollectionTankSignal "Collection Tank Model"

  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant Area(k=area)
    "area of the roof collecting water"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Interfaces.RealInput RaiWatIn
    "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Blocks.Sources.Constant Intom(k=0.0254) "inches to meter converter"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Sources.Constant WatDen(k=999.97) "Water Density"
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Modelica.Blocks.Interfaces.RealOutput MasRai "mass of the rainl"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Real area "Constant output value";
equation
  connect(Area.y, product.u2) annotation (Line(
      points={{1,0},{10,0},{10,14},{18,14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, product1.u1) annotation (Line(
      points={{41,20},{50,20},{50,6},{58,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product2.u1, Intom.y) annotation (Line(
      points={{-22,46},{-46,46},{-46,60},{-59,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product1.u2, WatDen.y) annotation (Line(
      points={{58,-6},{50,-6},{50,-20},{41,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product1.y, MasRai) annotation (Line(
      points={{81,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.u1, product2.y) annotation (Line(
      points={{18,26},{10,26},{10,40},{1,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product2.u2, integrator.y) annotation (Line(
      points={{-22,34},{-30,34},{-30,30},{-39,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(RaiWatIn, integrator.u) annotation (Line(
      points={{-120,0},{-80,0},{-80,30},{-62,30}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics));
end CollectionTankSignal;
