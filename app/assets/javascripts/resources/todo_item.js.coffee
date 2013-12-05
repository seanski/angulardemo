# require ../apps/angular_demo

@AngularDemo.factory 'TodoItem', (railsResourceFactory) -> 
  todoItems = railsResourceFactory({url: '/api/todo_items', name: 'todo_item'})