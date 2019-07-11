Gem::Specification.new do |s|
  s.name = 'active_admin-elastic_stats'
  s.version = '0.0.4'
  s.licenses = ['MIT']
  s.date = '2019-07-11'
  s.summary = 'Active Admin component to display elastic statistics.'
  s.authors = 'Datarade'
  s.files = [
    'lib/active_admin-elastic_stats.rb',
    'lib/active_admin/elastic_stats.rb'
  ]
  s.require_paths = ['lib']

  s.add_runtime_dependency 'arbre', '>= 1.1.1'
  s.add_runtime_dependency 'elasticsearch-model'
end
