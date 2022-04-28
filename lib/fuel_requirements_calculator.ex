defmodule NasaFuelConsumptionCalculator.FuelRequirementsCalculator do
  @planets %{moon: 1.62, mars: 3.711, earth: 9.807}

  @moduledoc """
    Documentation for `FuelRequirementsCalculator`.
  """


  @doc """
    calculate_consumption/3
    Used to calculate basic fuel requirements using formulas
    land: mass * gravity * 0.033 - 42
    launch: mass * gravity * 0.042 - 33

    ## Examples
    iex> NasaFuelConsumptionCalculator.FuelRequirementsCalculator.calculate_consumption(:land, 28801, 9.807)
    9278
  """

  @spec calculate_consumption(atom, integer, float) :: float
  def calculate_consumption(directive, mass, gravity) do
    mode = find_mode(directive)
    fuel = mass * gravity * mode.arg1 - mode.arg2
    floor(fuel)
  end

   @doc """
    fuel_for_trip/3
    Used to calculate fuel requirements for a round trip, (i.e) extra fuel required as reserve

    ## Examples
    iex> NasaFuelConsumptionCalculator.FuelRequirementsCalculator.fuel_for_journey(:land, 28801, 9.807)
    0
  """

  @spec fuel_for_journey(atom, integer, float) :: float
  def fuel_for_journey(directive, mass, gravity) do
    fuel_required = calculate_consumption(directive, mass, gravity)

    if fuel_required <= 0, do: 0, else: fuel_for_journey(directive, fuel_required, gravity)
  end

    @doc """
      get_gravity/1
      Used to get gravity value using keyword

      ## Examples
      iex> NasaFuelConsumptionCalculator.FuelRequirementsCalculator.get_gravity(:earth)
      9.807

      iex> NasaFuelConsumptionCalculator.FuelRequirementsCalculator.get_gravity(9.807)
      9.807
  """

  @spec get_gravity(any) :: any
  def get_gravity(value) do
    case @planets[value] do
      nil -> value
      gravity -> gravity
    end
  end

  defp find_mode(:land), do: %{arg1: 0.033, arg2: 42}
  defp find_mode(:launch), do: %{arg1: 0.042, arg2: 33}
end
