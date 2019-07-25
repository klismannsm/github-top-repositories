# frozen_string_literal: true

class GithubRepositoriesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: GithubRepositoryDatatable.new(params) }
    end
  end

  def import
    @repositories = Github::TrendingRepositories.new(languages).get

    redirect_to github_repositories_path
  end

  def destroy_all
    GithubRepository.destroy_all

    redirect_to github_repositories_path
  end

  private

  def languages
    %w[python ruby c%23 javascript elixir]
  end
end
