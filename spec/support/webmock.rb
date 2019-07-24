# frozen_string_literal: true

WebMock.disable_net_connect!(allow: ENV['ELASTICSEARCH_URL'])

module WebMockHelpers
  def stub_get(uri)
    stub_request(:get, uri)
  end

  def stub_post(uri)
    stub_request(:post, uri)
  end

  def stub_put(uri)
    stub_request(:put, uri)
  end

  def stub_patch(uri)
    stub_request(:patch, uri)
  end

  def stub_delete(uri)
    stub_request(:delete, uri)
  end

  def stub_head(uri)
    stub_request(:head, uri)
  end
end

RSpec.configure do |config|
  config.include WebMockHelpers
end
