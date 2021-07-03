# vim:set filetype=ruby:
# frozen_string_literal: true

SimpleCov.start do
  add_filter '/spec/'

  add_group 'Formatters', '/lib/motoko/formatters/'
  add_group 'Resolvers',  '/lib/motoko/resolvers/'
  add_group 'Utils',      '/lib/motoko/utils/'
end
