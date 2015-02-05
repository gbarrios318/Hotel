within HotelModel.CollectionTank.ProcessingSystem.Examples;
model FilterModel "Filter Model example"
  import HotelModel;
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  parameter Modelica.SIunits.Pressure dpfilter_nominal
    "Pressure drop at nominal mass flow rate";
  HotelModel.CollectionTank.ProcessingSystem.FilterModel filterModel(
    redeclare package MediumRainWater = MediumRainWater,
    dpfilter_nominal(displayUnit="kPa") = 11720,
    m_flow_nominal=1.89)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.Boundary_pT Sou(nPorts=1,
    redeclare package Medium = MediumRainWater,
    use_p_in=true)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Fluid.Sources.Boundary_pT Sou1(
                                          nPorts=1, redeclare package Medium =
        MediumRainWater)
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Sources.Step step(
    height=150000,
    offset=100000,
    startTime=1200)
    annotation (Placement(transformation(extent={{-94,20},{-74,40}})));
  Buildings.Fluid.Sensors.Pressure senPre(redeclare package Medium =
        MediumRainWater)
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
equation
  connect(filterModel.port_a1, Sou.ports[1]) annotation (Line(
      points={{-10,0},{-40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(filterModel.port_b1, Sou1.ports[1]) annotation (Line(
      points={{10,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(Sou.p_in, step.y) annotation (Line(
      points={{-62,8},{-68,8},{-68,30},{-73,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(filterModel.port_b1, senPre.port) annotation (Line(
      points={{10,0},{20,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(graphics));
end FilterModel;
