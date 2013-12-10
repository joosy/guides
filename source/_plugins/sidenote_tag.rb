module Jekyll
  class SidenoteBlock < Liquid::Block
    def initialize(tag_name, css_class, tokens)      
      super
      @css_class = css_class      
    end

    def render(context)    	
      converter = context.registers[:site].getConverterImpl(::Jekyll::Converters::Markdown)
      message   = converter.convert(super.strip)

      "<div class='#{@css_class}'>#{message}</div>"
    end
  end
end

Liquid::Template.register_tag('sidenote', Jekyll::SidenoteBlock)
