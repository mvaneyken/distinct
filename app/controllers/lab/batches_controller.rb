class Lab::BatchesController < Lab::BaseController
  
  before_filter :find_batch, except: [:index, :new, :create]
  
  def index
    @batches = Batch.order('created_at desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @batchs }
    end  
  end
  
  def show

  end
  
  def new
    @batch = Batch.new
  end
  
  def create
    @batch = Batch.new(params[:batch])
    if @batch.save
      redirect_to edit_lab_batch_path(@batch), flash: {success: "Batch added."}
    else
      render :new
    end    
  end
  
  def edit

  end
  
  def update
    if @batch.update_attributes(params[:batch])
      redirect_to lab_batch_path(@batch), flash: {success: 'Batch was successfully updated.'}
    else
      render :edit
    end
  end
  
  def destroy
    @batch.destroy
    
    redirect_to lab_batches_path
  end
  
  private
  
  def find_batch
    @batch = Batch.find(params[:id])
  end
  
end