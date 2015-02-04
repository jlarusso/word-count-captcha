require 'digest/sha1'

class Parser
  attr_reader :sha, :text, :word_ary
  CHEAT_PREVENTION_KEY = "etlcbajtdmqrnehwnmtftldbfpcxbrjlhnvfswmwhquqwqheti"

  def initialize(text)
    @text = text
    @sha = generate_key_for(text)
    @word_ary = split_text(@text)
  end

  # Key is based on the text itself + a secret key that is stored server-side
  def generate_key_for(text)
    Digest::SHA1.hexdigest(text + CHEAT_PREVENTION_KEY)
  end

  # Return an array of downcased words containing only letters
  def split_text(text)
    text.split.map { |word| word.gsub(/\W+/, '').downcase }
  end

  # Return empty array if @word_ary only contains only one unique word.
  # Otherwise, return an array of excluded words roughly 10% of the total
  # non-random and evenly spaced throughout the document.
  def excluded
    word_count = @word_ary.length
    if word_count == 1
      []
    else
      excludes_count = (word_count.to_f / 10).ceil
      excludes_count.times.map do |i|
        word_index = (word_count / (i + 1)).ceil - 1
        @word_ary[word_index]
      end.uniq
    end
  end

  # Return a hash count of word frequency in @word_ary
  def freq_count
    @word_ary.inject({}) do |hash, word|
      if hash[word]
        hash[word] = hash[word] + 1
      else
        hash[word] = 1
      end

      hash
    end
  end

  # Return a hash count of word frequency ommitting words on the excludes list
  def freq_count_excluded
    exclude_list = excluded
    freq_count.reject { |k, v| exclude_list.include? k }
  end
end
