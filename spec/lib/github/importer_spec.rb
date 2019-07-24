# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Importer do
  subject(:importer) { described_class.new }

  describe '#import' do
    subject(:import) { importer.import(repositories) }

    context 'with no existing repositories' do
      let(:repositories) do
        [
          {
            'id' => 100,
            'name' => 'Repository1',
            'owner' => {
              'id' => 110,
              'login' => 'login1',
            },
          },
          {
            'id' => 200,
            'name' => 'Repository2',
            'owner' => {
              'id' => 210,
              'login' => 'login2',
            },
          },
        ]
      end
      let(:params) do
        [
          {
            'github_id' => 100,
            'name' => 'Repository1',
            'github_repository_owner_attributes' => {
              'github_id' => 110,
              'github_login' => 'login1',
            },
          },
          {
            'github_id' => 200,
            'name' => 'Repository2',
            'github_repository_owner_attributes' => {
              'github_id' => 210,
              'github_login' => 'login2',
            },
          },
        ]
      end

      let(:params_builder) { instance_double(Github::ParamsBuilder) }

      before do
        allow(Github::ParamsBuilder)
          .to receive(:new)
          .with(no_args)
          .and_return(params_builder)

        allow(params_builder)
          .to receive(:build)
          .with(repositories[0])
          .and_return(params[0])

        allow(params_builder)
          .to receive(:build)
          .with(repositories[1])
          .and_return(params[1])

        import
      end

      it { expect(GithubRepository.count).to eq(2) }
      it { expect(GithubRepository.first.github_id).to eq(repositories[0]['id']) }
      it { expect(GithubRepository.second.github_id).to eq(repositories[1]['id']) }
    end

    context 'with existing repositories' do
      let(:github_repositories) do
        GithubRepository.create!(
          'github_id' => 100,
          'name' => 'Repository1',
          'github_repository_owner_attributes' => {
            'github_id' => 110,
            'github_login' => 'login1',
          },
        )
      end

      let(:repositories) do
        [
          {
            'id' => 100,
            'name' => 'Repository1',
            'owner' => {
              'id' => 110,
              'login' => 'login1',
            },
          },
          {
            'id' => 200,
            'name' => 'Repository2',
            'owner' => {
              'id' => 210,
              'login' => 'login2',
            },
          },
        ]
      end
      let(:params) do
        [
          {
            'github_id' => 100,
            'name' => 'Repository1',
            'github_repository_owner_attributes' => {
              'github_id' => 110,
              'github_login' => 'login1',
            },
          },
          {
            'github_id' => 200,
            'name' => 'Repository2',
            'github_repository_owner_attributes' => {
              'github_id' => 210,
              'github_login' => 'login2',
            },
          },
        ]
      end

      let(:params_builder) do
        instance_double(Github::ParamsBuilder)
      end

      before do
        github_repositories

        allow(Github::ParamsBuilder)
          .to receive(:new)
          .with(no_args)
          .and_return(params_builder)

        allow(params_builder)
          .to receive(:build)
          .with(repositories[0])
          .and_return(params[0])

        allow(params_builder)
          .to receive(:build)
          .with(repositories[1])
          .and_return(params[1])

        import
      end

      it { expect(GithubRepository.count).to eq(2) }
      it { expect(GithubRepository.first.github_id).to eq(repositories[0]['id']) }
      it { expect(GithubRepository.second.github_id).to eq(repositories[1]['id']) }
    end
  end
end
