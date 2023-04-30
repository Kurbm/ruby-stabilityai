module StabilityAI
  class Images
    def initialize(access_token: nil, organization_id: nil)
      StabilityAI.configuration.access_token = access_token if access_token
      StabilityAI.configuration.organization_id = organization_id if organization_id
    end

    # def edit(parameters: {})
    #   OpenAI::Client.multipart_post(path: "/images/edits", parameters: open_files(parameters))
    # end

    def image_to_image(parameters: {})
      StabilityAI::Client.multipart_post(path: "/image-to-image", parameters: open_files(parameters))
    end

		def upscale(parameters: {})
      StabilityAI::Client.multipart_post(path: "/image-to-image/upscale", parameters: open_files(parameters))
    end
    private

    def open_files(parameters)
      parameters = parameters.merge(init_image: File.open(parameters[:init_image])) if parameters[:init_image]
			parameters = parameters.merge(image: File.open(parameters[:image])) if parameters[:image]
      parameters = parameters.merge(mask: File.open(parameters[:mask])) if parameters[:mask]
      parameters
    end
  end
end
