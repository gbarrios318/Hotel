within HotelModel.HeatPumpSection.BoilerPackage;
package Example
extends Modelica.Icons.ExamplesPackage;
  model Boiler "Example for the boiler and its components"
   extends Modelica.Icons.Example;
  equation

  end Boiler;

  model BoilerSystem "Example for boiler system"
    extends Modelica.Icons.Example;
   package MediumCW = Buildings.Media.ConstantPropertyLiquidWater
      "Medium for condenser water"
        annotation (choicesAllMatching = true);
    parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
      "Nominal mass flow rate of water";
    parameter Modelica.SIunits.Pressure dp_nominal=100
      "Nominal pressure difference";
    Boiler2WithControls boiler2WithControls(
      redeclare package MediumCW = MediumCW,
      mWater_flow_nominal=mWater_flow_nominal,
      dp_nominal=dp_nominal)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    Buildings.Fluid.Sources.MassFlowSource_T boundary(nPorts=1, redeclare
        package Medium = MediumCW,
      m_flow=mWater_flow_nominal)
      annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
    inner Modelica.Fluid.System system(T_ambient=283.15)
      annotation (Placement(transformation(extent={{40,59},{60,79}})));
    Buildings.Fluid.Sources.Boundary_pT bou1(
      nPorts=1,
      redeclare package Medium = MediumCW,
      p=dp_nominal)
      annotation (Placement(transformation(extent={{80,-10},{60,10}})));
    Modelica.Blocks.Interfaces.RealOutput TBoi1
      "Signal of the output temperature after it has gone through the boiler"
      annotation (Placement(transformation(extent={{100,30},{120,50}})));
    Modelica.Blocks.Sources.Constant const(k=273.15 + 22.22)
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Modelica.Blocks.Sources.IntegerConstant StaVal(k=1)
      "State value representation"
      annotation (Placement(transformation(extent={{-80,66},{-60,86}})));
  equation
    connect(boundary.ports[1], boiler2WithControls.port_a1) annotation (Line(
        points={{-68,0},{-20,0}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(boiler2WithControls.port_b1, bou1.ports[1]) annotation (Line(
        points={{20,0},{60,0}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(boiler2WithControls.TBoi, TBoi1) annotation (Line(
        points={{22.4,8.4},{40,8.4},{40,40},{110,40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(const.y, boiler2WithControls.HPTSen) annotation (Line(
        points={{-59,40},{-40,40},{-40,8.4},{-21.6,8.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(StaVal.y, boiler2WithControls.Sta) annotation (Line(
        points={{-59,76},{-32,76},{-32,12.4},{-21.6,12.4}},
        color={255,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end BoilerSystem;
end Example;
