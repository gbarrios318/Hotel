within HotelModel.RainWaterCollectionSystem;
model RainWaterCollectionTankModel
  "Collection Tank System components not including control sequence"
  CollectionSystem.CollectionTankModel ColTan annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-70,30})));
  StorageSystem.StorageSystemModel StoSys
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  ProcessingSystem.ProcessingSystemModel ProSys
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  UsageSystem.UsageSystemModel UseSys
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a CitWat1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Blocks.Interfaces.RealInput RaiWatIn1
    "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Fluid.Interfaces.FluidPort_a CooTow1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(ColTan.ports1[1], StoSys.port_a1) annotation (Line(
      points={{-70,20.2},{-70,0},{-60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(StoSys.port_b1, ProSys.port_a1) annotation (Line(
      points={{-40,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ProSys.port_1, UseSys.port_a1) annotation (Line(
      points={{10,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ProSys.CitWat, CitWat1) annotation (Line(
      points={{0,9.8},{0,100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ColTan.RaiWatIn1, RaiWatIn1) annotation (Line(
      points={{-70,42},{-70,60},{-120,60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(UseSys.CooTow, CooTow1) annotation (Line(
      points={{80,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics), Icon(coordinateSystem(extent={{-100,
            -100},{100,100}}, preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-60,-40},{60,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,70},{60,-50}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,6},{94,-6}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-60,80},{60,60}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-60,40},{60,-50}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-60,-40},{60,-60}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,30},{60,50}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-24},{60,-50}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-60,70},{-60,-50}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{60,70},{60,-50}},
          color={0,0,0},
          smooth=Smooth.None),
        Rectangle(
          extent={{-6,92},{6,70}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Text(
          extent={{-100,-60},{100,-100}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          textString="%name")}));
end RainWaterCollectionTankModel;
