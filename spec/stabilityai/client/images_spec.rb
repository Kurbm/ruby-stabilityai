RSpec.describe StabilityAI::Client do
  describe "#images" do
    describe "#image-to-image", :vcr do
      let(:response) do
        StabilityAI::Client.new.images.image_to_image(
          parameters: {
						image_strength: image_strength,
						init_image_mode: "IMAGE_STRENGTH",
						init_image: init_image,
						"text_prompts[0][text]": text,
						"text_prompts[0][weight]": weight,
						cfg_scale: cfg_scale,
						samples: samples,
						steps: steps,
						style_preset: style_presets
          }
        )
      end
      let(:cassette) { "images variations #{image_filename}" }
      let(:init_image) { File.join(RSPEC_ROOT, "fixtures/files", image_filename) }
      let(:image_filename) { "image.png" }
      let(:image_strength) { 0.5 }
			let(:text) { "A dog sapce comander" }
			let(:weight) { 1 }
			let(:cfg_scale) { 7 }
			let(:samples) { 1 }
			let(:steps) { 10 }
			let(:style_presets) { "origami" }

      it "succeeds" do
        VCR.use_cassette(cassette, preserve_exact_body_bytes: true) do
          r = JSON.parse(response.body)
          expect(r.dig("artifacts", 0)).to include("finishReason")
        end
      end
    end

		describe "#upscale", :vcr do
      let(:response) do
        StabilityAI::Client.new(engine_id: "/esrgan-v1-x2plus").images.upscale(
          parameters: {
						image: image
          }
        )
      end
      let(:cassette) { "images upscale #{image_filename}" }
      let(:image) { File.join(RSPEC_ROOT, "fixtures/files", image_filename) }
      let(:image_filename) { "image.png" }

      it "succeeds" do
        VCR.use_cassette(cassette, preserve_exact_body_bytes: true) do
          r = JSON.parse(response.body)
          expect(r.dig("artifacts", 0)).to include("finishReason")
        end
      end
    end
  end
end
