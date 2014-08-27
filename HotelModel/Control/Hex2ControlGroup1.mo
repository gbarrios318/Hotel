within HotelModel.Control;
model Hex2ControlGroup1
  extends Modelica.Blocks.Interfaces.BlockIcon;

  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=3)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1, 0, 0, 1; 2, 1, 1,
        0; 3, 1, 1, 0; 4, 0, 0, 1; 5, 1, 1, 0; 6, 1, 1, 0; 7, 0, 0, 1])
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerInput sta
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput val2
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput val1
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput val3
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
equation
  connect(integerToReal.y, replicator.u) annotation (Line(
      points={{-59,0},{-52,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sta, integerToReal.u) annotation (Line(
      points={{-120,0},{-82,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(replicator.y, combiTable1D.u) annotation (Line(
      points={{-29,0},{-12,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[1], val1) annotation (Line(
      points={{11,0},{26,0},{26,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[2], val2) annotation (Line(
      points={{11,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[3], val3) annotation (Line(
      points={{11,0},{26,0},{26,-40},{110,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (defaultComponentName="Hex2ConGro1", Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Hex2ControlGroup1;
