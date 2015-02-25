within HotelModel.HeatRecoverySystem.DomesticHotWater.Example;
model DomesticWaterControls "Example for the domestic water controls"
  import HotelModel;
 extends Modelica.Icons.Example;
  replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal=20
    "Nominal mass flow rate";
         parameter Modelica.SIunits.Pressure dpDW_nominal=100
    "Nominal pressure difference";
      parameter Modelica.SIunits.Volume VTan "Volume of the tank";
    parameter Modelica.SIunits.Height hTan "Height of the tank";
    parameter Modelica.SIunits.Thickness dIns "Thickness of the insulation";
    parameter Modelica.SIunits.HeatFlowRate Q_flow_DWnominal
    "Nominal heat flow rate";
    parameter Modelica.SIunits.MassFlowRate MassFloDomIn
    "Mass flow rate of water going into domestic water usage";
    parameter Modelica.SIunits.MassFlowRate MassFloKitIn
    "Mass flow rate of water going to kitchen";
    parameter Modelica.SIunits.Temp_K TBoiSetIn "Boiler setting";

  Buildings.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = MediumDW,
    use_m_flow_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  Modelica.Blocks.Sources.Constant MassFloRate3(k=80)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Buildings.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = MediumDW,
    p=1000000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = MediumDW,
    p=10000 + 100,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,0})));
  HotelModel.HeatRecoverySystem.DomesticHotWater.DomesticWaterControls
    domesticWaterControls(
    redeclare package MediumDW = MediumDW,
    mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=dpDW_nominal,
    VTan=VTan,
    hTan=hTan,
    dIns=dIns,
    Q_flow_DWnominal=Q_flow_DWnominal,
    MassFloDomIn=15,
    MassFloKitIn=5,
    TBoiSetIn=273.15 + 49)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = MediumDW,
    p=10000 + 100,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,50})));
  Modelica.Blocks.Sources.Constant MassFloRateDom(k=15)
    annotation (Placement(transformation(extent={{-52,70},{-32,90}})));
  Modelica.Blocks.Sources.Constant MassFloRateKit(k=5)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
equation

  connect(MassFloRate3.y,boundary1. m_flow_in) annotation (Line(
      points={{81,70},{94,70},{94,-42},{40,-42}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(bou.ports[1], domesticWaterControls.port_b1) annotation (Line(
      points={{-40,20},{-20,20},{-20,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticWaterControls.DomHotWat1, bou1.ports[1]) annotation (Line(
      points={{10,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary1.ports[1], domesticWaterControls.port_a2) annotation (Line(
      points={{20,-50},{0,-50},{0,-10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(bou2.ports[1], domesticWaterControls.KitWat1) annotation (Line(
      points={{20,50},{0,50},{0,10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(MassFloRateKit.y, domesticWaterControls.m_flow_in_kit) annotation (
      Line(
      points={{-59,50},{-18,50},{-18,4},{-12,4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(MassFloRateDom.y, domesticWaterControls.m_flow_in_dom) annotation (
      Line(
      points={{-31,80},{-12,80},{-12,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end DomesticWaterControls;
