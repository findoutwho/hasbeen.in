class Travellers

  def self.find(username)
    username.downcase!
    source = File.join(HasBeen.datadir, "#{username}.yml")

    if File.exist? source
      tree = YAML.load(File.read source)
      tree.merge!({'username' => username.to_s})
      Traveller.new(tree) if tree.kind_of? Hash
    end
  end

  def self.find_all
    files = Dir.glob("#{HasBeen.datadir}/[^www]*.yml")
    files.sort!
    files.collect do |file|
      name = File.basename(file, ".yml")
      self.find(name)
    end
  end

end
