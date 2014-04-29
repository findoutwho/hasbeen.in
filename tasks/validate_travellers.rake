# Validate Travellers by iterating over all available YAML files
# This should also help validating pull requests.
namespace :validate do
  desc "Validate if all travellers in /config have valid YAML"
  task :travellers => :environment do
    Dir.glob("#{HasBeen.datadir}/*.yml").all? do |file|
      begin
        YAML.parse(File.read(file))
      rescue Psych::SyntaxError => e
        puts "Error parsing #{file}'s traveller yaml: #{e.message}"
        raise "Invalid YAML file detected. Validation failed!"
      rescue Exception => e
        raise "Whoopsie. Something went wrong: [#{e}]. We're sorry."
      end
    end
  end
end

