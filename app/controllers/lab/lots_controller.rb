class Lab::LotsController < Lab::BaseController
  
  before_filter :find_lot, except: [:index, :new, :create]
  
  def index
    @lots = Lot.order('created_at desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @lots }
    end  
  end
  
  def show

  end
  
  def new
    @lot = Lot.new
   end
  
  def create
    @lot = Lot.new(params[:lot])
    if @lot.save
      redirect_to new_lab_lot_lot_version_path(@lot), flash: {success: "Lot ##{@lot.id} added."}
    else
      render :new
    end    
  end
  
  def edit

  end
  
  def update
    if @lot.update_attributes(params[:lot])
      redirect_to new_lab_lot_lot_version_path(@lot), flash: {success: 'Lot was successfully updated.'}
    else
      render :edit
    end
  end
  
  def update_plus_version
    if @lot.update_attributes(params[:lot])
      redirect_to lab_lot_path(@lot), flash: {success: 'Lot was successfully updated.'}
    else
      render :edit
    end
  end
  
  def destroy
    @lot.destroy
    
    redirect_to lab_lots_path
  end
  
  private
  
  def find_lot
    @lot = Lot.find(params[:id])
  end
  
end