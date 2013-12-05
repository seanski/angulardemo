@AngularDemo = angular.module('AngularDemo', ['rails', 'sessionService'])

@AngularDemo.config ($httpProvider, $locationProvider) ->
  token = $('meta[name=csrf-token]').attr('content')
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = token
  $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest'

  $locationProvider.html5Mode(true);
  
  interceptor = ($location, $rootScope, $q) ->
    success = (response) ->
      response
    
    error = (response) ->
      if response.status == 401
        $rootScope.$broadcast('unauthorized')
        $location.path('/users/login')
        return response
      
      $q.reject(response)

    (promise) ->
      promise.then(success, error);
    
  $httpProvider.responseInterceptors.push(interceptor)

@AngularDemo.config ($routeProvider) ->
    $routeProvider
      .when('/', { templateUrl: '/assets/home.html', controller: 'TodoController' })
      .when('/users/login', { templateUrl: '/assets/users/login.html', controller: 'UsersController' })
      .when('/users/register', { templateUrl: '/assets/users/register.html', controller: 'UsersController' })
