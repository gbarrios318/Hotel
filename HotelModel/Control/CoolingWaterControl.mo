within HotelModel.Control;
model CoolingWaterControl
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Modelica.SIunits.Temperature TDomHotWatSet
    "Set temperature for domestic hot water";
  parameter Real kPCon "Gain of controler for P control";
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{36,-10},{56,10}})));
  Modelica.Blocks.Sources.Constant const(k=TDomHotWatSet)
    annotation (Placement(transformation(extent={{-74,52},{-54,72}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput masFlow
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput Tem
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    reverseAction=true,
    k=kPCon) annotation (Placement(transformation(extent={{-32,52},{-12,72}})));
equation
  connect(product1.u2, masFlow) annotation (Line(
      points={{34,-6},{0,-6},{0,-40},{-120,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.u_s, const.y) annotation (Line(
      points={{-34,62},{-53,62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.y, product1.u1) annotation (Line(
      points={{-11,62},{0,62},{0,6},{34,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product1.y, y) annotation (Line(
      points={{57,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.u_m, Tem) annotation (Line(
      points={{-22,50},{-22,40},{-120,40}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (defaultComponentName="cooWatCon", Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end CoolingWaterControl;
