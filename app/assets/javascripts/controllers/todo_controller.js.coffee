# require ../apps/angular_demo.js.coffee

@AngularDemo.controller 'TodoController', ($scope, TodoItem) ->
  TodoItem.query().then (results) ->
    $scope.todoItems = results

  $scope.selectedItem = new TodoItem()
  
  $scope.new = -> $scope.selectedItem = new TodoItem()
  $scope.setSelectedItem = (todoItem) -> $scope.selectedItem = todoItem

  $scope.save = (todoItem) -> 
    todoItem.save().then (todoItem) -> 
      unless $scope.todoItems.find((i) -> i.id == todoItem.id)
        $scope.todoItems.push(todoItem)