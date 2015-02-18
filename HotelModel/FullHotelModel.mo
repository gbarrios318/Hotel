within HotelModel;
model FullHotelModel
  "Hotel Model including both the Heat Recover and Rain Water collection subsystems"
  HeatRecoverySystem.HeatRecoverySystem heatRecoverySystem
    annotation (Placement(transformation(extent={{20,0},{60,20}})));
  RainWaterCollectionSystem.RainWaterCollectionTankModel
    rainWaterCollectionTankModel
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.Fluid.Sources.FixedBoundary DomHotWat(nPorts=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-30})));
  Buildings.Fluid.Sources.FixedBoundary KitWat(nPorts=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,50})));
  Buildings.Fluid.Sources.Boundary_pT CitWat(nPorts=2) "City Water" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,70})));
equation
  connect(weaDat.weaBus, rainWaterCollectionTankModel.weaBus1) annotation (Line(
      points={{-60,30},{-10,30}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(weaDat.weaBus, heatRecoverySystem.weaBus) annotation (Line(
      points={{-60,30},{-20,30},{-20,6},{20,6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(rainWaterCollectionTankModel.CooTow1, heatRecoverySystem.port_a1)
    annotation (Line(
      points={{10,30},{20,30},{20,14}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatRecoverySystem.CitWat1, CitWat.ports[1]) annotation (Line(
      points={{40,20},{40,48},{22,48},{22,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(rainWaterCollectionTankModel.CitWat1, CitWat.ports[2]) annotation (
      Line(
      points={{0,40},{0,48},{18,48},{18,60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatRecoverySystem.KitWat1, KitWat.ports[1]) annotation (Line(
      points={{60,16},{70,16},{70,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatRecoverySystem.DomHotWat1, DomHotWat.ports[1]) annotation (Line(
      points={{60,4},{70,4},{70,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end FullHotelModel;
