class ApplicationController < ActionController::API
  protected

  def json_response(serializer, status: :ok)
    render json: serializer, status: status
  end

  def respond_with_errors(errors)
    render json:   { errors: ErrorSerializer.new(errors).serialized_json },
           status: :unprocessable_entity
  end
end
