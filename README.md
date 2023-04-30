# Ruby Stability.ai
[![Gem Version](https://badge.fury.io/rb/ruby-stabilityai.svg)](https://badge.fury.io/rb/ruby-stabilityai)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/kurbm/ruby-stabilityai/blob/main/LICENSE.txt)

Use the [Stability.ai API](https://platform.stability.ai/) with Ruby! 🤖❤️

Generate images with Stability AI, get engines, accounts and balance

[Ruby AI Builders Discord](https://discord.gg/k4Uc224xVD)

### Bundler

Add this line to your application's Gemfile:

```ruby
gem "ruby-stabilityai"
```

And then execute:

$ bundle install

### Gem install

Or install with:

$ gem install ruby-stabilityai

and require with:

```ruby
require "stabilityai"
```


## Usage

- Get your API key from [https://beta.dreamstudio.ai/account](https://beta.dreamstudio.ai/account)


### Quickstart

For a quick test you can pass your token directly to a new client:

```ruby
client = StabilityAI::Client.new(access_token: "access_token_goes_here")
```

### With Config

For a more robust setup, you can configure the gem with your API keys, for example in an `stabilityai.rb` initializer file. Never hardcode secrets into your codebase - instead use something like [dotenv](https://github.com/motdotla/dotenv) to pass the keys safely into your environments.

```ruby
StabilityAI.configure do |config|
    config.access_token = ENV.fetch('STABILITYAI_ACCESS_TOKEN')
    config.organization_id = ENV.fetch('STABILITYAI_ORGANIZATION_ID') # Optional.
end
```

Then you can create a client like this:

```ruby
client = StabilityAI::Client.new
```

#### Custom timeout and engine

The default timeout for any Stability.ai request is 120 seconds. You can change that passing the `request_timeout` when initializing the client.

```ruby
client = StabilityAI::Client.new(
    access_token: "access_token_goes_here",
    request_timeout: 240,
		engine_id: "/stable-diffusion-v1-5"
)
```

or when configuring the gem:

```ruby
StabilityAI.configure do |config|
    config.access_token = ENV.fetch("STABILITYAI_ACCESS_TOKEN")
    config.organization_id = ENV.fetch("STABILITYAI_ORGANIZATION_ID") # Optional
		config.engine_id = "/stable-diffusion-v1-5"
    config.request_timeout = 240 # Optional
end
```

### Engines

There are different engines that can be used to generate images. For a full list:

```ruby
client.engines
```

#### Examples

- V1
  - stable-diffusion-v1
  - stable-diffusion-v1-5
- V2
  - stable-diffusion-512-v2-0
  - stable-diffusion-768-v2-0

### Account

Get an overview of accounts connected to your user:

```ruby
response = client.account
puts response
# => "{"email":"email@email.com","id":"user-abcdefghijklmn","organizations":[{"id":"org-abcdefghijklmn","is_default":true,"name":"Personal","role":"OWNER"}],"profile_picture":"https://lh3.googleusercontent.com/a/abcdefghijklmn"}"
```

### Balance

Get feedback, how much balance is left in your account:

```ruby
response = client.balance
puts response
# => {"credits":1001.73012}
```

### Text To Image

Send a string and additional settings to create your image:

```ruby
client = StabilityAI::Client.new(engine_id: "/stable-diffusion-xl-beta-v2-2-2")
response = client.text_to_image(
			parameters: {
					text_prompts:  [
						{
							text: "A red candle"
						}
					],
					cfg_scale: 7,
					clip_guidance_preset: "FAST_BLUE",
					height: 512,
					width: 512,
					samples: 1,
					steps: 30
			}
		)
		data = response.dig("artifacts", 0, "base64")
# => Outputs base64 string, which can be used in an image tag like this <img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAgAAAAIACAIAAAB7GkOtAAACEmVYSWZNTQAq..."">
```

![Ruby](https://i.ibb.co/4mvDFG3/flamingo.png)

### Parameters, which can be set

- height
- width
- text_prompts (required)
- cfg_scale
  - Default: 7
	- Between 0 and 35
- clip_guidance_preset
  - Default: None
	- FAST_BLUE
	- FAST_GREEN
	- NONE
	- SIMPLE
	- SLOW
	- SLOWER
	- SLOWEST
- sampler
  - DDIM
	- DDPM
	- K_DPMPP_2M
	- K_DPMPP_2S_ANCESTRAL
	- K_DPM_2
	- K_DPM_2_ANCESTRAL
	- K_EULER
	- K_EULER_ANCESTRAL
	- K_HEUN
	- K_LMS
- samples (Number of images to generate)
  - Default: 1
	- Between 1 and 10
- seed
  - Default: 0
	- Random noise seed (omit this option or use 0 for a random seed)
- steps
  - Default: 50
	- Between: 10 and 150
	- Number of diffusion steps to run
- style_preset
  - 3d-model
	- analog-film
	- anime
	- cinematic
	- comic-book
	- digital-art
	- enhance
	- fantasy-art
	- isometric
	- line-art
	- low-poly
	- modeling-compound
	- neon-punk
	- origami
	- photographic
	- pixel-art
	- tile-texture

More information can be found here: [Stability AI Text to Image](https://platform.stability.ai/rest-api#tag/v1generation/operation/textToImage)


### Image to Image

Create n variations of an image.

```ruby
client = StabilityAI::Client.new(engine_id: "/stable-diffusion-xl-beta-v2-2-2")
response = client.images.image_to_image(
			parameters: {
				image_strength: 0.35,
				init_image_mode: "IMAGE_STRENGTH",
				init_image: "image.png",
				"text_prompts[0][text]": "A dog space commanger",
				"text_prompts[0][weight]": 1,
				cfg_scale: 7,
				samples: 1,
				steps: 30,
				style_preset: "origami"
			}
		)
		data = response.dig("artifacts", 0, "base64")
# => Outputs base64 string, which can be used in an image tag like this <img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAgAAAAIACAIAAAB7GkOtAAACEmVYSWZNTQAq..."">
```

Original Image:

![Ruby](https://i.ibb.co/cxvwPv8/Flamingo-Variation-original.png)

Image variation:

![Ruby](https://i.ibb.co/28T2Bt8/Flamingo-Variations.png)


### Parameters, which can be set

- text_prompts (required)
- cfg_scale
  - Default: 7
	- Between 0 and 35
- init_image (required)
- init_image_mode
  - image_strength
	- step_schedule_*
	  - step_schedule_start
		  - Default: 0.65
			- Between 0 and 1
		- step_schedule_end
			- Between 0 and 1
- clip_guidance_preset
  - Default: None
	- FAST_BLUE
	- FAST_GREEN
	- NONE
	- SIMPLE
	- SLOW
	- SLOWER
	- SLOWEST
- sampler
  - DDIM
	- DDPM
	- K_DPMPP_2M
	- K_DPMPP_2S_ANCESTRAL
	- K_DPM_2
	- K_DPM_2_ANCESTRAL
	- K_EULER
	- K_EULER_ANCESTRAL
	- K_HEUN
	- K_LMS
- samples (Number of images to generate)
  - Default: 1
	- Between 1 and 10
- seed
  - Default: 0
	- Random noise seed (omit this option or use 0 for a random seed)
- steps
  - Default: 50
	- Between: 10 and 150
	- Number of diffusion steps to run
- style_preset
  - 3d-model
	- analog-film
	- anime
	- cinematic
	- comic-book
	- digital-art
	- enhance
	- fantasy-art
	- isometric
	- line-art
	- low-poly
	- modeling-compound
	- neon-punk
	- origami
	- photographic
	- pixel-art
	- tile-texture

More information can be found here: [Stability AI Image to Image](https://platform.stability.ai/rest-api#tag/v1generation/operation/imageToImage)


### Upscale an image

Create a higher resolution version of an input image.

By default, the input image will be upscaled by a factor of 2. For additional control over the output dimensions, a width or height parameter may be specified.

Engine Id to be used: "esrgan-v1-x2plus"

```ruby
client = StabilityAI::Client.new(engine_id: "/esrgan-v1-x2plus")
response = client.images.upscale(
			parameters: {
				image: "image.png"
			}
		)
		data = response.dig("artifacts", 0, "base64")
# => Outputs base64 string, which can be used in an image tag like this <img src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAgAAAAIACAIAAAB7GkOtAAACEmVYSWZNTQAq..."">
```

Original Image:

![Ruby](https://i.ibb.co/4mvDFG3/flamingo.png)

Upscaled Image:

![Ruby](https://i.ibb.co/y6J01J7/flamingo-upscale.png)

### Parameters, which can be set

- image (required)
- height
- width

More information can be found here: [Stability AI Image Upscale](https://platform.stability.ai/rest-api#tag/v1generation/operation/upscaleImage)
