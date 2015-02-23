within HotelModel.HeatRecoverySystem.HeatPumpSection.HeatPumpPackage.Example;
model HeatPump "Testing the Heat Pump "
     replaceable package MediumHW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for hot water loop"
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
    annotation (Placement(transformation(extent={{72,-10},{52,10}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumHW,
    p=300000 + dpHW_nominal,
    T=303.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.Constant const1(k=30000)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  HotelModel.HeatRecoverySystem.HeatPumpSection.HeatPumpPackage.HeatPump
    heatPump(
    redeclare package MediumHW = MediumHW,
    mHW_flow_nominal=mHW_flow_nominal,
    dpHW_nominal=dpHW_nominal,
    HeatPumpVol=HeatPumpVol,
    HeaPumTRef=HeaPumTRef)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(const1.y, heatPump.Q_flow) annotation (Line(
      points={{-59,-50},{-36,-50},{-36,-4},{-11.2,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sin.ports[1], heatPump.port_b1) annotation (Line(
      points={{52,0},{10,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(sou.ports[1], heatPump.port_a1) annotation (Line(
      points={{-50,0},{-10.2,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPump;
