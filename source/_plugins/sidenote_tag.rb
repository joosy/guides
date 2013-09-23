require "pry"
module Jekyll
  class SidenoteBlock < Liquid::Block

    def initialize(tag_name, css_class, tokens)      
      super
      @css_class = css_class      
    end

    def render(context)    	
    	message = super    	
      "<div class='#{@css_class}'><p>#{message}</p></div>"
    end
  end
end

Liquid::Template.register_tag('sidenote', Jekyll::SidenoteBlock)
