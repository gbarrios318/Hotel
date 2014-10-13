within HotelModel.Control;
model Boi2Control
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Modelica.SIunits.Temperature TBoi2Set
    "Working temperature for boiler2";
  parameter Real kPCon "Gain of controler for boiler2 P control";
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-80,64},{-60,84}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=3)
    annotation (Placement(transformation(extent={{-50,64},{-30,84}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1, 1, 1, 0; 2, 1, 1,
        0; 3, 0, 0, 1; 4, 0, 0, 1; 5, 0, 0, 1; 6, 0, 0, 1; 7, 0, 0, 1])
    annotation (Placement(transformation(extent={{-10,64},{10,84}})));
  Modelica.Blocks.Interfaces.IntegerInput sta
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput boi2
    annotation (Placement(transformation(extent={{100,32},{120,52}})));
  Modelica.Blocks.Interfaces.RealOutput val5
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput val4
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput Tem2
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Buildings.Controls.Continuous.LimPID conPID(controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=kPCon) annotation (Placement(transformation(extent={{-10,26},{10,46}})));
  Modelica.Blocks.Sources.Constant const(k=TBoi2Set)
    annotation (Placement(transformation(extent={{-54,26},{-34,46}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{60,32},{80,52}})));
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
  connect(boi2, boi2) annotation (Line(
      points={{110,42},{110,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, conPID.u_s) annotation (Line(
      points={{-33,36},{-12,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tem2, conPID.u_m) annotation (Line(
      points={{-120,-20},{0,-20},{0,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boi2, product1.y) annotation (Line(
      points={{110,42},{81,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.y, product1.u2) annotation (Line(
      points={{11,36},{58,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[1], product1.u1) annotation (Line(
      points={{11,73.3333},{46,73.3333},{46,48},{58,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[2], val4) annotation (Line(
      points={{11,74},{46,74},{46,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[3], val5) annotation (Line(
      points={{11,74.6667},{46,74.6667},{46,-40},{110,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (defaultComponentName="boi2Con", Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Boi2Control;
