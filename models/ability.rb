class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new
#      if user.role? :admin
#         can :manage, :all
#      elsif user.role? :tramites
#        #Cuando usuario de Solo Consulta
#        can :read, Persona # Para que la opcion salga en el menu
#        can :consultar, Persona
#        can :read, Vivienda
#      else
#         can :read, :all
#      end

#      user.permissions.each do |permission|
#        can permission.action.to_sym, permission.subject_class.constantize do |subject|
#          permission.subject_id.nil? || permission.subject_id == subject.id
#        end
#      end

  end

end
