RSpec.describe StabilityAI::Client do
  describe "#images" do
    describe "#generate", :vcr do
      let(:response) do
        StabilityAI::Client.new.text_to_image(
          parameters: {
            text_prompts:  [
							{
								text: prompt
							}
						],
						cfg_scale: cfg_scale,
						clip_guidance_preset: clip_guidance_preset,
						height: height,
						width: width,
						samples: samples,
						steps: steps,
						style_presets: style_presets
          }
        )
      end
      let(:cassette) { "images generate #{prompt}" }
      let(:prompt) { "A sunlit indoor lounge area with a pool containing a flamingo" }
      let(:size) { "256x256" }
      let(:cfg_scale) { 7 }
      let(:clip_guidance_preset) { "FAST_BLUE" }
      let(:height) { 512 }
      let(:width) { 512 }
      let(:samples) { 1 }
      let(:steps) { 30 }
			let(:style_presets) { "origami" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          r = JSON.parse(response.body)
          expect(r.dig("artifacts", 0)).to include("finishReason")
        end
      end
    end
  end
end
