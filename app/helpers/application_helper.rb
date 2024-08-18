module ApplicationHelper
  MARU_NUMBERS = ["①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧"].freeze
  KAKUMARU_NUMBERS = ["❶", "❷", "❸", "❹", "❺", "❻", "❼", "❽"].freeze

  def to_marunumber(num)
    MARU_NUMBERS[num - 1]
  end

  def to_kakumaru(num)
    KAKUMARU_NUMBERS[num - 1]
  end
end
