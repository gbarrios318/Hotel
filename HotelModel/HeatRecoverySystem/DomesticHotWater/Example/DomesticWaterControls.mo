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
  HotelModel.DomesticHotWater.DomesticWaterControls domesticWaterControls(
      redeclare package MediumDW = MediumDW, mDW_flow_nominal=mDW_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = MediumDW,
    use_m_flow_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{60,10},{40,30}})));
  Modelica.Blocks.Sources.Constant MassFloRate3(k=80)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Buildings.Fluid.Sources.Boundary_pT bou(
    nPorts=1,
    redeclare package Medium = MediumDW,
    p=1000000000)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = MediumDW,
    p=10000 + 100)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-48})));
equation

  connect(MassFloRate3.y,boundary1. m_flow_in) annotation (Line(
      points={{81,70},{94,70},{94,28},{60,28}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(boundary1.ports[1], domesticWaterControls.port_a2) annotation (Line(
      points={{40,20},{20,20},{20,-10},{0,-10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticWaterControls.port_a3, bou1.ports[1]) annotation (Line(
      points={{0,-10},{0,-38}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(bou.ports[1], domesticWaterControls.port_a1) annotation (Line(
      points={{-40,20},{-20,20},{-20,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end DomesticWaterControls;
