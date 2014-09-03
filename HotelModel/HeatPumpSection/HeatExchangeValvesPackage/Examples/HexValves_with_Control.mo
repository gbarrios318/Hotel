within HotelModel.HeatPumpSection.HeatExchangeValvesPackage.Examples;
model HexValves_with_Control
  "Examples for the heat exchange valves with the controls"
     replaceable package MediumCW =
      Buildings.Media.ConstantPropertyLiquidWater "Medium for condenser water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
    "Nominal mass flow rate of water";
  parameter Modelica.SIunits.Pressure dp_nominal=100
    "Nominal pressure difference";
  import HotelModel;
 extends Modelica.Icons.Example;
  HotelModel.HeatPumpSection.HeatExchangeValvesPackage.HeatEx_and_valves
    heatEx_and_valves
    annotation (Placement(transformation(extent={{-8,10},{12,30}})));
equation

end HexValves_with_Control;
