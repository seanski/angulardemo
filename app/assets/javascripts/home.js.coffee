# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@AngularDemo = angular.module('AngularDemo', ['rails'])

@AngularDemo.config ($httpProvider) ->
  token = $('meta[name=csrf-token]').attr('content')
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = token
  $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';

@AngularDemo.factory 'TodoItem', (railsResourceFactory) -> 
  todoItems = railsResourceFactory({url: '/api/todo_items', name: 'todo_item'})

@AngularDemo.controller 'TodoController', ($scope, TodoItem) ->
  $scope.todoItems = TodoItem.query()
  $scope.selectedItem = new TodoItem()
  
  $scope.new = -> $scope.selectedItem = new TodoItem()
  $scope.setSelectedItem = (todoItem) -> $scope.selectedItem = todoItem

  $scope.save = -> $scope.selectedItem.save()

  $scope.changeStatus = (todoItem) -> todoItem.save()
