within HotelModel.RainWaterCollectionSystem.StorageSystem;
model OutputVolume "Output Volume model from simple liquid water systems"
  replaceable package Medium =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  Modelica.Fluid.Vessels.ClosedVolume Vol(
    redeclare package Medium = Medium,
    V=V,
    use_portsData=use_portsData,
    portsData=portsData) "Volume model"
    annotation (Placement(transformation(extent={{-10,-38},{10,-18}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Vol.fluidVolume)
    "Outputs actual volume of the fluid "
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealOutput VolOut "Value of Real output"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports_b(redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-38,-112},{38,-88}})));
  parameter Modelica.SIunits.Volume V "Volume";
  parameter Boolean use_portsData=true
    "= false to neglect pressure loss and kinetic energy";
  parameter Modelica.Fluid.Vessels.BaseClasses.VesselPortsData portsData[if
    use_portsData then nPorts else 0] "Data of inlet/outlet ports";
equation
  connect(realExpression.y, VolOut) annotation (Line(
      points={{61,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(ports_b, ports_b) annotation (Line(
      points={{0,-100},{0,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Vol.ports[1], ports_b) annotation (Line(
      points={{0,-38},{0,-100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Sphere),
        Text(
          extent={{-78,40},{80,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={85,170,255},
          textString="V = %V"),
        Text(
          extent={{-100,140},{100,100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={85,170,255},
          textString="%name")}));
end OutputVolume;
