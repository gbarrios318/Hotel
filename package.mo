within ;
package NewHotelModel
replaceable package MediumCW =
          Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
          annotation (choicesAllMatching = true);
      parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
      parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
  package CoolingTowerSection
    "Cooling Tower plus components that interact with it"
    model CoolingTowerComponents
     replaceable package MediumCW =
          Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
          annotation (choicesAllMatching = true);
      parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
        "Nominal mass flow rate of water";
      parameter Modelica.SIunits.Pressure dp_nominal=100
        "Nominal pressure difference";

      Buildings.Fluid.Sources.Boundary_pT bou(nPorts=2, redeclare package
          Medium = MediumCW) "Boundry for realistic circumstances" annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-42,40})));
      Buildings.Fluid.HeatExchangers.CoolingTowers.FixedApproach CooTow(
          redeclare package Medium = MediumCW) "Cooling Tower"
        annotation (Placement(transformation(extent={{-30,10},{-10,-10}})));
      Buildings.Fluid.Movers.FlowMachine_m_flow Pum(
        addPowerToMedium=false,
        redeclare package Medium = MediumCW,
        m_flow_nominal=mWater_flow_nominal,
        m_flow(start=mWater_flow_nominal),
        dp(start=dp_nominal)) "pump corresponding to the cooling tower"
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort TemSen(m_flow_nominal=
            mWater_flow_nominal, redeclare package Medium = MediumCW)
        "Temperature sensor of water after going through cooling tower"
        annotation (Placement(transformation(extent={{38,-10},{58,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{92,-70},{112,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
            iconTransformation(extent={{-110,30},{-90,50}})));
      Modelica.Blocks.Interfaces.RealInput TWea
        "Entering air dry or wet bulb temperature" annotation (Placement(
            transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(
              extent={{-124,-64},{-100,-40}})));
      Modelica.Blocks.Interfaces.RealInput m_flow_in
        "Prescribed mass flow rate" annotation (Placement(transformation(extent={{-140,40},
                {-100,80}}),          iconTransformation(extent={{-124,56},{
                -100,80}})));
    equation
      connect(CooTow.port_b, Pum.port_a) annotation (Line(
          points={{-10,0},{10,0}},
          color={0,127,255},
          thickness=1,
          smooth=Smooth.None));
      connect(Pum.port_b, TemSen.port_a) annotation (Line(
          points={{30,0},{38,0}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(CooTow.port_a, bou.ports[1]) annotation (Line(
          points={{-30,0},{-40,0},{-40,30}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(TemSen.port_b, port_b1) annotation (Line(
          points={{58,0},{60,0},{60,-60},{102,-60}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(CooTow.port_a, port_a1) annotation (Line(
          points={{-30,0},{-60,0},{-60,40},{-100,40}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(CooTow.TAir, TWea) annotation (Line(
          points={{-32,-4},{-40,-4},{-40,-60},{-120,-60}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(Pum.m_flow_in, m_flow_in) annotation (Line(
          points={{19.8,12},{20,12},{20,60},{-120,60}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
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
    end CoolingTowerComponents;

    model CoolingTowerControls
      "Cooling tower components with controls included"
     replaceable package MediumCW =
          Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
          annotation (choicesAllMatching = true);
      parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
        "Nominal mass flow rate of water";
      parameter Modelica.SIunits.Pressure dp_nominal=100
        "Nominal pressure difference";

      CoolingTowerComponents CooTowCom(
        redeclare package MediumCW = MediumCW,
        mWater_flow_nominal=mWater_flow_nominal,
        dp_nominal=dp_nominal) "Cooling Tower Components"
        annotation (Placement(transformation(extent={{-30,-28},{26,30}})));
      Modelica.Blocks.Sources.Constant TWea(k=273.15 + 23.5)
        "Weather temperature"
        annotation (Placement(transformation(extent={{-92,-50},{-72,-30}})));
      Modelica.Blocks.Interfaces.RealInput m_flo_in "Prescribed mass flow rate"
        annotation (Placement(transformation(extent={{-122,40},{-82,80}}),
            iconTransformation(extent={{-108,54},{-82,80}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,10},{-90,30}}),
            iconTransformation(extent={{-110,10},{-90,30}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
            iconTransformation(extent={{90,-90},{110,-70}})));
    equation
      connect(CooTowCom.m_flow_in1, m_flo_in) annotation (Line(
          points={{-29.44,20.2},{-60,20.2},{-60,60},{-102,60}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(CooTowCom.TWeather, TWea.y) annotation (Line(
          points={{-30,-14.08},{-60,-14.08},{-60,-40},{-71,-40}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(CooTowCom.port_a1, port_a1) annotation (Line(
          points={{-30,12.6},{-80.72,12.6},{-80.72,20},{-100,20}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(CooTowCom.port_b1, port_b1) annotation (Line(
          points={{26.56,-16.4},{59.28,-16.4},{59.28,-80},{100,-80}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={
            Text(
              extent={{-60,86},{60,66}},
              lineColor={0,0,255},
              lineThickness=1,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="%name"),
            Rectangle(
              extent={{-46,60},{42,34}},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{-56,34},{54,-94}},
              pattern=LinePattern.None,
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-94,24},{26,24},{36,4}},
              color={255,0,0},
              smooth=Smooth.None),
            Line(
              points={{0,24},{-6,4}},
              color={255,0,0},
              smooth=Smooth.None),
            Line(
              points={{26,24},{18,4}},
              color={255,0,0},
              smooth=Smooth.None),
            Line(
              points={{0,22},{8,4}},
              color={255,0,0},
              smooth=Smooth.None),
            Line(
              points={{-26,24},{-34,4}},
              color={255,0,0},
              smooth=Smooth.None),
            Line(
              points={{-26,24},{-16,4}},
              color={255,0,0},
              smooth=Smooth.None),
            Ellipse(
              extent={{-42,48},{-4,48}},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0}),
            Ellipse(
              extent={{-42,54},{-4,42}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{0,54},{38,42}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{54,-76},{92,-84}},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Ellipse(
              extent={{-76,78},{-88,56}},
              lineColor={255,0,0},
              lineThickness=1,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-72,76},{-82,58}},
              lineColor={255,0,0},
              lineThickness=1,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-76,74},{-70,60}},
              lineColor={255,0,0},
              lineThickness=1,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-68,62},{-72,72}},
              lineColor={255,0,0},
              lineThickness=1,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid)}));
    end CoolingTowerControls;
  end CoolingTowerSection;

  package HeatPumpSection
    package BoilerPackage
      model Boiler2
        "Boiler system in the condenser water loop that provides heating in the cold winter"
       replaceable package MediumCW =
            Modelica.Media.Interfaces.PartialMedium
          "Medium for condenser water"
            annotation (choicesAllMatching = true);
        parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
          "Nominal mass flow rate of water";
        parameter Modelica.SIunits.Pressure dp_nominal=100
          "Nominal pressure difference";
        Buildings.Fluid.Boilers.BoilerPolynomial boi(
          Q_flow_nominal=2000000,
          fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
          redeclare package Medium = MediumCW,
          m_flow_nominal=mWater_flow_nominal,
          dp_nominal=dp_nominal)
          "Boiler that corresponds of the heat pump section"
          annotation (Placement(transformation(extent={{40,30},{60,50}})));
        Buildings.Fluid.Actuators.Valves.TwoWayLinear valBoi(
          redeclare package Medium = MediumCW,
          m_flow_nominal=mWater_flow_nominal,
          dpValve_nominal=dp_nominal) "Valve to control the flow into boiler"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,0})));
        Buildings.Fluid.Actuators.Valves.TwoWayLinear valByp(
          m_flow_nominal=mWater_flow_nominal,
          dpValve_nominal=dp_nominal,
          redeclare package Medium = MediumCW) "Bypass valve"
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b1
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a1
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
        Modelica.Blocks.Interfaces.RealInput boiCon "Control singal for boiler"
          annotation (Placement(transformation(extent={{-120,68},{-100,88}}),
              iconTransformation(extent={{-116,72},{-100,88}})));
        Modelica.Blocks.Interfaces.RealInput valCon
          "Control signal for valves in boiler loop" annotation (Placement(
              transformation(extent={{-120,28},{-100,48}}), iconTransformation(extent={{-116,32},
                  {-100,48}})));
        Modelica.Blocks.Math.Add add(k1=-1)
          annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
        Modelica.Blocks.Sources.Constant const(k=1)
          annotation (Placement(transformation(extent={{-64,-88},{-44,-68}})));
      equation
        connect(valBoi.port_b, boi.port_a) annotation (Line(
            points={{6.66134e-016,10},{6.66134e-016,40},{40,40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(valBoi.port_a, valByp.port_a) annotation (Line(
            points={{-4.44089e-016,-10},{-4.44089e-016,-40},{40,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(valByp.port_b, port_b1) annotation (Line(
            points={{60,-40},{100,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(boi.port_b, port_b1) annotation (Line(
            points={{60,40},{80,40},{80,-40},{100,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(valByp.port_a, port_a1) annotation (Line(
            points={{40,-40},{-100,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(boi.y, boiCon) annotation (Line(
            points={{38,48},{-20,48},{-20,78},{-110,78}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(valBoi.y, valCon) annotation (Line(
            points={{-12,6.66134e-016},{-40,6.66134e-016},{-40,38},{-110,38}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(valCon, add.u1) annotation (Line(
            points={{-110,38},{-60,38},{-60,-54},{-22,-54}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(const.y, add.u2) annotation (Line(
            points={{-43,-78},{-40,-78},{-40,-66},{-22,-66}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(add.y, valByp.y) annotation (Line(
            points={{1,-60},{20,-60},{20,-20},{50,-20},{50,-28}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={
              Rectangle(
                extent={{-60,40},{60,-62}},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                lineThickness=0.5,
                pattern=LinePattern.None),
              Rectangle(
                extent={{-94,-32},{0,-48}},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid,
                lineThickness=0.5,
                pattern=LinePattern.None),
              Rectangle(
                extent={{0,-32},{96,-48}},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid,
                lineThickness=0.5,
                pattern=LinePattern.None),
              Rectangle(
                extent={{-10,28},{12,-48}},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid,
                lineThickness=0.5,
                pattern=LinePattern.None),
              Line(
                points={{-90,40},{-80,40},{-80,-20},{-10,-20}},
                color={0,0,255},
                smooth=Smooth.None,
                thickness=0.5,
                pattern=LinePattern.DashDot),
              Line(
                points={{-90,80},{-60,80},{-60,20},{-10,20}},
                color={0,0,255},
                smooth=Smooth.None,
                thickness=0.5,
                pattern=LinePattern.DashDot),
              Line(
                points={{-60,-80},{60,-80},{42,-68}},
                color={0,128,255},
                thickness=0.5,
                smooth=Smooth.None),
              Line(
                points={{60,-80},{44,-92}},
                color={0,128,255},
                thickness=0.5,
                smooth=Smooth.None),
              Text(
                extent={{-54,80},{54,60}},
                lineColor={0,128,255},
                lineThickness=0.5,
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid,
                textString="%name")}));
      end Boiler2;

      model Boiler2WithControls "Heat Pump boiler with controls included"
      replaceable package MediumCW =
            Modelica.Media.Interfaces.PartialMedium
          "Medium for condenser water"
            annotation (choicesAllMatching = true);
        parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
          "Nominal mass flow rate of water";
        parameter Modelica.SIunits.Pressure dp_nominal=100
          "Nominal pressure difference";
        Boiler2 boi(
          redeclare package MediumCW = MediumCW,
          mWater_flow_nominal=mWater_flow_nominal,
          dp_nominal=dp_nominal)
          "Boiler to heat the condenser water in a cold winter"
          annotation (Placement(transformation(extent={{-12,-8},{12,20}})));
        BolierControls bolCon "Boiler Control"
          annotation (Placement(transformation(extent={{-60,46},{-40,66}})));
        Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium
            = MediumCW)
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort BoiTSen(redeclare package
            Medium = MediumCW, m_flow_nominal=mWater_flow_nominal)
          "Finds the temperature of the water after it has been through the boiler"
          annotation (Placement(transformation(extent={{50,-10},{70,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b1
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a1
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Blocks.Interfaces.IntegerInput Sta
          "States commanded by the supervisory control" annotation (Placement(
              transformation(extent={{-120,50},{-100,70}}), iconTransformation(
                extent={{-116,54},{-100,70}})));
        Modelica.Blocks.Interfaces.RealInput HPTSen
          "Heat pump temperature sensor signall" annotation (Placement(
              transformation(extent={{-120,30},{-100,50}}), iconTransformation(
                extent={{-116,34},{-100,50}})));
        Modelica.Blocks.Interfaces.RealOutput BoiTSenSig
          "Signal of the output temperature after it has gone through the boiler"
          annotation (Placement(transformation(extent={{100,30},{120,50}}),
              iconTransformation(extent={{104,34},{120,50}})));
      equation
        connect(bolCon.BoilerControl, boi.BoilerControl) annotation (Line(
            points={{-39,54},{-32,54},{-32,17.48},{-12.96,17.48}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(senMasFlo.port_b, boi.port_a1) annotation (Line(
            points={{-60,0},{-40,0},{-40,0.4},{-12,0.4}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(boi.port_b1, BoiTSen.port_a) annotation (Line(
            points={{12,0.4},{40,0.4},{40,0},{50,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(BoiTSen.port_b, port_b1) annotation (Line(
            points={{70,0},{100,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(senMasFlo.port_a, port_a1) annotation (Line(
            points={{-80,0},{-100,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(bolCon.StabilityControl, Sta) annotation (Line(
            points={{-64,60},{-110,60}},
            color={255,127,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(BoiTSen.T, BoiTSenSig) annotation (Line(
            points={{60,11},{60,40},{110,40}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(port_a1, port_a1) annotation (Line(
            points={{-100,0},{-100,4},{-100,4},{-100,0}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(bolCon.TMea, HPTSen) annotation (Line(
            points={{-62,50},{-80,50},{-80,40},{-110,40}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(bolCon.Valve4Control, boi.valCon) annotation (Line(
            points={{-39,60},{-36,60},{-36,11.6},{-12.96,11.6}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={
              Rectangle(
                extent={{-60,60},{60,-40}},
                pattern=LinePattern.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-80,-60},{-60,-40},{60,-40},{80,-60},{-80,-60}},
                pattern=LinePattern.None,
                smooth=Smooth.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-20,40},{20,-50}},
                pattern=LinePattern.None,
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,0}),
              Rectangle(
                extent={{-94,8},{-20,-8}},
                pattern=LinePattern.None,
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{20,8},{96,-8}},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Line(
                points={{-90,40},{-80,40},{-80,20},{-20,20}},
                pattern=LinePattern.DashDot,
                smooth=Smooth.None,
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-90,60},{-70,60},{-70,30},{-20,30}},
                color={0,0,0},
                pattern=LinePattern.DashDot,
                thickness=0.5,
                smooth=Smooth.None),
              Line(
                points={{20,24},{80,24},{80,40},{94,40}},
                color={0,0,0},
                pattern=LinePattern.DashDot,
                thickness=0.5,
                smooth=Smooth.None),
              Text(
                extent={{-40,90},{38,70}},
                lineColor={0,0,255},
                textString="%HPBoiler")}));
      end Boiler2WithControls;

      model BolierControls "Boiler with controls, including valve controls"

        Modelica.Blocks.Math.IntegerToReal integerToReal
          annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
        Modelica.Blocks.Routing.Replicator replicator(nout=3)
          annotation (Placement(transformation(extent={{-20,30},{0,50}})));
        Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1,1,1,0; 2,1,1,
              0; 3,0,0,1; 4,0,0,1; 5,0,0,1; 6,0,0,1; 7,0,0,1])
          annotation (Placement(transformation(extent={{20,30},{40,50}})));
        Modelica.Blocks.Sources.Constant TSetBoi(k=kTSetBoi)
          "Set point temperature of boiler"
          annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
        Buildings.Controls.Continuous.LimPID conPID
          annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
        Modelica.Blocks.Math.Product product
          annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
        Modelica.Blocks.Interfaces.RealOutput BoilerControl
          "Connector of Real output signal"
          annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
        Modelica.Blocks.Interfaces.RealOutput Valve4Control
          "Connector of Real output signals"
          annotation (Placement(transformation(extent={{100,30},{120,50}})));
        Modelica.Blocks.Interfaces.RealInput TMea
          "Measured temperture of water leaving the heat pump" annotation (
            Placement(transformation(extent={{-140,-80},{-100,-40}})));
        Modelica.Blocks.Interfaces.IntegerInput sta
          "State of the system sent from superviory control"
          annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
      equation
        connect(replicator.y, combiTable1D.u) annotation (Line(
            points={{1,40},{18,40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(integerToReal.y, replicator.u) annotation (Line(
            points={{-59,40},{-22,40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(TSetBoi.y, conPID.u_s) annotation (Line(
            points={{-19,-20},{-2,-20}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(conPID.y, product.u2) annotation (Line(
            points={{21,-20},{42,-20},{42,-26},{58,-26}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(combiTable1D.y[1], product.u1) annotation (Line(
            points={{41,39.3333},{50,39.3333},{50,-14},{58,-14}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(product.y, BoilerControl) annotation (Line(
            points={{81,-20},{110,-20}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(combiTable1D.y, Valve4Control) annotation (Line(
            points={{41,40},{110,40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(conPID.u_m, TMea) annotation (Line(
            points={{10,-32},{10,-60},{-120,-60}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(integerToReal.u, sta) annotation (Line(
            points={{-82,40},{-120,40}},
            color={255,127,0},
            smooth=Smooth.None));
        connect(BoilerControl, BoilerControl) annotation (Line(
            points={{110,-20},{110,-20}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),        graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={
              Rectangle(
                extent={{-80,60},{80,-80}},
                lineThickness=0.5,
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None,
                lineColor={0,0,255}),
              Text(
                extent={{-60,88},{60,66}},
                lineColor={0,0,255},
                lineThickness=0.5,
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid,
                textString="%name")}));
      end BolierControls;
    end BoilerPackage;

    package HeatPumpPackage
      "Representation of the Heat Pump along with components interacting directly with it"
      model HeatPump "Base class representation of the Heat Pump"
      replaceable package MediumCW =
            Modelica.Media.Interfaces.PartialMedium
          "Medium for condenser water"
            annotation (choicesAllMatching = true);
        parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
          "Nominal mass flow rate of water";
        parameter Modelica.SIunits.Pressure dp_nominal=100
          "Nominal pressure difference";
        Buildings.Fluid.MixingVolumes.MixingVolume HPTan(
          redeclare package Medium = MediumCW,
          m_flow_nominal=mWater_flow_nominal,
          V=100,
          nPorts=4) "Volume control of the Heat Pump"
          annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
          prescribedHeatFlow "Prescribed Heat flow of the Heat Pump"
          annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
        Modelica.Blocks.Interfaces.RealInput Q_flow "Heat Flow input "
          annotation (Placement(transformation(extent={{-124,-52},{-100,-28}})));
        Buildings.Fluid.Movers.FlowMachine_m_flow HeaPum(
          redeclare package Medium = MediumCW,
          m_flow(start=mWater_flow_nominal),
          dp(start=dp_nominal))
          "The actual pump behind the Heat Pump component"
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort HPTemp(redeclare package
            Medium = MediumCW, m_flow_nominal=mWater_flow_nominal)
          "Tempearture after Heat Pump"
          annotation (Placement(transformation(extent={{40,-10},{60,10}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a1
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b1
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput masFloPum
          "Prescribed mass flow rate of Heat Pump"
          annotation (Placement(transformation(extent={{-124,28},{-100,52}})));
        Modelica.Blocks.Interfaces.RealOutput HPTemSig
          "Signal of temperature of the passing fluid"
          annotation (Placement(transformation(extent={{100,30},{120,50}})));
      equation
        connect(prescribedHeatFlow.Q_flow, Q_flow) annotation (Line(
            points={{-80,-40},{-112,-40}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(prescribedHeatFlow.port, HPTan.heatPort) annotation (Line(
            points={{-60,-40},{-50,-40},{-50,10},{-40,10}},
            color={191,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(HeaPum.port_a, port_a1) annotation (Line(
            points={{0,0},{-102,0}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HeaPum.port_b, HPTemp.port_a) annotation (Line(
            points={{20,0},{40,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(HPTemp.port_b, port_b1) annotation (Line(
            points={{60,0},{100,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(HPTan.ports[1], port_a1) annotation (Line(
            points={{-33,0},{-102,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(HeaPum.port_a, HPTan.ports[2]) annotation (Line(
            points={{0,0},{-31,0}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HeaPum.port_a, HPTan.ports[3]) annotation (Line(
            points={{0,0},{-29,0}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HeaPum.port_a, HPTan.ports[4]) annotation (Line(
            points={{0,0},{-27,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(HeaPum.m_flow_in, masFloPum) annotation (Line(
            points={{9.8,12},{9.8,40},{-112,40}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(HPTemp.T, HPTemSig) annotation (Line(
            points={{50,11},{50,40},{110,40}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={
              Rectangle(
                extent={{-96,8},{-60,0}},
                pattern=LinePattern.None,
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-96,-8},{-60,0}},
                pattern=LinePattern.None,
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,40},{60,-40}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,20},{60,-20}},
                lineColor={0,0,255},
                fillPattern=FillPattern.Sphere,
                fillColor={255,0,0}),
              Rectangle(
                extent={{60,8},{94,-8}},
                fillPattern=FillPattern.Solid,
                fillColor={80,0,127},
                pattern=LinePattern.None,
                lineColor={0,0,0}),
              Line(
                points={{-100,40},{-80,40},{-80,30},{-60,30}},
                color={0,0,0},
                smooth=Smooth.None,
                pattern=LinePattern.DashDot,
                thickness=0.5),
              Line(
                points={{-100,-40},{-80,-40},{-80,-30},{-60,-30}},
                color={0,0,0},
                pattern=LinePattern.DashDot,
                thickness=0.5,
                smooth=Smooth.None),
              Line(
                points={{60,28}},
                color={0,0,0},
                pattern=LinePattern.DashDot,
                thickness=0.5,
                smooth=Smooth.None),
              Line(
                points={{60,30},{80,30},{80,40},{100,40}},
                color={0,0,0},
                pattern=LinePattern.DashDot,
                thickness=0.5,
                smooth=Smooth.None),
              Line(
                points={{-60,-70},{60,-70}},
                color={0,255,255},
                smooth=Smooth.None),
              Line(
                points={{40,-60},{60,-70},{40,-80}},
                color={0,255,255},
                smooth=Smooth.None),
              Text(
                extent={{-60,80},{60,60}},
                lineColor={0,0,255},
                lineThickness=1,
                fillPattern=FillPattern.Sphere,
                fillColor={255,0,0},
                textString="%name")}));
      end HeatPump;

      model HeatPumpwithControls "Heat Pump with its controls"
      replaceable package MediumCW =
            Modelica.Media.Interfaces.PartialMedium
          "Medium for condenser water"
            annotation (choicesAllMatching = true);
        parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
          "Nominal mass flow rate of water";
        parameter Modelica.SIunits.Pressure dp_nominal=100
          "Nominal pressure difference";
        HeatPump HeaPum(
          redeclare package MediumCW = MediumCW,
          dp_nominal=dp_nominal,
          mWater_flow_nominal=mWater_flow_nominalMasFloHeatPum)
          "Heat pump with all components directly interacting with it"
          annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a1
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b1
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealOutput HPtem
          "Temperature of the passing fluid leaving the heat pump"
          annotation (Placement(transformation(extent={{100,30},{120,50}})));
        Modelica.Blocks.Sources.Constant MasFloHeatPum(k=40)
          "Mass flow rate of Heat Pump"
          annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
        Modelica.Blocks.Sources.Constant Q_floIn(k=-2300000) "Heat flow input"
          annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
      equation
        connect(HeaPum.port_a1, port_a1) annotation (Line(
            points={{-20.4,0},{-102,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(HeaPum.port_b1, port_b1) annotation (Line(
            points={{20,0},{100,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(HeaPum.HeatTempOut, HPtem) annotation (Line(
            points={{20,8},{60,8},{60,40},{110,40}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(MasFloHeatPum.y, HeaPum.massFlowPump) annotation (Line(
            points={{-59,40},{-40,40},{-40,8},{-21.2,8}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(Q_floIn.y, HeaPum.Q_flow) annotation (Line(
            points={{-59,-40},{-40,-40},{-40,-8},{-22.4,-8}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),        graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={
              Rectangle(
                extent={{-96,8},{-60,0}},
                pattern=LinePattern.None,
                fillPattern=FillPattern.Solid,
                fillColor={255,0,0},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-96,-8},{-60,0}},
                pattern=LinePattern.None,
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,40},{60,-40}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,20},{60,-20}},
                lineColor={0,0,255},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={255,0,0}),
              Rectangle(
                extent={{60,8},{96,-8}},
                pattern=LinePattern.None,
                fillColor={95,0,127},
                fillPattern=FillPattern.Solid),
              Line(
                points={{60,30},{80,30},{80,40},{90,40}},
                color={0,0,0},
                pattern=LinePattern.DashDot,
                thickness=0.5,
                smooth=Smooth.None),
              Text(
                extent={{-40,80},{40,60}},
                lineColor={0,0,255},
                textString="%Heat Pump")}));
      end HeatPumpwithControls;
    end HeatPumpPackage;

    package HeatExchangeValvesPackage
      "Heat exchanger 2 with series of valves and controls for it"
      model HeatEx_and_valves
      replaceable package MediumCW =
            Modelica.Media.Interfaces.PartialMedium
          "Medium for condenser water"
            annotation (choicesAllMatching = true);
        parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
          "Nominal mass flow rate of water";
        parameter Modelica.SIunits.Pressure dp_nominal=100
          "Nominal pressure difference";
        Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
          redeclare package Medium1 = MediumCW,
          redeclare package Medium2 = MediumCW,
          m1_flow_nominal=mWater_flow_nominal,
          m2_flow_nominal=mWater_flow_nominal,
          dp1_nominal=dp_nominal,
          dp2_nominal=dp_nominal)
          "Heat exchanger corresponding to the connection between the heat pump and the domestic water"
          annotation (Placement(transformation(extent={{-10,-44},{10,-24}})));
        Buildings.Fluid.Actuators.Valves.TwoWayLinear hexval1(
          redeclare package Medium = MediumCW,
          m_flow_nominal=mWater_flow_nominal,
          dpValve_nominal=dp_nominal) "Heat Exchanger valve 1" annotation (
            Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=-90,
              origin={-40,0})));
        Buildings.Fluid.Actuators.Valves.TwoWayLinear valbyp(
          redeclare package Medium = MediumCW,
          m_flow_nominal=mWater_flow_nominal,
          dpValve_nominal=dp_nominal) "Heat exchange valve bypass"
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        Buildings.Fluid.Actuators.Valves.TwoWayLinear hexval2(
          redeclare package Medium = MediumCW,
          m_flow_nominal=mWater_flow_nominal,
          dpValve_nominal=dp_nominal) "Heat Exchange valve 2" annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={40,0})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a1
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b1
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,30},{110,50}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b2
          "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a2
          "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
        Modelica.Blocks.Interfaces.RealInput ValCtrl1
          "Signal controling the first heat exchange valve" annotation (
            Placement(transformation(
              extent={{12,-12},{-12,12}},
              rotation=90,
              origin={-60,112})));
        Modelica.Blocks.Interfaces.RealInput BypValCtrl
          "Signal controling the bypass valve"     annotation (Placement(
              transformation(
              extent={{-12,-12},{12,12}},
              rotation=-90,
              origin={60,112})));
        Modelica.Blocks.Interfaces.RealInput ValCtrl2
          "Signal controling the second heat exchange valve" annotation (
            Placement(transformation(
              extent={{-12,-12},{12,12}},
              rotation=-90,
              origin={0,112})));
      equation
        connect(hex.port_a1, hexval1.port_b) annotation (Line(
            points={{-10,-28},{-40,-28},{-40,-10}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(hexval1.port_a, valbyp.port_a) annotation (Line(
            points={{-40,10},{-40,40},{-10,40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(valbyp.port_b, hexval2.port_a) annotation (Line(
            points={{10,40},{40,40},{40,10}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(hexval2.port_b, hex.port_b1) annotation (Line(
            points={{40,-10},{40,-28},{10,-28}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(valbyp.port_a, port_a1) annotation (Line(
            points={{-10,40},{-100,40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(valbyp.port_b, port_b1) annotation (Line(
            points={{10,40},{100,40}},
            color={0,127,255},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None},
            thickness=1));
        connect(hex.port_b2, port_b2) annotation (Line(
            points={{-10,-40},{-100,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(hex.port_a2, port_a2) annotation (Line(
            points={{10,-40},{100,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(hexval1.y, ValCtrl1) annotation (Line(
            points={{-52,0},{-60,0},{-60,112}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(valbyp.y,BypValCtrl)  annotation (Line(
            points={{0,52},{0,60},{60,60},{60,112}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(hexval2.y, ValCtrl2) annotation (Line(
            points={{28,6.66134e-016},{20,6.66134e-016},{20,80},{0,80},{0,112}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));

        connect(port_b2, port_b2) annotation (Line(
            points={{-100,-40},{-100,-40}},
            color={0,127,255},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),        graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={
              Rectangle(
                extent={{-94,48},{-60,32}},
                lineThickness=1,
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Rectangle(
                extent={{-94,-32},{-60,-48}},
                pattern=LinePattern.None,
                lineThickness=1,
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{60,48},{94,32}},
                lineThickness=1,
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Rectangle(
                extent={{60,-32},{94,-48}},
                lineThickness=1,
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Rectangle(
                extent={{-60,60},{60,-60}},
                lineThickness=1,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Text(
                extent={{-40,-68},{40,-88}},
                pattern=LinePattern.None,
                lineThickness=1,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255},
                textString="%name"),
              Line(
                points={{-60,90},{-60,80},{-40,80},{-40,60}},
                color={0,0,127},
                pattern=LinePattern.DashDot,
                thickness=0.5,
                smooth=Smooth.None),
              Line(
                points={{0,90},{0,60}},
                color={0,0,127},
                pattern=LinePattern.DashDot,
                thickness=0.5,
                smooth=Smooth.None),
              Line(
                points={{60,90},{60,80},{40,80},{40,60}},
                color={0,0,127},
                pattern=LinePattern.DashDot,
                thickness=0.5,
                smooth=Smooth.None)}));
      end HeatEx_and_valves;

      model HexValves_with_Control "Control for the heat exchange and valves"
      replaceable package MediumCW =
            Modelica.Media.Interfaces.PartialMedium
          "Medium for condenser water"
            annotation (choicesAllMatching = true);
        parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
          "Nominal mass flow rate of water";
        parameter Modelica.SIunits.Pressure dp_nominal=100
          "Nominal pressure difference";
        HeatEx_and_valves Hex(
          redeclare package MediumCW = MediumCW,
          mWater_flow_nominal=mWater_flow_nominal,
          dp_nominal=dp_nominal) "Hex with the valves included"
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a1
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b1
          "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a2
          "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
          annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b2
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{90,30},{110,50}})));
        HeatExchangeControls heatExchangeControls annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={0,58})));
        Modelica.Blocks.Interfaces.IntegerInput SuperCtrl "Supervisory Control"
          annotation (Placement(transformation(
              extent={{-12,12},{12,-12}},
              rotation=-90,
              origin={0,112})));
      equation

        connect(Hex.port_a1, port_a1) annotation (Line(
            points={{-10,4},{-60,4},{-60,40},{-100,40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(Hex.port_b2, port_b1) annotation (Line(
            points={{-10,-4},{-60,-4},{-60,-40},{-100,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(Hex.port_a2, port_a2) annotation (Line(
            points={{10,-4},{60,-4},{60,-40},{100,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(Hex.port_b1, port_b2) annotation (Line(
            points={{10,4},{60,4},{60,40},{100,40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(heatExchangeControls.ValveCtrl3, Hex.ValveCtrl1) annotation (
            Line(
            points={{-4,48},{-6,48},{-6,10.2}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(heatExchangeControls.ValveCtrl2, Hex.ValveCtrl2) annotation (
            Line(
            points={{0,48},{0,10.2}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(heatExchangeControls.ValveCtrl1, Hex.ValveCtrl3) annotation (
            Line(
            points={{4,48},{6,48},{6,10.2}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(heatExchangeControls.u1, SuperCtrl) annotation (Line(
            points={{0,68.6},{0,112}},
            color={255,127,0},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),        graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={
              Rectangle(
                extent={{-94,48},{-60,32}},
                pattern=LinePattern.None,
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{60,48},{94,32}},
                pattern=LinePattern.None,
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{60,-32},{94,-48}},
                pattern=LinePattern.None,
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-94,-32},{-60,-48}},
                pattern=LinePattern.None,
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,60},{60,-60}},
                pattern=LinePattern.None,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(
                points={{0,90},{0,60},{0,60}},
                color={255,128,0},
                pattern=LinePattern.Dash,
                smooth=Smooth.None,
                thickness=0.5),
              Text(
                extent={{-40,-70},{40,-92}},
                lineColor={255,128,0},
                pattern=LinePattern.Dash,
                lineThickness=0.5,
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                textString="%name")}));
      end HexValves_with_Control;

      model HeatExchangeControls "Controls for the Heat Exchange"

        Modelica.Blocks.Math.IntegerToReal integerToReal
          annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        Modelica.Blocks.Routing.Replicator replicator(nout=3)
          annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1,0,0,1; 2,1,1,
              0; 3,1,1,0; 4,0,0,1; 5,1,1,0; 6,1,1,0; 7,0,0,1])
          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
        Modelica.Blocks.Interfaces.IntegerInput u1
          "Connector of Integer input signal"
          annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
        Modelica.Blocks.Interfaces.RealOutput ValveCtrl1 "controls valve 1"
          annotation (Placement(transformation(extent={{90,30},{110,50}})));
        Modelica.Blocks.Interfaces.RealOutput ValveCtrl2 "control for valve 2"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealOutput ValveCtrl3 "control for valve 3"
          annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
      equation
        connect(integerToReal.y, replicator.u) annotation (Line(
            points={{-39,0},{-22,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(replicator.y, combiTable1D.u) annotation (Line(
            points={{1,0},{18,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(integerToReal.u, u1) annotation (Line(
            points={{-62,0},{-106,0}},
            color={255,127,0},
            smooth=Smooth.None));
        connect(combiTable1D.y, ValveCtrl2) annotation (Line(
            points={{41,0},{100,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(combiTable1D.y, ValveCtrl1) annotation (Line(
            points={{41,0},{60,0},{60,40},{100,40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(combiTable1D.y, ValveCtrl3) annotation (Line(
            points={{41,0},{60,0},{60,-40},{100,-40}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                  {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Rectangle(
                extent={{-80,60},{80,-60}},
                lineColor={0,0,127},
                fillColor={255,255,85},
                fillPattern=FillPattern.Solid), Text(
                extent={{-46,90},{38,72}},
                lineColor={0,0,255},
                textString="%HexControls")}));
      end HeatExchangeControls;
    end HeatExchangeValvesPackage;

    model HeatPump "Complete heat pump section with everything put together"
    replaceable package MediumCW =
          Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
          annotation (choicesAllMatching = true);
      parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
        "Nominal mass flow rate of water";
      parameter Modelica.SIunits.Pressure dp_nominal=100
        "Nominal pressure difference";
      BoilerPackage.Boiler2WithControls HPBoiler(
        redeclare package MediumCW = MediumCW,
        mWater_flow_nominal=mWater_flow_nominal,
        dp_nominal=dp_nominal) "Boiler corresponding to the heat pump section"
        annotation (Placement(transformation(extent={{-60,50},{-80,70}})));
      HeatPumpPackage.HeatPumpwithControls HeaPum(
        redeclare package MediumCW = MediumCW,
        mWater_flow_nominal=mWater_flow_nominal,
        dp_nominal=dp_nominal) "Heat Pump"
        annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
      HeatExchangeValvesPackage.HexValves_with_Control HexVal(
        redeclare package MediumCW = MediumCW,
        mWater_flow_nominal=mWater_flow_nominal,
        dp_nominal=dp_nominal) "Heat exchange valves with controls" annotation (
         Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={44,0})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-108,-70},{-88,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
      Modelica.Blocks.Interfaces.IntegerInput SuperCtrl1 "Supervisory Control"
        annotation (Placement(transformation(extent={{-114,-10},{-94,10}})));
      Buildings.Fluid.Sources.Boundary_pT BouHP(nPorts=3, redeclare package
          Medium = MediumCW) "Boundry that allows for realistic circumstances"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-10,70})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a2
        "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
        annotation (Placement(transformation(extent={{90,50},{110,70}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b2
        "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
        annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
      Modelica.Blocks.Interfaces.RealOutput Tboi
        "Temperature of the passing fluid in the boiler" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={60,102})));
      Modelica.Blocks.Interfaces.RealOutput HPTemp
        "Temperature of the passing fluid leaving from the heat pumps"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={60,-110})));
    equation
      connect(HeaPum.port_a1, port_a1) annotation (Line(
          points={{-40.2,-60},{-98,-60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(HPBoiler.port_b1, port_b1) annotation (Line(
          points={{-80,60},{-100,60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(HexVal.port_a1, HeaPum.port_b1) annotation (Line(
          points={{40,-10},{40,-60},{-20,-60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(HPBoiler.port_a1, HexVal.port_b2) annotation (Line(
          points={{-60,60},{40,60},{40,10}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(port_b1, port_b1) annotation (Line(
          points={{-100,60},{-100,60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(HexVal.SuperCtrl, SuperCtrl1) annotation (Line(
          points={{32.8,0},{-104,0}},
          color={255,127,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(BouHP.ports[1], HPBoiler.port_a1) annotation (Line(
          points={{-7.33333,60},{-60,60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(BouHP.ports[2], HexVal.port_b2) annotation (Line(
          points={{-10,60},{40,60},{40,10}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(HPBoiler.port_a1, BouHP.ports[3]) annotation (Line(
          points={{-60,60},{-12.6667,60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(HexVal.port_a2, port_a2) annotation (Line(
          points={{48,10},{48,60},{100,60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(HexVal.port_b1, port_b2) annotation (Line(
          points={{48,-10},{48,-60},{100,-60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(SuperCtrl1, HPBoiler.StabilityControl1) annotation (Line(
          points={{-104,0},{-40,0},{-40,66},{-60.2,66}},
          color={255,127,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(HPBoiler.BoilerTempSensorSignal, Tboi) annotation (Line(
          points={{-80.2,64},{-90,64},{-90,20},{60,20},{60,102}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(HeaPum.HeatTempOut, HPTemp) annotation (Line(
          points={{-20,-56},{0,-56},{0,-20},{60,-20},{60,-110}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(HeaPum.HeatTempOut, HPBoiler.HeatPumpTempSensor1) annotation (
          Line(
          points={{-20,-56},{-20,-40},{-50,-40},{-50,64},{-60.2,64}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Ellipse(
              extent={{-80,80},{80,-80}},
              fillPattern=FillPattern.Solid,
              fillColor={255,255,85},
              pattern=LinePattern.None), Polygon(
              points={{-32,42},{-32,-38},{48,2},{-32,42}},
              smooth=Smooth.None,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None)}));
    end HeatPump;
  end HeatPumpSection;
  annotation (uses(Buildings(version="1.5"), Modelica(version="3.2.1")),
      version="1");
end NewHotelModel;
