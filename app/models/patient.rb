class Patient < ApplicationRecord
  serialize :upper_right, Array
  serialize :upper_left, Array
  serialize :lower_right, Array
  serialize :lower_left, Array
end
