# frozen_string_literal: true

require 'bundler/gem_tasks'

require 'github_changelog_generator/task'
GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.future_release = Motoko::VERSION
  config.header = <<~HEADER.chomp
    # Changelog

    All notable changes to this project will be documented in this file.

    The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
    and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
  HEADER
  config.exclude_labels = %w[dependencies duplicate ignore invalid question skip-changelog wont-fix wontfix]
  config.user = 'opus-codium'
  config.project = 'motoko'
  config.since_tag = 'v1.0.0'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: :spec
