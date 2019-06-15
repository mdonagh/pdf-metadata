class PdfsController < ApplicationController
  def show_metadata
    return render json: {}, status: 422 if invalid_urls?(params[:urls])
    metadata_processor = MetadataProcessor.new(params[:urls])
    render :json => metadata_processor.pdf_metadata
  end

  private

  def invalid_urls?(urls)
    http_codes = urls.map do |url|
      response = HTTParty.get(url)
      response.code
    end
    return false if http_codes.all? { |code| code == 200 }
    true
  end
end
