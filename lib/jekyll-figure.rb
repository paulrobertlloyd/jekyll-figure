require 'utils'
require 'jekyll-figure-ref'

module Jekyll
  module Figure

    class FigureTag < Liquid::Block
      include Utils

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

        @settings = site.config["jekyll-figure"]
        @caption = attributes["caption"]
        @class = attributes["class"]
        @label = attributes["label"]
        @context = context

        # Caption: convert markdown and remove paragraphs
        unless @caption.nil?
          figure_caption = @caption.gsub!(/\A"|"\Z/, "")
          figure_caption = converter.convert(figure_caption).gsub(/<\/?p[^>]*>/, "").chomp
          figure_caption = print_figure_counter(@label) + figure_caption unless @label.nil? || @label.empty?
          figure_caption = "  <figcaption>#{figure_caption}</figcaption>\n"
        end

        # Class name(s)
        unless @class.nil?
          figure_class = @class.gsub!(/\A"|"\Z/, "")
          figure_class = " class\=\"#{figure_class}\""
        end

        figure_label = @label.nil? || @label.empty? ? "" : ' id="' + @label.gsub(/A"|"\Z/, "") + '"'
        
        # Content
        if @settings && @settings["paragraphs"] == false
          # Strip paragraphs
          figure_main = converter.convert(super(context)).gsub(/<\/?p[^>]*>/, "")
        else
          # Don't strip paragraphs
          figure_main = converter.convert(super(context))
        end

        # Used to escape markdown parsing rendering
        markdown_escape = "\ "

        # Render <figure>
        figure_tag =  "<figure#{figure_class}#{figure_label}>"
        figure_tag += "#{figure_main}"
        figure_tag += "#{figure_caption}"
        figure_tag += "</figure>"
      end
    end

  end
end

Liquid::Template.register_tag("figure", Jekyll::Figure::FigureTag)
