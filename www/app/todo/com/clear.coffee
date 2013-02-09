define [
  'jquery'
  'cs!../todo.model'
  
  'css!./clear'
], (
  $
  Model
) ->
  options:
    id: 'clear-completed'

  render: """
    <button>Clear completed</button>
  """

  attach: (el) ->
    el = $(el)

    Model.refresh.on ->
      completedCount = Model.completedCount()
      if completedCount > 0
        el.removeClass 'hidden'
        el.html "Clear completed (#{completedCount})"
      else
        el.addClass 'hidden'
    
    el.click -> Model.clearCompleted()