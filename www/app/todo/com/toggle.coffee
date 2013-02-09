define [
  'jquery'
  'cs!../todo.model'
  'css!./toggle'
], (
  $
  Model
) ->

  render: """
    <div>
      <input id="toggle-all" type="checkbox">
      <label for="toggle-all">Mark all as complete</label>
    </div>
  """
  
  attach: (el) ->
    $checkbox = $(el).filter('input')
    
    Model.refresh.on ->
      if Model.completedCount() == Model.items.length
        $checkbox[0].checked = true
      else
        $checkbox[0].checked = false
    
    $checkbox.change ->
      Model.setAllCompleted $checkbox[0].checked