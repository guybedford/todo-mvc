define [
  'jquery'
  'cs!../todo.model'
  'css!./filters'
], (
  $
  Model
) ->
  options:
    id: 'filters'

  render: """
    <ul>
            <li>
                    <a class="selected" href="#/">All</a>
            </li>
            <li>
                    <a href="#/active">Active</a>
            </li>
            <li>
                    <a href="#/completed">Completed</a>
            </li>
    </ul>
  """
  
  attach: (el) ->
    el = $('a', el)
    
    $(el).click 'a', ->
      el.removeClass 'selected'
      Model.filter = $(@).addClass('selected').attr('href').split('/').pop()
      Model.refresh()
    