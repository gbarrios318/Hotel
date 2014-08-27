within ;
package HotelModel "Models of hotel project"
  annotation (uses(                          Modelica(version="3.2.1"),
        Buildings(version="1.6"),
    Modelica_StateGraph2(version="2.0.2"),
    Hotel2(version="2")),
      version="2",
    conversion(from(version="1", script="ConvertFromNewHotelModel_1.mos")));
end HotelModel;
