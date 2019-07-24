# frozen_string_literal: true

module Github
  class Finder
    ApiError = Class.new(StandardError)
    JsonError = Class.new(StandardError)

    BASE_URL = 'https://api.github.com'
    LANGUAGE_ENDPOINT = '/search/repositories?sort=stars&order=desc&q=language:'

    def find_by_language(language)
      response = Excon.get(url(language))

      raise(ApiError, response.body) if response.status != 200

      body = JSON.parse(response.body)
      raise(JsonError, response.body) if body['items'].blank?

      body['items']
    end

    private

    def url(language)
      "#{BASE_URL}#{LANGUAGE_ENDPOINT}#{language}"
    end
  end
end
