class InstalledBase::InstallationsController < InstalledBase::BaseController
  
  before_filter :find_installation, except: [:index, :new, :create]
  
  def index
    respond_to do |format|
      format.html 
        @installations = Installation.order(:client_id, :location).page(params[:page]).per(10)
      format.csv { send_data Installation.to_csv, filename: "installations.csv" }
    end
  end
  
  def show
  end
  
  def new
    @installation = Installation.new
  end
  
  def create
    @installation = Installation.new(params[:installation])
    if @installation.save
      redirect_to installed_base_installations_path, flash: {success: "Installation ##{@installation.id} added."}
    else
      render :new
    end    
  end
  
  def edit
  end
  
  def update
    if @installation.update_attributes(params[:installation])
      redirect_to installed_base_installations_path, flash: {success: 'Installation was successfully updated.'}
    else
      render :edit
    end
  end
  
  def destroy
    @installation.destroy
    
    redirect_to installed_base_installations_path
  end
  
  private
  
  def find_installation
    @installation = Installation.find(params[:id])
  end
end