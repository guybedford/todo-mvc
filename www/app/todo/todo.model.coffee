define [
  'zest'
  'underscore'
], (
  $z
  _
) ->
  # private functions
  curId = 0
  getCurId = (items) ->
    return curId if not items.length
    curId = (_.max items, (item) -> item.id).id

  # public interface
  refresh: $z.fn() #refresh event
  
  load: ->
    if !localStorage.getItem 'todos-zestjs'
      localStorage.setItem 'todos-zestjs', JSON.stringify []
    
    @items = JSON.parse localStorage.getItem 'todos-zestjs'
    getCurId @items
    
    @refresh()
    
  save: ->
    localStorage.setItem 'todos-zestjs', JSON.stringify @items
    
  update: ->
    @save()
    @refresh()

  items: []
  
  filter: 'all'
  
  getItems: ->
    if @filter == 'active'
      _.filter @items, (item) -> !item.completed
    else if @filter == 'completed'
      _.filter @items, (item) -> item.completed
    else
      @items
  
  add: (title) ->
    title = title.trim()
    return if title == ''
    
    @items.push
      title: title
      completed: false
      id: ++curId
      
    @update()
    
  remove: (id) ->
    id = parseInt id
    @items = _.filter @items, (item) -> item.id != id
    @update()
    
  setTitle: (id, title) ->
    title = title.trim()
    return if title == ''    
    id = parseInt id
    
    item = _.find @items, (item) -> item.id == id
    item.title = title
    @update()
  
  setCompleted: (id, completed) ->
    id = parseInt id
    
    item = _.find @items, (item) -> item.id == id
    item.completed = completed
    @update()
    
  setAllCompleted: (completed) ->
    _.each @items, (item) ->
      item.completed = completed
    @update()
  
  clearCompleted: ->
    @items = _.filter @items, (item) -> !item.completed
    @update()
    
  completedCount: ->
    completed = _.filter @items, (item) -> item.completed
    completed.length