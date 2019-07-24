# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Finder do
  subject(:finder) { described_class.new }

  describe '#find_by_language' do
    context 'when successful' do
      subject(:repositories) { finder.find_by_language('ruby') }

      let(:api_response) do
        {
          'items' => [
            {
              'id' => 100,
              'name' => 'Repository1',
            },
          ],
        }
      end

      before do
        stub_get('https://api.github.com/search/repositories?sort=stars&order=desc&q=language:ruby')
          .to_return(status: 200, body: api_response.to_json)
      end

      it { expect(repositories).to eq(api_response['items']) }
    end

    context 'when unsuccessful' do
      subject(:repositories) { -> { finder.find_by_language('ruby') } }

      let(:api_response) do
        'Error message 1'
      end

      before do
        stub_get('https://api.github.com/search/repositories?sort=stars&order=desc&q=language:ruby')
          .to_return(status: 500, body: api_response)
      end

      it { expect(repositories).to raise_error(Github::Finder::ApiError, api_response) }
    end

    context 'when the response body does not contain the items key' do
      subject(:repositories) { -> { finder.find_by_language('ruby') } }

      let(:api_response) do
        { 'key' => 'value' }.to_json
      end

      before do
        stub_get('https://api.github.com/search/repositories?sort=stars&order=desc&q=language:ruby')
          .to_return(status: 200, body: api_response)
      end

      it { expect(repositories).to raise_error(Github::Finder::JsonError, api_response) }
    end
  end
end
