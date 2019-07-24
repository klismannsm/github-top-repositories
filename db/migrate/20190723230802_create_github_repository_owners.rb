# frozen_string_literal: true

class CreateGithubRepositoryOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :github_repository_owners do |t|
      t.string :github_login
      t.integer :github_id
      t.string :avatar_url
      t.string :gravatar_id
      t.string :url
      t.string :html_url
      t.string :followers_url
      t.string :following_url
      t.string :gists_url
      t.string :starred_url
      t.string :subscriptions_url
      t.string :organizations_url
      t.string :repos_url
      t.string :events_url
      t.string :received_events_url
      t.string :user_type
      t.boolean :site_admin

      t.timestamps null: false
    end
  end
end
