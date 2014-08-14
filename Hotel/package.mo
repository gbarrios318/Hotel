within ;
package HotelModel "Models of hotel project"
replaceable package MediumCW =
          Modelica.Media.Interfaces.PartialMedium "Medium for condenser water"
          annotation (choicesAllMatching = true);
      parameter Modelica.SIunits.MassFlowRate mWater_flow_nominal=10
  "Nominal mass flow rate of water";
      parameter Modelica.SIunits.Pressure dp_nominal=100
  "Nominal pressure difference";


  annotation (uses(                          Modelica(version="3.2.1"),
        Buildings(version="1.6")),
      version="2",
    conversion(from(version="1", script="ConvertFromNewHotelModel_1.mos")));
end HotelModel;
