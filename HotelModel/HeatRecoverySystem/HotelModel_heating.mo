within HotelModel.HeatRecoverySystem;
model HotelModel_heating
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
  Modelica.Blocks.Sources.CombiTimeTable TwetBulbData(
    tableOnFile=true,
    fileName="Twb1.txt",
    tableName="table1",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-130,0},{-122,8}})));
  Buildings.Fluid.Storage.ExpansionVessel exp4(
    redeclare package Medium = MediumCW,
    V_start=1)
              annotation (Placement(transformation(extent={{-90,38},{-82,46}})));
  Modelica.Blocks.Sources.CombiTimeTable KitHotWatDem(
    fileName="Twb1.txt",
    tableName="table1",
    tableOnFile=false,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table=[0,0.21; 3600,0.21; 7200,0.21; 10800,0.21; 14400,0.21; 18000,0.21;
        21600,0.21; 25200,0.21; 28800,0.21; 32400,0.21; 36000,0.21; 39600,1.15;
        43200,0.21; 46800,0.21; 50400,0.21; 54000,0.21; 57600,0.21; 61200,0.21;
        64800,0.21; 68400,1.15; 72000,0.21; 75600,0.21; 79200,0.21; 82800,0.21;
        86400,0.21])
    annotation (Placement(transformation(extent={{50,-60},{58,-52}})));
  Modelica.Blocks.Sources.CombiTimeTable HeaLoa(
    fileName="Twb1.txt",
    tableName="table1",
    tableOnFile=false,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table=[0,-174000; 3600,-175800; 7200,-178000; 10800,-175800; 14400,-179000;
        18000,-175800; 21600,-173000; 25200,-175000; 28800,-146500; 32400,-117200;
        36000,-117200; 39600,-87900; 43200,-87500; 46800,-87000; 50400,-73300; 54000,
        -73300; 57600,-58600; 61200,-73300; 64800,-99620; 68400,-99620; 72000,-110000;
        75600,-123000; 79200,-131000; 82800,-135000; 86400,-135000])
    annotation (Placement(transformation(extent={{-86,-50},{-78,-42}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=(connectingLoop.senTem.T
         - 273.15 - 20)*(connectingLoop.MasFloRatCloWat.m_flow)*4.2*(1 -
        heatPump.BypValPos)/((connectingLoop.MasFloRatCloWat.m_flow)*(60 - 20)*
        4.2 + 0.00001))
    annotation (Placement(transformation(extent={{120,50},{140,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=(connectingLoop.senTem.T
         - 273.15 - 20)*(connectingLoop.MasFloRatCloWat.m_flow)*4.2*(1 -
        heatPump.BypValPos))
    annotation (Placement(transformation(extent={{120,70},{140,90}})));
  Modelica.Blocks.Sources.CombiTimeTable GueRooDomWatDem(
    fileName="Twb1.txt",
    tableName="table1",
    tableOnFile=false,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    table=[0,0.0; 3600,0.0; 7200,0.0; 10800,0.0; 14400,0.0; 18000,0; 21600,0;
        25200,1.5; 28800,1.5; 32400,1.5; 36000,0; 39600,0; 43200,0.0; 46800,0.0;
        50400,0.0; 54000,0; 57600,0; 61200,1.5; 64800,1.5; 68400,1.5; 72000,0.0;
        75600,0.0; 79200,0.0; 82800,0.0; 86400,0.0])
    annotation (Placement(transformation(extent={{50,-46},{58,-38}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = MediumCW,
    redeclare package Medium2 = MediumHW,
    m1_flow_nominal=mCW_flow_nominal,
    dp1_nominal=dp_nominal,
    dp2_nominal=dpHW_nominal,
    m2_flow_nominal=mHW_flow_nominal) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-2})));
  Buildings.Fluid.Storage.ExpansionVessel exp3(
    redeclare package Medium = MediumCW,
    V_start=1)
              annotation (Placement(transformation(extent={{-20,-28},{-12,-20}})));
  Buildings.Fluid.Storage.ExpansionVessel exp1(
    redeclare package Medium = MediumCW,
    V_start=1)
              annotation (Placement(transformation(extent={{60,-26},{68,-18}})));
  Buildings.Fluid.Storage.ExpansionVessel exp2(
    redeclare package Medium = MediumCW, V_start=10)
              annotation (Placement(transformation(extent={{126,4},{134,12}})));
  CoolingTowerSection.CoolingTowerSystem coolingTowerSystem
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  HeatPumpSection.HeatPump heatPump
    annotation (Placement(transformation(extent={{0,8},{20,-12}})));
  Control.SupervisoryControl supCon
    annotation (Placement(transformation(extent={{-170,50},{-150,70}})));
  ConnectingPackage.ConnectingLoop connectingLoop
    annotation (Placement(transformation(extent={{80,-32},{100,-12}})));
  DomesticHotWater.DomesticWaterControls domesticWaterControls
    annotation (Placement(transformation(extent={{140,-26},{160,-6}})));
equation

  connect(coolingTowerSystem.port_a, hex.port_b1) annotation (Line(
      points={{-90,19.8},{-90,28},{-56,28},{-56,8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(coolingTowerSystem.port_b, hex.port_a1) annotation (Line(
      points={{-90,0},{-90,-32},{-56,-32},{-56,-12}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(supCon.y, coolingTowerSystem.sta) annotation (Line(
      points={{-149,60},{-120,60},{-120,16},{-102,16}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.y, heatPump.Sta) annotation (Line(
      points={{-149,60},{-20,60},{-20,-4},{-1,-4}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.port_b1, hex.port_a2) annotation (Line(
      points={{0,4},{0,28},{-44,28},{-44,8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(hex.port_b2, heatPump.port_a1) annotation (Line(
      points={{-44,-12},{-44,-32},{0,-32},{0,-8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp3.port_a, heatPump.port_a1) annotation (Line(
      points={{-16,-28},{-16,-32},{0,-32},{0,-8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatPump.THeaPum, supCon.THeatPump) annotation (Line(
      points={{16,9},{16,80},{-180,80},{-180,72},{-172,72}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.BypValPos, supCon.BypasValPos) annotation (Line(
      points={{14,-13},{14,-66},{-110,-66},{-110,52},{-148,52}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.Tboi, supCon.TBoiHP) annotation (Line(
      points={{16,-13},{16,-72},{-180,-72},{-180,48},{-172,48}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(heatPump.port_a2, connectingLoop.port_b2) annotation (Line(
      points={{20,4},{20,28},{80,28},{80,-16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(heatPump.port_b2, connectingLoop.port_a2) annotation (Line(
      points={{20,-8},{20,-32},{80,-32},{80,-28}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp1.port_a, connectingLoop.port_a2) annotation (Line(
      points={{64,-26},{64,-32},{80,-32},{80,-28}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_a1, domesticWaterControls.port_a1) annotation (
      Line(
      points={{100,-16},{140,-16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(connectingLoop.port_b1, domesticWaterControls.port_a2) annotation (
      Line(
      points={{100.2,-28},{106,-28},{106,-52},{150,-52},{150,-26}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(exp2.port_a, domesticWaterControls.port_a1) annotation (Line(
      points={{130,4},{130,-16},{140,-16}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(domesticWaterControls.Pum3_flow, connectingLoop.m_flow_in)
    annotation (Line(
      points={{161,-15.4},{164,-15.4},{164,18},{72,18},{72,-24},{78,-24}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(supCon.TBoiDW, domesticWaterControls.TBoi1) annotation (Line(
      points={{-172,56},{-186,56},{-186,-80},{164,-80},{164,-20},{161,-20}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(connectingLoop.m_flow1, supCon.masFloHotWat) annotation (Line(
      points={{94,-11},{98,-11},{98,90},{-186,90},{-186,64},{-172,64}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(exp4.port_a, hex.port_b1) annotation (Line(
      points={{-86,38},{-86,28},{-56,28},{-56,8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=1));
  connect(TwetBulbData.y[1], coolingTowerSystem.TWet) annotation (Line(
      points={{-121.6,4},{-112,4},{-112,4.2},{-101.2,4.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HeaLoa.y[1], heatPump.Q_flow1) annotation (Line(
      points={{-77.6,-46},{-8,-46},{-8,0},{-2,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(KitHotWatDem.y[1], domesticWaterControls.m_flow_in_kit) annotation (
      Line(
      points={{58.4,-56},{134,-56},{134,-32},{134,-32},{134,-12},{138,-12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(GueRooDomWatDem.y[1], domesticWaterControls.m_flow_in_dom)
    annotation (Line(
      points={{58.4,-42},{116,-42},{116,-8},{138,-8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(connectingLoop.sta1, heatPump.Sta) annotation (Line(
      points={{86,-10},{86,60},{-20,60},{-20,-4},{-1,-4}},
      color={255,127,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (__Dymola_Commands(file=
          "modelica://HotelModel/Resources/Scripts/HotelModel_heating.mos"
        "Simulate and plot"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
            {200,100}}),       graphics), Icon(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=86400),
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
end HotelModel_heating;
