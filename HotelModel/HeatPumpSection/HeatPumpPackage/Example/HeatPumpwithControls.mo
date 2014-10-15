within HotelModel.HeatPumpSection.HeatPumpPackage.Example;
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

  HotelModel.HeatPumpSection.HeatPumpPackage.HeatPumpwithControls
    heatPumpwithControls(
    redeclare package MediumHW = MediumHW,
    mHW_flow_nominal=mHW_flow_nominal,
    dpHW_nominal=dpHW_nominal,
    HeatPumpVol=HeatPumpVol,
    HeaPumTRef=HeaPumTRef)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    p(displayUnit="Pa") = 300000,
    nPorts=1,
    redeclare package Medium = MediumHW,
    T=333.15) "Sink"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    nPorts=1,
    p=300000 + dpHW_nominal,
    redeclare package Medium = MediumHW,
    T=303.15)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.Constant const1(k=30000)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
equation
  connect(heatPumpwithControls.port_b1, sin.ports[1]) annotation (Line(
      points={{10,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sou.ports[1], heatPumpwithControls.port_a1) annotation (Line(
      points={{-50,0},{-10.2,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const1.y, heatPumpwithControls.Q_flow1) annotation (Line(
      points={{-49,-40},{-30,-40},{-30,-4},{-12,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpwithControls;
