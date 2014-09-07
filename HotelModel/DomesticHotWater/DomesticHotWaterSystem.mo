within HotelModel.DomesticHotWater;
model DomesticHotWaterSystem
  Buildings.Fluid.Movers.FlowMachine_m_flow KitPum
    "Pump for the kitchen domestic cold water" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,50})));
  Buildings.Fluid.Sources.Boundary_pT KitColWat(nPorts=1)
    "Kitchen domestic cold water" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-70,90})));
  Buildings.Fluid.Sources.Boundary_pT DomHotWat(nPorts=1) "Domestic hot water"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,20})));
  Buildings.Fluid.Sources.MassFlowSource_T DomColWat(nPorts=1, use_m_flow_in=
        true) "Domestic cold water " annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,40})));
  Buildings.Fluid.Movers.FlowMachine_m_flow DomPum "Domestic hot water pump"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,20})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Buildings.Fluid.Storage.StratifiedEnhanced tan annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-30})));
  Buildings.Fluid.Boilers.BoilerPolynomial boi
    annotation (Placement(transformation(extent={{-20,-90},{-40,-70}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-50})));
  Buildings.Fluid.Movers.FlowMachine_m_flow fan2 annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,-10})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-36,-16},{-24,-4}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo
    annotation (Placement(transformation(extent={{28,14},{40,26}})));
  Control.CoolingWaterControl cooWatCon annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-32,70})));
  Modelica.Blocks.Interfaces.RealInput TBoiSet "Part load ratio"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealOutput TBoi "Boiler temperature"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_in_kit
    "Prescribed mass flow rate for kitchen pump"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_in_dom
    "Prescribed mass flow rate for domestic water pump"
    annotation (Placement(transformation(extent={{-140,50},{-100,90}})));
equation
  connect(DomColWat.ports[1], senTem.port_a) annotation (Line(
      points={{-40,30},{-40,20},{-20,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(KitPum.port_a, tan.port_b) annotation (Line(
      points={{-70,40},{-70,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(KitPum.port_a, senTem.port_a) annotation (Line(
      points={{-70,40},{-70,20},{-20,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(KitPum.port_b, KitColWat.ports[1]) annotation (Line(
      points={{-70,60},{-70,80}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(DomPum.port_b, DomHotWat.ports[1]) annotation (Line(
      points={{70,20},{80,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val.y, const1.y) annotation (Line(
      points={{8,-50},{-10,-50},{-10,-10},{-23.4,-10}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(val.port_b, fan2.port_b) annotation (Line(
      points={{20,-40},{20,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(KitPum.port_a, port_a1) annotation (Line(
      points={{-70,40},{-70,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val.port_a, port_a2) annotation (Line(
      points={{20,-60},{20,-80},{0,-80},{0,-82},{0,-82},{0,-100},{0,-100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(val.port_a, port_a3) annotation (Line(
      points={{20,-60},{20,-80},{60,-80},{60,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(DomPum.port_a, senMasFlo.port_b) annotation (Line(
      points={{50,20},{40,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senMasFlo.port_a, senTem.port_b) annotation (Line(
      points={{28,20},{0,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(senMasFlo.port_a, fan2.port_a) annotation (Line(
      points={{28,20},{20,20},{20,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(DomColWat.m_flow_in, cooWatCon.y) annotation (Line(
      points={{-32,50},{-32,59}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senTem.T, cooWatCon.Tem) annotation (Line(
      points={{-10,31},{-10,90},{-28,90},{-28,82}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(senMasFlo.m_flow, cooWatCon.masFlow) annotation (Line(
      points={{34,26.6},{34,92},{-36,92},{-36,82}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(boi.port_a, port_a2) annotation (Line(
      points={{-20,-80},{0,-80},{0,-100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boi.port_b, tan.port_a) annotation (Line(
      points={{-40,-80},{-70,-80},{-70,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(boi.y, TBoiSet) annotation (Line(
      points={{-18,-72},{-14,-72},{-14,-60},{-90,-60},{-90,-40},{-120,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(boi.T, TBoi) annotation (Line(
      points={{-41,-72},{-50,-72},{-50,-28},{80,-28},{80,-40},{110,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(port_a2, port_a2) annotation (Line(
      points={{0,-100},{0,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(KitPum.m_flow_in, m_flow_in_kit) annotation (Line(
      points={{-82,49.8},{-88,49.8},{-88,30},{-120,30}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(DomPum.m_flow_in, m_flow_in_dom) annotation (Line(
      points={{59.8,32},{60,32},{60,70},{-120,70}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(const1.y, fan2.m_flow_in) annotation (Line(
      points={{-23.4,-10},{-8,-10},{-8,-9.8},{8,-9.8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics
        ={
        Rectangle(
          extent={{-94,8},{-58,-8}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{58,8},{94,-8}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,10},{20,-10}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={-1.77636e-015,-78},
          rotation=90),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-44,42},{44,-44}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,74},{72,8}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-78,60},{-28,26}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={135,135,135}),
        Rectangle(
          extent={{28,60},{78,26}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={135,135,135}),
        Rectangle(
          extent={{-60,26},{-44,8}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{44,26},{60,8}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}));
end DomesticHotWaterSystem;
