require 'arigato/version'

module Arigato
  class View

    TITLE = 'Special Thanks'

    attr_accessor :theme, :specs, :layout, :title

    def initialize(theme, gemfile = './Gemfile', layout = true) 
      @theme = theme
      @specs = Arigato.specs(gemfile)
      @layout = layout
      @title = TITLE
    end
    
    def render 
      @layout ? render_with_layout : render_without_layout
    end

    def render_without_layout
      content
    end

    def render_with_layout
      layout
    end

    def content
      erb(content_file).result(binding)
    end

    def layout
      erb(layout_file).result(binding)
    end

    def erb(path)
      erb = ERB.new(File.read(path), nil, '-')
      erb.filename = path
      erb 
    end

    def theme_dir
      Pathname.new(File.join(Arigato.themes_dir, theme))
    end

    def content_file
      file('content')
    end

    def layout_file
      file('layout')
    end

    def link_to(label, href, target = '_blank')
      %!<a href="#{href}" target="#{target}">#{label}</a>!
    end

    def content_for(title = nil)
    end

    def self.author(spec)
      spec.author ? "by #{spec.author}" : ''
    end

  private

    def file(name)
      File.join(theme_dir, "#{name}.html.erb")
    end

  end
end

