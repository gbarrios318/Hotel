within HotelModel.CollectionTank.ProcessingSystem.Examples;
model FilterModel "Filter Model example"
  import HotelModel;
 extends Modelica.Icons.Example;
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  HotelModel.CollectionTank.ProcessingSystem.FilterModel filterModel(
    redeclare package MediumRainWater = MediumRainWater,
    dpfilter_nominal(displayUnit="kPa") = 11720,
    m_flow_nominal=1.89,
    m_valveflow_nominal=0.39,
    dpValve_nominal(displayUnit="kPa") = 1000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.Boundary_pT Sou(nPorts=1,
    redeclare package Medium = MediumRainWater,
    use_p_in=true)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Step step(
    height=150000,
    offset=100000,
    startTime=1200)
    annotation (Placement(transformation(extent={{-94,20},{-74,40}})));
  Buildings.Fluid.Sensors.Pressure senPre(redeclare package Medium =
        MediumRainWater)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Buildings.Fluid.Sources.FixedBoundary sinc(nPorts=1, redeclare package Medium
      = MediumRainWater)
    annotation (Placement(transformation(extent={{66,-10},{46,10}})));
  Modelica.Blocks.Sources.Constant FluValCon(k=0) "Flush valve controls"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
equation
  connect(filterModel.port_a1, Sou.ports[1]) annotation (Line(
      points={{-10,0},{-40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(Sou.p_in, step.y) annotation (Line(
      points={{-62,8},{-68,8},{-68,30},{-73,30}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(filterModel.port_b1, senPre.port) annotation (Line(
      points={{10,0},{30,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senPre.port, sinc.ports[1]) annotation (Line(
      points={{30,0},{46,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(FluValCon.y, filterModel.FlushFil) annotation (Line(
      points={{-39,-30},{-20,-30},{-20,-6},{-12,-6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics));
end FilterModel;
