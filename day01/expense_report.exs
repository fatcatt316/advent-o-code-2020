defmodule ExpenseReport do

  def run([num1 | rest]) do
    case number_that_adds_up_to_2020(num1, rest) do
      nil -> run(rest)
      solution -> solution
    end
  end

  def number_that_adds_up_to_2020(_num1, []), do: nil

  def number_that_adds_up_to_2020(num1, [num2 | rest]) do
    if num1 + num2 == 2020 do
      num1 * num2
    else
      number_that_adds_up_to_2020(num1, rest)
    end
  end

  def run2([num1 | rest]) do
    case multiply_numbers_that_add_up_to_2020(num1, rest) do
      nil -> run2(rest)
      solution -> solution
    end
  end

  def multiply_numbers_that_add_up_to_2020(num1, []), do: nil

  def multiply_numbers_that_add_up_to_2020(num1, [num2 | rest]) do
    case find_num3(num1, num2, rest) do
      nil -> multiply_numbers_that_add_up_to_2020(num1, rest)
      num3 -> num1 * num2 * num3
    end
  end

  def find_num3(num1, num2, []), do: nil

  def find_num3(num1, num2, [num3 | rest]) do
    if num1 + num2 + num3 == 2020 do
      num3
    else
      find_num3(num1, num2, rest)
    end
  end
end


