module PatientsHelper
  def convert_to_dental_notation(parts)
    return "" unless parts.is_a?(Hash)

    upper_left = Array(parts[:upper_left] || []).map { |t| t.match(/\d+/)[0] rescue nil }.compact.sort.reverse.join  # 例: 321
    upper_right = Array(parts[:upper_right] || []).map { |t| t.match(/\d+/)[0] rescue nil }.compact.sort.join  # 例: 123
    lower_left = Array(parts[:lower_left] || []).map { |t| t.match(/\d+/)[0] rescue nil }.compact.sort.reverse.join  # 例: 321
    lower_right = Array(parts[:lower_right] || []).map { |t| t.match(/\d+/)[0] rescue nil }.compact.sort.join  # 例: 123

    notation = []

    if upper_left.present? && upper_right.present?
      notation << "#{upper_left}⊥#{upper_right}"
    elsif upper_left.present?
      notation << "⸤#{upper_left}"
    elsif upper_right.present?
      notation << "#{upper_right}⸥"
    end

    if lower_left.present? && lower_right.present?
      notation << "#{lower_left}⊤#{lower_right}"
    elsif lower_left.present?
      notation << "⸢#{lower_left}"
    elsif lower_right.present?
      notation << "#{lower_right}⸣"
    end

    notation.join(" ")
  end
end
