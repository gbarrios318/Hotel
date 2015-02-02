within HotelModel.HeatRecoverySystem.Control;
model CoolingTowerControl
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Modelica.SIunits.MassFlowRate pum1MasFlo
    "constant mass flow rate of pum1";
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-80,22},{-60,42}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=1)
    annotation (Placement(transformation(extent={{-50,22},{-30,42}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1, 0; 2, 0; 3, 0; 4,
        0; 5, 0; 6, 1; 7, 1])
    annotation (Placement(transformation(extent={{-10,22},{10,42}})));
  Modelica.Blocks.Interfaces.IntegerInput sta
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput pum1
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant const(k=pum1MasFlo)
    annotation (Placement(transformation(extent={{-10,-16},{10,4}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(integerToReal.y, replicator.u) annotation (Line(
      points={{-59,32},{-52,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sta, integerToReal.u) annotation (Line(
      points={{-120,0},{-92,0},{-92,32},{-82,32}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(replicator.y, combiTable1D.u) annotation (Line(
      points={{-29,32},{-12,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pum1, pum1) annotation (Line(
      points={{110,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pum1, product1.y) annotation (Line(
      points={{110,0},{81,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[1], product1.u1) annotation (Line(
      points={{11,32},{46,32},{46,6},{58,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, product1.u2) annotation (Line(
      points={{11,-6},{58,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (defaultComponentName="cooTowCon", Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end CoolingTowerControl;
