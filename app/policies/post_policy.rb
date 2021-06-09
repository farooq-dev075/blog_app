class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
    edit?
  end

  def edit?
    user.is_admin? || post.user == user
  end

  def destroy?
    update?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.is_admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
