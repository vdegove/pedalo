class DeliveryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def bulk_create?
    true
  end

  def past?
    true
  end

  def upcoming?
    true
  end

  def today?
    true
  end

  def show?
    true
  end
end
