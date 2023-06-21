class SpicesController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    #GET /spices
    def index
        spices = Spice.all
        render json: spices
    end
    #POST /spices
    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end
    #UPDATE /spices
    def update
        #byebug
        spice = find_spice
        spice.update(spice_params)
        render json: spice
    end
    #DELETE /spices
    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end


    private

    def find_spice
        Spice.find_by(id: params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_not_found_response
        render json: { error: "Spice not found" }, status: :not_found
    end
end
