within HotelModel.RainWaterCollectionSystem.StorageSystem;
model OutVol "Output Volume model"

  Modelica.Fluid.Vessels.ClosedVolume Vol(
    redeclare package Medium = MediumRainWater,
    V=V) "Volume model"
    annotation (Placement(transformation(extent={{-10,-44},{10,-24}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Vol.fluidVolume)
    "Outputs actual volume of the fluid "
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealOutput VolOut "Value of Real output"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports1[size(Vol.ports,
    1)] "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{-10,-138},{10,-58}})));
equation
  connect(realExpression.y, VolOut) annotation (Line(
      points={{61,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end OutVol;
