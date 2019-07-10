Gem::Specification.new do |s|
  s.name = 'elastic_stats'
  s.version = '0.0.1'
  s.date = '2019-07-05'
  s.summary = 'Gem for elastic statistics.'
  s.authors = 'Datarade'
  s.files = [
    'lib/elastic_stats.rb'
  ]
  s.require_paths = ['lib']
  s.add_development_dependency 'arbre', '>= 1.1.1'
  s.add_development_dependency 'elasticsearch-model'
end
