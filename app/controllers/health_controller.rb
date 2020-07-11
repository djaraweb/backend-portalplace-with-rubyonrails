class HealthController < ApplicationController
  def health
    render json: {api: 'OK'}, status: 200
  end
end