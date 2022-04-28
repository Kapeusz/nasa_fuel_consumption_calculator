defmodule NasaFuelConsumptionCalculator.InputValidator do
  @directives [:land, :launch]
  @planets [:earth, :moon, :mars]

  @moduledoc """
  Documentation for `InputValidator`.
  """

  @doc """
    validate/2

    Used to check the input for errors
    ## Examples
    iex> NasaFuelConsumptionCalculator.InputValidator.validate_inputs(28801, "hello world")
    {:error, "Invalid directives details."}

    iex> NasaFuelConsumptionCalculator.InputValidator.validate_inputs(1.23, [{:land, :earth}])
    {:error, "Invalid ship weight. Weight must be an integer."}

    iex> NasaFuelConsumptionCalculator.InputValidator.validate_inputs(28801, [{:land, :earth}])
    {:ok, [{:land, :earth}]}
  """

  @spec validate_inputs(integer, list(tuple)) :: tuple
  def validate_inputs(ship_weight, _paths) when not is_integer(ship_weight) or ship_weight <= 0 do
    {:error, "Invalid ship weight. Weight must be an integer."}
  end

  def validate_inputs(_ship_weight, directives) do
    case directives do
      directives when is_list(directives) ->
        if Enum.all?(directives, fn directive ->
             is_tuple(directive) &&
               validate_directives(directive) &&
               validate_gravity(directive)
           end),
           do: {:ok, directives},
           else: {:error, "Invalid directives details."}

      _directives ->
        {:error, "Invalid directives details."}
    end
  end

  defp validate_directives({mode, _gravity}), do: Enum.member?(@directives, mode)

  defp validate_gravity({_mode, gravity}) do
    is_float(gravity) || Enum.member?(@planets, gravity)
  end
end
