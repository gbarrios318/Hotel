within HotelModel.CoolingTowerSection;
model CoolingTowerSystem
  "Components directly interacting with the Cooling Tower"
  replaceable package MediumCW =
      Buildings.Media.Interfaces.PartialSimpleMedium
    "Medium in the condenser water side";
  parameter Modelica.SIunits.Power P_nominal
    "Nominal cooling tower component power (at y=1)";
  parameter Modelica.SIunits.TemperatureDifference dTCW_nominal
    "Temperature difference between the outlet and inlet of the module";
  parameter Modelica.SIunits.TemperatureDifference dTApp_nominal
    "Nominal approach temperature";
  parameter Modelica.SIunits.Temperature TWetBul_nominal
    "Nominal wet bulb temperature";
  parameter Modelica.SIunits.Pressure dP_nominal
    "Pressure difference between the outlet and inlet of the module ";
  parameter Modelica.SIunits.MassFlowRate mCW_flow_nominal
    "Nominal mass flow rate";
  parameter Real GaiPi "Gain of the component PI controller";
  parameter Real tIntPi "Integration time of the component PI controller";
  parameter Real v_flow_rate[:] "Volume flow rate rate";
  parameter Real eta[:] "Fan efficiency";
  parameter Modelica.SIunits.Temperature TSet
    "Temperature set point for CW water leaving the cooling tower";
    parameter Real Motor_eta[:] "Motor efficiency";
    parameter Real Hydra_eta[:] "Hydraulic efficiency";

  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumCW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumCW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput TWet
    "Entering air dry or wet bulb temperature" annotation (Placement(
        transformation(extent={{-128,-74},{-100,-46}}), iconTransformation(
          extent={{-124,-70},{-100,-46}})));
  Modelica.Blocks.Math.Gain gain(k=mCW_flow_nominal)
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  CoolingTower coolingTower(
    redeclare package MediumCW = MediumCW,
    P_nominal=P_nominal,
    dTCW_nominal=dTCW_nominal,
    dTApp_nominal=dTApp_nominal,
    TWetBul_nominal=TWetBul_nominal,
    dP_nominal=dP_nominal,
    mCW_flow_nominal=mCW_flow_nominal,
    GaiPi=GaiPi,
    tIntPi=tIntPi,
    v_flow_rate=v_flow_rate,
    eta=eta) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Control.CoolingTowerControl        cooTowCon(pum1MasFlo=mCW_flow_nominal)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  Modelica.Blocks.Interfaces.IntegerInput sta "System status"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Routing.Multiplex2 multiplex2_1
    annotation (Placement(transformation(extent={{68,-50},{88,-30}})));
  Modelica.Blocks.Interfaces.RealOutput P[2]
    "P[1]: Pump Power; P[2]: Tower Power"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=TSet)
    annotation (Placement(transformation(extent={{-56,6},{-36,26}})));
  Buildings.Fluid.Movers.FlowMachine_m_flow Pum(
    motorEfficiency(eta=Motor_eta),
    hydraulicEfficiency(eta=Hydra_eta),
    addPowerToMedium=false,
    allowFlowReversal=true,
    redeclare package Medium = MediumCW,
    m_flow_nominal=mCW_flow_nominal)
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));
equation
  connect(coolingTower.port_a_CW, port_a) annotation (Line(
      points={{-20,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(port_a, port_a) annotation (Line(
      points={{-100,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cooTowCon.sta, sta) annotation (Line(
      points={{-88,60},{-120,60}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(coolingTower.TWetBul, TWet) annotation (Line(
      points={{-22,-4},{-50,-4},{-50,-60},{-114,-60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(coolingTower.P, multiplex2_1.u2[1]) annotation (Line(
      points={{1,-4},{14,-4},{14,-46},{66,-46}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(multiplex2_1.y, P) annotation (Line(
      points={{89,-40},{110,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(realExpression.y, coolingTower.TSet) annotation (Line(
      points={{-35,16},{-30,16},{-30,8},{-22,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(gain.y, Pum.m_flow_in) annotation (Line(
      points={{1,60},{35.8,60},{35.8,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Pum.P, multiplex2_1.u1[1]) annotation (Line(
      points={{47,8},{60,8},{60,-34},{66,-34}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(cooTowCon.pum1, gain.u) annotation (Line(
      points={{-65,60},{-22,60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(cooTowCon.pum1, coolingTower.On) annotation (Line(
      points={{-65,60},{-60,60},{-60,4},{-22,4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Pum.port_b, port_b) annotation (Line(
      points={{46,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTower.port_b_CW, Pum.port_a) annotation (Line(
      points={{0,0},{26,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-40,76},{48,50}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-50,50},{60,-78}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-94,62}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-96,64}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-94,62}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-88,40},{32,40},{42,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{6,40},{0,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{32,40},{24,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{6,38},{14,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-20,40},{-28,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Line(
          points={{-20,40},{-10,20}},
          color={255,0,0},
          smooth=Smooth.None),
        Ellipse(
          extent={{-36,64},{2,64}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-36,70},{2,58}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,70},{44,58}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,-56},{98,-64}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-60,100},{60,80}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end CoolingTowerSystem;
