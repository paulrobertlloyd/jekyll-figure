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

  it "creates a figref element" do
    expect(contents).to match /See <a href="#example">figure 1<\/a>/
  end
end
