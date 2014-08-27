within HotelModel.DomesticHotWater.BaseClasses;
model PartialDW "Common properties used for models in domestic water loop"
   replaceable package MediumDW =
      Buildings.Media.ConstantPropertyLiquidWater
    "Medium for domestic hot water";
      //Buildings.Media.Interfaces.PartialSimpleMedium
   parameter Modelica.SIunits.MassFlowRate mDW_flow_nominal
    "Nominal mass flow rate";

end PartialDW;
