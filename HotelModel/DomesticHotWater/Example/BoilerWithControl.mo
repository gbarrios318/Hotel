within HotelModel.DomesticHotWater.Example;
model BoilerWithControl
  import HotelModel;
  extends Modelica.Icons.Example;

   package Medium = Buildings.Media.ConstantPropertyLiquidWater "Medium model";
 parameter Modelica.SIunits.Power Q_flow_nominal = 3000 "Nominal power";
 parameter Modelica.SIunits.Temperature dT_nominal = 200
    "Nominal temperature difference";
 parameter Modelica.SIunits.MassFlowRate m_flow_nominal = Q_flow_nominal/dT_nominal/4200
    "Nominal mass flow rate";
 parameter Modelica.SIunits.Pressure dp_nominal = 3000
    "Pressure drop at m_flow_nominal";
  parameter Modelica.SIunits.Temperature TSet= 273.15+100
    "Temperature set point for boiler";

  HotelModel.DomesticHotWater.BoilerWithControl boilerWithControl(
    Q_flow_nominal=Q_flow_nominal,
    dT_nominal=dT_nominal,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    TSet=TSet) annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Buildings.Fluid.Sources.MassFlowSource_T
                                      sou(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=m_flow_nominal,
    T=303.15)
    annotation (Placement(transformation(extent={{-62,-20},{-42,0}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    nPorts=1,
    p(displayUnit="Pa") = 300000,
    T=333.15) "Sink"
    annotation (Placement(transformation(extent={{52,-22},{32,-2}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-86,-60},{-66,-40}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=30,
    freqHz=0.01,
    offset=273.15 + 30)
    annotation (Placement(transformation(extent={{-96,4},{-76,24}})));
equation
  connect(sou.ports[1], boilerWithControl.port_a1) annotation (Line(
      points={{-42,-10},{-32,-10},{-32,-13.6},{-20,-13.6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boilerWithControl.port_b1, sin.ports[1]) annotation (Line(
      points={{0,-13.6},{16,-13.6},{16,-12},{32,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sine.y, sou.T_in) annotation (Line(
      points={{-75,14},{-72,14},{-72,-6},{-64,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end BoilerWithControl;
