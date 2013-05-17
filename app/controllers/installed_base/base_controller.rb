class InstalledBase::BaseController < ApplicationController
  before_filter :authenticate_representative!
  
  layout 'installed_base'
  
end