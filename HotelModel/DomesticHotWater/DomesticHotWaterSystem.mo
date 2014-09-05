within HotelModel.DomesticHotWater;
model DomesticHotWaterSystem
  Buildings.Fluid.Movers.FlowMachine_m_flow fan annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-150,130})));
  Buildings.Fluid.Sources.Boundary_pT bou(nPorts=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-150,170})));
  Buildings.Fluid.Sources.Boundary_pT bou1(nPorts=1) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={146,-72})));
  Buildings.Fluid.Sources.Boundary_pT bou2(nPorts=1) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,80})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-90,130})));
equation
  connect(fan.port_a, bou.ports[1]) annotation (Line(
      points={{-150,140},{-150,160}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-200,-200},{200,200}})));
end DomesticHotWaterSystem;
