define [
  'zest'
  'jquery'
  'cs!../todo.model'
  
  'css!./todo-list'
], (
  $z
  $
  Model
) ->

  # todo item template - private var
  TodoItem = (o) -> """
    <li class="#{if o.completed then 'completed' else ''}" data-todoid="#{o.id}">
            <div class="view">
                    <input class="toggle" type="checkbox" #{if o.completed then 'checked' else ''}>
                    <label>#{$z.esc o.title, 'htmlText'}</label>
                    <button class="destroy"></button>
            </div>
            <input class="edit" value="#{$z.esc o.title, 'attr'}">
    </li>
  """
  
  # render component
  options:
    id: 'todo-list'

  render: """
    <ul></ul>
  """
  
  attach: (el) ->  
    
    Model.refresh.on ->
      html = ''
      # render the list of items with the TodoItem template
      items = Model.getItems()
      html += TodoItem item for item in items
      el.innerHTML = html
    
    # get todo id from any html element in the todo list
    getId = (el) -> $(el).closest('li').attr 'data-todoid'
    
    # complete editing
    completeEdit = ->
      title = @.value.trim()
      if title
        Model.setTitle getId(@), title
      else
        Model.remove getId(@)
    
    $(el)
      .on 'click', '.toggle', ->
        Model.setCompleted getId(@), !!@.checked
      
      .on 'click', '.destroy', ->
        Model.remove getId(@)
        
      .on 'dblclick', 'label', ->
        $(@).closest('li').addClass('editing').find('.edit').focus()
        
      .on 'keypress', 'input.edit', (e) ->
        if e.keyCode == 13
          completeEdit.call @
          
      .on 'blur', 'input.edit', completeEdit

