RSpec.describe "compatibility" do
  context "for moved constants" do
    describe "::Ruby::StabilityAI::VERSION" do
      it "is mapped to ::StabilityAI::VERSION" do
        expect(Ruby::StabilityAI::VERSION).to eq(StabilityAI::VERSION)
      end
    end

    describe "::Ruby::StabilityAI::Error" do
      it "is mapped to ::StabilityAI::Error" do
        expect(Ruby::StabilityAI::Error).to eq(StabilityAI::Error)
        expect(Ruby::StabilityAI::Error.new).to be_a(StabilityAI::Error)
        expect(StabilityAI::Error.new).to be_a(Ruby::StabilityAI::Error)
      end
    end

    describe "::Ruby::StabilityAI::ConfigurationError" do
      it "is mapped to ::StabilityAI::ConfigurationError" do
        expect(Ruby::StabilityAI::ConfigurationError).to eq(StabilityAI::ConfigurationError)
        expect(Ruby::StabilityAI::ConfigurationError.new).to be_a(StabilityAI::ConfigurationError)
        expect(StabilityAI::ConfigurationError.new).to be_a(Ruby::StabilityAI::ConfigurationError)
      end
    end

    describe "::Ruby::StabilityAI::Configuration" do
      it "is mapped to ::StabilityAI::Configuration" do
        expect(Ruby::StabilityAI::Configuration).to eq(StabilityAI::Configuration)
        expect(Ruby::StabilityAI::Configuration.new).to be_a(StabilityAI::Configuration)
        expect(StabilityAI::Configuration.new).to be_a(Ruby::StabilityAI::Configuration)
      end
    end
  end
end
