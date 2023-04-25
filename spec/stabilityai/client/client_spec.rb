RSpec.describe StabilityAI::Client do
  let(:default_timeout) { StabilityAI::Configuration::DEFAULT_REQUEST_TIMEOUT }

  it "can be initialized" do
    expect { StabilityAI::Client.new }.not_to raise_error
  end

  describe ".get" do
    it "passes timeout as param to httparty" do
      expect(HTTParty).to receive(:get).with(any_args, hash_including(timeout: default_timeout))
      StabilityAI::Client.get(path: "abc")
    end
  end

  describe ".json_post" do
    it "passes timeout as param to httparty" do
      expect(HTTParty).to receive(:post).with(any_args, hash_including(timeout: default_timeout))
      StabilityAI::Client.json_post(path: "abc", parameters: { foo: :bar })
    end
  end

  describe ".multipart_post" do
    it "passes timeout as param to httparty" do
      expect(HTTParty).to receive(:post).with(any_args, hash_including(timeout: default_timeout))
      StabilityAI::Client.multipart_post(path: "abc")
    end
  end

  describe ".delete" do
    it "passes timeout as param to httparty" do
      expect(HTTParty).to receive(:delete).with(any_args, hash_including(timeout: default_timeout))
      StabilityAI::Client.delete(path: "abc")
    end
  end
end
