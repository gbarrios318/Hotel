within HotelModel.HeatRecoverySystem.HeatPumpSection.HeatPumpPackage.Example;
model HeatPumpwithControls "Testing the Heat Pump with controls"
     replaceable package MediumHW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dpHW_nominal=100
    "Nominal pressure difference";
  parameter Modelica.SIunits.Volume HeatPumpVol "Volume of the Heat Pump";
  parameter Modelica.SIunits.Temperature HeaPumTRef
    "Reference tempearture of heat pump";

  import HotelModel;
 extends Modelica.Icons.Example;

  Buildings.Fluid.Sources.Boundary_pT sin(
    p(displayUnit="Pa") = 300000,
    redeclare package Medium = MediumHW,
    T=333.15,
    nPorts=1) "Sink"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    p=300000 + dpHW_nominal,
    redeclare package Medium = MediumHW,
    T=303.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.Constant const1(k=30000)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  HotelModel.HeatRecoverySystem.HeatPumpSection.HeatPumpPackage.HeatPumpwithControls
    heatPumpwithControls(
    redeclare package MediumHW = MediumHW,
    mHW_flow_nominal=mHW_flow_nominal,
    dpHW_nominal=dpHW_nominal,
    HeatPumpVol=HeatPumpVol,
    HeaPumTRef=HeaPumTRef)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
equation
  connect(const1.y, heatPumpwithControls.Q_flow1) annotation (Line(
      points={{-49,-40},{-30,-40},{-30,-8},{-24,-8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sou.ports[1], heatPumpwithControls.port_a1) annotation (Line(
      points={{-50,0},{-20.4,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sin.ports[1], heatPumpwithControls.port_b1) annotation (Line(
      points={{60,0},{20,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpwithControls;
