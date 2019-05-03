require "spec_helper"

describe(Jekyll) do
  Jekyll.logger.log_level = :error

  let(:config_overrides) { {} }
  let(:config) do
    Jekyll.configuration(
      config_overrides.merge(
        "source" => source_dir,
        "destination" => dest_dir,
        "url" => "http://example.org",
      )
    )
  end
  let(:site) { Jekyll::Site.new(config) }
  let(:contents) { File.read(dest_dir("index.html")) }
  before(:each) do
    site.process
  end

  it "creates a figure element" do
    expect(contents).to match /<figure>\n<p>Content<\/p>\n<\/figure>/
  end

  it "creates a figure element with image content" do
    expect(contents).to match /<figure>\n<p><img src="#" alt="Image" \/><\/p>\n<\/figure>/
  end

  it "creates a figure element with caption" do
    expect(contents).to match /<figure>\n<p>Content<\/p>\n  <figcaption>A caption<\/figcaption>\n<\/figure>/
  end

  it "creates a figure element with caption and class name" do
    expect(contents).to match /<figure>\n<p><strong>Markdown<\/strong> content<\/p>\n  <figcaption><em>Markdown<\/em> content<\/figcaption>\n<\/figure>/
  end

  it "creates a figure element with liquid variable for caption" do
    expect(contents).to match /<figure>\n<p>Content<\/p>\n  <figcaption>Page data<\/figcaption>\n<\/figure>/
  end

  it "creates a figure element with caption and label" do
    expect(contents).to match /<figure id="example">\n<p>Content<\/p>\n  <figcaption><em>Figure 1:<\/em> A caption<\/figcaption>\n<\/figure>/
  end

  context "with paragraphs stripped" do
    let(:config_overrides) do
      {
        "jekyll-figure" => { "paragraphs" => false },
      }
    end

    it "creates a figure element" do
      expect(contents).to match /<figure>\nContent\n<\/figure>/
    end

    it "creates a figure element with image content" do
      expect(contents).to match /<figure>\n<img src="#" alt="Image" \/>\n<\/figure>/
    end
  end
end
