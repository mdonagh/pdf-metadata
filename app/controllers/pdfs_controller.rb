class PdfsController < ApplicationController
  def show_metadata
    puts params[:urls].inspect
    metadata = MetadataProcessor.new(params[:urls])
    render :json => metadata.get_metadata
  end
end
