within HotelModel.CoolingTowerSection.CoolingTowerTest;
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
    annotation (Placement(transformation(extent={{20,59},{40,79}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(nPorts=1, redeclare package
      Medium =         MediumCW)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Interfaces.RealOutput T1 "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 30)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
equation
  connect(CooTow.port_b1, bou1.ports[1]) annotation (Line(
      points={{20,-16},{58,-16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boundary.ports[1], CooTow.port_a1) annotation (Line(
      points={{-60,-10},{-40,-10},{-40,4},{-20,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(CooTow.T1, T1) annotation (Line(
      points={{22,12},{60,12},{60,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(CooTow.m_flo_in, const.y) annotation (Line(
      points={{-22.6,13.4},{-39.3,13.4},{-39.3,40},{-59,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(const1.y, CooTow.TWea) annotation (Line(
      points={{-59,-60},{-30,-60},{-30,-10.6},{-22.6,-10.6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),        graphics));
end TestwithConstant;
