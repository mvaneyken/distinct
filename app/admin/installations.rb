ActiveAdmin.register Installation do
  
  menu false
  
  collection_action :import_csv, method: :post do
    @results = Installation.import_csv(params[:file].read)
    render 'import_csv', object: @results
  end
  
end