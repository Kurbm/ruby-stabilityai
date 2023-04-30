RSpec.describe StabilityAI::Client do
  describe "#images" do
    describe "#text-to-image", :vcr do
      let(:response) do
        StabilityAI::Client.new(engine_id: "/stable-diffusion-xl-beta-v2-2-2").text_to_image(
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
						style_preset: style_preset
          }
        )
      end
      let(:cassette) { "images text to image #{prompt}" }
      let(:prompt) { "A sunlit indoor lounge area with a pool containing a flamingo" }
      let(:size) { "256x256" }
      let(:cfg_scale) { 7 }
      let(:clip_guidance_preset) { "FAST_BLUE" }
      let(:height) { 512 }
      let(:width) { 512 }
      let(:samples) { 1 }
      let(:steps) { 10 }
			let(:style_preset) { "origami" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          r = JSON.parse(response.body)
          expect(r.dig("artifacts", 0)).to include("finishReason")
        end
      end
    end
  end
end
