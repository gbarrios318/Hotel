within HotelModel.CoolingTowerSection.Example.BaseClass;
model PartialCoolingTower "Partial model for cooling tower examples"
 package MediumCW = Buildings.Media.ConstantPropertyLiquidWater
    "Medium for condenser water"
      annotation (choicesAllMatching = true);
 parameter Modelica.SIunits.Power P_nominal=30000
    "Nominal compressor power (at y=1)";
  parameter Modelica.SIunits.TemperatureDifference dTCW_nominal=5.18
    "Temperature difference between the outlet and inlet of the modules";
  parameter Modelica.SIunits.TemperatureDifference dTApp_nominal=4.44
    "Nominal approach temperature";
  parameter Modelica.SIunits.Temperature TWetBul_nominal=273.15+25
    "Nominal wet bulb temperature";
  parameter Modelica.SIunits.Pressure dP_nominal=1000
    "Pressure difference between the outlet and inlet of the modules ";
  parameter Modelica.SIunits.MassFlowRate mCW_flow_nominal=10
    "Nominal mass flow rate at condenser water wide";
  parameter Real GaiPi=1 "Gain of the PI controller";
  parameter Real tIntPi=60 "Integration time of the PI controller";
  parameter Real v_flow_rate[:]={1} "Volume flow rate rate";
  parameter Real eta[:]={1} "Fan efficiency";

end PartialCoolingTower;
