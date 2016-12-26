function printdigit(digit, rows, columns)
  for i = 1:rows
    for j = 1:columns
      print(digit[(i - 1) * columns + j] > 128 ? '.' : ' ')
    end

    print('\n')
  end
end
