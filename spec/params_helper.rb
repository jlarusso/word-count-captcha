module ParamsMixin
  def params_correct
    p  = Parser.new("The quick brown fox jumped over the lazy dog.")
    {
      text: p.text,
      excluded: p.excluded,
      freq_count_excluded: p.freq_count_excluded,
      text_token: p.sha
    }
  end

  def params_bad_token
    p = Parser.new("apple pear orange apple cherry")
    {
      text: p.text,
      excluded: p.excluded,
      freq_count_excluded: p.freq_count_excluded,
      text_token: 'abcd1234'
    }
  end

  def params_bad_count
    p = Parser.new("apple pear orange apple cherry")
    {
      text: p.text,
      excluded: p.excluded,
      freq_count_excluded: {"apple"=>2, "pear"=>1, "orange"=>1, "cherry"=>1},
      text_token: p.sha
    }
  end
end

RSpec.configure { |c| c.include ParamsMixin }
