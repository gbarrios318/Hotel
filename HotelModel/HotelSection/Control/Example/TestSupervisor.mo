within HotelModel.HotelSection.Control.Example;
model TestSupervisor

  Modelica.Blocks.Sources.Constant Tem3(k=273.15 + 30)
    annotation (Placement(transformation(extent={{-90,12},{-70,32}})));
  Modelica.Blocks.Sources.Constant Tem2(k=273.15 + 30)
    annotation (Placement(transformation(extent={{-66,38},{-46,58}})));
  Modelica.Blocks.Sources.Constant TBoi1(k=273.15 + 58)
    annotation (Placement(transformation(extent={{-90,-24},{-70,-4}})));
  Modelica.Blocks.Sources.Constant masFloHotWat(k=9)
    annotation (Placement(transformation(extent={{-66,-50},{-46,-30}})));
  SupervisoryControl supCon(
    dT(displayUnit="K"),
    deaBan(displayUnit="K"),
    masFloSet=10,
    TBoi1Set=333.15,
    TBoi2Set=289.261,
    T1Set=291.4833,
    T2Set=298.15,
    T3Set=302.0389)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation
  connect(Tem2.y, supCon.Tem2) annotation (Line(
      points={{-45,48},{-34,48},{-34,6},{-10,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tem3.y, supCon.Tem3) annotation (Line(
      points={{-69,22},{-42,22},{-42,2},{-10,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TBoi1.y, supCon.TBoi1) annotation (Line(
      points={{-69,-14},{-42,-14},{-42,-2},{-10,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(masFloHotWat.y, supCon.masFloHotWat) annotation (Line(
      points={{-45,-40},{-34,-40},{-34,-6},{-10,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end TestSupervisor;
