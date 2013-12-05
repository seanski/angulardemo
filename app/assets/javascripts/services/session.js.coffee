@SessionService = angular.module("sessionService", [])

@SessionService.factory "Session", ($location, $http, $q) ->
  
  # Redirect to the given url (defaults to '/')
  redirect = (url) ->
    url = url or "/"
    $location.path url
  service =
    login: (email, password) ->
      $http.post("/api/users/sign_in.json",
        user:
          email: email
          password: password
      ).then (response) ->
        service.currentUser = response.data
        
        #TODO: Send them back to where they came from
        #$location.path(response.data.redirect);
        $location.path "/" if service.isAuthenticated()

    logout: (redirectTo) ->
      $http.delete("/api/users/sign_out").then ->
        service.currentUser = null
        redirect redirectTo

    register: (email, password, confirm_password) ->
      $http.post("/api/users.json",
        user:
          email: email
          password: password
          password_confirmation: confirm_password
      ).then (response) ->
        service.currentUser = response.data
        $location.path "/"  if service.isAuthenticated()

    requestCurrentUser: ->
      if service.isAuthenticated()
        $q.when service.currentUser
      else
        $http.get("/api/current_user").then (response) ->
          service.currentUser = response.data
          service.currentUser

    currentUser: null
    
    isAuthenticated: ->
      !!service.currentUser

  service
