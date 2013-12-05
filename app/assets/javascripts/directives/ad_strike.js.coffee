# require ../apps/angular_demo

@AngularDemo.directive 'adStrike', () ->
  {
    link: (scope, element, lattrs) ->
      scope.$watch lattrs['adStrike'], (value) ->     
        decoration = if value then 'line-through' else 'none'
        element.css('text-decoration', decoration)          
  }  
   