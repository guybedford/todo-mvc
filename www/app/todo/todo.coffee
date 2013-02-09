define [
  'jquery'
  'cs!./todo.model'
  
  'cs!./com/new'
  'cs!./com/toggle'
  'cs!./com/todo-list'
  'cs!./com/count'
  'cs!./com/filters'
  'cs!./com/clear'
  
  'is!app/ie-detect?ie-shims'
  
  'css!./todo'
], (
  $
  Model
  
  New
  Toggle
  TodoList
  Count
  Filters
  Clear
) ->
  "use strict"
  
  options:
    id: 'todoapp'

  render: """  
    <section>
            <header id="header">
                    <h1>todos</h1>
                    {`header`}
            </header>
            <section id="main" class="hidden">
                    {`main`}
            </section>
            <footer id="footer" class="hidden">
                    {`footer`}
            </footer>
    </section>
    <footer id="info">
        <p>Double-click to edit a todo</p>
        <p>Created by <a href="http://zestjs.org">Guy Bedford</a></p>
        <p>Part of <a href="http://todomvc.com">TodoMVC</a></p>
    </footer>  
  """
  
  header: [New]
  main: [TodoList]
  footer: [Count, Filters, Clear]
    
  attach: (el) ->
    $main = $('#main', el)
    $footer = $('#footer', el)
    
    # add functionality to hide or show regions when no items
    Model.refresh.on ->
      if !Model.items.length
        $main.addClass 'hidden'
        $footer.addClass 'hidden'
      else
        $main.removeClass 'hidden'
        $footer.removeClass 'hidden'
    
    # load any data from the model, which will push a refresh to the views
    Model.load()