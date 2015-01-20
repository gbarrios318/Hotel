within HotelModel.HotelSection;
model HotelModel_annual
     extends Modelica.Icons.Example;
     replaceable package MediumCW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mCW_flow_nominal=44.16
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=1000
    "Nominal pressure difference";
       replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal=12.62
    "Nominal mass flow rate";
      //The nominal flow rate of water for domestic flow rate is one I gave it
      //Need to look up actual values
   parameter Modelica.SIunits.Pressure dpDW_nominal=1000
    "Nominal pressure difference";
  replaceable package MediumHW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mHW_flow_nominal=44.16
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dpHW_nominal=1000
    "Nominal pressure difference";
  .HotelModel.CoolingTowerSection.CoolingTowerSystem coolingTowerSystem(
    redeclare package MediumCW = MediumCW,
    P_nominal=2200,
    Motor_eta={0.85},
    Hydra_eta={1},
    GaiPi=1,
    mCW_flow_nominal=mCW_flow_nominal,
    v_flow_rate={0,0.1,0.3,0.6,1},
    eta={0,0.1^3,0.3^3,0.6^3,1},
    tIntPi=60,
    dTCW_nominal(displayUnit="degC") = 5.56,
    dTApp_nominal(displayUnit="degC") = 3.89,
    TWetBul_nominal=273.15 + 25.55,
    TSet=273.15 + 29.44,
    dP_nominal=29800,
    coolingTower(val(riseTime=60))) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,26})));
  .HotelModel.HeatPumpSection.HeatPump heatPump(
    redeclare package MediumDW = MediumDW,
    HeatPumpVol=25.99029318,
    dpDW_nominal=dpDW_nominal,
    redeclare package MediumHW = MediumHW,
    mHW_flow_nominal=mHW_flow_nominal,
    dpHW_nominal=dpDW_nominal,
    mDW_flow_nominal=mHW_flow_nominal,
    Q_flow_nominal=1024283.3902519,
    HeaPum(HeaPum(HeaPumTan(T_start=273.15 + 20))),
    HexVal(Hex(
        hexval1(riseTime=60),
        hexval2(riseTime=60),
        valbyp(riseTime=60))),
    HeaPumTRef=273.15 + 22.22,
    TSetBoiIn=273.15 + 16.11)
    annotation (Placement(transformation(extent={{12,18},{32,-2}})));
  .HotelModel.ConnectingPackage.ConnectingLoop connectingLoop(
    redeclare package MediumDW = MediumDW,
    dpDW_nominal=dpDW_nominal,
    mDW_flow_nominal=mDW_flow_nominal,
    pum(filteredSpeed=false),
    pum1(filteredSpeed=false))
    annotation (Placement(transformation(extent={{80,-24},{100,-4}})));
  .HotelModel.DomesticHotWater.DomesticWaterControls domesticWaterControls(
    redeclare package MediumDW = MediumDW,
    VTan=3,
    hTan=3,
    MassFloKitIn=0.03,
    dIns=0.05,
    mDW_flow_nominal=mDW_flow_nominal,
    domesticHotWaterSystem(cooWatCon(
        kPCon=0.1,
        TDomHotWatSet=316.15,
        conPID(yMax=1))),
    dpDW_nominal=dpDW_nominal,
    TBoiSetIn=273.15 + 60,
    MassFloDomIn=8,
    Q_flow_DWnominal=350000)
    annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
  .HotelModel.Control.SupervisoryControl supCon(
    TBoi1Set=273.15 + 60,
    TBoi2Set=273.15 + 16.11,
    T1Set=273.15 + 18.33,
    T2Set=273.15 + 25,
    T3Set=273.15 + 28.88,
    dT(displayUnit="K") = 0.56,
    masFloSet=0.25,
    timDel=600,
    step5(initialStep=true),
    step7(initialStep=false),
    deaBan(displayUnit="K") = 1.12)
    annotation (Placement(transformation(extent={{-160,62},{-140,82}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{160,60},{180,80}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = MediumCW,
    redeclare package Medium2 = MediumHW,
    m1_flow_nominal=mCW_flow_nominal,
    dp1_nominal=dp_nominal,
    dp2_nominal=dpHW_nominal,
    m2_flow_nominal=mHW_flow_nominal)                      annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,10})));
  Buildings.Fluid.Storage.ExpansionVessel exp3(
    redeclare package Medium = MediumCW,
    V_start=1)
              annotation (Placement(transformation(extent={{-24,-18},{-16,-10}})));
  Buildings.Fluid.Storage.ExpansionVessel exp1(
    redeclare package Medium = MediumCW,
    V_start=1)
              annotation (Placement(transformation(extent={{56,-18},{64,-10}})));
  Buildings.Fluid.Storage.ExpansionVessel exp4(
    redeclare package Medium = MediumCW,
    V_start=1)
              annotation (Placement(transformation(extent={{-94,48},{-86,56}})));
  Modelica.Blocks.Sources.CombiTimeTable KitHotWatDem(
    fileName="Twb1.txt",
    tableName="table1",
    tableOnFile=false,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table=[0,0.21; 3600,0.21; 7200,0.21; 10800,0.21; 14400,0.21; 18000,0.21;
        21600,0.21; 25200,0.21; 28800,0.21; 32400,0.21; 36000,0.21; 39600,1.15;
        43200,0.21; 46800,0.21; 50400,0.21; 54000,0.21; 57600,0.21; 61200,0.21;
        64800,0.21; 68400,1.15; 72000,0.21; 75600,0.21; 79200,0.21; 82800,0.21;
        86400,0.21],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{50,-60},{58,-52}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=if supCon.y > 4 then
        max((connectingLoop.senTem.T - 273.15 - 20)*(connectingLoop.MasFloRatCloWat.m_flow)
        *4.2*(1 - heatPump.BypValPos)/((connectingLoop.MasFloRatCloWat.m_flow)*
        (60 - 20)*4.2 + 0.00001), 0) else 0)
    annotation (Placement(transformation(extent={{120,50},{140,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=if supCon.y > 4
         then max((connectingLoop.senTem.T - 273.15 - 20)*(connectingLoop.MasFloRatCloWat.m_flow)
        *4.2*(1 - heatPump.BypValPos), 0) else 0)
    annotation (Placement(transformation(extent={{120,70},{140,90}})));
  Buildings.Fluid.Storage.ExpansionVessel exp2(
    redeclare package Medium = MediumCW, V_start=10)
              annotation (Placement(transformation(extent={{136,-2},{144,6}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaData(filNam=
        "modelica://HotelModel/Resources/weatherdata/USA_FL_Miami.Intl.AP.722020_TMY.mos")
    annotation (Placement(transformation(extent={{-166,16},{-156,24}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus
    annotation (Placement(transformation(extent={{-150,10},{-130,30}})));
  .HotelModel.Load.Load Loa
    annotation (Placement(transformation(extent={{-66,-44},{-58,-34}})));
  Modelica.Blocks.Sources.CombiTimeTable GueRooDomWatDem(
    fileName="Twb1.txt",
    tableName="table1",
    tableOnFile=false,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,0.0; 3600,0.0; 7200,0.0; 10800,0.0; 14400,0.0; 18000,0; 21600,0;
        25200,1.5; 28800,1.5; 32400,1.5; 36000,0; 39600,0; 43200,0.0; 46800,0.0;
        50400,0.0; 54000,0; 57600,0; 61200,1.5; 64800,1.5; 68400,1.5; 72000,0.0;
        75600,0.0; 79200,0.0; 82800,0.0; 86400,0.0])
    annotation (Placement(transformation(extent={{50,-44},{58,-36}})));
equation
  connect(connectingLoop.port_a1, domesticWaterControls.port_a1) annotation (
      Line(
      points={{100,-8},{140,-8},{140,-30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_b1, domesticWaterControls.port_a2) annotation (
      Line(
      points={{100.2,-20},{100,-20},{100,-40},{150,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(supCon.y, coolingTowerSystem.sta) annotation (Line(
      points={{-139,72},{-120,72},{-120,32},{-102,32}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y, heatPump.Sta) annotation (Line(
      points={{-139,72},{-10,72},{-10,6},{11,6}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y, connectingLoop.sta1) annotation (Line(
      points={{-139,72},{86,72},{86,-2}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticWaterControls.TBoi1, supCon.TBoiDW) annotation (Line(
      points={{161,-34},{176,-34},{176,-72},{-176,-72},{-176,68},{-162,68}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(coolingTowerSystem.port_a, hex.port_b1) annotation (Line(
      points={{-90,35.8},{-90,40},{-56,40},{-56,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_b, hex.port_a1) annotation (Line(
      points={{-90,16},{-90,-20},{-56,-20},{-56,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(hex.port_a2, heatPump.port_b1) annotation (Line(
      points={{-44,20},{-44,40},{12,40},{12,14}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(hex.port_b2, heatPump.port_a1) annotation (Line(
      points={{-44,0},{-44,-20},{12,-20},{12,2}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatPump.port_a2, connectingLoop.port_b2) annotation (Line(
      points={{32,14},{32,40},{80,40},{80,-8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatPump.port_b2, connectingLoop.port_a2) annotation (Line(
      points={{32,2},{32,-20},{80,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp1.port_a, connectingLoop.port_a2) annotation (Line(
      points={{60,-18},{60,-20},{80,-20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp4.port_a, hex.port_b1) annotation (Line(
      points={{-90,48},{-90,40},{-56,40},{-56,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatPump.Tboi, supCon.TBoiHP) annotation (Line(
      points={{28,-3},{28,-66},{-172,-66},{-172,60},{-162,60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.THeaPum, supCon.THeatPump) annotation (Line(
      points={{28,19},{28,94},{-180,94},{-180,84},{-162,84}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticWaterControls.Pum3_flow, connectingLoop.m_flow_in)
    annotation (Line(
      points={{161,-29.4},{176,-29.4},{176,18},{74,18},{74,-16},{78,-16}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(KitHotWatDem.y[1], domesticWaterControls.m_flow_in_kit) annotation (
      Line(
      points={{58.4,-56},{126,-56},{126,-26},{138,-26}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.BypValPos, supCon.BypasValPos) annotation (Line(
      points={{26,-3},{26,-60},{-132,-60},{-132,64},{-138,64}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(exp3.port_a, heatPump.port_a1) annotation (Line(
      points={{-20,-18},{-20,-20},{12,-20},{12,2}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.m_flow1, supCon.masFloHotWat) annotation (Line(
      points={{94,-3},{94,40},{184,40},{184,-80},{-180,-80},{-180,76},{-162,76}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(exp2.port_a, domesticWaterControls.port_a1) annotation (Line(
      points={{140,-2},{140,-30}},
      color={0,127,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(weaData.weaBus,weaBus)  annotation (Line(
      points={{-156,20},{-140,20}},
      thickness=0.5,
      smooth=Smooth.None,
      color={0,128,255},
      pattern=LinePattern.Dash),
                           Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.TWetBul, coolingTowerSystem.TWet) annotation (Line(
      points={{-140,20},{-122,20},{-122,20.2},{-101.2,20.2}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(Loa.TDryBul, weaBus.TDryBul) annotation (Line(
      points={{-66.8,-39},{-116,-39},{-116,20},{-140,20}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Loa.Loa, heatPump.Q_flow1) annotation (Line(
      points={{-57.6,-39},{0,-39},{0,10},{10,10}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticWaterControls.m_flow_in_dom, GueRooDomWatDem.y[1])
    annotation (Line(
      points={{138,-22},{108,-22},{108,-40},{58.4,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (__Dymola_Commands(file=
          "modelica://HotelModel/Resources/Scripts/HotelModel_annual.mos"
        "Simulate and plot"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
            {200,100}}),       graphics), Icon(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=3.1526e+007),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>The purpose of the model is to compare the HVAC system design of a heat recovery system (HR) versus a conventional system that does not use heat recovery and evaluate both systems total energy consumption, peak energy and system stability. </p>
<p>The models and controls are being implemented in Dymola using the Modelica Building Library which is an open source library for building environment simulation. </p>
<p>The specific system being used for experimentation is a the Grand Beach Hotel in Miami Beach, Florida</p>
<h4><span style=\"color:#008000\">Hotel Schematics</span></h4>
<p><img src=\"modelica://HotelModel/Resources/HotelInfo/HotelSchematic_heating.PNG\"/></p>
<h4><span style=\"color:#008000\">System Stages</span></h4>
<p><br><img src=\"modelica://HotelModel/Resources/HotelInfo/Stage.PNG\"/></p>
<p><u><b></font><font style=\"color: #008000; \">Unit Conversions</font></b></u></p>
<p>mCW_flow_nominal = 699 GPM [44.10 kg/s]</p>
<p>dp_nominal = 4.335 psi [29889.8 Pa]</p>
<p>mDW_flow_nominal = 25.68 GPM [1.62 kg/s]</p>
<p>dpDW_flow_nominal = 4.335 psi [29889.8 Pa]</p>
<p>mHW_flow_nominal = 699 GPM [44.10 kg/s]</p>
<p>dpHW_flow_nominal = 4.335 psi [29889.8 Pa]</p>
<p><i><b><font style=\"color: #008000; \">Unit Conversion in subsystem models</font></b></i></p>
<h5>Cooling Tower System parameters</h5>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><h4>Name</h4></td>
<td><h4>IP units</h4></td>
<td><h4>SI units</h4></td>
</tr>
<tr>
<td><p>P_nominal&nbsp;</p></td>
<td><p>2.95 horsepower&nbsp;</p></td>
<td><p>2.2kW</p></td>
</tr>
<tr>
<td><p>dTC_nominal</p></td>
<td><p>10&deg; F</p></td>
<td><p>5.56&deg; C</p></td>
</tr>
<tr>
<td><p>dTApp_nominal</p></td>
<td><p>3&deg; F</p></td>
<td><p>3.89&deg; C</p></td>
</tr>
<tr>
<td><p>TWetBul_nominal</p></td>
<td><p>79&deg; F</p></td>
<td><p>273.15 + 25.55 K</p></td>
</tr>
<tr>
<td><p>Tset</p></td>
<td><p>85&deg; F</p></td>
<td><p>273.15+29.44 K</p></td>
</tr>
</table>
<h5>Heat Pump System parameters</h5>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><h4>Name</h4></td>
<td><h4>IP units</h4></td>
<td><h4>SI units</h4></td>
</tr>
<tr>
<td><p>Q_flow_nominal</p></td>
<td><p>3495 MBH</p></td>
<td><p>1024283.3902519 W</p></td>
</tr>
<tr>
<td><p>Q_floSet</p></td>
<td><p>2796 MBH&nbsp;</p></td>
<td><p>&nbsp;819426.71220153 W</p></td>
</tr>
<tr>
<td><p>HeatPumpVol</p></td>
<td><p>6865.9 gal</p></td>
<td><p>&nbsp;25.99029318 m^3</p></td>
</tr>
<tr>
<td><p>HeatPumTRef</p></td>
<td><p>72&deg; F</p></td>
<td><p>273.15 + 22.22 K</p></td>
</tr>
<tr>
<td><p>TSetBoiIn</p></td>
<td><p>68&deg; F</p></td>
<td><p>273.15 + 20 K</p></td>
</tr>
</table>
<p><br><br><br><br><b><font style=\"font-size: 7pt; \">Domestic Water System parameters</b></p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><h4>Name</h4></td>
<td><h4>IP units</h4></td>
<td><h4>SI units</h4></td>
</tr>
<tr>
<td><p>VTan</p></td>
<td><p>792.516 gal</p></td>
<td><p>3 m^3</p></td>
</tr>
<tr>
<td><p>hTan</p></td>
<td><p>9.84252 ft</p></td>
<td><p>3 m</p></td>
</tr>
<tr>
<td><p>dIns</p></td>
<td><p>1.97 in&nbsp;</p></td>
<td><p>0.05 m</p></td>
</tr>
<tr>
<td><p>Q_flow_DWnominal</p></td>
<td><p>2047284.9798 MBH</p></td>
<td><p>600000 W</p></td>
</tr>
<tr>
<td><p>TBoiSetIn</p></td>
<td><p>68&deg; F</p></td>
<td><p>273.15 + 20 K</p></td>
</tr>
</table>
<p><br><br><h4><span style=\"color:#008000\">Results</span></h4></p>
<p><img src=\"modelica://HotelModel/../HotelInfo/Results0.PNG\"/></p>
<p><br><img src=\"modelica://HotelModel/../HotelInfo/Results1.PNG\"/></p>
<p><br><h5>Notes on the results:</h5></p>
<p><br>        &GT; 549.82 hp [410 kW] </p>
<p>        &GT; 556.52 hp [415 kW]</p>
<p>        &GT; 23.78 gpm [1.5 kg/s]</p>
<p>        &GT; 19.02 gpm [1.2 kg/s]</p>
<p><br><h4><span style=\"color:#008000\">Conclusion</span></h4></p>
<p><br>The system showed that during the greatest changes in system inputs, there was about 25&percnt; energy savings using a heat recovery system. </p>
</html>"));
end HotelModel_annual;
