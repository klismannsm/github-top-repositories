# frozen_string_literal: true

module GithubRepositoriesHelper
  def simple_fields
    %w[
      id github_id name full_name description size stargazers_count watchers_count
      language forks_count open_issues_count forks open_issues watchers default_branch
      score license
    ]
  end

  def date_fields
    %w[github_created_at github_updated_at pushed_at created_at updated_at]
  end

  def url_fields
    %w[
      homepage html_url forks_url keys_url collaborators_url teams_url hooks_url issue_events_url
      events_url assignees_url branches_url tags_url blobs_url git_tags_url git_refs_url trees_url
      statuses_url languages_url stargazers_url contributors_url subscribers_url subscription_url
      commits_url git_commits_url comments_url issue_comment_url contents_url compare_url merges_url
      archive_url downloads_url issues_url pulls_url milestones_url notifications_url labels_url
      releases_url deployments_url git_url ssh_url clone_url svn_url mirror_url
    ]
  end

  def boolean_fields
    %w[private fork archived has_issues has_projects has_downloads has_wiki has_pages]
  end

  def owner_fields
    %w[
      id github_login github_id avatar_url gravatar_id url html_url followers_url following_url
      gists_url starred_url subscriptions_url organizations_url repos_url events_url
      received_events_url user_type site_admin created_at updated_at
    ]
  end

  def format_datetime(field)
    field.to_datetime.strftime('%Y/%m/%d %H:%M:%S')
  end
end
