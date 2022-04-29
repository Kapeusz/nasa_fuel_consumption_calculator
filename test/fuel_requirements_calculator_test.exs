defmodule NasaFuelConsumptionCalculator.FuelRequirementsCalculatorTest do
  use ExUnit.Case

  doctest NasaFuelConsumptionCalculator.FuelRequirementsCalculator

  test "compute fuel with sample inputs" do
    ship_weight = 28801
    gravity = 9.807
    directive = :land
    output = NasaFuelConsumptionCalculator.FuelRequirementsCalculator.calculate_consumption(directive, ship_weight, gravity)
    assert output == 9278
  end

  test "compute trip fuel with sample inputs" do
    ship_weight = 28801
    gravity = 9.807
    directive = :land
    output = NasaFuelConsumptionCalculator.FuelRequirementsCalculator.fuel_for_journey(directive, ship_weight, gravity)
    assert output == 13447
  end
end
