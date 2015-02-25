within HotelModel.HeatRecoverySystem.DomesticHotWater.Example;
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
   parameter Modelica.SIunits.Pressure dpDW_nominal=100
    "Nominal pressure difference";
        parameter Modelica.SIunits.Volume VTan "Volume of the tank";
    parameter Modelica.SIunits.Height hTan "Height of the tank";
    parameter Modelica.SIunits.Thickness dIns "Thickness of the insulation";
    parameter Modelica.SIunits.HeatFlowRate Q_flow_DWnominal
    "Nominal heat flow rate";

  Modelica.Blocks.Sources.Constant TBoiSet(k=273.15 + 60)
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Buildings.Controls.Continuous.LimPID conPID
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  Modelica.Blocks.Interfaces.RealOutput TBoi1 "Boiler temperature" annotation (
      Placement(transformation(extent={{100,-40},{120,-20}}),
        iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Sources.Constant MassFloRateDom(k=20)
    "Mass flow rate for the domestic water"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Sources.Constant MassFloRateKit(k=5)
    "mass flow rate for the kitchen"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumDW,
    p=1000000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumDW,
    p=10000 + 100,
    nPorts=1)      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-64})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  HotelModel.HeatRecoverySystem.DomesticHotWater.DomesticHotWaterSystem
    domesticHotWaterSystem(
    redeclare package MediumDW = MediumDW,
    mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=dpDW_nominal,
    VTan=1,
    hTan=1,
    dIns=0.05,
    Q_flow_DWnominal=2000000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.Boundary_pT CitWat(
    redeclare package Medium = MediumDW,
    nPorts=1,
    p=10000 + 50) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,50})));
  Buildings.Fluid.Sources.Boundary_pT DomHotWat(
    redeclare package Medium = MediumDW,
    nPorts=1,
    p=10000 + 20) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,0})));
equation

  connect(TBoiSet.y,conPID. u_s) annotation (Line(
      points={{-69,-20},{-52,-20}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPID.y, domesticHotWaterSystem.TBoiSet) annotation (Line(
      points={{-29,-20},{-20,-20},{-20,-4},{-12,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(MassFloRateKit.y, domesticHotWaterSystem.m_flow_in_kit) annotation (
      Line(
      points={{-39,50},{-20,50},{-20,3},{-12,3}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(MassFloRateDom.y, domesticHotWaterSystem.m_flow_in_dom) annotation (
      Line(
      points={{-39,80},{-16,80},{-16,7},{-12,7}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPID.u_m, domesticHotWaterSystem.TBoi) annotation (Line(
      points={{-40,-32},{-40,-40},{40,-40},{40,-4},{11,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sou.ports[1], domesticHotWaterSystem.port_a2) annotation (Line(
      points={{0,-54},{0,-10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticHotWaterSystem.DomHotWat, DomHotWat.ports[1]) annotation (
      Line(
      points={{10,2},{20,2},{20,0},{50,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(CitWat.ports[1], domesticHotWaterSystem.KitWat) annotation (Line(
      points={{0,40},{0,20},{-7,20},{-7,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticHotWaterSystem.TBoi, TBoi1) annotation (Line(
      points={{11,-4},{40,-4},{40,-30},{110,-30}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sin.ports[1], domesticHotWaterSystem.port_b1) annotation (Line(
      points={{-60,20},{-40,20},{-40,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end DomesticHotWaterSystem;
