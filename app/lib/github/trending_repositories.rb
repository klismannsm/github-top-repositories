# frozen_string_literal: true

module Github
  class TrendingRepositories
    def initialize(languages)
      @languages = languages
      @finder = Finder.new
      @importer = Importer.new
    end

    def get
      @languages.map do |language|
        repositories = @finder.find_by_language(language)

        {
          language: language,
          repositories: @importer.import(repositories),
        }
      end
    end
  end
end
