class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, TodoItem, user_id: user.id
  end
end
