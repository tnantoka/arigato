require 'arigato/version'
require 'arigato/cli'
require 'arigato/view'

module Arigato
  class << self
    def themes_dir
      Pathname.new(File.join(File.dirname(__FILE__), 'arigato', 'themes'))
    end

    def specs(file)
      path = Pathname.new(file)
      dsl = Bundler::Dsl.new
      dsl.eval_gemfile(file)
      specs = dsl.to_definition(nil, {}).specs.to_a

      specs.unshift(self.spec('Ruby', 'http://www.ruby-lang.org/', 'Yukihiro Matsumoto'))

      specs.reject { |spec| spec.name == 'arigato' }
    end

    def specs_array(file, labeld = true)
      specs(file).map do |spec|
        {
          name: spec.name,
          homepage: spec.homepage,
          author: spec.author
        }
      end
    end

    def specs_hash(file)
      hash = {}
      specs(file).each do |spec|
        hash[spec.name] = {
          homepage: spec.homepage,
          author: spec.author
        }
      end
      hash
    end

    def spec(name, homepage, author)
      Gem::Specification.new do |gem|
        gem.name          = name
        gem.authors       = [author]
        gem.homepage      = homepage
      end
    end

  end
end

