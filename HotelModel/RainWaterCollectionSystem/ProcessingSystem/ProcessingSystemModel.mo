within HotelModel.RainWaterCollectionSystem.ProcessingSystem;
model ProcessingSystemModel
  "System model of the processing of collection tank model"
  replaceable package MediumRainWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  replaceable package MediumCityWater =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium in the condenser water side";
  parameter Modelica.SIunits.MassFlowRate m_RWflow_nominal
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dpSSFil_nominal
    "Pressure drop of solid separator filter";
  parameter Modelica.SIunits.Pressure dpUVFil_nominal
    "Pressure drop of UV filter";
  parameter Modelica.SIunits.Pressure dpRW_nominal "Nominal Pressure drop";
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valE(m_flow_nominal=
        m_CitWatflow_nominal, redeclare package Medium = MediumCityWater,
    dpValve_nominal=dpValve_nominal)                 annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-50,60})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valL(redeclare package Medium
      = MediumRainWater, m_flow_nominal=m_RWflow_nominal + m_CitWatflow_nominal,
    dpValve_nominal=dpValve_nominal)
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valK(redeclare package Medium
      = MediumRainWater, m_flow_nominal=m_RWflow_nominal + m_CitWatflow_nominal,
    dpValve_nominal=dpValve_nominal)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  FilterModel SolSepFil(
    redeclare package MediumRainWater = MediumRainWater,
    m_flow_nominal=m_CitWatflow_nominal + m_RWflow_nominal,
    m_valveflow_nominal=m_valveflow_nominal,
    dpfilter_nominal=dpSSFil_nominal,
    dpValve_nominal=dpValve_nominal) "Solid Separator Filter"
    annotation (Placement(transformation(extent={{8,-10},{28,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumRainWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_1(redeclare package Medium =
        MediumRainWater)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a CitWat(redeclare package Medium =
        MediumCityWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));
  FilterModel UVFil(
    redeclare package MediumRainWater = MediumRainWater,
    m_flow_nominal=m_RWflow_nominal + m_CitWatflow_nominal,
    m_valveflow_nominal=m_valveflow_nominal,
    dpfilter_nominal=dpUVFil_nominal,
    dpValve_nominal=dpValve_nominal) "UV Filter System"
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Interfaces.RealInput ValE
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput ValByP
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  parameter Modelica.SIunits.MassFlowRate m_CitWatflow_nominal
    "Nominal mass flow rate";
  Buildings.Examples.ChillerPlant.BaseClasses.Controls.KMinusU kMinu(k=1)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  parameter Modelica.SIunits.MassFlowRate m_valveflow_nominal
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dpValve_nominal
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint";
  Buildings.Fluid.Actuators.Valves.TwoWayLinear valK1(
                                                     redeclare package Medium
      = MediumRainWater, m_flow_nominal=m_RWflow_nominal + m_CitWatflow_nominal,
    dpValve_nominal=dpValve_nominal)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant const1(
                                         k=1)
    annotation (Placement(transformation(extent={{-94,22},{-80,36}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear OneWayVal(
    redeclare package Medium = MediumRainWater,
    m_flow_nominal=m_RWflow_nominal + m_CitWatflow_nominal,
    dpValve_nominal=dpValve_nominal) "one way valve, always open"
    annotation (Placement(transformation(extent={{34,-10},{54,10}})));
  Modelica.Blocks.Sources.Constant SSFilSig(k=SSFilIn)
    "Solid separator controls signal (0: no flush; 1: flush)"
    annotation (Placement(transformation(extent={{-20,-48},{-4,-32}})));
  Modelica.Blocks.Sources.Constant UVFilSig(k=UVFilIn)
    "UV filter control signal (0: no flush; 1: flush)"
    annotation (Placement(transformation(extent={{40,-48},{56,-32}})));
  parameter Real SSFilIn "Constant output value";
  parameter Real UVFilIn "Constant output value";
equation
  connect(valK.port_b, SolSepFil.port_a1) annotation (Line(
      points={{0,0},{8,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valE.port_a, CitWat) annotation (Line(
      points={{-50,70},{-50,88},{0,88},{0,98}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(port_1, UVFil.port_b1) annotation (Line(
      points={{100,0},{90,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valE.y, ValE) annotation (Line(
      points={{-62,60},{-120,60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(valK.y, ValByP) annotation (Line(
      points={{-10,12},{-10,20},{-30,20},{-30,-60},{-120,-60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(kMinu.y, valL.y) annotation (Line(
      points={{1,70},{20,70},{20,62}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(kMinu.u, ValByP) annotation (Line(
      points={{-21.8,70},{-30,70},{-30,-60},{-120,-60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(port_a1, valK1.port_a) annotation (Line(
      points={{-100,0},{-80,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valE.port_b, valK1.port_b) annotation (Line(
      points={{-50,50},{-50,0},{-60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valK1.port_b, valK.port_a) annotation (Line(
      points={{-60,0},{-20,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(valL.port_a, valK1.port_b) annotation (Line(
      points={{10,50},{-40,50},{-40,0},{-60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const1.y, valK1.y) annotation (Line(
      points={{-79.3,29},{-70,29},{-70,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(valL.port_b, UVFil.port_a1) annotation (Line(
      points={{30,50},{60,50},{60,0},{70,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(SolSepFil.port_b1, OneWayVal.port_a) annotation (Line(
      points={{28,0},{34,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(UVFil.port_a1, OneWayVal.port_b) annotation (Line(
      points={{70,0},{54,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(const1.y, OneWayVal.y) annotation (Line(
      points={{-79.3,29},{44,29},{44,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(SSFilSig.y, SolSepFil.FlushFil) annotation (Line(
      points={{-3.2,-40},{0,-40},{0,-6},{6,-6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(UVFilSig.y, UVFil.FlushFil) annotation (Line(
      points={{56.8,-40},{60,-40},{60,-6},{68,-6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-8,92},{8,40}},
          lineColor={0,127,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-94,8},{-60,-8}},
          lineColor={0,127,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,8},{94,-8}},
          lineColor={0,127,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,40},{60,-40}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,255},
          textString="%name")}));
end ProcessingSystemModel;
