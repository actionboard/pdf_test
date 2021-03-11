class HomeController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "hello#{params[:index]}"
      end
    end
  end

end
