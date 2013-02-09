define [
  'cs!../todo.model'
  'css!./new'
], (
  Model
) ->
  options:
    id: 'new-todo'

  render: """
    <input placeholder="What needs to be done?" autofocus>
  """
  
  attach: (el) ->
    $(el)
      .on 'keypress', (e) ->
        if e.keyCode == 13
          Model.add @.value
          @.value = ''
          
      .on 'blur', ->
        Model.add @.value
        @.value = ''