within HotelModel.HeatRecoverySystem.Load;
model Load

  Modelica.Blocks.Interfaces.RealInput TDryBul
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Loa
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  Loa=max((TDryBul-21-273.15)/5.5*0.5*410000,-350000)+0.5*410000
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-156,146},{144,106}},
          textString="%name",
          lineColor={0,0,255})}));
end Load;
