module PatientsHelper
  def convert_to_dental_notation(parts)
    return "" unless parts.is_a?(Hash)
  
    upper_left = Array(parts[:upper_left] || []).map { |t| t.match(/\d+/)[0] rescue nil }.compact.sort.join  # 若い順にしたいので降順
    upper_right = Array(parts[:upper_right] || []).map { |t| t.match(/\d+/)[0] rescue nil }.compact.sort.reverse.join  # 若い順にしたいので昇順
    lower_left = Array(parts[:lower_left] || []).map { |t| t.match(/\d+/)[0] rescue nil }.compact.sort.join  # 若い順にしたいので降順
    lower_right = Array(parts[:lower_right] || []).map { |t| t.match(/\d+/)[0] rescue nil }.compact.sort.reverse.join  # 若い順にしたいので昇順
  
    notation = []
  
    # 上顎の処理
    if upper_left.present? && upper_right.present?
      notation << "#{upper_right}⊥#{upper_left}"
    elsif upper_left.present?
      notation << "⌞#{upper_left}"  # 左側だけの場合も降順
    elsif upper_right.present?
      notation << "#{upper_right}⌟"  # 右側だけの場合も昇順
    end
  
    # 下顎の処理
    if lower_left.present? && lower_right.present?
      notation << "#{lower_right}⊤#{lower_left}"
    elsif lower_left.present?
      notation << "⌜#{lower_left}"  # 左側だけの場合も降順
    elsif lower_right.present?
      notation << "#{lower_right}⌝"  # 右側だけの場合も昇順
    end
  
    notation.join(" ")
  end
end