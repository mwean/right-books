dependencies = [
  'templates',
  'angular-redactor',
  'multi-select',
  'ui.sortable'
]

app = angular.module('rightBooks', dependencies)

redactorConfig = (redactorOptions) ->
  redactorOptions.buttons = ['bold', 'italic', 'link']
  redactorOptions.plugins = ['blockquoteButton']

redactorConfig.$inject = ['redactorOptions']
app.config(redactorConfig)
