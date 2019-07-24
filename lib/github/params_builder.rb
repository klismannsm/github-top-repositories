# frozen_string_literal: true

module Github
  class ParamsBuilder
    COMMON_ATTRIBUTES = %w[
      name full_name private html_url description fork url forks_url keys_url collaborators_url
      teams_url hooks_url issue_events_url events_url assignees_url branches_url tags_url blobs_url
      git_tags_url git_refs_url trees_url statuses_url languages_url stargazers_url contributors_url
      subscribers_url subscription_url commits_url git_commits_url comments_url issue_comment_url
      contents_url compare_url merges_url archive_url downloads_url issues_url pulls_url
      milestones_url notifications_url labels_url releases_url deployments_url pushed_at git_url
      ssh_url clone_url svn_url homepage size stargazers_count watchers_count language has_issues
      has_projects has_downloads has_wiki has_pages forks_count mirror_url archived
      open_issues_count forks open_issues watchers default_branch score license
    ].freeze

    def build(repository)
      attributes = {
        'github_id' => repository['id'],
        'github_created_at' => repository['created_at'],
        'github_updated_at' => repository['updated_at'],
      }
      attributes.merge!(owner_attributes(repository))
      attributes.merge!(common_attributes(repository))

      attributes
    end

    def owner_attributes(repository)
      owner_id = owners[repository.dig('owner', 'id')]
      return { 'github_repository_owner_id' => owner_id } if owner_id.present?

      { 'github_repository_owner_attributes' => build_owner_attributes(repository) }
    end

    def build_owner_attributes(repository)
      {
        'github_id' => repository.dig('owner', 'id'),
        'github_login' => repository.dig('owner', 'login'),
        'user_type' => repository.dig('owner', 'type'),
      }
    end

    def common_attributes(repository)
      COMMON_ATTRIBUTES.each_with_object({}) do |attribute, attributes|
        attributes[attribute] = repository[attribute]
      end
    end

    def owners
      @owners ||= GithubRepositoryOwner
        .pluck(:id, :github_id)
        .map { |id, github_id| { github_id => id } }
        .flatten
        .first || []
    end
  end
end
