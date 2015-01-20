within HotelModel.HotelSection;
package HeatPumpSection

  model HeatPump "Complete heat pump section with everything put together"
  replaceable package MediumHW =
          Buildings.Media.ConstantPropertyLiquidWater
      "Medium for condenser water"
        annotation (choicesAllMatching = true);
    parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal
      "Nominal mass flow rate of water";
    parameter Modelica.SIunits.Pressure dpHW_nominal
      "Nominal pressure difference";
  replaceable package MediumDW =
        Buildings.Media.ConstantPropertyLiquidWater
      "Medium for domestic hot water";
        //Buildings.Media.Interfaces.PartialSimpleMedium
     parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal
      "Nominal mass flow rate";
      //Nominal flow rate is value I gave, probably different
     parameter Modelica.SIunits.Pressure dpDW_nominal
      "Nominal pressure difference";
    parameter Modelica.SIunits.Power Q_flow_nominal "Nominal heat flow";
    parameter Modelica.SIunits.Volume HeatPumpVol "Volume of the Heat Pump";
    parameter Modelica.SIunits.Temperature HeaPumTRef
      "Reference tempearture of heat pump";
    parameter Modelica.SIunits.Temp_K TSetBoiIn "Set temperature for boiler";
    BoilerPackage.Boiler2WithControls HeaPumBoi(
      redeclare package MediumHW = MediumHW,
      dpHW_nominal=dpHW_nominal,
      Q_flow_nominal=Q_flow_nominal,
      TSetBoiIn=TSetBoiIn,
      mHW_flow_nominal=mHW_flow_nominal,
      bolCon(conPID(controllerType=Modelica.Blocks.Types.SimpleController.PI, Ti=
              60))) "Boiler corresponding to the heat pump section"
      annotation (Placement(transformation(extent={{-20,42},{-60,78}})));
    HeatPumpPackage.HeatPumpwithControls HeaPum(
      redeclare package MediumHW = MediumHW,
      dpHW_nominal=dpHW_nominal,
      HeatPumpVol=HeatPumpVol,
      HeaPumTRef=HeaPumTRef,
      mHW_flow_nominal=mHW_flow_nominal) "Heat Pump"
      annotation (Placement(transformation(extent={{-60,-80},{-20,-40}})));
    HeatExchangeValvesPackage.HexValves_with_Control HexVal(
      redeclare package MediumDW = MediumDW,
      mDW_flow_nominal=mDW_flow_nominal,
      mHW_flow_nominal=mHW_flow_nominal,
      redeclare package MediumHW = MediumHW,
      dpHW_nominal=dpHW_nominal,
      dpDW_nominal=dpDW_nominal) "Heat exchange valves with controls"
                                                                  annotation (
       Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={40,0})));

    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
          MediumHW)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
          MediumHW)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
    Modelica.Blocks.Interfaces.IntegerInput Sta
      "States controlled by the supervisory control"
      annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
          MediumDW)
      "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
          MediumDW)
      "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,50},{110,70}})));
    Modelica.Blocks.Interfaces.RealOutput Tboi
      "Temperature of the passing fluid in the boiler" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={60,110})));
    Modelica.Blocks.Interfaces.RealOutput THeaPum
      "Temperature of the passing fluid leaving from the heat pumps"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={60,-110})));
    Modelica.Blocks.Interfaces.RealInput Q_flow1 "Heat Flow input "
      annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
    Modelica.Blocks.Interfaces.RealOutput BypValPos "Actual valve position"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={40,110})));
  equation
    connect(HexVal.port_a1, HeaPum.port_b1) annotation (Line(
        points={{32,-20},{32,-60},{-20,-60}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(HeaPumBoi.Sta, Sta) annotation (Line(
        points={{-18.4,71.16},{-18.4,72},{-8,72},{-8,20},{-110,20}},
        color={255,127,0},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(HeaPum.THeaPum, THeaPum) annotation (Line(
        points={{-18,-52},{0,-52},{0,-40},{60,-40},{60,-110}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(HeaPum.THeaPum, HeaPumBoi.HPTSen) annotation (Line(
        points={{-18,-52},{0,-52},{0,67.56},{-18.4,67.56}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(HeaPumBoi.TBoi, Tboi) annotation (Line(
        points={{-62.4,67.56},{-62.4,68},{-80,68},{-80,40},{60,40},{60,110}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));

    connect(Sta, HexVal.Sta) annotation (Line(
        points={{-110,20},{-8,20},{-8,1.33227e-015},{17.6,1.33227e-015}},
        color={255,127,0},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(HeaPum.Q_flow1, Q_flow1) annotation (Line(
        points={{-64,-68},{-80,-68},{-80,-20},{-120,-20}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    connect(HexVal.port_b1, HeaPumBoi.port_a1) annotation (Line(
        points={{32,20},{32,60},{-20,60}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(HexVal.port_b2, port_a2) annotation (Line(
        points={{48.4,-20},{48,-20},{48,-60},{100,-60}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(port_b2, HexVal.port_a2) annotation (Line(
        points={{100,60},{48,60},{48,20}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(HeaPumBoi.port_b1, port_a1) annotation (Line(
        points={{-60,60},{-100,60}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(HeaPum.port_a1, port_b1) annotation (Line(
        points={{-60.4,-60},{-100,-60}},
        color={0,127,255},
        smooth=Smooth.None,
        thickness=1));
    connect(HexVal.BypValPos, BypValPos) annotation (Line(
        points={{40,22},{40,110}},
        color={0,0,127},
        smooth=Smooth.None,
        pattern=LinePattern.Dash));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Rectangle(
            extent={{-80,80},{80,-80}},
            lineThickness=1,
            pattern=LinePattern.None,
            lineColor={135,135,135},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-80,60},{80,20}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-80,-20},{80,-60}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Rectangle(
            extent={{-80,20},{80,-20}},
            fillColor={128,0,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0})}));
  end HeatPump;

  package BoilerPackage

    model Boiler2
      "Boiler system in the condenser water loop that provides heating in the cold winter"
     replaceable package MediumHW =
           Buildings.Media.ConstantPropertyLiquidWater
        "Medium for condenser water"
          annotation (choicesAllMatching = true);
      parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal
        "Nominal mass flow rate of water";
      parameter Modelica.SIunits.Pressure dpHW_nominal
        "Nominal pressure difference";
      parameter Modelica.SIunits.Power Q_flow_nominal "Nominal heat flow";
      Buildings.Fluid.Boilers.BoilerPolynomial boi(
        fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
        redeclare package Medium = MediumHW,
        Q_flow_nominal=Q_flow_nominal,
        m_flow_nominal=mHW_flow_nominal,
        dp_nominal=dpHW_nominal)
        "Boiler that corresponds of the heat pump section"
        annotation (Placement(transformation(extent={{40,30},{60,50}})));
      Buildings.Fluid.Actuators.Valves.TwoWayLinear valBoi(
        redeclare package Medium = MediumHW,
        m_flow_nominal=mHW_flow_nominal,
        dpValve_nominal=dpHW_nominal) "Valve to control the flow into boiler"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,0})));
      Buildings.Fluid.Actuators.Valves.TwoWayLinear valByp(
        redeclare package Medium = MediumHW,
        m_flow_nominal=mHW_flow_nominal,
        dpValve_nominal=dpHW_nominal) "Bypass valve"
        annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
            MediumHW)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
            MediumHW)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
      Modelica.Blocks.Interfaces.RealInput boiCon "Control singal for boiler"
        annotation (Placement(transformation(extent={{-120,68},{-100,88}}),
            iconTransformation(extent={{-116,72},{-100,88}})));
      Modelica.Blocks.Interfaces.RealInput valCon
        "Control signal for valves in boiler loop" annotation (Placement(
            transformation(extent={{-120,30},{-100,50}}), iconTransformation(extent={{-116,34},
                {-100,50}})));
      Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
        annotation (Placement(transformation(extent={{-44,4},{-24,24}})));
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1
        "Heat port, can be used to connect to ambient"
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
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
      connect(valCon, add.u1) annotation (Line(
          points={{-110,40},{-60,40},{-60,20},{-46,20}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(const.y, add.u2) annotation (Line(
          points={{-69,-10},{-60,-10},{-60,8},{-46,8}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(boi.heatPort, heatPort1) annotation (Line(
          points={{50,47.2},{50,70},{0,70},{0,100}},
          color={191,0,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(add.y, valBoi.y) annotation (Line(
          points={{-23,14},{-18,14},{-18,0},{-12,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(valByp.y, valCon) annotation (Line(
          points={{50,-28},{50,-20},{20,-20},{20,32},{-40,32},{-40,40},{-110,40}},
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
    replaceable package MediumHW =
             Buildings.Media.ConstantPropertyLiquidWater
        "Medium for condenser water"
          annotation (choicesAllMatching = true);
      parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal
        "Nominal mass flow rate of water";
      parameter Modelica.SIunits.Pressure dpHW_nominal
        "Nominal pressure difference";
      parameter Modelica.SIunits.Power Q_flow_nominal "Nominal heat flow";
      parameter Real TSetBoiIn "Set temperature for boiler";
      Boiler2 boi(
        redeclare package MediumHW = MediumHW,
        mHW_flow_nominal=mHW_flow_nominal,
        dpHW_nominal=dpHW_nominal,
        Q_flow_nominal=Q_flow_nominal)
        "Boiler to heat the condenser water in a cold winter"
        annotation (Placement(transformation(extent={{-10,-6},{10,14}})));
      BolierControls bolCon(TSetBoiIn=TSetBoiIn) "Boiler Control"
        annotation (Placement(transformation(extent={{-60,46},{-40,66}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort BoiTSen(redeclare package
          Medium = MediumHW, m_flow_nominal=mHW_flow_nominal)
        "Finds the temperature of the water after it has been through the boiler"
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
            MediumHW)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
            MediumHW)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Blocks.Interfaces.IntegerInput Sta
        "States commanded by the supervisory control" annotation (Placement(
            transformation(extent={{-120,50},{-100,70}}), iconTransformation(
              extent={{-116,54},{-100,70}})));
      Modelica.Blocks.Interfaces.RealInput HPTSen
        "Heat pump temperature sensor signal"  annotation (Placement(
            transformation(extent={{-120,30},{-100,50}}), iconTransformation(
              extent={{-116,34},{-100,50}})));
      Modelica.Blocks.Interfaces.RealOutput TBoi
        "Signal of the output temperature after it has gone through the boiler"
        annotation (Placement(transformation(extent={{100,30},{120,50}}),
            iconTransformation(extent={{104,34},{120,50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1
        "Heat port, can be used to connect to ambient"
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    equation
      connect(boi.port_b1, BoiTSen.port_a) annotation (Line(
          points={{10,0},{50,0}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(BoiTSen.port_b, port_b1) annotation (Line(
          points={{70,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(port_a1, port_a1) annotation (Line(
          points={{-100,0},{-100,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(Sta, bolCon.sta) annotation (Line(
          points={{-110,60},{-62,60}},
          color={255,127,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(HPTSen, bolCon.TMea) annotation (Line(
          points={{-110,40},{-80,40},{-80,50},{-62,50}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(bolCon.Val4Ctr, boi.valCon) annotation (Line(
          points={{-39,60},{-24,60},{-24,8.2},{-10.8,8.2}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(bolCon.BoiCtr, boi.boiCon) annotation (Line(
          points={{-39,54},{-20,54},{-20,12},{-10.8,12}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(BoiTSen.T, TBoi) annotation (Line(
          points={{60,11},{60,40},{110,40}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(boi.port_a1, port_a1) annotation (Line(
          points={{-10,0},{-100,0}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(boi.heatPort1, heatPort1) annotation (Line(
          points={{0,14},{0,100}},
          color={191,0,0},
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
              textString="%name")}));
    end Boiler2WithControls;

    model BolierControls "Boiler with controls, including valve controls"
      parameter Real TSetBoiIn "Set temperature for boiler";
      Modelica.Blocks.Math.IntegerToReal integerToReal
        annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
      Modelica.Blocks.Routing.Replicator replicator(nout=2)
        annotation (Placement(transformation(extent={{-20,30},{0,50}})));
      Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1,1,0; 2,1,0; 3,
            0,1; 4,0,1; 5,0,1; 6,0,1; 7,0,1])
        annotation (Placement(transformation(extent={{22,30},{42,50}})));
      Modelica.Blocks.Sources.Constant TSetBoi(k=TSetBoiIn)
        "Set point temperature of boiler"
        annotation (Placement(transformation(extent={{-40,-36},{-20,-16}})));
      Buildings.Controls.Continuous.LimPID conPID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=60)
        annotation (Placement(transformation(extent={{0,-36},{20,-16}})));
      Modelica.Blocks.Math.Product product
        annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
      Modelica.Blocks.Interfaces.RealOutput BoiCtr
        "Connector of Real output signal"
        annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
      Modelica.Blocks.Interfaces.RealOutput Val4Ctr
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
          points={{1,40},{20,40}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(integerToReal.y, replicator.u) annotation (Line(
          points={{-59,40},{-22,40}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(conPID.y, product.u2) annotation (Line(
          points={{21,-26},{58,-26}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(product.y, BoiCtr) annotation (Line(
          points={{81,-20},{110,-20}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(conPID.u_m, TMea) annotation (Line(
          points={{10,-38},{10,-60},{-120,-60}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(integerToReal.u, sta) annotation (Line(
          points={{-82,40},{-120,40}},
          color={255,127,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(BoiCtr, BoiCtr) annotation (Line(
          points={{110,-20},{110,-20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TSetBoi.y, conPID.u_s) annotation (Line(
          points={{-19,-26},{-2,-26}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(combiTable1D.y[1], product.u1) annotation (Line(
          points={{43,39.5},{50,39.5},{50,-14},{58,-14}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(Val4Ctr, combiTable1D.y[2]) annotation (Line(
          points={{110,40},{76,40},{76,40.5},{43,40.5}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
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

    package Example "Example of boiler package"
        extends Modelica.Icons.ExamplesPackage;

      model Boiler "Example for the boiler and its components"
         replaceable package MediumHW =
            Buildings.Media.ConstantPropertyLiquidWater
          "Medium for condenser water"
            annotation (choicesAllMatching = true);
        parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal=10
          "Nominal mass flow rate of water";
        parameter Modelica.SIunits.Pressure dpHW_nominal=100
          "Nominal pressure difference";
        parameter Modelica.SIunits.Power Q_flow_nominal "Nominal heat flow";
        import HotelModel;
       extends Modelica.Icons.Example;
        HotelModel.HeatPumpSection.BoilerPackage.Boiler2 boiler2_1(
          redeclare package MediumHW = MediumHW,
          mHW_flow_nominal=mHW_flow_nominal,
          dpHW_nominal=dpHW_nominal,
          Q_flow_nominal=Q_flow_nominal)
          annotation (Placement(transformation(extent={{-10,-46},{10,-26}})));
        Buildings.Fluid.Sources.Boundary_pT sin(
          p(displayUnit="Pa") = 300000,
          nPorts=1,
          redeclare package Medium = MediumHW,
          T=333.15) "Sink"
          annotation (Placement(transformation(extent={{74,-50},{54,-30}})));
        Buildings.Fluid.Sources.Boundary_pT sou(
          nPorts=1,
          redeclare package Medium = MediumHW,
          p=300000 + dpHW_nominal,
          T=303.15)
          annotation (Placement(transformation(extent={{-78,-50},{-58,-30}})));
        Modelica.Blocks.Sources.TimeTable y(table=[0,0; 1800,1; 1800,0; 2400,0; 2400,
              1; 3600,1])
          annotation (Placement(transformation(extent={{-76,18},{-56,38}})));
        inner Modelica.Fluid.System system
          annotation (Placement(transformation(extent={{80,80},{100,100}})));
        Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
            Medium = MediumHW)
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
            smooth=Smooth.None,
            thickness=1));
        connect(y.y, boiler2_1.boiCon) annotation (Line(
            points={{-55,28},{-30,28},{-30,-28},{-10.8,-28}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(temperature.port_b, sin.ports[1]) annotation (Line(
            points={{40,-40},{54,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(temperature.port_a, boiler2_1.port_b1) annotation (Line(
            points={{20,-40},{10,-40}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(TAmb2.port, boiler2_1.heatPort1) annotation (Line(
            points={{-20,50},{0,50},{0,-26}},
            color={191,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(pulse.y, boiler2_1.valCon) annotation (Line(
            points={{-55,-8},{-34,-8},{-34,-31.8},{-10.8,-31.8}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),      graphics));
      end Boiler;

      model BoilerSystem "Example for boiler system"
        extends Modelica.Icons.Example;
         replaceable package MediumHW =
            Buildings.Media.ConstantPropertyLiquidWater
          "Medium for condenser water"
            annotation (choicesAllMatching = true);
         parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal=10
          "Nominal mass flow rate of water";
         parameter Modelica.SIunits.Pressure dpHW_nominal=100
          "Nominal pressure difference";
         parameter Modelica.SIunits.Power Q_flow_nominal "Nominal heat flow";
         parameter Real TSetBoiIn "Set temperature for boiler";
       import HotelModel;
        Boiler2WithControls boiler2WithControls(
          redeclare package MediumHW = MediumHW,
          mHW_flow_nominal=mHW_flow_nominal,
          dpHW_nominal=dpHW_nominal,
          Q_flow_nominal=Q_flow_nominal,
          TSetBoiIn=TSetBoiIn)
          annotation (Placement(transformation(extent={{-20,-80},{20,-40}})));
        inner Modelica.Fluid.System system(T_ambient=283.15)
          annotation (Placement(transformation(extent={{40,61},{60,81}})));
        Buildings.Fluid.Sources.Boundary_pT bou1(
          nPorts=1,
          redeclare package Medium = MediumHW,
          p=0)
          annotation (Placement(transformation(extent={{82,-70},{62,-50}})));
        Modelica.Blocks.Sources.Constant const(k=273.15 + 22.22)
          annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
        Buildings.Fluid.Sources.MassFlowSource_T boundary(
          nPorts=1,
          T=273.15 + 22.22,
          redeclare package Medium = MediumHW,
          m_flow=mHW_flow_nominal)
          annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
        Modelica.Blocks.Sources.IntegerTable integerTable(table=[0,1; 100,2; 200,3; 300,
              4; 400,5; 500,6; 600,7])
          annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      equation
        connect(boiler2WithControls.port_b1, bou1.ports[1]) annotation (Line(
            points={{20,-60},{62,-60}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(const.y, boiler2WithControls.HPTSen) annotation (Line(
            points={{-59,40},{-40,40},{-40,-51.6},{-21.6,-51.6}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(boundary.ports[1], boiler2WithControls.port_a1) annotation (Line(
            points={{-60,-60},{-20,-60}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(integerTable.y, boiler2WithControls.Sta) annotation (Line(
            points={{-59,70},{-34,70},{-34,-47.6},{-21.6,-47.6}},
            color={255,127,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics),
          experiment(StopTime=2700, __Dymola_NumberOfIntervals=1000),
          __Dymola_experimentSetupOutput);
      end BoilerSystem;
    end Example;
  end BoilerPackage;

  package HeatPumpPackage
    "Representation of the Heat Pump along with components interacting directly with it"

    model HeatPump "Base class representation of the Heat Pump"
    replaceable package MediumHW =
          Buildings.Media.ConstantPropertyLiquidWater
        "Medium for condenser water"
          annotation (choicesAllMatching = true);
      parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal
        "Nominal mass flow rate of water";
      parameter Modelica.SIunits.Pressure dpHW_nominal
        "Nominal pressure difference";
      parameter Modelica.SIunits.Volume HeatPumpVol "Volume of the Heat Pump";
      parameter Modelica.SIunits.Temperature HeaPumTRef
        "Reference tempearture of heat pump";

      Buildings.Fluid.MixingVolumes.MixingVolume HeaPumTan(
        redeclare package Medium = MediumHW,
        m_flow_nominal=mHW_flow_nominal,
        V=HeatPumpVol,
        nPorts=2) "Volume control of the Heat Pump"
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow(T_ref=HeaPumTRef)
        "Prescribed Heat flow of the Heat Pump"
        annotation (Placement(transformation(extent={{-66,-50},{-46,-30}})));
      Modelica.Blocks.Interfaces.RealInput Q_flow "Heat Flow input "
        annotation (Placement(transformation(extent={{-124,-52},{-100,-28}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort HeaPumTemp(redeclare package
          Medium = MediumHW, m_flow_nominal=mHW_flow_nominal)
        "Tempearture after Heat Pump"
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
            MediumHW)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
            MediumHW)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealOutput THeaPum
        "Signal of temperature of the passing fluid"
        annotation (Placement(transformation(extent={{100,30},{120,50}})));
      inner Modelica.Fluid.System system
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      Buildings.Fluid.Movers.FlowMachine_m_flow Pum(
        addPowerToMedium=false,
        allowFlowReversal=true,
        redeclare package Medium = MediumHW,
        m_flow_nominal=mHW_flow_nominal)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Modelica.Blocks.Sources.Constant const(k=mHW_flow_nominal)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-70,70})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=if Q_flow > 0 then
            Q_flow*(1 + 1/4) else Q_flow*(1 - 1/3))
        annotation (Placement(transformation(extent={{-94,-50},{-74,-30}})));
    equation
      connect(prescribedHeatFlow.port, HeaPumTan.heatPort) annotation (Line(
          points={{-46,-40},{-20,-40},{-20,10}},
          color={191,0,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(HeaPumTemp.port_b, port_b1) annotation (Line(
          points={{70,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(HeaPumTemp.T, THeaPum) annotation (Line(
          points={{60,11},{60,40},{110,40}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(THeaPum, THeaPum) annotation (Line(
          points={{110,40},{110,40}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(const.y, Pum.m_flow_in) annotation (Line(
          points={{-70,59},{-70,12},{-70.2,12}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(HeaPumTan.ports[1], Pum.port_b) annotation (Line(
          points={{-12,0},{-60,0}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(Pum.port_a, port_a1) annotation (Line(
          points={{-80,0},{-102,0}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(HeaPumTan.ports[2], HeaPumTemp.port_a) annotation (Line(
          points={{-8,0},{50,0}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(realExpression.y, prescribedHeatFlow.Q_flow) annotation (Line(
          points={{-73,-40},{-66,-40}},
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
    replaceable package MediumHW =
          Buildings.Media.ConstantPropertyLiquidWater
        "Medium for condenser water";
      parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal
        "Nominal mass flow rate of water";
      parameter Modelica.SIunits.Pressure dpHW_nominal
        "Nominal pressure difference";
      parameter Modelica.SIunits.Volume HeatPumpVol "Volume of the Heat Pump";
      parameter Modelica.SIunits.Temperature HeaPumTRef
        "Reference tempearture of heat pump";

      HeatPump HeaPum(
        redeclare package MediumHW = MediumHW,
        HeatPumpVol=HeatPumpVol,
        HeaPumTRef=HeaPumTRef,
        mHW_flow_nominal=mHW_flow_nominal,
        dpHW_nominal=dpHW_nominal)
        "Heat pump with all components directly interacting with it"
        annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
            MediumHW)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
            MediumHW)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealOutput THeaPum
        "Temperature of the passing fluid leaving the heat pump"
        annotation (Placement(transformation(extent={{100,30},{120,50}})));
      Modelica.Blocks.Interfaces.RealInput Q_flow1 "Heat Flow input "
        annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
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
      connect(HeaPum.THeaPum, THeaPum) annotation (Line(
          points={{22,8},{60,8},{60,40},{110,40}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(HeaPum.Q_flow, Q_flow1) annotation (Line(
          points={{-22.4,-8},{-30,-8},{-30,-40},{-120,-40}},
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
              textString="%name")}));
    end HeatPumpwithControls;

    package Example "Examples involving the Heat Pump "
      extends Modelica.Icons.ExamplesPackage;
      model HeatPump "Testing the Heat Pump "
           replaceable package MediumHW =
            Buildings.Media.ConstantPropertyLiquidWater
          "Medium for hot water loop"
            annotation (choicesAllMatching = true);
        parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal=10
          "Nominal mass flow rate of water";
        parameter Modelica.SIunits.Pressure dpHW_nominal=100
          "Nominal pressure difference";
            parameter Modelica.SIunits.Volume HeatPumpVol
          "Volume of the Heat Pump";
        parameter Modelica.SIunits.Temperature HeaPumTRef
          "Reference tempearture of heat pump";

        import HotelModel;
       extends Modelica.Icons.Example;

        HotelModel.HeatPumpSection.HeatPumpPackage.HeatPump heatPump(
          redeclare package MediumHW = MediumHW,
          mHW_flow_nominal=mHW_flow_nominal,
          dpHW_nominal=dpHW_nominal,
          HeatPumpVol=HeatPumpVol,
          HeaPumTRef=HeaPumTRef)
          annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
        Buildings.Fluid.Sources.Boundary_pT sin(
          p(displayUnit="Pa") = 300000,
          nPorts=1,
          redeclare package Medium = MediumHW,
          T=333.15) "Sink"
          annotation (Placement(transformation(extent={{72,-10},{52,10}})));
        Buildings.Fluid.Sources.Boundary_pT sou(
          nPorts=1,
          redeclare package Medium = MediumHW,
          p=300000 + dpHW_nominal,
          T=303.15)
          annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
        inner Modelica.Fluid.System system
          annotation (Placement(transformation(extent={{80,80},{100,100}})));
        Modelica.Blocks.Sources.Constant const1(k=30000)
          annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
      equation
        connect(heatPump.port_b1, sin.ports[1]) annotation (Line(
            points={{8,0},{52,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(sou.ports[1], heatPump.port_a1) annotation (Line(
            points={{-50,0},{-12.2,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(const1.y, heatPump.Q_flow) annotation (Line(
            points={{-59,-50},{-40,-50},{-40,-4},{-13.2,-4}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics));
      end HeatPump;

      model HeatPumpwithControls "Testing the Heat Pump with controls"
           replaceable package MediumHW =
            Buildings.Media.ConstantPropertyLiquidWater
          "Medium for condenser water"
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

        HotelModel.HeatPumpSection.HeatPumpPackage.HeatPumpwithControls
          heatPumpwithControls(
          redeclare package MediumHW = MediumHW,
          mHW_flow_nominal=mHW_flow_nominal,
          dpHW_nominal=dpHW_nominal,
          HeatPumpVol=HeatPumpVol,
          HeaPumTRef=HeaPumTRef)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Buildings.Fluid.Sources.Boundary_pT sin(
          p(displayUnit="Pa") = 300000,
          nPorts=1,
          redeclare package Medium = MediumHW,
          T=333.15) "Sink"
          annotation (Placement(transformation(extent={{80,-10},{60,10}})));
        Buildings.Fluid.Sources.Boundary_pT sou(
          nPorts=1,
          p=300000 + dpHW_nominal,
          redeclare package Medium = MediumHW,
          T=303.15)
          annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
        inner Modelica.Fluid.System system
          annotation (Placement(transformation(extent={{80,80},{100,100}})));
        Modelica.Blocks.Sources.Constant const1(k=30000)
          annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
      equation
        connect(heatPumpwithControls.port_b1, sin.ports[1]) annotation (Line(
            points={{10,0},{60,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(sou.ports[1], heatPumpwithControls.port_a1) annotation (Line(
            points={{-50,0},{-10.2,0}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(const1.y, heatPumpwithControls.Q_flow1) annotation (Line(
            points={{-49,-40},{-30,-40},{-30,-4},{-12,-4}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics));
      end HeatPumpwithControls;
    end Example;
  end HeatPumpPackage;

  package HeatExchangeValvesPackage
    "Heat exchanger 2 with series of valves and controls for it"

    model HeatEx_and_valves
    replaceable package MediumHW =
          Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
          annotation (choicesAllMatching = true);
      parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal
        "Nominal mass flow rate of water";
      parameter Modelica.SIunits.Pressure dpHW_nominal
        "Nominal pressure difference";
           replaceable package MediumDW =
          Buildings.Media.ConstantPropertyLiquidWater
        "Medium for domestic hot water";
          //Buildings.Media.Interfaces.PartialSimpleMedium
       parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal
        "Nominal mass flow rate";
         parameter Modelica.SIunits.Pressure dpDW_nominal
        "Nominal pressure difference";

      Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
        redeclare package Medium1 = MediumHW,
        redeclare package Medium2 = MediumDW,
        m2_flow_nominal=mDW_flow_nominal,
        m1_flow_nominal=mHW_flow_nominal,
        dp1_nominal=dpHW_nominal,
        dp2_nominal=dpDW_nominal)
        "Heat exchanger corresponding to the connection between the heat pump and the domestic water"
        annotation (Placement(transformation(extent={{-10,-44},{10,-24}})));
      Buildings.Fluid.Actuators.Valves.TwoWayLinear hexval1(
        redeclare package Medium = MediumHW,
        dpValve_nominal=dpHW_nominal,
        m_flow_nominal=mHW_flow_nominal) "Heat Exchanger valve 1"
                                                             annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-40,0})));
      Buildings.Fluid.Actuators.Valves.TwoWayLinear valbyp(
        redeclare package Medium = MediumHW,
        m_flow_nominal=mHW_flow_nominal,
        dpValve_nominal=dpHW_nominal) "Heat exchange valve bypass"
        annotation (Placement(transformation(extent={{-10,30},{10,50}})));
      Buildings.Fluid.Actuators.Valves.TwoWayLinear hexval2(
        redeclare package Medium = MediumHW,
        m_flow_nominal=mHW_flow_nominal,
        dpValve_nominal=dpHW_nominal) "Heat Exchange valve 2"
                                                            annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,0})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
            MediumHW)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
            MediumHW)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{90,30},{110,50}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
            MediumDW)
        "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
            MediumDW)
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
      Modelica.Blocks.Interfaces.RealOutput BypValPos "Actual valve position"
        annotation (Placement(transformation(extent={{100,-10},{120,10}}),
            iconTransformation(extent={{100,-10},{120,10}})));
      inner Modelica.Fluid.System system
        annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
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
      connect(hex.port_b1, hexval2.port_a) annotation (Line(
          points={{10,-28},{40,-28},{40,-10}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(hexval2.port_b, port_b1) annotation (Line(
          points={{40,10},{40,40},{100,40}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(valbyp.y_actual, BypValPos) annotation (Line(
          points={{5,47},{80,47},{80,0},{110,0}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
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
    replaceable package MediumHW =
          Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
          annotation (choicesAllMatching = true);
      parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal
        "Nominal mass flow rate of water";
      parameter Modelica.SIunits.Pressure dpHW_nominal
        "Nominal pressure difference";
               replaceable package MediumDW =
          Buildings.Media.ConstantPropertyLiquidWater
        "Medium for domestic hot water";
          //Buildings.Media.Interfaces.PartialSimpleMedium
       parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal
        "Nominal mass flow rate";
          parameter Modelica.SIunits.Pressure dpDW_nominal
        "Nominal pressure difference";
      HeatEx_and_valves Hex(
        redeclare package MediumDW = MediumDW,
        mDW_flow_nominal=mDW_flow_nominal,
        dpDW_nominal=dpDW_nominal,
        redeclare package MediumHW = MediumHW,
        mHW_flow_nominal=mHW_flow_nominal,
        dpHW_nominal=dpHW_nominal) "Hex with the valves included"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
            MediumHW)
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
            MediumHW)
        "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
        annotation (Placement(transformation(extent={{90,30},{110,50}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
            MediumDW)
        "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
        annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
            MediumDW)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-52},{-90,-32}})));
      HeatExchangeControls heatExchangeControls annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={0,58})));
      Modelica.Blocks.Interfaces.IntegerInput Sta
        "States decided by supervisory control" annotation (Placement(
            transformation(
            extent={{-12,12},{12,-12}},
            rotation=-90,
            origin={0,112})));
      Modelica.Blocks.Interfaces.RealOutput BypValPos "Actual valve position"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation

      connect(Hex.port_a1, port_a1) annotation (Line(
          points={{-10,4},{-60,4},{-60,40},{-100,40}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(Hex.port_a2, port_a2) annotation (Line(
          points={{10,-4},{60,-4},{60,-40},{100,-40}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(heatExchangeControls.u1, Sta) annotation (Line(
          points={{0,70},{0,112}},
          color={255,127,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(heatExchangeControls.ValCtrlByp, Hex.BypValCtrl) annotation (Line(
          points={{4,47},{6,47},{6,11.2}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(heatExchangeControls.ValCtrl2, Hex.ValCtrl2) annotation (Line(
          points={{0,47},{0,11.2}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(heatExchangeControls.ValCtrl1, Hex.ValCtrl1) annotation (Line(
          points={{-4,47},{-6,47},{-6,11.2}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(port_b1, Hex.port_b1) annotation (Line(
          points={{100,40},{60,40},{60,4},{10,4}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(port_b2, Hex.port_b2) annotation (Line(
          points={{-100,-42},{-60,-42},{-60,-4},{-10,-4}},
          color={0,127,255},
          smooth=Smooth.None,
          thickness=1));
      connect(Hex.BypValPos, BypValPos) annotation (Line(
          points={{11,0},{110,0}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
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
              points={{0,98},{0,68},{0,60}},
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
      Modelica.Blocks.Routing.Replicator replicator(nout=2)
        annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
      Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1,0,1; 2,1,0; 3,1,0;
            4,0,1; 5,1,0; 6,1,0; 7,0,1])
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Modelica.Blocks.Interfaces.IntegerInput u1
        "Connector of Integer input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput ValCtrlByp "controls bypass valve"
        annotation (Placement(transformation(extent={{100,30},{120,50}})));
      Modelica.Blocks.Interfaces.RealOutput ValCtrl2 "control for hex valve 2"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.RealOutput ValCtrl1 "control for hex valve 1"
        annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
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
          points={{-62,0},{-120,0}},
          color={255,127,0},
          smooth=Smooth.None));
      connect(combiTable1D.y[2], ValCtrlByp) annotation (Line(
          points={{41,0.5},{60,0.5},{60,40},{110,40}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(ValCtrl1, ValCtrl2) annotation (Line(
          points={{110,-40},{80,-40},{80,0},{110,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(combiTable1D.y[1], ValCtrl2) annotation (Line(
          points={{41,-0.5},{40,-0.5},{40,0},{110,0}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),        graphics), Icon(coordinateSystem(
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

    package Examples "Examples for the Heat Exchange valves package"
        extends Modelica.Icons.ExamplesPackage;

      model HeatEx_and_valves "Example for the HeatEx and valves"
           replaceable package MediumHW =
            Buildings.Media.ConstantPropertyLiquidWater
          "Medium for condenser water"
            annotation (choicesAllMatching = true);
        parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal=10
          "Nominal mass flow rate of water";
        parameter Modelica.SIunits.Pressure dpHW_nominal=100
          "Nominal pressure difference";
             replaceable package MediumDW =
            Buildings.Media.ConstantPropertyLiquidWater
          "Medium for domestic hot water";
            //Buildings.Media.Interfaces.PartialSimpleMedium
         parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal=15
          "Nominal mass flow rate";
            //The nominal flow rate of water for domestic flow rate is one I gave it
            //Need to look up actual values
         parameter Modelica.SIunits.Pressure dpDW_nominal=100
          "Nominal pressure difference";
        import HotelModel;
       extends Modelica.Icons.Example;
        HotelModel.HeatPumpSection.HeatExchangeValvesPackage.HeatEx_and_valves
          heatEx_and_valves(
          redeclare package MediumHW = MediumHW,
          mHW_flow_nominal=mHW_flow_nominal,
          dpHW_nominal=dpHW_nominal,
          redeclare package MediumDW = MediumDW,
          mDW_flow_nominal=mDW_flow_nominal)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Buildings.Fluid.Sources.Boundary_pT sin_2(
          use_p_in=true,
          T=273.15 + 10,
          nPorts=1,
          redeclare package Medium = MediumDW,
          X={1})                annotation (Placement(transformation(extent={{-60,-30},
                  {-40,-10}},rotation=0)));
          Modelica.Blocks.Sources.Ramp TWat(
          height=10,
          duration=60,
          offset=273.15 + 30,
          startTime=60) "Water temperature"
                       annotation (Placement(transformation(extent={{-100,40},{-80,60}},
                rotation=0)));
          Modelica.Blocks.Sources.Constant POut(k=101325)
            annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
                rotation=0)));
        Buildings.Fluid.Sources.Boundary_pT sou_1(
          p=300000 + 5000,
          T=273.15 + 50,
          use_T_in=true,
          nPorts=1,
          redeclare package Medium = MediumHW)
                                annotation (Placement(transformation(extent={{-60,10},
                  {-40,30}}, rotation=0)));
        Buildings.Fluid.Sources.Boundary_pT sin_1(
          use_p_in=true,
          T=273.15 + 25,
          nPorts=1,
          redeclare package Medium = MediumHW,
          p=300000)             annotation (Placement(transformation(extent={{60,10},
                  {40,30}},rotation=0)));
        Modelica.Blocks.Sources.Trapezoid trapezoid(
          amplitude=5000,
          rising=10,
          width=100,
          falling=10,
          period=3600,
          offset=300000)
          annotation (Placement(transformation(extent={{60,50},{80,70}})));
          Modelica.Blocks.Sources.Ramp PIn(
          height=200,
          duration=60,
          offset=101325,
          startTime=50)
                       annotation (Placement(transformation(extent={{20,-60},{40,-40}},
                rotation=0)));
        Buildings.Fluid.Sources.Boundary_pT sou_2(
                                      T=273.15 + 5,
          use_p_in=true,
          use_T_in=true,
          redeclare package Medium = MediumDW,
          nPorts=1)             annotation (Placement(transformation(extent={{60,-30},
                  {40,-10}}, rotation=0)));
        Modelica.Blocks.Sources.Constant TDb(k=293.15) "Drybulb temperature"
          annotation (Placement(transformation(extent={{20,-90},{40,-70}}, rotation=0)));
        Modelica.Blocks.Sources.Step step(startTime=1800)
          annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
        Modelica.Blocks.Sources.Pulse pulse(period=3600)
          annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
        inner Modelica.Fluid.System system
          annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
      equation

        connect(TWat.y,sou_1. T_in)
          annotation (Line(points={{-79,50},{-70,50},{-70,36},{-70,24},{-62,24}},
                                                       color={0,0,127},
            pattern=LinePattern.Dash));
        connect(POut.y,sin_2. p_in) annotation (Line(
            points={{-79,-50},{-70,-50},{-70,-12},{-62,-12}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(sin_2.ports[1], heatEx_and_valves.port_b2) annotation (Line(
            points={{-40,-20},{-20,-20},{-20,-4},{-10,-4}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(sou_1.ports[1], heatEx_and_valves.port_a1) annotation (Line(
            points={{-40,20},{-20,20},{-20,4},{-10,4}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(trapezoid.y,sin_1. p_in) annotation (Line(
            points={{81,60},{88,60},{88,28},{62,28}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(sin_1.ports[1], heatEx_and_valves.port_b1) annotation (Line(
            points={{40,20},{20,20},{20,4},{10,4}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(step.y, heatEx_and_valves.ValCtrl1) annotation (Line(
            points={{-19,50},{-6,50},{-6,11.2}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(step.y, heatEx_and_valves.ValCtrl2) annotation (Line(
            points={{-19,50},{0,50},{0,11.2}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(pulse.y, heatEx_and_valves.BypValCtrl) annotation (Line(
            points={{-19,80},{6,80},{6,11.2}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(sou_2.ports[1], heatEx_and_valves.port_a2) annotation (Line(
            points={{40,-20},{20,-20},{20,-4},{10,-4}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(PIn.y, sou_2.p_in) annotation (Line(
            points={{41,-50},{80,-50},{80,-12},{62,-12}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(TDb.y, sou_2.T_in) annotation (Line(
            points={{41,-80},{70,-80},{70,-16},{62,-16}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics));
      end HeatEx_and_valves;

      model HexValves_with_Control
        "Examples for the heat exchange valves with the controls"
           replaceable package MediumCW =
            Buildings.Media.ConstantPropertyLiquidWater
          "Medium for condenser water"
            annotation (choicesAllMatching = true);
        parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
          "Nominal mass flow rate of water";
        parameter Modelica.SIunits.Pressure dp_nominal=100
          "Nominal pressure difference";
            replaceable package MediumDW =
            Buildings.Media.ConstantPropertyLiquidWater
          "Medium for domestic hot water";
            //Buildings.Media.Interfaces.PartialSimpleMedium
         parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal=20
          "Nominal mass flow rate";
            //The nominal flow rate of water for domestic flow rate is one I gave it
            //Need to look up actual values
         parameter Modelica.SIunits.Pressure dpDW_nominal=100
          "Nominal pressure difference";
        import HotelModel;
       extends Modelica.Icons.Example;
        HotelModel.HeatPumpSection.HeatExchangeValvesPackage.HexValves_with_Control
          hexValves_with_Control(
          redeclare package MediumCW = MediumCW,
          mWater_flow_nominal=mWater_flow_nominal,
          dp_nominal=dp_nominal,
          redeclare package MediumDW = MediumDW,
          mDW_flow_nominal=mDW_flow_nominal)
          annotation (Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=90,
              origin={0,0})));
        Buildings.Fluid.Sources.Boundary_pT sin_2(
          use_p_in=true,
          T=273.15 + 10,
          redeclare package Medium = MediumDW,
          X={1},
          nPorts=1)             annotation (Placement(transformation(extent={{-50,-30},
                  {-30,-10}},rotation=0)));
          Modelica.Blocks.Sources.Ramp TWat(
          height=10,
          offset=273.15 + 30,
          duration=5,
          startTime=5) "Water temperature"
                       annotation (Placement(transformation(extent={{-100,40},{-80,60}},
                rotation=0)));
          Modelica.Blocks.Sources.Constant POut(k=101325)
            annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
                rotation=0)));
        Buildings.Fluid.Sources.Boundary_pT sou_1(
          p=300000 + 5000,
          T=273.15 + 50,
          use_T_in=true,
          redeclare package Medium = MediumCW,
          nPorts=1)             annotation (Placement(transformation(extent={{-54,16},
                  {-34,36}}, rotation=0)));
        Buildings.Fluid.Sources.Boundary_pT sin_1(
          use_p_in=true,
          T=273.15 + 25,
          redeclare package Medium = MediumCW,
          p=300000,
          nPorts=1)             annotation (Placement(transformation(extent={{70,10},{
                  50,30}}, rotation=0)));
        Modelica.Blocks.Sources.Trapezoid trapezoid(
          amplitude=5000,
          rising=10,
          width=100,
          falling=10,
          offset=300000,
          period=700)
          annotation (Placement(transformation(extent={{60,40},{80,60}})));
          Modelica.Blocks.Sources.Ramp PIn(
          height=200,
          duration=60,
          offset=101325,
          startTime=50)
                       annotation (Placement(transformation(extent={{20,-60},{40,-40}},
                rotation=0)));
        Buildings.Fluid.Sources.Boundary_pT sou_2(
                                      T=273.15 + 5,
          use_p_in=true,
          use_T_in=true,
          redeclare package Medium = MediumDW,
          nPorts=1)             annotation (Placement(transformation(extent={{70,-30},
                  {50,-10}}, rotation=0)));
        Modelica.Blocks.Sources.Constant TDb(k=293.15) "Drybulb temperature"
          annotation (Placement(transformation(extent={{20,-90},{40,-70}}, rotation=0)));
        inner Modelica.Fluid.System system
          annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
        Modelica.Blocks.Sources.IntegerTable integerTable(table=[0,1; 100,2; 200,3; 300,
              4; 400,5; 500,6; 600,7])
          "Representation of all the states in the supervisory control"
          annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
      equation

        connect(hexValves_with_Control.port_b1, sin_2.ports[1]) annotation (Line(
            points={{-4,-10},{-20,-10},{-20,-20},{-30,-20}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(sou_1.ports[1], hexValves_with_Control.port_a1) annotation (Line(
            points={{-34,26},{-20,26},{-20,10},{-4,10}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(TWat.y, sou_1.T_in) annotation (Line(
            points={{-79,50},{-60,50},{-60,30},{-56,30}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(POut.y, sin_2.p_in) annotation (Line(
            points={{-79,-50},{-60,-50},{-60,-12},{-52,-12}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(trapezoid.y,sin_1. p_in) annotation (Line(
            points={{81,50},{90,50},{90,28},{72,28}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(PIn.y, sou_2.p_in) annotation (Line(
            points={{41,-50},{90,-50},{90,-12},{72,-12}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(TDb.y, sou_2.T_in) annotation (Line(
            points={{41,-80},{80,-80},{80,-16},{72,-16}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(sin_1.ports[1], hexValves_with_Control.port_b2) annotation (Line(
            points={{50,20},{20,20},{20,10},{4.2,10}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(sou_2.ports[1], hexValves_with_Control.port_a2) annotation (Line(
            points={{50,-20},{20,-20},{20,-10},{4,-10}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=1));
        connect(integerTable.y, hexValves_with_Control.Sta) annotation (Line(
            points={{-19,80},{-11.2,80},{-11.2,0}},
            color={255,127,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics));
      end HexValves_with_Control;
    end Examples;
  end HeatExchangeValvesPackage;
end HeatPumpSection;
