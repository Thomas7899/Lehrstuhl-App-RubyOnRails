class TextAnalyzerService
  def initialize(text)
    @text = text.to_s.downcase
    @threat_words = YAML.load_file(Rails.root.join("config/threat_words.yml"))["threat_words"] rescue []
  end

    def contains_threat?
      @threat_words.any? { |word| @text.include?(word) }
    end

    def highlighted_text
      @text.gsub(/(#{@threat_words.join('|')})/i) do |match|
        "<span style='color: red; font-weight: bold;'>#{match}</span>"
      end.html_safe
    end

    def detected_words
      @threat_words.select { |word| @text.include?(word) }
    end
end
