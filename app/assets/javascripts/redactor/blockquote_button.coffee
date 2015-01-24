window.RedactorPlugins ||= {}

window.RedactorPlugins.blockquoteButton = ->
  init: ->
    button = @button.add('blockquote-button', 'Quote')
    @button.addCallback(button, @blockquoteButton.quote)

  quote: ->
    @block.format('blockquote')
