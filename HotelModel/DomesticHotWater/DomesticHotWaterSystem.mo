within HotelModel.DomesticHotWater;
model DomesticHotWaterSystem
  replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal
    "Nominal mass flow rate";
    //Nominal flow rate is value I gave, probably different
   parameter Modelica.SIunits.Pressure dpDW_nominal
    "Nominal pressure difference";
    parameter Modelica.SIunits.Volume VTan "Volume of the tank";
    parameter Modelica.SIunits.Height hTan "Height of the tank";
    parameter Modelica.SIunits.Thickness dIns "Thickness of the insulation";
    parameter Modelica.SIunits.HeatFlowRate Q_flow_DWnominal
    "Nominal heat flow rate";

  Buildings.Fluid.Movers.FlowMachine_m_flow KitPum(redeclare package Medium =
        MediumDW, m_flow_nominal=mDW_flow_nominal,
    m_flow(fixed=false),
    addPowerToMedium=true) "Pump for the kitchen domestic cold water"
                                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,50})));
  Buildings.Fluid.Sources.Boundary_pT KitColWat(nPorts=1, redeclare package
      Medium = MediumDW) "Kitchen domestic cold water"
                                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-70,90})));
  Buildings.Fluid.Sources.Boundary_pT DomHotWat(nPorts=1, redeclare package
      Medium = MediumDW) "Domestic hot water"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,20})));
  Buildings.Fluid.Sources.MassFlowSource_T DomColWat(nPorts=1, use_m_flow_in=true,
    redeclare package Medium = MediumDW) "Domestic cold water "
                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,40})));
  Buildings.Fluid.Movers.FlowMachine_m_flow DomPum(redeclare package Medium =
        MediumDW, m_flow_nominal=mDW_flow_nominal) "Domestic hot water pump"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,20})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        MediumDW, m_flow_nominal=mDW_flow_nominal)
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Buildings.Fluid.Storage.StratifiedEnhanced tan(
    redeclare package Medium = MediumDW,
    m_flow_nominal=mDW_flow_nominal,
    VTan=VTan,
    hTan=hTan,
    dIns=dIns) "Hot water storage tank"          annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-30})));
  Buildings.Fluid.Boilers.BoilerPolynomial boi(
    redeclare package Medium = MediumDW,
    m_flow_nominal=mDW_flow_nominal,
    fue=Buildings.Fluid.Data.Fuels.NaturalGasLowerHeatingValue(),
    dp_nominal=dpDW_nominal,
    Q_flow_nominal=Q_flow_DWnominal) "Boiler for the domestic hot water system"
    annotation (Placement(transformation(extent={{-20,-90},{-40,-70}})));
  Buildings.Fluid.Movers.FlowMachine_m_flow pum(redeclare package Medium =
        MediumDW, m_flow_nominal=mDW_flow_nominal) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,-10})));
  Modelica.Blocks.Sources.Constant const1(k=0.21)
    annotation (Placement(transformation(extent={{-36,-16},{-24,-4}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumDW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        MediumDW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Control.CoolingWaterControl cooWatCon(TDomHotWatSet=288.15, kPCon=1)
                                        annotation (Placement(transformation(
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
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(
                                                    redeclare package Medium =
        MediumDW, m_flow_nominal=mDW_flow_nominal)
    annotation (Placement(transformation(extent={{-66,10},{-46,30}})));
  Modelica.Blocks.Interfaces.RealOutput Pum3_flow1
    annotation (Placement(transformation(extent={{100,46},{120,66}})));
equation
  connect(DomColWat.ports[1], senTem.port_a) annotation (Line(
      points={{-40,30},{-40,20},{-20,20}},
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
  connect(senTem.T, cooWatCon.Tem) annotation (Line(
      points={{-10,31},{-10,90},{-26,90},{-26,82}},
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
  connect(const1.y, pum.m_flow_in) annotation (Line(
      points={{-23.4,-10},{-8,-10},{-8,-9.8},{8,-9.8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(KitPum.port_a, tan.port_b) annotation (Line(
      points={{-70,40},{-70,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      arrow={Arrow.Filled,Arrow.None},
      thickness=1));
  connect(port_a1, tan.port_b) annotation (Line(
      points={{-100,0},{-70,0},{-70,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pum.port_a, senTem.port_b) annotation (Line(
      points={{20,0},{20,20},{0,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(KitPum.port_a, senTem1.port_a) annotation (Line(
      points={{-70,40},{-70,20},{-66,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
<<<<<<< HEAD
  connect(senTem1.port_b, senTem.port_a) annotation (Line(
      points={{-46,20},{-20,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(cooWatCon.Pum3_flow, Pum3_flow1) annotation (Line(
      points={{-38,59},{-38,56},{110,56}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(cooWatCon.CooWat_mas_flow, DomColWat.m_flow_in) annotation (Line(
      points={{-32,59},{-32,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(DomPum.port_a, senTem.port_b) annotation (Line(
      points={{50,20},{0,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
=======
<<<<<<< HEAD
  connect(val.port_a, pum.port_b) annotation (Line(
      points={{20,-40},{20,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(pum.port_a, senTem.port_b) annotation (Line(
      points={{20,0},{20,20},{0,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
=======
  connect(senTem1.port_b, senTem.port_a) annotation (Line(
      points={{-46,20},{-20,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(cooWatCon.Pum3_flow, Pum3_flow1) annotation (Line(
      points={{-38,59},{-38,56},{110,56}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(cooWatCon.CooWat_mas_flow, DomColWat.m_flow_in) annotation (Line(
      points={{-32,59},{-32,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(DomPum.port_a, senTem.port_b) annotation (Line(
      points={{50,20},{0,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
>>>>>>> 28ddfe9bf89f09511b58cb2305beefb8a58ad1a0
  connect(cooWatCon.DommasFlow, m_flow_in_dom) annotation (Line(
      points={{-32,82},{-32,92},{-50,92},{-50,70},{-120,70}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(cooWatCon.KitmasFlow, m_flow_in_kit) annotation (Line(
      points={{-38,82},{-38,86},{-54,86},{-54,64},{-88,64},{-88,30},{-120,30}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(pum.port_b, port_a2) annotation (Line(
      points={{20,-20},{20,-80},{0,-80},{0,-100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
<<<<<<< HEAD
=======
>>>>>>> 3865189e5634e33bda839ef44016725b7e587bbd
>>>>>>> 28ddfe9bf89f09511b58cb2305beefb8a58ad1a0
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-94,8},{-58,-8}},
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
          pattern=LinePattern.None),
        Rectangle(
          extent={{-44,8},{44,-8}},
          lineColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255})}));
end DomesticHotWaterSystem;
