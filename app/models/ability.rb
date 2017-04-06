class Ability
    include CanCan::Ability
    def initialize(admin)
        admin ||= AdminUser.new
        if admin.role == "Admin"
            can :manage, :all
        elsif admin.role == "TL"
            can :read, :all
        elsif admin.role == "HR"
            can :manage, :all
        else
            can :read, :all
        end    
    end
end
