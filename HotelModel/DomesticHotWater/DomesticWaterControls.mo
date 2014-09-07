within HotelModel.DomesticHotWater;
model DomesticWaterControls "Domestic water with controls"
  DomesticHotWaterSystem domesticHotWaterSystem
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Sources.Constant TBoiSet(k=273.15 + 60)
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Buildings.Controls.Continuous.LimPID conPID
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Constant MassFloDom(k=20)
    "Mass flow going to domestic water"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Constant MassFloKit(k=5)
    "Mass flow of water going to the kitchen"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Interfaces.RealOutput TBoi1 "Boiler temperature"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
equation
  connect(domesticHotWaterSystem.port_a1, port_a1) annotation (Line(
      points={{-10,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticHotWaterSystem.port_a3, port_a2) annotation (Line(
      points={{10,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticHotWaterSystem.port_a2, port_a3) annotation (Line(
      points={{0,-10},{0,-100}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(TBoiSet.y, conPID.u_s) annotation (Line(
      points={{-69,-30},{-62,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(domesticHotWaterSystem.TBoi, conPID.u_m) annotation (Line(
      points={{11,-4},{20,-4},{20,-60},{-50,-60},{-50,-42}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPID.y, domesticHotWaterSystem.BoiOnOff) annotation (Line(
      points={{-39,-30},{-30,-30},{-30,-4},{-12,-4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(MassFloDom.y, domesticHotWaterSystem.m_flow_in_dom) annotation (Line(
      points={{-59,70},{-36,70},{-36,7},{-12,7}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(MassFloKit.y, domesticHotWaterSystem.m_flow_in_kit) annotation (Line(
      points={{-59,30},{-52,30},{-52,3},{-12,3}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticHotWaterSystem.TBoi, TBoi1) annotation (Line(
      points={{11,-4},{60,-4},{60,-60},{110,-60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end DomesticWaterControls;
