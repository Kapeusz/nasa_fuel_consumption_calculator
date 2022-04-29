defmodule NasaFuelConsumptionCalculatorTest do
  use ExUnit.Case
  doctest NasaFuelConsumptionCalculator

  test "calculate fuel to launch from Earth" do
    assert NasaFuelConsumptionCalculator.calculate(28801, :land, 9.807) == 13447
  end

  test "calculate fuel for trip: Earth to Mars, Mars to Earth" do
    equipment_weight = 14606
    expected_fuel_weight = 33388
    coordinates = [{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
    assert NasaFuelConsumptionCalculator.calculate(equipment_weight, coordinates) == expected_fuel_weight
  end

  test "calculate fuel for trip: Earth to Moon, Moon to Earth" do
    equipment_weight = 28801
    expected_fuel_weight = 51898
    coordinates = [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}]
    assert NasaFuelConsumptionCalculator.calculate(equipment_weight, coordinates) == expected_fuel_weight
  end

  test "calculate fuel for trip: Earth -> Moon -> Mars -> Earth" do
    equipment_weight = 75432
    expected_fuel_weight = 212_161

    coordinates = [
      {:launch, 9.807},
      {:land, 1.62},
      {:launch, 1.62},
      {:land, 3.711},
      {:launch, 3.711},
      {:land, 9.807}
    ]

    assert NasaFuelConsumptionCalculator.calculate(equipment_weight, coordinates) == expected_fuel_weight
  end

  test "calculate fuel for trip using label: Earth -> Moon -> Mars -> Earth" do
    equipment_weight = 75432
    expected_fuel_weight = 212_161

    coordinates = [
      {:launch, :earth},
      {:land, :moon},
      {:launch, :moon},
      {:land, :mars},
      {:launch, :mars},
      {:land, :earth}
    ]

    assert NasaFuelConsumptionCalculator.calculate(equipment_weight, coordinates) == expected_fuel_weight
  end

  test "calculate fuel for trip with error: Earth to Moon, Moon to Earth" do
    equipment_weight = 28801
    coordinates = [{:launch, 9.807}, {:land, 1.62}, {"launch", 1.62}, {:land, 9.807}]
    output = NasaFuelConsumptionCalculator.calculate(equipment_weight, coordinates)
    assert String.contains?(output, "Invalid directives details.")
  end

  test "calculate fuel for invalid mode" do
    equipment_weight = 75432
    coordinates = [{"launch", 9.807}]
    output = NasaFuelConsumptionCalculator.calculate(equipment_weight, coordinates)
    assert String.contains?(output, "Invalid directives details.")
  end

  test "calculate fuel for invalid path" do
    equipment_weight = 75432
    coordinates = {:launch, 9.807}
    output = NasaFuelConsumptionCalculator.calculate(equipment_weight, coordinates)
    assert String.contains?(output, "Invalid directives details.")
  end

  test "calculate fuel for invalid weight" do
    equipment_weight = -28801
    coordinates = [{"launch", 9.807}]
    output = NasaFuelConsumptionCalculator.calculate(equipment_weight, coordinates)
    assert String.contains?(output, "Invalid ship weight. Weight must be an integer.")
  end
end
