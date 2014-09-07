within HotelModel.DomesticHotWater.Example;
model DomesticWaterControls "Example for the domestic water controls"
  import HotelModel;
 extends Modelica.Icons.Example;
  replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal=20
    "Nominal mass flow rate";
  HotelModel.DomesticHotWater.DomesticWaterControls domesticWaterControls(
      redeclare package MediumDW = MediumDW, mDW_flow_nominal=mDW_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumDW,
    use_m_flow_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = MediumDW,
    use_m_flow_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{60,10},{40,30}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary2(
    use_m_flow_in=true,
    redeclare package Medium = MediumDW,
    nPorts=1)                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-50})));
  Modelica.Blocks.Sources.Constant MassFloRate1(k=15)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Modelica.Blocks.Sources.Constant MassFloRate2(k=10)
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Modelica.Blocks.Sources.Constant MassFloRate3(k=80)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
equation

  connect(MassFloRate1.y,boundary. m_flow_in) annotation (Line(
      points={{-69,50},{-60,50},{-60,28},{-50,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MassFloRate3.y,boundary1. m_flow_in) annotation (Line(
      points={{81,70},{94,70},{94,28},{60,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MassFloRate2.y,boundary2. m_flow_in) annotation (Line(
      points={{-29,-70},{-8,-70},{-8,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundary2.ports[1], domesticWaterControls.port_a3) annotation (Line(
      points={{0,-40},{0,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary.ports[1], domesticWaterControls.port_a1) annotation (Line(
      points={{-30,20},{-20,20},{-20,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary1.ports[1], domesticWaterControls.port_a2) annotation (Line(
      points={{40,20},{20,20},{20,0},{10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end DomesticWaterControls;
