# NASAFuelConsumptionCalculator

## Tech
- Elixir 1.13.4 (compiled with Erlang/OTP 24)

## How to start the application

<pre>
  git clone https://github.com/Kapeusz/nasa_fuel_consumption_calculator.git
  cd nasa_fuel_consumption_calculator
  mix compile
  iex -S mix
 </pre>
  
  ## Making a request
  #### Example for two way trip
 ```iex> NasaFuelConsumptionCalculator.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])```
  
  #### Example for a trip from Earth to Moon, then from Moon to Mars and back to Earth
  ```iex> NasaFuelConsumptionCalculator.calculate(75432, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}])```

   ## Testing
   
   run ```mix test```
   
   
