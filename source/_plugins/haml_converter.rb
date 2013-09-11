module Jekyll
  require 'haml'

  class HamlContext
    def initialize(config)
      @config = config
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