# jekyll-figure

A liquid tag for Jekyll that generates `<figure>` elements.

[![Gem version](https://img.shields.io/gem/v/jekyll-figure.svg)](https://rubygems.org/gems/jekyll-figure)
[![Build status](https://github.com/paulrobertlloyd/jekyll-figure/workflows/test/badge.svg)](https://github.com/paulrobertlloyd/jekyll-figure/actions)

## Installation

1. Add `gem 'jekyll-figure'` to your site’s Gemfile and run `bundle`
2. Add the following to your site’s `_config.yml`:

```yaml
plugins:
  - jekyll-figure
```

Note: If you are using a Jekyll version less than 3.5.0, use the `gems` key instead of `plugins`.

## Usage

This plugin provides a liquid tag that enables you to generate a `<figure>` element. It takes optional `caption` and `class` parameters.

```liquid
{% figure [caption:"Caption (markdown)"] [class:"class1 class2"] %}
Figure content (markdown)
{% endfigure %}
```

### Examples

In simplest usage:

```liquid
{% figure %}
Content
{% endfigure %}
```

```html
<figure>
  <p>Content</p>
</figure>
```

You can provide a caption, for which any markdown will be rendered:

```liquid
{% figure caption:"*Markdown* caption" %}
Content
{% endfigure %}
```

```html
<figure>
  <p>Content</p>
  <figcaption><em>Markdown</em> caption</figcaption>
</figure>
```

You can also provide a class name(s) for CSS styling:

```liquid
{% figure caption:"A caption" class:"classname" %}
Content
{% endfigure %}
```

```html
<figure class="classname">
  <p>Content</p>
  <figcaption>A caption</figcaption>
</figure>
```

The `caption` parameter also accepts liquid markup:

```liquid
{% figure caption:"{{ page.title }}" %}
Content
{% endfigure %}
```

```html
<figure>
  <p>Content</p>
  <figcaption>The title of my page</figcaption>
</figure>
```

You can add labels and reference to it.

```
{% figure caption:"This is some caption." label:myfigure %}
Content
{% endfigure %}
...
You can see in figure {% figref myfigure %}, ...
```

```html
<figure id="myfigure">
<p>Content</p>
  <figcaption><em>Figure 1:</em> This is some caption.</figcaption>
</figure>
...
<p>You can see in figure <a href="#myfigure">1</a></p>
```
The word 'Figure' in the figcaption is translated according to the `lang` you
set in the yaml header of your post.  If your language is not supported simple
set `figure` to the yaml header of your post to the value you want to use
instead of 'Figure'.



## Configuration

Any markdown provided within the `{% figure %}` block is rendered using Jekyll's Markdown parser, [Kramdown](https://kramdown.gettalong.org). However, this means images and other content will be wrapped within `<p>` tags, like so:

```html
<figure>
  <p><img src="/path/to/image.jpg" alt="Image"></p>
</figure>
```

To disable this behaviour, in your Jekyll configuration set the `paragraphs` value for this plugin to `false`:

```yaml
plugins:
  - jekyll-figure

jekyll-figure:
  paragraphs: false
```

Note however that this will remove *all* paragraph tags, even those nested within other elements.

## Testing

1. `bundle install`
2. `bundle exec rake spec`

## Contributing

1. Fork the project
2. Create a descriptively named feature branch
3. Add your feature
4. Submit a pull request
