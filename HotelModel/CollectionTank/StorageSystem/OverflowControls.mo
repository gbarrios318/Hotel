within HotelModel.CollectionTank.StorageSystem;
model OverflowControls "Overflow Controls"
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Interfaces.RealInput MassIn
    "mass flow rate of water going into the tank"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.Continuous.LimPID conPID(
    reverseAction=true,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=60) annotation (Placement(transformation(extent={{10,10},{30,30}})));
  Modelica.Blocks.Sources.Constant MflowSet(k=0) "Mass flow set"
    annotation (Placement(transformation(extent={{-38,50},{-18,70}})));
  Modelica.Blocks.Interfaces.RealOutput ValCon
    "Connector of actuator output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput MassOut
    "Connector of Real input signal 1"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
equation
  connect(add.u2, MassIn) annotation (Line(
      points={{-42,-6},{-60,-6},{-60,-40},{-120,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(add.y, conPID.u_m) annotation (Line(
      points={{-19,0},{20,0},{20,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPID.u_s, MflowSet.y) annotation (Line(
      points={{8,20},{0,20},{0,60},{-17,60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPID.y, ValCon) annotation (Line(
      points={{31,20},{40,20},{40,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(add.u1, MassOut) annotation (Line(
      points={{-42,6},{-60,6},{-60,40},{-120,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end OverflowControls;
