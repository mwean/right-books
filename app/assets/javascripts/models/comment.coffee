angular.module('rightBooks').factory 'Comment', ->
  class Comment
    constructor: (data) ->
      @id          = data.id
      @body        = data.body
      @timestamp   = data.timestamp
      @time        = moment.unix(@timestamp)
      @user        = data.user
      @date        = moment(new Date(@timestamp * 1000).setHours(0, 0, 0, 0))
      @dateInWords = @formatDate()
      @children    = _.map(data.children, (child) -> new Comment(child))
      @reply       = data.reply

    formatDate: ->
      if @time.year() == moment().year()
        @time.format('MMMM Do')
      else
        @time.format('MMMM Do, YYYY')
