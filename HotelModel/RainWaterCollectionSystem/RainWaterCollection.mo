within HotelModel.RainWaterCollectionSystem;
model RainWaterCollection "Simulation for the rain water collection system"
 extends Modelica.Icons.Example;
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  replaceable package MediumCityWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  RainWaterCollectionTankModel rainWaterCollectionTankModel(
    redeclare package MediumRainWater = MediumRainWater,
    redeclare package MediumCityWater = MediumCityWater,
    m_RWflow_nominal=7.89,
    dpSSFil_nominal(displayUnit="kPa") = 68940,
    dpUVFil_nominal(displayUnit="kPa") = 68940,
    dpRW_nominal(displayUnit="kPa") = 1103160,
    m_CitWatflow_nominal=551.58,
    m_valveflow_nominal=2,
    dpValve_nominal(displayUnit="kPa") = 34470,
    SSFilIn=0,
    UVFilIn=0,
    ColTanVol=6.06,
    area=10,
    dp_OFnominal(displayUnit="kPa") = 1000,
    m_OFflow_nominal=0.5,
    StoTanVol=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.Boundary_pT bou(nPorts=1,
    redeclare package Medium = MediumCityWater,
    use_p_in=true)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Fluid.Sources.FixedBoundary bou1(nPorts=1, redeclare package Medium
      = MediumRainWater)
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant const(k=1000 + 80)
    annotation (Placement(transformation(extent={{-78,58},{-58,78}})));
equation
  connect(bou.ports[1], rainWaterCollectionTankModel.CitWat1) annotation (Line(
      points={{-20,60},{0,60},{0,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(rainWaterCollectionTankModel.CooTow, bou1.ports[1]) annotation (Line(
      points={{10,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(weaDat.weaBus, rainWaterCollectionTankModel.weaBus1) annotation (Line(
      points={{-40,0},{-10,0}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bou.p_in, const.y) annotation (Line(
      points={{-42,68},{-57,68}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end RainWaterCollection;
