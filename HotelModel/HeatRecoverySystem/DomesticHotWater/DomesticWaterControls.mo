within HotelModel.HeatRecoverySystem.DomesticHotWater;
model DomesticWaterControls "Domestic water with controls"
  replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal
    "Nominal mass flow rate";
       parameter Modelica.SIunits.Pressure dpDW_nominal
    "Nominal pressure difference";
    parameter Modelica.SIunits.Volume VTan "Volume of the tank";
    parameter Modelica.SIunits.Height hTan "Height of the tank";
    parameter Modelica.SIunits.Thickness dIns "Thickness of the insulation";
    parameter Modelica.SIunits.HeatFlowRate Q_flow_DWnominal
    "Nominal heat flow rate";
    parameter Modelica.SIunits.MassFlowRate MassFloDomIn
    "Mass flow rate of water going into domestic water usage";
    parameter Modelica.SIunits.MassFlowRate MassFloKitIn
    "Mass flow rate of water going to kitchen";
    parameter Modelica.SIunits.Temp_K TBoiSetIn "Boiler setting";

  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        MediumDW)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Sources.Constant TBoiSet(k=TBoiSetIn)
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=60)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Interfaces.RealOutput TBoi1 "Boiler temperature" annotation (
      Placement(transformation(extent={{100,-50},{120,-30}}),
        iconTransformation(extent={{100,-50},{120,-30}})));
  DomesticHotWaterSystem domesticHotWaterSystem(
    redeclare package MediumDW = MediumDW,
    mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=dpDW_nominal,
    VTan=VTan,
    hTan=hTan,
    dIns=dIns,
    Q_flow_DWnominal=Q_flow_DWnominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput Pum3_flow
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_in_kit
    "Prescribed mass flow rate for kitchen pump"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_in_dom
    "Prescribed mass flow rate for domestic water pump"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b KitWat1(redeclare package Medium =
        MediumDW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b DomHotWat1(redeclare package Medium =
        MediumDW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumDW)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  connect(TBoiSet.y, conPID.u_s) annotation (Line(
      points={{-69,-30},{-62,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(domesticHotWaterSystem.port_a2, port_a2) annotation (Line(
      points={{0,-10},{0,-100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticHotWaterSystem.TBoi, TBoi1) annotation (Line(
      points={{11,-4},{20,-4},{20,-40},{110,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticHotWaterSystem.TBoi, conPID.u_m) annotation (Line(
      points={{11,-4},{20,-4},{20,-58},{-50,-58},{-50,-42}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPID.y, domesticHotWaterSystem.TBoiSet) annotation (Line(
      points={{-39,-30},{-20,-30},{-20,-4},{-12,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticHotWaterSystem.Pum3_flow1, Pum3_flow) annotation (Line(
      points={{11,5.6},{36,5.6},{36,6},{60,6},{60,40},{110,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticHotWaterSystem.m_flow_in_kit, m_flow_in_kit) annotation (Line(
      points={{-12,3},{-60,3},{-60,40},{-120,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticHotWaterSystem.m_flow_in_dom, m_flow_in_dom) annotation (Line(
      points={{-12,7},{-40,7},{-40,80},{-120,80}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticHotWaterSystem.KitWat, KitWat1) annotation (Line(
      points={{-7,10},{-7,40},{0,40},{0,100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticHotWaterSystem.DomHotWat, DomHotWat1) annotation (Line(
      points={{10,2},{40,2},{40,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(DomHotWat1, DomHotWat1) annotation (Line(
      points={{100,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(domesticHotWaterSystem.port_b1, port_b1) annotation (Line(
      points={{-10,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
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
          origin={0,-78},
          rotation=90),
        Ellipse(
          extent={{-60,58},{60,-62}},
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
end DomesticWaterControls;
