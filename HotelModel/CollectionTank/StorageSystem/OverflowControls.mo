within HotelModel.CollectionTank.StorageSystem;
model OverflowControls "Overflow Controls"
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Interfaces.RealInput MassOut
    "Mass flow rate of water going out of storage tank"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput MassIn
    "mass flow rate of water going into the tank"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.Continuous.LimPID conPID(
    reverseAction=true,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=60) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Sources.Constant MflowSet(k=0) "Mass flow set"
    annotation (Placement(transformation(extent={{-38,50},{-18,70}})));
  Modelica.Blocks.Interfaces.RealOutput ValCon
    "Connector of actuator output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(gain.u, MassOut) annotation (Line(
      points={{-82,30},{-92,30},{-92,40},{-120,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, add.u1) annotation (Line(
      points={{-59,30},{-52,30},{-52,6},{-42,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.u2, MassIn) annotation (Line(
      points={{-42,-6},{-72,-6},{-72,-40},{-120,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, conPID.u_m) annotation (Line(
      points={{-19,0},{30,0},{30,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.u_s, MflowSet.y) annotation (Line(
      points={{18,30},{0,30},{0,60},{-17,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.y, ValCon) annotation (Line(
      points={{41,30},{50,30},{50,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end OverflowControls;
