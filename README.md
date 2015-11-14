# jekyll-figure

A liquid tag for Jekyll that generates `<figure>` elements.

[![Gem Version](https://img.shields.io/gem/v/jekyll-figure.svg)](https://rubygems.org/gems/jekyll-figure)
[![Build Status](https://img.shields.io/travis/paulrobertlloyd/jekyll-figure/master.svg)](https://travis-ci.org/paulrobertlloyd/jekyll-figure)

## Installation

1. Add `gem 'jekyll-figure'` to your site’s Gemfile and run `bundle`
2. Add the following to your site’s `_config.yml`:

```yml
gems:
  - jekyll-figure
```

## Usage

This plugin provides a liquid tag that enables you to generate a `<figure>` element. It takes optional `caption` and `class` parameters.

```
{% figure [caption:"Caption (markdown)"] [class:"class1 class2"] %}
Figure content (markdown)
{% endfigure %}
```

### Examples

In simplest usage:

```
{% figure %}
Content
{% endfigure %}
```

```html
<figure>
  <p>Content</p>
</figure>
```

If a figure contains an image (or multiple images), the surrounding `<p>` will be stripped:

```
{% figure %}
![Image](/path/to/image.jpg)
{% endfigure %}
```

```html
<figure>
  <img src="/path/to/image.jpg" alt="Image" />
</figure>
```

You can provide a caption. Any markdown will be rendered:

```
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

You can also provide a class name(es) for CSS styling:

```
{% figure caption:"A caption" | class:"classname" %}
Content
{% endfigure %}
```

```html
<figure class="classname">
  <p>Content</p>
  <figcaption>A caption</figcaption>
</figure>
```

Finally, the `caption` parameter will accept liquid ouput markup:

```
{% figure caption:"{{ page.title }}" %}
Content
{% endfigure %}
```

```html
<figure>
  <p>Content</p>
  <figcaption>The title of my post</figcaption>
</figure>
```

## Testing

1. `script/bootstrap`
2. `script/cibuild`

## Contributing

1. Fork the project
2. Create a descriptively named feature branch
3. Add your feature
4. Submit a pull request
