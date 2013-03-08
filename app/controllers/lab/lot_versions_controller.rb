class Lab::LotVersionsController < Lab::BaseController
  before_filter :find_lot
  
  def new
    @lot_version = @lot.lot_versions.build(technician_id: current_technician.id)
    @lot_version.issue_version_number
    test_suite = @lot.item_master.test_suite
    if test_suite
      @lot_version.prepare_samples(test_suite)
    else
      redirect_to edit_lab_lot_path(@lot), flash: {error: "There is no test suite for item master #{@lot.item_master.code}!"}
      return
    end
  end
  
  def create
    @lot_version = @lot.lot_versions.build(params[:lot_version].merge({technician_id: current_technician.id}))
    if @lot_version.save
      redirect_to edit_lab_lot_path(@lot), flash: {success: "Lot version ##{@lot_version.version} updated."}
    else
      render :new
    end
  end
  
  def edit
    @lot_version = LotVersion.find(params[:id])
  end
  
  def update
    @lot_version = LotVersion.find(params[:id])
    if @lot_version.update_attributes(params[:lot_version].merge({technician_id: current_technician.id}))
      redirect_to edit_lab_lot_path(@lot), flash: {success: "Lot version ##{@lot_version.version} updated."}
    else
      render :edit
    end
  end
  
  private
  
  def find_lot
    @lot = Lot.find(params[:lot_id])
  end
  
end