class AppointmentsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                    :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :authenticate_user!

  def index
    @client = Client.find params[:client_id]
    @appointments = @client.appointments
  end

  def show
    @client = Client.find params[:client_id]
    @appointment = @client.appointments.find params[:id]
    @locations = @appointment.locations
  end

  def edit
  end

  def create
     @client = Client.find params[:client_id]
     @appointment = @client.appointments.build(appointment_params)
     @locations = @appointment.locations

    if @appointment.save
    	@appointment
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => @appointment.errors.full_messages,
                        :data => {} }
    end
  end

  def update
    @client = Client.find params[:client_id]
    @appointment = @client.appointments.find params[:id]
    @locations = @appointment.locations
    if @appointment.update(appointment_params)
    	@appointment
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => @appointment.errors.full_messages,
                        :data => {} }
    end
  end
    
  def destroy 
    @appointment.destroy
  end

  private
    def appointment_params
      params.require(:appointment).permit(:note, :client_id)
    end
end
