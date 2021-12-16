defmodule Price do
  # currently only working with prices > 1,00
  def toString(integer) do
    "$ "<>Integer.to_string(integer)
    |> String.split_at(-2)
    |> Tuple.to_list()
    |> Enum.join(",")
  end
end

defmodule Cart do
  defstruct [:client, products: []]

  def new(name) do
    %Cart{client: name}
  end

  def printClient(cart) do
    IO.puts(" Client: #{cart.client}")
  end

  def printSummary(cart) do
    items = calculateItems(cart)
    total = calculateTotal(cart)
    discount = calculateDiscount(cart, items, total)
    printClient(cart)
    printDetails(cart)
    IO.puts(" Item total: #{items} \n Discount: #{Price.toString(discount)} \n Total price: #{Price.toString(total)} \n Total with discount: #{Price.toString(total - discount)}")
  end

  def printDetails(cart) do
    cart.products
    |> Enum.with_index()
    |> Enum.each(fn {item, index} ->
      IO.puts(
        " Item #{index + 1} - #{item.name} - #{item.amount} unt - #{Price.toString(item.price)}"
      )
    end)
  end

  def calculateTotal(cart) do
    sum = fn product, acc -> acc + product.amount * product.price end
    Enum.reduce(cart.products, 0, sum)
  end

  def calculateItems(cart) do
    sum = fn product, acc -> acc + product.amount end
    Enum.reduce(cart.products, 0, sum)
  end

  def discountItems(cart, items) do
    if items > 4 do
      Enum.sort_by(cart.products, & &1.price)
      |> List.first()
      |> Map.get(:price)
    end
  end

  def discountTotal(total) do
    if total > 10000 do
      div(total * 10, 100)
    end
  end

  def calculateDiscount(cart, items, total) do
    discountOne =  discountTotal(total)
    dicountTwo =   discountItems(cart, items)
    [discountOne, dicountTwo] |> Enum.sort(:desc) |> List.first()
  end

  def insertProduct(cart, newProduct) do
    newProductIndex = Enum.find_index(cart.products, fn p -> p.id == newProduct.id end)

    if newProductIndex != nil do
      updatedProductList = List.delete_at(cart.products, newProductIndex)

      updatedProduct =
        Enum.at(cart.products, newProductIndex)
        |> Map.update(:amount, 0, fn value -> value + newProduct.amount end)

      %Cart{cart | products: [updatedProduct | updatedProductList]}
    else
      %Cart{cart | products: [newProduct | cart.products]}
    end
  end
end

defmodule Product do
  defstruct [:id, :name, :amount, :price]

  def new(id, name, amount, price) do
    %Product{id: id, name: name, amount: amount, price: price}
  end
end

defmodule Main do
  def main do
    shorts = Product.new(2, "Shorts", 2, 5000)
    shirt = Product.new(1, "Shirt", 3, 3000)

    Cart.new("Guido Bernal")
    |> Cart.insertProduct(shorts)
    |> Cart.insertProduct(shirt)
    |> Cart.printSummary()
  end
end

Main.main()
