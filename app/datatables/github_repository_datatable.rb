# frozen_string_literal: true

class GithubRepositoryDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :github_repository_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # rubocop:disable Metrics/MethodLength
  def view_columns
    @view_columns ||= {
      id: {
        source: 'GithubRepository.id',
        cond: :eq,
        orderable: true,
      },
      github_id: {
        source: 'GithubRepository.github_id',
        cond: :eq,
        orderable: true,
      },
      name: {
        source: 'GithubRepository.name',
        cond: :like,
        searchable: true,
        orderable: true,
      },
      language: {
        source: 'GithubRepository.language',
        cond: :like,
        searchable: true,
        orderable: true,
      },
      stargazers_count: {
        source: 'GithubRepository.stargazers_count',
        cond: :eq,
        orderable: true,
      },
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        github_id: record.github_id,
        name: link_to(
          record.name,
          github_repository_path(record),
        ),
        language: record.language,
        stargazers_count: record.stargazers_count,
      }
    end
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Naming/AccessorMethodName
  def get_raw_records
    GithubRepository.all
  end
  # rubocop:enable Naming/AccessorMethodName
end
