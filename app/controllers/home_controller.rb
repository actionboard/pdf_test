class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.html
      format.js do
        params[:index].to_i.times do |i|
          PdfCreateWorker.perform_async(i)
        end
      end
      format.pdf do
        render pdf: "hello#{params[:index]}"
      end
    end
  end

end
