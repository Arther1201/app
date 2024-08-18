module PatientsHelper
    def convert_to_dental_notation(prosthesis_sites)
        return unless prosthesis_sites.present?
    
        prosthesis_sites.map do |site|
          case site
          when /upper_left_(\d)/
            "\\\\#{$1}\\\\｜"
          when /upper_right_(\d)/
            "｜\\\\#{$1}\\\\"
          when /lower_left_(\d)/
            "ー\\\\#{$1}\\\\"
          when /lower_right_(\d)/
            "\\\\#{$1}ー"
          else
            site
          end
        end.join(' ')
    end
end