defmodule Car do
  defstruct turnedOn: false,
            speed: 0

  def new() do
    %Car{}
  end

  def status(car) do
    state =
      if car.turnedOn == true do
        "Car on"
      else
        "Car off"
      end

    IO.puts("#{state}. Speed: #{car.speed}.")
  end

  def turnOn(car) do
    if car.turnedOn === false do
      newCar = %Car{car | turnedOn: true}
      status(newCar)
      newCar
    else
      IO.puts("Car already on.")
      car
    end
  end

  def turnOff(car) do
    if car.turnedOn === true do
      newCar = %Car{car | turnedOn: false, speed: 0}
      status(newCar)
      newCar
    else
      IO.puts("Car already off.")
      car
    end
  end

  def speedUp(car) do
    if car.turnedOn === true do
      newCar = %Car{car | speed: car.speed + 10}
      status(newCar)
      newCar
    else
      IO.puts("Can't speed up a turned off car.")
      car
    end
  end

  def speedDown(car) do
    if car.turnedOn === true do
      newCar = %Car{car | speed: car.speed - 10}
      status(newCar)
      newCar
    else
      IO.puts("Can't speed down a turned off car.")
      car
    end
  end
end

defmodule Main do
  def main do
    myCar =
      Car.new()
      |> Car.turnOff()
      |> Car.turnOn()
      |> Car.turnOn()
      |> Car.speedUp()
      |> Car.speedUp()
      |> Car.speedDown()
      |> Car.turnOff()
      |> Car.speedUp()
      |> Car.speedDown()
  end
end

Main.main()
