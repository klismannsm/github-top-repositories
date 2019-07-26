# frozen_string_literal: true

module Github
  class Importer
    def initialize
      @params_builder = ParamsBuilder.new
    end

    def import(repositories)
      repositories_attributes = build_attributes(repositories)
      GithubRepository.create(repositories_attributes)
    end

    private

    def build_attributes(repositories)
      repositories.map do |repository|
        delete_if_exists(repository['id'])

        @params_builder.build(repository)
      end
    end

    def delete_if_exists(github_id)
      repository = GithubRepository.find_by(github_id: github_id)
      return if repository.blank?

      repository.destroy
    end
  end
end
