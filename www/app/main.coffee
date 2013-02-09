require ['zest', 'cs!app/todo/todo'], ($z, ToDo) ->
  "use strict"
  $z.render ToDo, document.body
