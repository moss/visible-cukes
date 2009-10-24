Gem::Specification.new do |s|
  s.name = 'visible-cukes'
  s.version = '0.2'
  s.date = '2009-10-24'
  s.authors = ['Moss Collum']
  s.email = 'moss.collum@gmail.com'
  s.summary = 'Capture screenshots to illustrate Cucumber steps.'
  s.homepage = 'http://github.com/moss/visible-cukes'
  s.description = 'VisibleCukes is a Cucumber formatter that saves screenshots after each Webrat step.'
  s.add_dependency 'webrat', '>= 0.5.3'
  s.add_dependency 'cucumber', '>= 0.3.102'
  s.files = ['lib/visible_cukes.rb', 'lib/webrat_extensions.rb']
end
