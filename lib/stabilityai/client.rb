module StabilityAI
  class Client
    def initialize(access_token: nil, organization_id: nil, folder: nil, engine_id: nil, uri_base: nil,
                   request_timeout: nil)
      StabilityAI.configuration.access_token = access_token if access_token
			StabilityAI.configuration.organization_id = organization_id if organization_id
      StabilityAI.configuration.engine_id = engine_id if engine_id
      StabilityAI.configuration.folder = folder if folder
      StabilityAI.configuration.uri_base = uri_base if uri_base
      StabilityAI.configuration.request_timeout = request_timeout if request_timeout
    end

    def text_to_image(parameters: {})
      StabilityAI::Client.json_post(path: "/text-to-image", parameters: parameters)
    end

    def engines
      StabilityAI::Client.get(path: "/engines/list")
    end

    def account
      StabilityAI::Client.get(path: "/user/account")
    end

    def balance
      StabilityAI::Client.get(path: "/user/balance")
    end

    def self.get(path:)
      HTTParty.get(
        get_uri(path: path),
        headers: headers,
        timeout: request_timeout
      )
    end

    def self.json_post(path:, parameters:)
      HTTParty.post(
        uri(path: path),
        headers: headers,
        body: parameters&.to_json,
        timeout: request_timeout
      )
    end

    def self.multipart_post(path:, parameters: nil)
      HTTParty.post(
        uri(path: path),
        headers: headers.merge({ "Content-Type" => "multipart/form-data" }),
        body: parameters,
        timeout: request_timeout
      )
    end

    def self.delete(path:)
      HTTParty.delete(
        uri(path: path),
        headers: headers,
        timeout: request_timeout
      )
    end

    private_class_method def self.uri(path:)
      StabilityAI.configuration.uri_base + StabilityAI.configuration.api_version + StabilityAI.configuration.folder + StabilityAI.configuration.engine_id + path
    end

    private_class_method def self.get_uri(path:)
      StabilityAI.configuration.uri_base + StabilityAI.configuration.api_version + path
    end

    private_class_method def self.headers
      {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{StabilityAI.configuration.access_token}",
				"Organization" => StabilityAI.configuration.organization_id
      }
    end

    private_class_method def self.request_timeout
      StabilityAI.configuration.request_timeout
    end
  end
end
