guard(:livereload, host: 'localhost') do
  watch(%r{app/views/.+\.slim$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})

  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|scss))).*}) { '/assets/application.css' }
  watch(%r{(app|vendor)/assets/javascripts/(\w+/)?.+\.(js|coffee)}) { '/assets/application.js' }

  # Angular templates
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(html))).*})
end
