class ClientsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @clients = Client.all
  else

  end
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_path, notice: 'Successfully Added Client!'
    else
      render action: 'new'
    end
  end
  
  def show
    @client = Client.find(params[:id])
  end
  
  def edit
    @client = Client.find(params[:id])
  end
  
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def client_params
      params.require(:client).permit(:name, :address )
    end
end