within HotelModel.Control;
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
    yMax=1)  annotation (Placement(transformation(extent={{-32,70},{-12,90}})));
  Modelica.Blocks.Interfaces.RealOutput CooWat_mas_flow
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput KitmasFlow
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{4,-4},{24,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=if DommasFlow > 0
         then Tem else TDomHotWatSet)
    annotation (Placement(transformation(extent={{-74,24},{-54,44}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-52,-32},{-32,-12}})));
  Modelica.Blocks.Sources.Constant const1(k=0.21)
    annotation (Placement(transformation(extent={{-96,-44},{-76,-24}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=if DommasFlow > 0
         then 1 else 0)
    annotation (Placement(transformation(extent={{-74,42},{-54,62}})));
equation
  connect(conPID.u_s, const.y) annotation (Line(
      points={{-34,80},{-53,80}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(KitmasFlow, product1.u3) annotation (Line(
      points={{-120,-60},{-20,-60},{-20,-68},{38,-68}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(conPID.y, product.u1) annotation (Line(
      points={{-11,80},{-6,80},{-6,12},{2,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(product1.u1, product.y) annotation (Line(
      points={{38,-52},{28,-52},{28,6},{25,6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(CooWat_mas_flow, product.y) annotation (Line(
      points={{110,0},{48,0},{48,6},{25,6}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(product1.y, Pum3_flow) annotation (Line(
      points={{61,-60},{110,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression.y, conPID.u_m) annotation (Line(
      points={{-53,34},{-22,34},{-22,68}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(add.u1, DommasFlow) annotation (Line(
      points={{-54,-16},{-74,-16},{-74,0},{-120,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const1.y, add.u2) annotation (Line(
      points={{-75,-34},{-68,-34},{-68,-28},{-54,-28}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(add.y, product.u2) annotation (Line(
      points={{-31,-22},{-6,-22},{-6,0},{2,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(product1.u2, DommasFlow) annotation (Line(
      points={{38,-60},{0,-60},{0,-56},{-62,-56},{-62,-16},{-74,-16},{-74,0},{
          -120,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(realExpression1.y, conPID.On) annotation (Line(
      points={{-53,52},{-40,52},{-40,88},{-34,88}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (defaultComponentName="cooWatCon", Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end CoolingWaterControl;
