defmodule Price do
  # currently only working with prices > 1,00
  def toString(integer) do
    ("$ " <> Integer.to_string(integer))
    |> String.split_at(-2)
    |> Tuple.to_list()
    |> Enum.join(",")
  end
end

defmodule Event do
  defstruct [:type, :value]

  def new(type, value) do
    %Event{type: type, value: value}
  end
end

defmodule Account do
  defstruct [:name, balance: 0, history: []]

  def new(name) do
    %Account{name: name}
  end

  def deposit(account, value) do
    operation = "Deposit"

    IO.puts("#{operation} in the name of #{account.name}. Value: #{Price.toString(value)}\n")

    %Account{
      account
      | balance: account.balance + value,
        history: account.history ++ [Event.new("#{operation}", value)]
    }
  end

  def withdrawal(account, value) do
    operation = "Withdrawal"

    if value <= account.balance do
      IO.puts("#{operation} in the name of #{account.name}. Value: #{Price.toString(value)}\n")

      %Account{
        account
        | balance: account.balance - value,
          history: account.history ++ [Event.new("#{operation}", value)]
      }
    else
      IO.puts("Insufficient funds for withdrawal in the name of #{account.name}\n")
    end
  end

  def printStatement(account) do
    IO.puts(
      "Statement for #{account.name} - Balance: #{Price.toString(account.balance)} \nHistory:"
    )

    Enum.each(account.history, fn event ->
      IO.puts("#{event.type} of #{Price.toString(event.value)}")
    end)
  end
end

defmodule Main do
  def main do
    Account.new("Maria")
    |> Account.deposit(10000)
    |> Account.withdrawal(5000)
    |> Account.withdrawal(4900)
    |> Account.printStatement()
  end
end

Main.main()
