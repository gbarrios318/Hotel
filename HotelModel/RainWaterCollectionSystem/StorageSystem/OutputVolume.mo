within HotelModel.RainWaterCollectionSystem.StorageSystem;
model OutputVolume "Output Volume model from simple liquid water systems"
  replaceable package Medium =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  Modelica.Fluid.Vessels.ClosedVolume Vol(
    redeclare package Medium = Medium,
    V=V,
    nPorts=3,
    portsData=portsData,
    use_portsData=false) "Volume model"
    annotation (Placement(transformation(extent={{-10,-38},{10,-18}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Vol.fluidVolume)
    "Outputs actual volume of the fluid "
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealOutput VolOut "Value of Real output"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Modelica.SIunits.Volume V "Volume";
  parameter Boolean use_portsData=true
    "= false to neglect pressure loss and kinetic energy";

  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports1[3](redeclare
      package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{-52,-114},{52,-84}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(realExpression.y, VolOut) annotation (Line(
      points={{61,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Vol.ports, ports1) annotation (Line(
      points={{0,-38},{0,-99}},
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
