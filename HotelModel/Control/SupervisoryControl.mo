within HotelModel.Control;
model SupervisoryControl
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Modelica.SIunits.Temperature TBoi1Set
    "Working temperature for boiler1";
  parameter Modelica.SIunits.Temperature TBoi2Set
    "Working temperature for boiler2";
  parameter Modelica.SIunits.Temperature T1Set
    "Temperature set between stage 3 an 4";
  parameter Modelica.SIunits.Temperature T2Set
    "Temperature set between stage 4 an 5";
  parameter Modelica.SIunits.Temperature T3Set
    "Temperature set between stage 5 an 6";
  parameter Modelica.SIunits.Temperature dT=1
    "Temperature difference to switch Hex-2 off, between stage 6 and 7";
  parameter Modelica.SIunits.Temperature deaBan=1
    "Dead band of temperature to prevent stage short cycling";
  parameter Modelica.SIunits.MassFlowRate masFloSet
    "Hot water mass flow greater than this set value, Hex-2 will turn on";
  parameter Modelica.SIunits.Time timDel=10 "Time delay for changing stage";
  Modelica.Blocks.Interfaces.RealInput THeatPump annotation (Placement(
        transformation(extent={{-140,40},{-100,80}}), iconTransformation(extent=
           {{-140,40},{-100,80}})));
  Modelica_StateGraph2.Step step1(
    nOut=1,
    nIn=1,
    use_activePort=true)
    annotation (Placement(transformation(extent={{-4,116},{4,124}})));
  Modelica_StateGraph2.Step step2(
    use_activePort=true,
    nOut=2,
    nIn=2) annotation (Placement(transformation(extent={{-4,76},{4,84}})));
  Modelica_StateGraph2.Step step3(
    nOut=2,
    nIn=2,
    use_activePort=true)
    annotation (Placement(transformation(extent={{-4,36},{4,44}})));
  Modelica_StateGraph2.Step step4(
    use_activePort=true,
    nOut=2,
    nIn=2) annotation (Placement(transformation(extent={{-4,-4},{4,4}})));
  Modelica_StateGraph2.Step step5(
    use_activePort=true,
    initialStep=true,
    nOut=2,
    nIn=2) annotation (Placement(transformation(extent={{-4,-46},{4,-38}})));
  Modelica_StateGraph2.Step step6(
    use_activePort=true,
    nOut=2,
    nIn=2) annotation (Placement(transformation(extent={{-4,-84},{4,-76}})));
  Modelica_StateGraph2.Step step7(
    use_activePort=true,
    nIn=1,
    nOut=1) annotation (Placement(transformation(extent={{-4,-124},{4,-116}})));
  Modelica_StateGraph2.Blocks.MathInteger.MultiSwitch multiSwitch1(nu=7, expr={
        1,2,3,4,5,6,7})
    annotation (Placement(transformation(extent={{50,-10},{90,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput y annotation (Placement(
        transformation(extent={{100,-10},{120,10}}), iconTransformation(extent=
            {{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput TBoiHP
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput TBoiDW annotation (Placement(
        transformation(extent={{-140,-40},{-100,0}}), iconTransformation(extent=
           {{-140,-40},{-100,0}})));
  Modelica_StateGraph2.Transition T1(
    delayedTransition=true,
    waitTime=timDel,
    condition=TBoiHP > (TBoi1Set - 0.001))
    annotation (Placement(transformation(extent={{-24,96},{-16,104}})));
  Modelica_StateGraph2.Transition T2(
    delayedTransition=true,
    waitTime=timDel,
    condition=THeatPump > (TBoi2Set + deaBan))
    annotation (Placement(transformation(extent={{-24,56},{-16,64}})));
  Modelica_StateGraph2.Transition T3(
    delayedTransition=true,
    waitTime=timDel,
    condition=THeatPump > T1Set + deaBan)
    annotation (Placement(transformation(extent={{-24,16},{-16,24}})));
  Modelica_StateGraph2.Transition T4(
    delayedTransition=true,
    waitTime=timDel,
    condition=THeatPump > T2Set + deaBan)
    annotation (Placement(transformation(extent={{-24,-24},{-16,-16}})));
  Modelica_StateGraph2.Transition T5(
    delayedTransition=true,
    waitTime=timDel,
    condition=TBoiDW > T3Set + deaBan)
    annotation (Placement(transformation(extent={{-24,-64},{-16,-56}})));
  Modelica_StateGraph2.Transition T6(
    use_conditionPort=false,
    delayedTransition=true,
    waitTime=timDel,
    condition=THeatPump - TBoiDW < dT)
    annotation (Placement(transformation(extent={{-24,-104},{-16,-96}})));
  Modelica_StateGraph2.Transition T7(
    delayedTransition=true,
    waitTime=timDel,
    condition=TBoiHP < (TBoi1Set - deaBan))
                                           annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={20,100})));
  Modelica_StateGraph2.Transition T8(
    delayedTransition=true,
    waitTime=timDel,
    condition=THeatPump < (TBoi2Set - deaBan) or TBoiHP < (TBoi1Set - deaBan))
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={20,60})));
  Modelica_StateGraph2.Transition T9(
    delayedTransition=true,
    waitTime=timDel,
    condition=THeatPump < T1Set - deaBan)
                                     annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={20,20})));
  Modelica_StateGraph2.Transition T10(
    delayedTransition=true,
    waitTime=timDel,
    condition=THeatPump < T2Set - deaBan)
                                     annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={20,-20})));
  Modelica_StateGraph2.Transition T11(
    delayedTransition=true,
    waitTime=timDel,
    condition=TBoiDW < T3Set - deaBan)
                                     annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={20,-60})));
  Modelica_StateGraph2.Transition T12(
    delayedTransition=true,
    condition=masFloHotWat > masFloSet,
    waitTime=timDel) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={20,-100})));
  Modelica.Blocks.Interfaces.RealInput masFloHotWat annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(
          extent={{-140,-80},{-100,-40}})));
