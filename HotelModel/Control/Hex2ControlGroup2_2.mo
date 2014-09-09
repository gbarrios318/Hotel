within HotelModel.Control;
model Hex2ControlGroup2_2
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Modelica.SIunits.MassFlowRate pum3_mass_flow
    "constant mass flow rate of pum3";
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-80,64},{-60,84}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=5)
    annotation (Placement(transformation(extent={{-50,64},{-30,84}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1, 0, 0, 1, 0, 0; 2,
        1, 0, 1, 1, 1; 3, 1, 0, 1, 1, 1; 4, 0, 0, 1, 0, 0; 5, 0, 1, 0, 1, 0; 6,
        0, 1, 0, 1, 0; 7, 0, 0, 1, 0, 0])
    annotation (Placement(transformation(extent={{-10,64},{10,84}})));
  Modelica.Blocks.Interfaces.IntegerInput sta
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput MV1 annotation (Placement(
        transformation(extent={{100,50},{120,70}}), iconTransformation(extent={
            {100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput MV2 annotation (Placement(
        transformation(extent={{100,20},{120,40}}), iconTransformation(extent={
            {100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput MV3
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput MV4 annotation (Placement(
        transformation(extent={{100,-40},{120,-20}}), iconTransformation(extent=
           {{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealOutput pum3 annotation (Placement(
        transformation(extent={{100,-70},{120,-50}}), iconTransformation(extent=
           {{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealInput masFloMV2
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Math.Add add(k1=pum3_mass_flow)
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
equation
  connect(integerToReal.y, replicator.u) annotation (Line(
      points={{-59,74},{-52,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sta, integerToReal.u) annotation (Line(
      points={{-120,40},{-92,40},{-92,74},{-82,74}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(replicator.y, combiTable1D.u) annotation (Line(
      points={{-29,74},{-12,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[1], MV1) annotation (Line(
      points={{11,73.2},{20,73.2},{20,60},{110,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[2], MV2) annotation (Line(
      points={{11,73.6},{20,73.6},{20,30},{110,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[3], MV3) annotation (Line(
      points={{11,74},{20,74},{20,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[4], MV4) annotation (Line(
      points={{11,74.4},{20,74.4},{20,-30},{110,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pum3, add.y) annotation (Line(
      points={{110,-60},{61,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(masFloMV2, add.u2) annotation (Line(
      points={{-120,-20},{-30,-20},{-30,-66},{38,-66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[5], add.u1) annotation (Line(
      points={{11,74.8},{20,74.8},{20,-54},{38,-54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pum3, pum3) annotation (Line(
      points={{110,-60},{110,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Hex2ControlGroup2_2;
