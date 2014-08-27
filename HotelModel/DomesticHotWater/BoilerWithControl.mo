within HotelModel.DomesticHotWater;
model BoilerWithControl
package Medium = Buildings.Media.ConstantPropertyLiquidWater "Medium model";
parameter Modelica.SIunits.Power Q_flow_nominal "Nominal power";
 parameter Modelica.SIunits.Temperature dT_nominal
    "Nominal temperature difference";
 parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";
 parameter Modelica.SIunits.Pressure dp_nominal
    "Pressure drop at m_flow_nominal";

  parameter Modelica.SIunits.Temperature TSet
    "Temperature set point for boiler";

  Modelica.Blocks.Sources.Constant TBoiSet(k=TSet)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.Controls.Continuous.LimPID conPID(controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=0.5) annotation (Placement(transformation(extent={{-48,20},{-28,40}})));
  Buildings.Fluid.Boilers.BoilerPolynomial boi1(
    a={0.9},
    effCur=Buildings.Fluid.Types.EfficiencyCurves.Constant,
    Q_flow_nominal=Q_flow_nominal,
    m_flow_nominal = m_flow_nominal,
    redeclare package Medium = Medium,
    dp_nominal=dp_nominal,
    fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
    T_start=293.15) "Boiler"
    annotation (Placement(transformation(extent={{0,-46},{20,-26}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-46},{-90,-26}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-46},{110,-26}})));
equation
  connect(TBoiSet.y, conPID.u_s) annotation (Line(
      points={{-59,30},{-50,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.y, boi1.y) annotation (Line(
      points={{-27,30},{-16,30},{-16,0},{-34,0},{-34,-28},{-2,-28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.u_m, boi1.T) annotation (Line(
      points={{-38,18},{-38,14},{40,14},{40,-28},{21,-28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boi1.port_a, port_a1) annotation (Line(
      points={{0,-36},{-100,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boi1.port_b, port_b1) annotation (Line(
      points={{20,-36},{100,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end BoilerWithControl;
