within HotelModel.HeatRecoverySystem;
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
              annotation (Placement(transformation(extent={{-24,-16},{-16,-8}})));
  Buildings.Fluid.Storage.ExpansionVessel exp1(
    redeclare package Medium = MediumCW,
    V_start=1)
              annotation (Placement(transformation(extent={{56,-14},{64,-6}})));
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
    annotation (Placement(transformation(extent={{50,-64},{58,-56}})));
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
              annotation (Placement(transformation(extent={{122,36},{130,44}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaData(filNam=
        "modelica://HotelModel/Resources/weatherdata/USA_FL_Miami.Intl.AP.722020_TMY.mos")
    annotation (Placement(transformation(extent={{-170,-44},{-160,-36}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus
    annotation (Placement(transformation(extent={{-150,-50},{-130,-30}})));
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
    annotation (Placement(transformation(extent={{50,-50},{58,-42}})));
  CoolingTowerSection.CoolingTowerSystem coolingTowerSystem(
    redeclare package MediumCW = MediumCW,
    P_nominal=coolingTowerSystem.P_nominal,
    dTCW_nominal=coolingTowerSystem.dTCW_nominal,
    dTApp_nominal=coolingTowerSystem.dTApp_nominal,
    TWetBul_nominal=coolingTowerSystem.TWetBul_nominal,
    mCW_flow_nominal=coolingTowerSystem.mCW_flow_nominal,
    redeclare package MediumRainWater = MediumHW,
    GaiPi=coolingTowerSystem.GaiPi,
    tIntPi=coolingTowerSystem.tIntPi,
    eta=coolingTowerSystem.eta,
    TSet=coolingTowerSystem.TSet,
    Motor_eta=coolingTowerSystem.Motor_eta,
    Hydra_eta=coolingTowerSystem.Hydra_eta,
    dp_nominal=dp_nominal,
    mRW_flow_nominal=mCW_flow_nominal)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  HeatPumpSection.HeatPump heatPump(
    redeclare package MediumHW = MediumHW,
    mHW_flow_nominal=mHW_flow_nominal,
    dpHW_nominal=dpHW_nominal,
    redeclare package MediumDW = MediumDW,
    mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=dpDW_nominal,
    Q_flow_nominal=heatPump.Q_flow_nominal,
    HeatPumpVol=heatPump.HeatPumpVol,
    HeaPumTRef=heatPump.HeaPumTRef,
    TSetBoiIn=heatPump.TSetBoiIn)
    annotation (Placement(transformation(extent={{0,20},{20,0}})));
  Control.SupervisoryControl supCon
    annotation (Placement(transformation(extent={{-168,58},{-148,78}})));
  Load.Load TDryBul
    annotation (Placement(transformation(extent={{-68,-46},{-60,-34}})));
  ConnectingPackage.ConnectingLoop connectingLoop(
    redeclare package MediumDW = MediumDW,
    mDW_flow_nominal=mDW_flow_nominal,
    dpDW_nominal=dpDW_nominal)
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  DomesticHotWater.DomesticWaterControls domesticWaterControls(redeclare
      package MediumDW = MediumDW,
    dpDW_nominal=dpDW_nominal,
    VTan=domesticWaterControls.VTan,
    hTan=domesticWaterControls.hTan,
    dIns=domesticWaterControls.dIns,
    Q_flow_DWnominal=domesticWaterControls.Q_flow_DWnominal,
    MassFloDomIn=domesticWaterControls.MassFloDomIn,
    MassFloKitIn=domesticWaterControls.MassFloKitIn,
    TBoiSetIn=domesticWaterControls.TBoiSetIn,
    mDW_flow_nominal=mDW_flow_nominal)
    annotation (Placement(transformation(extent={{134,6},{154,26}})));
  Buildings.Fluid.Sources.FixedBoundary KitWat(nPorts=1, redeclare package
      Medium = MediumDW) "Kitchen Water " annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={144,42})));
  Buildings.Fluid.Sources.FixedBoundary DomHotWat(redeclare package Medium =
        MediumDW, nPorts=1) "Domestic Hot Water"
    annotation (Placement(transformation(extent={{188,8},{172,24}})));
  Buildings.Fluid.Sources.Boundary_pT CitWat(
    redeclare package Medium = MediumDW,
    p(displayUnit="kPa") = 275800,
    nPorts=1,
    use_p_in=false) "City Water pressure boundry"
    annotation (Placement(transformation(extent={{40,4},{56,20}})));
  Buildings.Fluid.Sources.FixedBoundary RaiWat(redeclare package Medium =
        MediumCW, nPorts=1)
    "Rain water collection in this simulation is zero so it is simulated by a fixed boundry"
    annotation (Placement(transformation(extent={{-166,12},{-150,28}})));
equation
  connect(exp4.port_a, hex.port_b1) annotation (Line(
      points={{-90,48},{-90,40},{-56,40},{-56,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));

  connect(weaData.weaBus,weaBus)  annotation (Line(
      points={{-160,-40},{-140,-40}},
      thickness=0.5,
      smooth=Smooth.None,
      color={0,128,255},
      pattern=LinePattern.Dash),
                           Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(coolingTowerSystem.port_a, hex.port_b1) annotation (Line(
      points={{-90,29.8},{-90,40},{-56,40},{-56,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_b, hex.port_a1) annotation (Line(
      points={{-90,10},{-90,-20},{-56,-20},{-56,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.TWet, weaBus.TWetBul) annotation (Line(
      points={{-101.2,14.2},{-140,14.2},{-140,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TDryBul.TDryBul, weaBus.TDryBul) annotation (Line(
      points={{-68.8,-40},{-140,-40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TDryBul.Loa, heatPump.Q_flow1) annotation (Line(
      points={{-59.6,-40},{-4,-40},{-4,12},{-2,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y, coolingTowerSystem.sta) annotation (Line(
      points={{-147,68},{-130,68},{-130,26},{-102,26}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y, heatPump.Sta) annotation (Line(
      points={{-147,68},{-20,68},{-20,8},{-1,8}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.port_b1, hex.port_a2) annotation (Line(
      points={{0,16},{0,40},{-44,40},{-44,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(hex.port_b2, heatPump.port_a1) annotation (Line(
      points={{-44,0},{-44,-20},{0,-20},{0,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp3.port_a, heatPump.port_a1) annotation (Line(
      points={{-20,-16},{-20,-20},{0,-20},{0,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatPump.THeaPum, supCon.THeatPump) annotation (Line(
      points={{16,21},{16,88},{-180,88},{-180,80},{-170,80}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.BypValPos, supCon.BypasValPos) annotation (Line(
      points={{14,-1},{14,-54},{-120,-54},{-120,60},{-146,60}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.Tboi, supCon.TBoiHP) annotation (Line(
      points={{16,-1},{16,-60},{-180,-60},{-180,56},{-170,56}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.port_b2, connectingLoop.port_a2) annotation (Line(
      points={{20,4},{20,-20},{80,-20},{80,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp1.port_a, connectingLoop.port_a2) annotation (Line(
      points={{60,-14},{60,-20},{80,-20},{80,4}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(KitHotWatDem.y[1], domesticWaterControls.m_flow_in_kit) annotation (
      Line(
      points={{58.4,-60},{120,-60},{120,20},{132,20}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(GueRooDomWatDem.y[1], domesticWaterControls.m_flow_in_dom)
    annotation (Line(
      points={{58.4,-46},{114,-46},{114,24},{132,24}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(domesticWaterControls.Pum3_flow, connectingLoop.m_flow_in)
    annotation (Line(
      points={{155,20},{160,20},{160,28},{72,28},{72,8},{78,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.TBoiDW, domesticWaterControls.TBoi1) annotation (Line(
      points={{-170,64},{-190,64},{-190,-80},{160,-80},{160,12},{155,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(connectingLoop.m_flow1, supCon.masFloHotWat) annotation (Line(
      points={{94,21},{92,21},{92,96},{-192,96},{-192,72},{-170,72}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(connectingLoop.sta1, heatPump.Sta) annotation (Line(
      points={{86,22},{86,68},{-20,68},{-20,8},{-1,8}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(connectingLoop.port_a1, domesticWaterControls.port_b1) annotation (
      Line(
      points={{100,16},{134,16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp2.port_a, domesticWaterControls.port_b1) annotation (Line(
      points={{126,36},{126,16},{134,16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_b1, heatPump.port_a2) annotation (Line(
      points={{80,16},{80,40},{20,40},{20,16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_b2, domesticWaterControls.port_a1) annotation (
      Line(
      points={{100,4},{100,-20},{144,-20},{144,6}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticWaterControls.KitWat1, KitWat.ports[1]) annotation (Line(
      points={{144,26},{144,34}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticWaterControls.DomHotWat1, DomHotWat.ports[1]) annotation (
      Line(
      points={{154,16},{172,16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(RaiWat.ports[1], coolingTowerSystem.port_a1) annotation (Line(
      points={{-150,20},{-100.2,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.CitWat, CitWat.ports[1]) annotation (Line(
      points={{80,12},{56,12}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
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
