defmodule NasaFuelConsumptionCalculator do
  import NasaFuelConsumptionCalculator.FuelRequirementsCalculator
  import NasaFuelConsumptionCalculator.InputValidator
  @moduledoc """
  Documentation for `NasaFuelConsumptionCalculator`.
  """

  @doc """
  Calculate/2

  ## Examples

      iex> NasaFuelConsumptionCalculator.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
      51898

  """

  @spec calculate(integer, list(tuple)) :: integer | String.t()
  def calculate(ship_weight, directives) do
    validate_inputs(ship_weight, directives)
    |> evaluate(ship_weight)
  end

    @doc """
    Calculate/3

    used to calculate fuel required to perform single step, i.e land or launch
    ## Examples
    iex>  NasaFuelConsumptionCalculator.calculate(28801, :land, 9.807)
    13447
    iex>  NasaFuelConsumptionCalculator.calculate(28801, :land, :earth)
    13447
  """
  @spec calculate(integer, atom, integer) :: integer | String.t()
  def calculate(ship_weight, mode, gravity) do
    validate_inputs(ship_weight, [{mode, gravity}])
    |> evaluate(ship_weight)
  end

  @spec evaluate(tuple, integer) :: integer | String.t()
  defp evaluate({:error, message}, _ship_weight), do: message <> " \n " <> IO.puts("Try: NasaFuelConsumptionCalculator.calculate.calculate(28801, :land, :earth) \n " <>
    "or: NasaFuelConsumptionCalculator.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])")
  defp evaluate({:ok, []}, _ship_weight), do: 0

  defp evaluate({:ok, directives}, ship_weight) do
    [current_directive | next_directives] = directives
    {mode, value} = current_directive
    gravity = get_gravity(value)
    shuttle_weight = evaluate({:ok, next_directives}, ship_weight)
    shuttle_weight + fuel_for_journey(mode, ship_weight + shuttle_weight, gravity)
  end
end
