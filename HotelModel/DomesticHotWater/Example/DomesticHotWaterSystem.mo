within HotelModel.DomesticHotWater.Example;
model DomesticHotWaterSystem "Example for the domestic hot water loop"
  import HotelModel;
 extends Modelica.Icons.Example;
  replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal=20
    "Nominal mass flow rate";
    //The nominal flow rate may be different
  HotelModel.DomesticHotWater.DomesticHotWaterSystem domesticHotWaterSystem(
      redeclare package MediumDW = MediumDW, mDW_flow_nominal=mDW_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = MediumDW,
    use_m_flow_in=true)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary1(
    nPorts=1,
    redeclare package Medium = MediumDW,
    use_m_flow_in=true)
    annotation (Placement(transformation(extent={{60,10},{40,30}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary2(
    nPorts=1,
    use_m_flow_in=true,
    redeclare package Medium = MediumDW) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-52})));
  Modelica.Blocks.Sources.Constant TBoiSet(k=273.15 + 60)
    annotation (Placement(transformation(extent={{-92,-28},{-72,-8}})));
  Buildings.Controls.Continuous.LimPID conPID
    annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
  Modelica.Blocks.Interfaces.RealOutput TBoi1 "Boiler temperature" annotation (
      Placement(transformation(extent={{100,-40},{120,-20}}),
        iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Sources.Constant MassFloRate1(k=15)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Blocks.Sources.Constant MassFloRate2(k=10)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  Modelica.Blocks.Sources.Constant MassFloRate3(k=80)
    annotation (Placement(transformation(extent={{50,50},{70,70}})));
  Modelica.Blocks.Sources.Constant MassFloRateDom(k=20)
    "Mass flow rate for the domestic water"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Sources.Constant MassFloRateKit(k=5)
    "mass flow rate for the kitchen"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
equation

  connect(boundary.ports[1], domesticHotWaterSystem.port_a1) annotation (Line(
      points={{-40,10},{-26,10},{-26,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(domesticHotWaterSystem.port_a2, boundary2.ports[1]) annotation (Line(
      points={{0,-10},{0,-42},{8.88178e-016,-42}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(domesticHotWaterSystem.port_a3, boundary1.ports[1]) annotation (Line(
      points={{10,0},{26,0},{26,20},{40,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TBoiSet.y,conPID. u_s) annotation (Line(
      points={{-71,-18},{-52,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.y, domesticHotWaterSystem.TBoiSet) annotation (Line(
      points={{-29,-18},{-22,-18},{-22,-4},{-12,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(domesticHotWaterSystem.TBoi, conPID.u_m) annotation (Line(
      points={{11,-4},{20,-4},{20,-34},{-40,-34},{-40,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(domesticHotWaterSystem.TBoi, TBoi1) annotation (Line(
      points={{11,-4},{32,-4},{32,-30},{110,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MassFloRate1.y, boundary.m_flow_in) annotation (Line(
      points={{-79,40},{-70,40},{-70,18},{-60,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MassFloRate3.y, boundary1.m_flow_in) annotation (Line(
      points={{71,60},{84,60},{84,28},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MassFloRate2.y, boundary2.m_flow_in) annotation (Line(
      points={{-39,-80},{-8,-80},{-8,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MassFloRateKit.y, domesticHotWaterSystem.m_flow_in_kit) annotation (
      Line(
      points={{-39,50},{-24,50},{-24,3},{-12,3}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MassFloRateDom.y, domesticHotWaterSystem.m_flow_in_dom) annotation (
      Line(
      points={{-39,80},{-20,80},{-20,7},{-12,7}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end DomesticHotWaterSystem;
