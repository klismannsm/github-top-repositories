# frozen_string_literal: true

class GithubRepositoryOwner < ApplicationRecord
  belongs_to :github_repository_owner

  accepts_nested_attributes_for :github_repository_owner

  validates_presence_of :github_id, :name
end
