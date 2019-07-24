# frozen_string_literal: true

require_relative 'boot'

require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module GithubTopRepositories
  class Application < Rails::Application
    config.load_defaults 5.2
    config.autoload_paths << "#{Rails.root}/lib"
  end
end
