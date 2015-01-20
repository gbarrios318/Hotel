within HotelModel.HotelSection.Control;
model Hex2ControlGroup2
  extends Modelica.Blocks.Interfaces.BlockIcon;

       parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal
    "Nominal mass flow rate";
      parameter Modelica.SIunits.Pressure dpDW_nominal
    "Nominal pressure difference";
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=5)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[1,0,0,1,0,1; 2,1,0,1,
        1,1; 3,1,0,1,1,1; 4,0,0,1,0,1; 5,0,1,0,1,1; 6,0,1,0,1,1; 7,0,0,1,0,1])
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.IntegerInput sta
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput MV1
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput MV2
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput MV3
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput MV4
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Modelica.Blocks.Interfaces.RealOutput pum3_switch
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
equation
  connect(integerToReal.y, replicator.u) annotation (Line(
      points={{-59,0},{-52,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sta, integerToReal.u) annotation (Line(
      points={{-120,0},{-82,0}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(replicator.y, combiTable1D.u) annotation (Line(
      points={{-29,0},{-12,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(combiTable1D.y[1], MV1) annotation (Line(
      points={{11,-0.8},{20,-0.8},{20,80},{110,80}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(combiTable1D.y[2], MV2) annotation (Line(
      points={{11,-0.4},{20,-0.4},{20,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(combiTable1D.y[3], MV3) annotation (Line(
      points={{11,0},{60,0},{60,20},{110,20}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(combiTable1D.y[4], MV4) annotation (Line(
      points={{11,0.4},{20,0.4},{20,0},{80,0},{80,-10},{110,-10}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(MV1, MV1) annotation (Line(
      points={{110,80},{110,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MV2, MV2) annotation (Line(
      points={{110,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pum3_switch, integerToReal.y) annotation (Line(
      points={{110,-40},{-59,-40},{-59,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (defaultComponentName="Hex2ConGro2", Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Hex2ControlGroup2;
