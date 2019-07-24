# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::TrendingRepositories do
  subject(:trending_repositories) { described_class.new(languages) }

  describe '#get' do
    subject(:result) { trending_repositories.get }

    let(:finder) { instance_double(Github::Finder) }
    let(:importer) { instance_double(Github::Importer) }

    let(:languages) { %w[ruby python] }

    let(:ruby_repositories) do
      [
        { 'id' => 100, 'name' => 'Repository1' },
        { 'id' => 200, 'name' => 'Repository2' },
      ]
    end
    let(:python_repositories) do
      [
        { 'id' => 300, 'name' => 'Repository3' },
        { 'id' => 400, 'name' => 'Repository4' },
      ]
    end
    let(:ruby_import_result) do
      [
        { 'github_id' => 100, 'name' => 'Repository1' },
        { 'github_id' => 200, 'name' => 'Repository2' },
      ]
    end
    let(:python_import_result) do
      [
        { 'github_id' => 300, 'name' => 'Repository3' },
        { 'github_id' => 400, 'name' => 'Repository4' },
      ]
    end

    before do
      allow(Github::Finder)
        .to receive(:new)
        .with(no_args)
        .and_return(finder)
      allow(Github::Importer)
        .to receive(:new)
        .with(no_args)
        .and_return(importer)

      allow(finder)
        .to receive(:find_by_language)
        .with('ruby')
        .and_return(ruby_repositories)
      allow(finder)
        .to receive(:find_by_language)
        .with('python')
        .and_return(python_repositories)
      allow(importer)
        .to receive(:import)
        .with(ruby_repositories)
        .and_return(ruby_import_result)
      allow(importer)
        .to receive(:import)
        .with(python_repositories)
        .and_return(python_import_result)
    end

    it do
      expect(result).to eq(
        [
          { language: 'ruby', repositories: ruby_import_result },
          { language: 'python', repositories: python_import_result },
        ],
      )
    end
  end
end
