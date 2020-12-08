module Seat
  function row_value(seat_code)
    row_code = SubString(seat_code, 1, 7)
    row_code = replace(row_code, "B" => "1")
    row_code = replace(row_code, "F" => "0")

    return parse(Int, row_code, base=2)
  end

  function col_value(seat_code)
    col_code = SubString(seat_code, 8, 10)
    col_code = replace(col_code, "R" => "1")
    col_code = replace(col_code, "L" => "0")

    return parse(Int, col_code, base=2)
  end

  function seat_id(seat_code)
    return row_value(seat_code) * 8 + col_value(seat_code)
  end

  function highest_id()
    highest_seat_value = 0

    # Read in file one line at a time
    # Track the highest seat value
    open("input.txt") do f
      while ! eof(f)
        s = readline(f)
        seat_id = Seat.seat_id(s)

        println("$s . $seat_id")

        if seat_id > highest_seat_value
          println("⭐ New high seat ID! $seat_id")
          highest_seat_value = seat_id
        end
      end
      println("Highest seat ID: $highest_seat_value")
    end
  end
end

# Tests
tests = Dict(
  "FBFBBFFRLR" => 358,
  "BFFFBBFRRR" => 567,
  "FFFBBBFRRR" => 119,
  "BBFFBBFRLL" => 820
)
println("Testing seat_id() function...")
for code in keys(tests)
  seat_id = Seat.seat_id(code)
  expected_id = tests[code]
  if expected_id == seat_id
    println("$code 👍")
  else
    println("$code 😿 expected $expected_id but got $seat_id")
  end
end

# Actual input
Seat.highest_id()
