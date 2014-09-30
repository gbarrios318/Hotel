within HotelModel.Control;
model Hex2ControlGroup2
  extends Modelica.Blocks.Interfaces.BlockIcon;

       parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal
    "Nominal mass flow rate";
      parameter Modelica.SIunits.Pressure dpDW_nominal
    "Nominal pressure difference";
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-80,64},{-60,84}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=5)
    annotation (Placement(transformation(extent={{-50,64},{-30,84}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1,0,0,1,0,1; 2,1,0,1,
        1,1; 3,1,0,1,1,1; 4,0,0,1,0,1; 5,0,1,0,1,1; 6,0,1,0,1,1; 7,0,0,1,0,1])
    annotation (Placement(transformation(extent={{-10,64},{10,84}})));
  Modelica.Blocks.Interfaces.IntegerInput sta
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput MV1
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Sources.Constant const(k=mDW_flow_nominal)
    annotation (Placement(transformation(extent={{-36,-36},{-16,-16}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{44,-30},{64,-10}})));
  Modelica.Blocks.Interfaces.RealOutput MV2
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput MV3
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput MV4
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Modelica.Blocks.Interfaces.RealOutput pum3
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput valByp
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{44,-64},{64,-44}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-36,-70},{-16,-50}})));
equation
  connect(integerToReal.y, replicator.u) annotation (Line(
      points={{-59,74},{-52,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sta, integerToReal.u) annotation (Line(
      points={{-120,0},{-92,0},{-92,74},{-82,74}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(replicator.y, combiTable1D.u) annotation (Line(
      points={{-29,74},{-12,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, product1.u2) annotation (Line(
      points={{-15,-26},{42,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product1.y, pum3) annotation (Line(
      points={{65,-20},{92,-20},{92,-40},{110,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[1], MV1) annotation (Line(
      points={{11,73.2},{20,73.2},{20,80},{110,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[2], MV2) annotation (Line(
      points={{11,73.6},{20,73.6},{20,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[3], MV3) annotation (Line(
      points={{11,74},{20,74},{20,20},{110,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[4], MV4) annotation (Line(
      points={{11,74.4},{20,74.4},{20,0},{80,0},{80,-10},{110,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[5], product1.u1) annotation (Line(
      points={{11,74.8},{20,74.8},{20,-14},{42,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(valByp, add.y) annotation (Line(
      points={{110,-70},{88,-70},{88,-54},{65,-54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.u2, const1.y) annotation (Line(
      points={{42,-60},{-15,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1D.y[5], add.u1) annotation (Line(
      points={{11,74.8},{20,74.8},{20,-48},{42,-48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MV1, MV1) annotation (Line(
      points={{110,80},{110,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MV2, MV2) annotation (Line(
      points={{110,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (defaultComponentName="Hex2ConGro2", Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Hex2ControlGroup2;
