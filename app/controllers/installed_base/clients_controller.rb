class InstalledBase::ClientsController < InstalledBase::BaseController
  
  before_filter :find_client, except: [:index, :new, :create]
  
  def index
    @clients = Client.order(:code).page(params[:page]).per(10)
  end
  
  def show
  end
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(params[:client])
    if @client.save
      redirect_to installed_base_clients_path, flash: {success: "Client ##{@client.id} added."}
    else
      render :new
    end    
  end
  
  def edit
  end
  
  def update
    if @client.update_attributes(params[:client])
      redirect_to installed_base_clients_path, flash: {success: 'Client was successfully updated.'}
    else
      render :edit
    end
  end
  
  def destroy
    @client.destroy
    
    redirect_to installed_base_clients_path
  end
  
  private
  
  def find_client
    @client = Client.find(params[:id])
  end
  
end