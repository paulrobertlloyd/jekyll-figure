require 'spec_helper'

describe(Jekyll) do
  let(:overrides) do
    {
      "source"      => source_dir,
      "destination" => dest_dir,
      "url"         => "http://example.org",
    }
  end
  let(:config) do
    Jekyll.configuration(overrides)
  end
  let(:site)     { Jekyll::Site.new(config) }
  let(:contents) { File.read(dest_dir("index.html")) }
  before(:each) do
    site.process
  end

  it "creates a figure element" do
    expect(contents).to match /<figure>\n  <p>Content<\/p>\n  \n<\/figure>/
  end

  it "creates a figure element with image content" do
    expect(contents).to match /<figure>\n  <img src="#" alt="Image" \/>\n  \n<\/figure>/
  end

  it "creates a figure element with caption" do
    expect(contents).to match /<figure>\n  <p>Content<\/p>\n  \n  <figcaption>A caption<\/figcaption>\n<\/figure>/
  end

  it "creates a figure element with caption and class name" do
    expect(contents).to match /<figure>\n  <p><strong>Markdown<\/strong> content<\/p>\n  \n  <figcaption><em>Markdown<\/em> content<\/figcaption>\n<\/figure>/
  end

  it "creates a figure element with liquid variable for caption" do
    expect(contents).to match /<figure>\n  <p>Content<\/p>\n  \n  <figcaption>Page data<\/figcaption>\n<\/figure>/
  end
end
