# frozen_string_literal: true

class GithubRepository < ApplicationRecord
  has_many :github_repositories

  validates_presence_of :github_login, :github_id
end
