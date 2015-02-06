within HotelModel.CollectionTank;
model CollectionTankSystem
  "Collection Tank System components not including control sequence"
  CollectionSystem.CollectionTankModel ColTan annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-70,50})));
  StorageSystem.StorageSystemModel StoSys
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  ProcessingSystem.ProcessingSystemModel ProSys
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  UsageSystem.UsageSystemModel UseSys
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Buildings.Fluid.Sources.Boundary_pT CitWat(nPorts=1) "CityWater" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,50})));
  Buildings.Fluid.Sources.FixedBoundary CooTow(nPorts=1)
    annotation (Placement(transformation(extent={{80,0},{60,20}})));
equation
  connect(ColTan.ports1[1], StoSys.port_a1) annotation (Line(
      points={{-70,40.2},{-70,10},{-60,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(StoSys.port_b1, ProSys.port_a1) annotation (Line(
      points={{-40,10},{-20,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ProSys.port_1, UseSys.port_a1) annotation (Line(
      points={{0,10},{20,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ProSys.CitWat, CitWat.ports[1]) annotation (Line(
      points={{-10,19.8},{-10,40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(UseSys.CooTow, CooTow.ports[1]) annotation (Line(
      points={{40,10},{60,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics), Icon(coordinateSystem(extent={{-100,
            -100},{100,100}})));
end CollectionTankSystem;
