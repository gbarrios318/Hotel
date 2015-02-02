within HotelModel.HeatRecoverySystem.Control;
model CoolingWaterControl
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Modelica.SIunits.Temperature TDomHotWatSet
    "Set temperature for domestic hot water";
  parameter Real kPCon "Gain of controler for P control";
  Modelica.Blocks.Math.Add3    product1(k1=-1, k3=+1)
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Modelica.Blocks.Sources.Constant const(k=TDomHotWatSet)
    annotation (Placement(transformation(extent={{-74,70},{-54,90}})));
  Modelica.Blocks.Interfaces.RealOutput Pum3_flow
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealInput DommasFlow
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Tem
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  LimPID                               conPID(
    reverseAction=true,
    k=kPCon,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=60,
    yMax=1)  annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Modelica.Blocks.Interfaces.RealOutput CooWat_mas_flow
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput KitmasFlow
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=if DommasFlow > 0
         then Tem else TDomHotWatSet)
    annotation (Placement(transformation(extent={{-74,24},{-54,44}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-50,-16},{-30,4}})));
  Modelica.Blocks.Sources.Constant const1(k=0.21)
    annotation (Placement(transformation(extent={{-92,-40},{-72,-20}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=if DommasFlow > 0
         then 1 else 0)
    annotation (Placement(transformation(extent={{-74,42},{-54,62}})));
equation
  connect(conPID.u_s, const.y) annotation (Line(
      points={{-32,80},{-53,80}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(KitmasFlow, product1.u3) annotation (Line(
      points={{-120,-60},{-80,-60},{-80,-68},{38,-68}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPID.y, product.u1) annotation (Line(
      points={{-9,80},{-6,80},{-6,6},{-2,6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(product1.u1, product.y) annotation (Line(
      points={{38,-52},{28,-52},{28,0},{21,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(CooWat_mas_flow, product.y) annotation (Line(
      points={{110,0},{21,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(product1.y, Pum3_flow) annotation (Line(
      points={{61,-60},{110,-60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(realExpression.y, conPID.u_m) annotation (Line(
      points={{-53,34},{-20,34},{-20,68}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(add.u1, DommasFlow) annotation (Line(
      points={{-52,0},{-120,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(const1.y, add.u2) annotation (Line(
      points={{-71,-30},{-68,-30},{-68,-12},{-52,-12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(add.y, product.u2) annotation (Line(
      points={{-29,-6},{-2,-6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(product1.u2, DommasFlow) annotation (Line(
      points={{38,-60},{-60,-60},{-60,0},{-72,0},{-72,0},{-120,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(realExpression1.y, conPID.On) annotation (Line(
      points={{-53,52},{-40,52},{-40,88},{-32,88}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (defaultComponentName="cooWatCon", Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end CoolingWaterControl;
