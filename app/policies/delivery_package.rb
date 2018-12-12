class DeliveryPackagePolicy < ApplicationPolicy
  # [...]

  class Scope < Scope
    def resolve
      scope.all # TODO : scope to the company
    end
  end
end
