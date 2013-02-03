class Lab::BaseController < ApplicationController
  before_filter :authenticate_technician!
  
end