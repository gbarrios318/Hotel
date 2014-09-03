within HotelModel.HeatPumpSection.HeatPumpPackage.Example;
model HeatPumpwithControls "Testing the Heat Pump with controls"
     replaceable package MediumCW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
  import HotelModel;
 extends Modelica.Icons.Example;

  HotelModel.HeatPumpSection.HeatPumpPackage.HeatPumpwithControls
    heatPumpwithControls(
    redeclare package MediumCW = MediumCW,
    mWater_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    p(displayUnit="Pa") = 300000,
    nPorts=1,
    redeclare package Medium = MediumCW,
    T=333.15) "Sink"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    nPorts=1,
    p=300000 + dp_nominal,
    redeclare package Medium = MediumCW,
    T=303.15)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Sources.Step step(startTime=100)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(heatPumpwithControls.port_b1, sin.ports[1]) annotation (Line(
      points={{10,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou.ports[1], heatPumpwithControls.port_a1) annotation (Line(
      points={{-50,0},{-10.2,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(step.y, heatPumpwithControls.InSig) annotation (Line(
      points={{-39,50},{-26,50},{-26,4},{-12,4}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPumpwithControls;
