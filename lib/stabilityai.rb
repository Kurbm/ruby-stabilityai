require "httparty"

require_relative "stabilityai/client"
require_relative "stabilityai/version"

module StabilityAI
  class Error < StandardError; end
  class ConfigurationError < Error; end

  class Configuration
    attr_writer :access_token
    attr_accessor :api_version, :organization_id, :folder, :uri_base, :engine_id, :request_timeout

    DEFAULT_API_VERSION = "/v1".freeze
    DEFAULT_ENGINE_ID = "/stable-diffusion-v1-5".freeze
    DEFAULT_FOLDER = "/generation".freeze
    DEFAULT_URI_BASE = "https://api.stability.ai".freeze
    DEFAULT_REQUEST_TIMEOUT = 120

    def initialize
      @access_token = nil
			@organization_id = nil
      @api_version = DEFAULT_API_VERSION
      @engine_id = DEFAULT_ENGINE_ID
      @folder = DEFAULT_FOLDER
      @uri_base = DEFAULT_URI_BASE
      @request_timeout = DEFAULT_REQUEST_TIMEOUT
    end

    def access_token
      return @access_token if @access_token

      error_text = "StabilityAI access token missing! See https://github.com/kurbm/ruby-stabilityai#usage"
      raise ConfigurationError, error_text
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= StabilityAI::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
