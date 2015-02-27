within HotelModel.RainWaterCollectionSystem;
model RainWaterCollectionTankModel
  "Collection Tank System components not including control sequence"

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
parameter Modelica.SIunits.MassFlowRate m_CitWatflow_nominal
    "Nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate m_valveflow_nominal
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dpValve_nominal
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint";
  parameter Real SSFilIn "Constant output value";
  parameter Real UVFilIn "Constant output value";
 parameter Modelica.SIunits.Volume ColTanVol "Volume";
  parameter Modelica.SIunits.Pressure dp_OFnominal
    "Pressure drop at nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate m_OFflow_nominal
    "Nominal mass flow rate";
  parameter Real area "Constant output value";
  parameter Modelica.SIunits.Volume StoTanVol "Volume";
  CollectionSystem.CollectionTankModel ColTan(redeclare package MediumRainWater
      = MediumRainWater, area=area)           annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-70,30})));
  StorageSystem.StorageSystemModel StoSys(
    redeclare package MediumRainWater = MediumRainWater,
    m_RWflow_nominal=m_RWflow_nominal,
    dpRW_nominal=dpRW_nominal,
    dp_OFnominal=dp_OFnominal,
    ColTanVol=ColTanVol,
    m_OFflow_nominal=m_OFflow_nominal)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  ProcessingSystem.ProcessingSystemModel ProSys(
    redeclare package MediumRainWater = MediumRainWater,
    redeclare package MediumCityWater = MediumCityWater,
    m_RWflow_nominal=m_RWflow_nominal,
    dpSSFil_nominal=dpSSFil_nominal,
    dpUVFil_nominal=dpUVFil_nominal,
    dpRW_nominal=dpRW_nominal,
    m_CitWatflow_nominal=m_CitWatflow_nominal,
    m_valveflow_nominal=m_valveflow_nominal,
    dpValve_nominal=dpValve_nominal,
    SSFilIn=SSFilIn,
    UVFilIn=UVFilIn)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  UsageSystem.UsageSystemModel UseSys(
    redeclare package MediumRainWater = MediumRainWater,
    m_RWflow_nominal=m_RWflow_nominal + m_CitWatflow_nominal,
    dpRW_nominal=dpRW_nominal,
    StoTanVol=StoTanVol)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a CitWat1(redeclare package Medium =
        MediumCityWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus1
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Control.RainWaterControls rainWaterControls(ColTanVol=ColTanVol)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Fluid.Interfaces.FluidPort_b CooTow(redeclare package Medium =
        MediumRainWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(ColTan.ports1[1], StoSys.port_a1) annotation (Line(
      points={{-70,20.2},{-70,0},{-60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(StoSys.port_b1, ProSys.port_a1) annotation (Line(
      points={{-40,0},{30,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ProSys.port_1, UseSys.port_a1) annotation (Line(
      points={{50,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ProSys.CitWat, CitWat1) annotation (Line(
      points={{40,9.8},{40,60},{0,60},{0,100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(ColTan.weaBus, weaBus1) annotation (Line(
      points={{-70,40},{-70,60},{-86,60},{-86,0},{-100,0}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None,
      pattern=LinePattern.Dash),
                           Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(StoSys.VolOut1, rainWaterControls.FluidVol) annotation (Line(
      points={{-39,6},{-30,6},{-30,30},{-22,30}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(ProSys.ValE, rainWaterControls.ValCon) annotation (Line(
      points={{28,6},{14,6},{14,30},{1,30}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(ProSys.ValByP, rainWaterControls.ValCon) annotation (Line(
      points={{28,-6},{14,-6},{14,30},{1,30}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(UseSys.port_b1, CooTow) annotation (Line(
      points={{80,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics), Icon(coordinateSystem(extent={{-100,
            -100},{100,100}}, preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-60,-40},{60,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,70},{60,-50}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,6},{94,-6}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-60,80},{60,60}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-60,40},{60,-50}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-60,-40},{60,-60}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,30},{60,50}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-24},{60,-50}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-60,70},{-60,-50}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{60,70},{60,-50}},
          color={0,0,0},
          smooth=Smooth.None),
        Rectangle(
          extent={{-6,92},{6,70}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Text(
          extent={{-60,40},{58,-60}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          textString="RWC")}));
end RainWaterCollectionTankModel;
