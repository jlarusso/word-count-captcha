class Text
  @@texts = []

  def self.add_from_path(path)
    @@texts << File.read(path).strip
  end

  def self.all
    @@texts
  end
end
