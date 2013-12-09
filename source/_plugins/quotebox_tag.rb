module Jekyll
  class QuoteBox < Liquid::Block
    

    def render(context)    	
    	message = super    	
      "<div class='black_wheel'><pre>#{message}</pre></div>"
    end
  end
end

Liquid::Template.register_tag('quotebox', Jekyll::QuoteBox)
