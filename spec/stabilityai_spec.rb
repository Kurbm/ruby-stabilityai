RSpec.describe StabilityAI do
  it "has a version number" do
    expect(StabilityAI::VERSION).not_to be nil
  end

  describe "#configure" do
    let(:access_token) { "abc123" }
    let(:api_version) { "v1" }
    let(:engine_id) { "def456" }
		let(:folder) { "das123" }
    let(:custom_uri_base) { "ghi789" }
    let(:custom_request_timeout) { 25 }

    before do
      StabilityAI.configure do |config|
        config.access_token = access_token
        config.api_version = api_version
				config.engine_id = engine_id
				config.folder = folder
      end
    end

    it "returns the config" do
      expect(StabilityAI.configuration.access_token).to eq(access_token)
      expect(StabilityAI.configuration.api_version).to eq(api_version)
			expect(StabilityAI.configuration.engine_id).to eq(engine_id)
			expect(StabilityAI.configuration.folder).to eq(folder)
      expect(StabilityAI.configuration.uri_base).to eq("https://api.openai.com/")
      expect(StabilityAI.configuration.request_timeout).to eq(120)
    end

    context "without an access token" do
      let(:access_token) { nil }

      it "raises an error" do
        expect { StabilityAI::Client.new.text_to_image }.to raise_error(StabilityAI::ConfigurationError)
      end
    end

    context "with custom timeout and uri base" do
      before do
        StabilityAI.configure do |config|
          config.uri_base = custom_uri_base
          config.request_timeout = custom_request_timeout
        end
      end

      it "returns the config" do
        expect(StabilityAI.configuration.access_token).to eq(access_token)
        expect(StabilityAI.configuration.api_version).to eq(api_version)
        expect(StabilityAI.configuration.engine_id).to eq(engine_id)
				expect(StabilityAI.configuration.folder).to eq(folder)
        expect(StabilityAI.configuration.uri_base).to eq(custom_uri_base)
        expect(StabilityAI.configuration.request_timeout).to eq(custom_request_timeout)
      end
    end
  end
end
