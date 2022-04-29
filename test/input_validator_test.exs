defmodule NasaFuelConsumptionCalculator.InputValidatorTest do
  use ExUnit.Case
  doctest NasaFuelConsumptionCalculator.InputValidator

  test "should fail with invalid inputs" do
    {_ship_weight, _directives} =
      NasaFuelConsumptionCalculator.InputValidator.validate_inputs(:land, "hello")
  end

  test "should fail with invalid directive" do
    {_ship_weight, directives} =
      NasaFuelConsumptionCalculator.InputValidator.validate_inputs(28801, "hello")

    assert directives == "Invalid directives details."
  end

  test "should fail with invalid mode" do
    {_ship_weight, directives} =
      NasaFuelConsumptionCalculator.InputValidator.validate_inputs(28801, [{"land", 12}])

    assert directives == "Invalid directives details."
  end

  test "should return directive with valid input" do
    {_ship_weight, directives} =
      NasaFuelConsumptionCalculator.InputValidator.validate_inputs(28801, [{:land, :earth}])

    assert directives == [{:land, :earth}]
  end
end
