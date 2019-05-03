module Jekyll
  module Figure
    module Utils

      class I18n
        @figure_i18n = {'en' => "Figure",
                        'de' => "Abbildung",
                        'sv' => "Figur",
                        'fr' => "Figure"}
        def self.figure(lang)
          return @figure_i18n[lang] if @figure_i18n.key?(lang)
          @figure_i18n['en']
        end
      end

      def lang
        return @context.registers[:page]["lang"].to_s if @context.registers[:page].key?("lang")
        "en".to_s
      end

      def figure
        return @context.registers[:page]["figure"].to_s if @context.registers[:page].key?("figure")
        I18n.figure(lang)
      end
      
      def print_figure_counter(label)
        label.gsub!(/\s/, '')
        @context.registers[:page]["figure_labels"] ||= {}
        
        if @context.registers[:page]["figure_labels"].key?(label)
          value = @context.registers[:page]["figure_labels"][label]
        else
          value = @context.registers[:page]["figure_labels"].length + 1
          @context.registers[:page]["figure_labels"][label] = value
        end
        "<em>" + figure + " " + value.to_s + ":</em> "
      end

      def print_reference(label)
        label.gsub!(/\s/, '')
        "<a href=\"\##{label.to_s}\">" + figure.downcase + " " +
          @context.registers[:page]["figure_labels"][label.to_s].to_s +
        "</a>"
      end
    end
  end
end
