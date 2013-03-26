require 'arigato/version'

require 'thor'
require 'bundler'
require 'json'
require 'yaml'
require 'csv'

module Arigato
  class CLI < Thor
    include Thor::Actions

    HTML_DIR = 'thanks'
    HTML_FILE = File.join(HTML_DIR, 'index.html')

    map 'g' => :generate

    map '--version' => :version
    map '-v' => :version

    desc 'generate [THEME] [options]', 'Generate HTML from Gemfile'
    option :file, aliases: '-f', desc: 'Path to Gemfile', default: './Gemfile'
    def generate(theme = 'default')
      empty_directory(HTML_DIR)
      gemfile = options[:file]
      view = View.new(theme, gemfile)
      create_file(HTML_FILE, view.render)
    end

    desc '-v, [--version]', 'Prints the version'
    def version
      say "Arigato #{Arigato::VERSION}"
    end

    desc 'themes', 'Shows all themes'
    def themes
      puts Dir::entries(Arigato.themes_dir).reject { |e| e =~ /^\./ }
    end

    desc 'json [FILE]', 'Displays thanks as JSON'
    def json(file = './Gemfile')
      say JSON.pretty_generate(Arigato.specs_array(file))
    end

    desc 'yaml [FILE]', 'Displays thanks as YAML'
    def yaml(file = './Gemfile')
      say Arigato.specs_hash(file).to_yaml
    end

    desc 'csv [FILE]', 'Displays thanks as CSV'
    def csv(file = './Gemfile')
      Arigato.specs_array(file, false).each do |spec|
        say spec.values.to_csv
      end
    end

  end
end
