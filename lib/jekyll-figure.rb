module Jekyll
  module Figure

    class FigureTag < Liquid::Block
      def initialize(tag_name, markup, tokens)
        @markup = markup
        super
      end

      def render(context)
        # Gather settings
        site = context.registers[:site]
        converter = site.find_converter_instance(::Jekyll::Converters::Markdown)

        # Render any liquid variables
        markup = Liquid::Template.parse(@markup).render(context)

        # Extract tag attributes
        attributes = {}
        markup.scan(Liquid::TagAttributes) do |key, value|
          attributes[key] = value
        end

        @caption = attributes['caption']
        @class = attributes['class']

        # Caption: convert markdown and remove paragraphs
        unless @caption.nil?
          figure_caption = @caption.gsub!(/\A"|"\Z/, '')
          figure_caption = converter.convert(figure_caption).gsub(/<\/?p[^>]*>/, '').chomp
          figure_caption = "  <figcaption>#{figure_caption}</figcaption>\n"
        end

        # Class name(s)
        unless @class.nil?
          figure_class = @class.gsub!(/\A"|"\Z/, '')
          figure_class = " class\=\"#{figure_class}\""
        end

        # Content: convert markdown and remove paragraphs containing images
        figure_main = converter.convert(super(context)).gsub(/^<p>\s*((<img[^<]+?)+)\s*<\/p>(.*)/, '\\1').gsub!(/[\n]+/, "\n  ");

        # Used to escape markdown parsing rendering
        markdown_escape = "\ "

        # Render <figure>
        figure_tag =  "<figure#{figure_class}>"
        figure_tag += "#{figure_main}\n"
        figure_tag += "#{figure_caption}"
        figure_tag += "</figure>"
      end
    end

  end
end

Liquid::Template.register_tag('figure', Jekyll::Figure::FigureTag)
