# frozen_string_literal: true

require 'csv'
require 'date'
require 'fileutils'
require 'yaml'

# Import the two initial narrative requirements; fail rather than silently lose coverage.
ig_root = File.expand_path(ARGV.fetch(0, '../fhir-us-quality-core'))
config = YAML.safe_load_file(File.join(ig_root, 'sushi-config.yaml'), permitted_classes: [Date])
abort 'Expected US Quality Core 1.0.0-ballot' unless config['version'] == '1.0.0-ballot'

page = 'us-quality-core-general-requirements'
source = File.read(File.join(ig_root, 'input', 'pages', "#{page}.md"))
ids = %w[usqc-patient-read usqc-patient-id-search].freeze
rows = ids.map do |id|
  matches = source.scan(/§#{Regexp.escape(id)}:([^§]+)§/).flatten
  abort "Expected exactly one marked statement for #{id}" unless matches.length == 1

  ['us-quality-core-v1.0.0-ballot', id, "#{config.fetch('canonical')}/#{page}.html##{id}",
   matches.first.strip, 'SHALL', 'Server', nil, false, nil, nil]
end

directory = File.expand_path('../lib/us_quality_core_test_kit/requirements', __dir__)
FileUtils.mkdir_p(directory)
path = File.join(directory, 'us_quality_core_test_kit_requirements.csv')
CSV.open(path, 'w') do |csv|
  csv << ['Req Set', 'ID', 'URL', 'Requirement', 'Conformance', 'Actors',
          'Sub-Requirement(s)', 'Conditionality', 'Not Tested Reason', 'Not Tested Details']
  rows.each { |row| csv << row }
end
puts "Imported #{rows.length} requirements into #{path}"
