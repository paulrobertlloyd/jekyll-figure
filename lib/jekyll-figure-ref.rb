require 'utils'

module Jekyll
  module Figure

    class FigRefTag < Liquid::Tag
      include Utils

      def initialize(tag_name, markup, tokens)
        @label = markup
        super
      end

      def render(context)
        @context = context
        print_reference(@label)
      end
    end
  end
end

Liquid::Template.register_tag("figref", Jekyll::Figure::FigRefTag)