equation
  connect(multiSwitch1.y, y) annotation (Line(
      points={{91,0},{110,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(step1.activePort, multiSwitch1.u[1]) annotation (Line(
      points={{4.72,120},{44,120},{44,2},{50,2},{50,2.57143}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(multiSwitch1.u[2], step2.activePort) annotation (Line(
      points={{50,1.71429},{42,1.71429},{42,80},{4.72,80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(multiSwitch1.u[3], step3.activePort) annotation (Line(
      points={{50,0.857143},{40,0.857143},{40,40},{4.72,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(multiSwitch1.u[4], step4.activePort) annotation (Line(
      points={{50,-1.11022e-016},{26.72,-1.11022e-016},{26.72,0},{4.72,0}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(multiSwitch1.u[5], step5.activePort) annotation (Line(
      points={{50,-0.857143},{40,-0.857143},{40,-42},{4.72,-42}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(multiSwitch1.u[6], step6.activePort) annotation (Line(
      points={{50,-1.71429},{42,-1.71429},{42,-80},{4.72,-80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(multiSwitch1.u[7], step7.activePort) annotation (Line(
      points={{50,-2.57143},{44,-2.57143},{44,-120},{4.72,-120}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(step1.outPort[1], T1.inPort) annotation (Line(
      points={{0,115.4},{0,110},{-20,110},{-20,104}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(step2.outPort[1], T2.inPort) annotation (Line(
      points={{-1,75.4},{-1,72},{-20,72},{-20,64}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(step3.outPort[1], T3.inPort) annotation (Line(
      points={{-1,35.4},{-1,32},{-20,32},{-20,24}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(step4.outPort[1], T4.inPort) annotation (Line(
      points={{-1,-4.6},{-1,-8},{-20,-8},{-20,-16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(step5.outPort[1], T5.inPort) annotation (Line(
      points={{-1,-46.6},{-1,-50},{-20,-50},{-20,-56}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(step6.outPort[1], T6.inPort) annotation (Line(
      points={{-1,-84.6},{-1,-88},{-20,-88},{-20,-96}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T1.outPort, step2.inPort[1]) annotation (Line(
      points={{-20,95},{-20,88},{-1,88},{-1,84}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T2.outPort, step3.inPort[1]) annotation (Line(
      points={{-20,55},{-20,48},{-1,48},{-1,44}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T3.outPort, step4.inPort[1]) annotation (Line(
      points={{-20,15},{-20,8},{-1,8},{-1,4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T4.outPort, step5.inPort[1]) annotation (Line(
      points={{-20,-25},{-20,-34},{-1,-34},{-1,-38}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T5.outPort, step6.inPort[1]) annotation (Line(
      points={{-20,-65},{-20,-72},{-1,-72},{-1,-76}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T6.outPort, step7.inPort[1]) annotation (Line(
      points={{-20,-105},{-20,-112},{0,-112},{0,-116}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(step7.outPort[1], T12.inPort) annotation (Line(
      points={{0,-124.6},{0,-128},{20,-128},{20,-104}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T12.outPort, step6.inPort[2]) annotation (Line(
      points={{20,-95},{20,-72},{1,-72},{1,-76}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T11.inPort, step6.outPort[2]) annotation (Line(
      points={{20,-64},{20,-68},{30,-68},{30,-88},{1,-88},{1,-84.6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T11.outPort, step5.inPort[2]) annotation (Line(
      points={{20,-55},{20,-34},{1,-34},{1,-38}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T7.outPort, step1.inPort[1]) annotation (Line(
      points={{20,105},{20,132},{0,132},{0,124}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T10.inPort, step5.outPort[2]) annotation (Line(
      points={{20,-24},{20,-28},{30,-28},{30,-50},{1,-50},{1,-46.6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T9.inPort, step4.outPort[2]) annotation (Line(
      points={{20,16},{20,14},{30,14},{30,-8},{1,-8},{1,-4.6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T10.outPort, step4.inPort[2]) annotation (Line(
      points={{20,-15},{20,8},{1,8},{1,4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T9.outPort, step3.inPort[2]) annotation (Line(
      points={{20,25},{20,48},{1,48},{1,44}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T8.inPort, step3.outPort[2]) annotation (Line(
      points={{20,56},{20,52},{30,52},{30,32},{1,32},{1,35.4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T8.outPort, step2.inPort[2]) annotation (Line(
      points={{20,65},{20,88},{1,88},{1,84}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T7.inPort, step2.outPort[2]) annotation (Line(
      points={{20,96},{20,90},{30,90},{30,72},{1,72},{1,75.4}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (
    defaultComponentName="supCon",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-150},{
            100,150}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end SupervisoryControl;
