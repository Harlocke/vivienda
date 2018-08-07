class NotificationsController < ApplicationController

  def index
  end

  def create
    Notifier.deliver_gmail_message
    flash[:notice] = 'Su Mensaje ha Sido Enviado'
    redirect_to root_path
  end
  
end

