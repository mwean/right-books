app = angular.module('rightBooks', ['templates', 'angular-redactor', 'multi-select'])

redactorConfig = (redactorOptions) ->
  redactorOptions.buttons = ['bold', 'italic', 'link']
  redactorOptions.plugins = ['blockquoteButton']

redactorConfig.$inject = ['redactorOptions']
app.config(redactorConfig)
