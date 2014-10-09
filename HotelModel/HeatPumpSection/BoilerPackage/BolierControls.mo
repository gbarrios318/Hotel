within HotelModel.HeatPumpSection.BoilerPackage;
model BolierControls "Boiler with controls, including valve controls"
  parameter Real TSetBoiIn "Set temperature for boiler";
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=2)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1,1,0; 2,1,0; 3,
        0,1; 4,0,1; 5,0,1; 6,0,1; 7,0,1])
    annotation (Placement(transformation(extent={{22,30},{42,50}})));
  Modelica.Blocks.Sources.Constant TSetBoi(k=TSetBoiIn)
    "Set point temperature of boiler"
    annotation (Placement(transformation(extent={{-40,-36},{-20,-16}})));
  Buildings.Controls.Continuous.LimPID conPID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=60)
    annotation (Placement(transformation(extent={{0,-36},{20,-16}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Modelica.Blocks.Interfaces.RealOutput BoiCtr
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput Val4Ctr
    "Connector of Real output signals"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealInput TMea
    "Measured temperture of water leaving the heat pump" annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.IntegerInput sta
    "State of the system sent from superviory control"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
equation
  connect(replicator.y, combiTable1D.u) annotation (Line(
      points={{1,40},{20,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(integerToReal.y, replicator.u) annotation (Line(
      points={{-59,40},{-22,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPID.y, product.u2) annotation (Line(
      points={{21,-26},{58,-26}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(product.y, BoiCtr) annotation (Line(
      points={{81,-20},{110,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.u_m, TMea) annotation (Line(
      points={{10,-38},{10,-60},{-120,-60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(integerToReal.u, sta) annotation (Line(
      points={{-82,40},{-120,40}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(BoiCtr, BoiCtr) annotation (Line(
      points={{110,-20},{110,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSetBoi.y, conPID.u_s) annotation (Line(
      points={{-19,-26},{-2,-26}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(combiTable1D.y[1], product.u1) annotation (Line(
      points={{43,39.5},{50,39.5},{50,-14},{58,-14}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Val4Ctr, combiTable1D.y[2]) annotation (Line(
      points={{110,40},{76,40},{76,40.5},{43,40.5}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),        graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-80,60},{80,-80}},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,255}),
        Text(
          extent={{-60,88},{60,66}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end BolierControls;
