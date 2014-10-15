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
   parameter Modelica.SIunits.Pressure dpDW_nominal=100
    "Nominal pressure difference";
        parameter Modelica.SIunits.Volume VTan "Volume of the tank";
    parameter Modelica.SIunits.Height hTan "Height of the tank";
    parameter Modelica.SIunits.Thickness dIns "Thickness of the insulation";
    parameter Modelica.SIunits.HeatFlowRate Q_flow_DWnominal
    "Nominal heat flow rate";

  HotelModel.DomesticHotWater.DomesticHotWaterSystem domesticHotWaterSystem(
      redeclare package MediumDW = MediumDW, mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=dpDW_nominal,
    VTan=VTan,
    hTan=hTan,
    dIns=dIns,
    Q_flow_DWnominal=Q_flow_DWnominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant TBoiSet(k=273.15 + 60)
    annotation (Placement(transformation(extent={{-92,-28},{-72,-8}})));
  Buildings.Controls.Continuous.LimPID conPID
    annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
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
    nPorts=1,
    redeclare package Medium = MediumDW,
    p=1000000000)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    nPorts=1,
    redeclare package Medium = MediumDW,
    p=10000 + 100) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-64})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
equation

  connect(TBoiSet.y,conPID. u_s) annotation (Line(
      points={{-71,-18},{-52,-18}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPID.y, domesticHotWaterSystem.TBoiSet) annotation (Line(
      points={{-29,-18},{-22,-18},{-22,-4},{-12,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticHotWaterSystem.TBoi, conPID.u_m) annotation (Line(
      points={{11,-4},{20,-4},{20,-34},{-40,-34},{-40,-30}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticHotWaterSystem.TBoi, TBoi1) annotation (Line(
      points={{11,-4},{40,-4},{40,-30},{110,-30}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(MassFloRateKit.y, domesticHotWaterSystem.m_flow_in_kit) annotation (
      Line(
      points={{-39,50},{-24,50},{-24,3},{-12,3}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(MassFloRateDom.y, domesticHotWaterSystem.m_flow_in_dom) annotation (
      Line(
      points={{-39,80},{-20,80},{-20,7},{-12,7}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sou.ports[1], domesticHotWaterSystem.port_a2) annotation (Line(
      points={{0,-54},{0,-10}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sin.ports[1], domesticHotWaterSystem.port_a1) annotation (Line(
      points={{-60,20},{-40,20},{-40,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end DomesticHotWaterSystem;
