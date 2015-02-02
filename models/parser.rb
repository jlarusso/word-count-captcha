class Parser
  def initialize(text)
    @text = text
  end

  # array with the last 5 words
  def excludes
    word_array = @text.split

    ((word_array.length-5)...(word_array.length)).map do |i|
      word_array[i]
    end
  end
end
