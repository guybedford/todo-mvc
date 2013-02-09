define [
  'cs!../todo.model'
  'css!./count'
], (
  Model
) ->
  options:
    id: 'todo-count'

  render: """
    <span></span>
  """
  
  attach: (o, el) ->
    Model.refresh.on ->
      remaining = Model.items.length - Model.completedCount()
      $(el).html """
        <strong>
          #{remaining}
        </strong>
        item#{if remaining > 1 then 's' else ''} left
      """