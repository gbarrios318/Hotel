within HotelModel.HeatPumpSection.HeatExchangeValvesPackage;
model HeatExchangeControls "Controls for the Heat Exchange"

  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=2)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1,0,1; 2,1,0; 3,1,0;
        4,0,1; 5,1,0; 6,1,0; 7,0,1])
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Interfaces.IntegerInput u1
    "Connector of Integer input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput ValCtrlByp "controls bypass valve"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput ValCtrl2 "control for hex valve 2"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput ValCtrl1 "control for hex valve 1"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
equation
  connect(integerToReal.y, replicator.u) annotation (Line(
      points={{-39,0},{-22,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(replicator.y, combiTable1D.u) annotation (Line(
      points={{1,0},{18,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(integerToReal.u, u1) annotation (Line(
      points={{-62,0},{-120,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(combiTable1D.y[2], ValCtrlByp) annotation (Line(
      points={{41,0.5},{60,0.5},{60,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ValCtrl1, ValCtrl2) annotation (Line(
      points={{110,-40},{80,-40},{80,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[1], ValCtrl2) annotation (Line(
      points={{41,-0.5},{40,-0.5},{40,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),        graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Rectangle(
          extent={{-80,60},{80,-60}},
          lineColor={0,0,127},
          fillColor={255,255,85},
          fillPattern=FillPattern.Solid), Text(
          extent={{-46,90},{38,72}},
          lineColor={0,0,255},
          textString="%HexControls")}));
end HeatExchangeControls;
