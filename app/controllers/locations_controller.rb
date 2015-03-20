class Api::V1::LocationsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                    :if => Proc.new { |c| c.request.format == 'application/json' }
  
  before_filter :authenticate_user!

  def index
    @client = Client.find params[:client_id]
    @appointment = @client.appointments.find [:app_id]
    @locations = @appointment.locations
  end

  def create
    @client = Client.find params[:client_id]
    @appointment = @client.appointments.find params[:app_id]
    @location = @appointment.locations.build(location_params)

    
    if @appointment.save
      @appointment
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => @appointment.errors.full_messages,
                        :data => {} }
    end
  end

  def show
    @client = Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :status => 404,
           :json => { :success => false,
                      :info => 'Not Found',
                      :data => {} }
  end

  def destroy
    @client = current_user.clients.find(params[:id])
    @client.destroy
  rescue ActiveRecord::RecordNotFound
    render :status => 404,
           :json => { :success => false,
                      :info => 'Not Found',
                      :data => {} }
  end

  private
    def location_params
      params.require(:location).permit(:latitude, :longitude, :app_id)
    end
end