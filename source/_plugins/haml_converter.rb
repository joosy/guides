module Jekyll
  require 'haml'

  class HamlContext
    def initialize(config)
      @config = config
    end

    def haml(file)
      engine = Haml::Engine.new(File.read @config['source']+"/_includes/"+file)
      engine.render self
    end
  end

  class HamlConverter < Converter
    safe true
    priority :low
 
    def matches(ext)
      ext =~ /haml/i
    end
 
    def output_ext(ext)
      ".html"
    end
 
    def convert(content)
      begin
        engine = Haml::Engine.new(content)
        engine.render(HamlContext.new @config)
      rescue StandardError => e
          puts "!!! HAML Error: " + e.message
      end
    end
  end
end

module Jekyll
  class HamlTag < Liquid::Tag

    def initialize(tag_name, path, tokens)
      super
      @path = path.strip
    end

    def render(context)
      path = context.scopes.first[@path] || @path

      begin
        engine = Haml::Engine.new(File.read context['site']['source']+'/_includes/'+path)
        engine.render(context)
      rescue StandardError => e
        puts "!!! HAML Error: " + e.message
      end
    end
  end
end

Liquid::Template.register_tag('haml', Jekyll::HamlTag)