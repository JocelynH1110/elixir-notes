defmodule Identicon.Image do
  defstruct hex: nil, color: nil, grid: nil, pixel_map: nil

  ## 等同上面，當所有預設值都是 nil 可以這樣寫： defstruct [:hex, :color, :grid, :pixel_map]
end
