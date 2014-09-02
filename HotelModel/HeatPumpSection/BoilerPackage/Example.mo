within HotelModel.HeatPumpSection.BoilerPackage;
package Example
extends Modelica.Icons.ExamplesPackage;

  model BoilerSystem "Example for boiler system"
    import HotelModel;
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
      annotation (Placement(transformation(extent={{-20,-80},{20,-40}})));
    inner Modelica.Fluid.System system(T_ambient=283.15)
      annotation (Placement(transformation(extent={{40,61},{60,81}})));
    Buildings.Fluid.Sources.Boundary_pT bou1(
      nPorts=1,
      redeclare package Medium = MediumCW,
      p=dp_nominal)
      annotation (Placement(transformation(extent={{82,-70},{62,-50}})));
    Modelica.Blocks.Interfaces.RealOutput TBoi1
      "Signal of the output temperature after it has gone through the boiler"
      annotation (Placement(transformation(extent={{100,30},{120,50}})));
    Modelica.Blocks.Sources.Constant const(k=273.15 + 22.22)
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Buildings.Fluid.Sources.Boundary_pT bou2(
      nPorts=1,
      redeclare package Medium = MediumCW,
      p=dp_nominal)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-70,-60})));
    Modelica.Blocks.Sources.IntegerTable integerTable(table=[0,1; 450,2; 900,3;
          1350,4; 1800,5; 2250,6; 2700,7])
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  equation
    connect(boiler2WithControls.port_b1, bou1.ports[1]) annotation (Line(
        points={{20,-60},{62,-60}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(boiler2WithControls.TBoi, TBoi1) annotation (Line(
        points={{22.4,-51.6},{40,-51.6},{40,40},{110,40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(const.y, boiler2WithControls.HPTSen) annotation (Line(
        points={{-59,40},{-40,40},{-40,-51.6},{-21.6,-51.6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(bou2.ports[1], boiler2WithControls.port_a1) annotation (Line(
        points={{-60,-60},{-20,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(integerTable.y, boiler2WithControls.Sta) annotation (Line(
        points={{-59,70},{-34,70},{-34,-47.6},{-21.6,-47.6}},
        color={255,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end BoilerSystem;

  model Boiler "Example for the boiler and its components"
     replaceable package MediumCW =
        Buildings.Media.ConstantPropertyLiquidWater
      "Medium for condenser water"
        annotation (choicesAllMatching = true);
    parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
      "Nominal mass flow rate of water";
    parameter Modelica.SIunits.Pressure dp_nominal=100
      "Nominal pressure difference";
    import HotelModel;
   extends Modelica.Icons.Example;
    HotelModel.HeatPumpSection.BoilerPackage.Boiler2 boiler2_1(
      redeclare package MediumCW = MediumCW,
      mWater_flow_nominal=mWater_flow_nominal,
      dp_nominal=dp_nominal)
      annotation (Placement(transformation(extent={{-10,-46},{10,-26}})));
    Buildings.Fluid.Sources.Boundary_pT sin(
      p(displayUnit="Pa") = 300000,
      nPorts=1,
      redeclare package Medium = MediumCW,
      T=333.15) "Sink"
      annotation (Placement(transformation(extent={{74,-50},{54,-30}})));
    Buildings.Fluid.Sources.Boundary_pT sou(
      nPorts=1,
      p=300000 + dp_nominal,
      redeclare package Medium = MediumCW,
      T=303.15)
      annotation (Placement(transformation(extent={{-78,-50},{-58,-30}})));
    Modelica.Blocks.Sources.TimeTable y(table=[0,0; 1800,1; 1800,0; 2400,0; 2400,
          1; 3600,1])
      annotation (Placement(transformation(extent={{-76,18},{-56,38}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{80,80},{100,100}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
        Medium = MediumCW)
      annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
    Buildings.HeatTransfer.Sources.FixedTemperature TAmb2(      T=288.15)
      "Ambient temperature in boiler room"
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Blocks.Sources.Pulse pulse(amplitude=1, period=1800)
      annotation (Placement(transformation(extent={{-76,-18},{-56,2}})));
  equation

    connect(sou.ports[1], boiler2_1.port_a1) annotation (Line(
        points={{-58,-40},{-10,-40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(y.y, boiler2_1.boiCon) annotation (Line(
        points={{-55,28},{-30,28},{-30,-28},{-10.8,-28}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(temperature.port_b, sin.ports[1]) annotation (Line(
        points={{40,-40},{54,-40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(temperature.port_a, boiler2_1.port_b1) annotation (Line(
        points={{20,-40},{10,-40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TAmb2.port, boiler2_1.heatPort1) annotation (Line(
        points={{-20,50},{0,50},{0,-26}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(pulse.y, boiler2_1.valCon) annotation (Line(
        points={{-55,-8},{-34,-8},{-34,-31.8},{-10.8,-31.8}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end Boiler;
end Example;
