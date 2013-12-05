# require ../apps/angular_demo

@AngularDemo.directive 'adWarn', () ->
  {
    link: (scope, element, lattrs) ->
      scope.$watch lattrs['adWarn'], (value) ->
        today = new Date()
        theDate = new Date(value)    
        decoration = if theDate < today then 'red' else 'inherit'
        element.css('color', decoration)          
  }  
   