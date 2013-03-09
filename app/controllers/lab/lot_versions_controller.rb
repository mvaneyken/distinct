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
      stamp_data_version(@lot_version, params[:stamp_row])
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
      stamp_data_version(@lot_version, params[:stamp_row])
      redirect_to edit_lab_lot_path(@lot), flash: {success: "Lot version ##{@lot_version.version} updated."}
    else
      render :edit
    end
  end
  
  def destroy
    @lot_version = LotVersion.find(params[:id])
    @lot_version.destroy
    
    redirect_to edit_lab_lot_path(@lot)
  end
  
  def show_results
    @lot_version = LotVersion.find(params[:lot_version_id])
  end
  
  private
  
  def find_lot
    @lot = Lot.find(params[:lot_id])
  end
  
  def stamp_data_version(lot_version, list)
    list.each do |key, value|
      if value.present?
        if value == '0'
          lot_version.samples[key.to_i].stamp_data_version!
        else
          sample = Sample.find(value)
          sample.stamp_data_version!
        end
      end
    end
  end
  
end