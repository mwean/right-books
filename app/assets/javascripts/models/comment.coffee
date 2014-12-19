angular.module('rightBooks').factory 'Comment', ->
  class Comment
    constructor: (data) ->
      @id          = data.id
      @body        = data.body
      @timestamp   = data.timestamp
      @time        = moment.unix(@timestamp)
      @userName    = data.userName
      @date        = moment(new Date(@timestamp * 1000).setHours(0, 0, 0, 0))
      @timeInWords = @time.format('M/D/YY h:mm A')
      @children    = _.map(data.children, (child) -> new Comment(child))
