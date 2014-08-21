within Hotel.Hotel.CoolingTowerSection.CoolingTowerTest;
model TestwithConstant "Testing Cooling Tower with Controls being constant"
 package MediumCW = Buildings.Media.ConstantPropertyLiquidWater
    "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
  CoolingTowerWithControls CooTow(
    redeclare package MediumCW = MediumCW,
    mWater_flow_nominal=mWater_flow_nominal,
    dp_nominal=dp_nominal) "Cooling Tower with Controls"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = MediumCW,
    p=dp_nominal)
    annotation (Placement(transformation(extent={{78,-26},{58,-6}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  inner Modelica.Fluid.System system(T_ambient=283.15)
    annotation (Placement(transformation(extent={{-60,-61},{-40,-41}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(nPorts=1, redeclare package
      Medium =         MediumCW)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
equation
  connect(CooTow.port_b1, bou1.ports[1]) annotation (Line(
      points={{20,-16},{58,-16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const.y, CooTow.m_flo_in) annotation (Line(
      points={{-59,40},{-40,40},{-40,13.4},{-22.6,13.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boundary.ports[1], CooTow.port_a1) annotation (Line(
      points={{-60,-10},{-38,-10},{-38,4},{-20,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),        graphics));
end TestwithConstant;
