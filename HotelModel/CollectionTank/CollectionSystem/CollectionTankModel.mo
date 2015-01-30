within HotelModel.CollectionTank.CollectionSystem;
model CollectionTankModel "Collection Tank Model"

  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Sources.Constant const(k=area)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(integrator.y, product.u1) annotation (Line(
      points={{1,30},{10,30},{10,6},{18,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, product.u2) annotation (Line(
      points={{1,-30},{10,-30},{10,-6},{18,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end CollectionTankModel;
