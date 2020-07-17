#require 'byebug'
require 'sendgrid-ruby'
class PropertiesController < ApplicationController
  include Secured
  include SendGrid

  before_action :valid_authenticate_user, only: [:create, :update, :propertiesforuser, :destroy]

  #rescue_from Exception do |e|
  #  render json: {error: e.message}, status: :internal_error
  #end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {code: 422, error: e.message}, status: 422
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {code: 404, error: e.message}, status: 404
  end

  # GET /properties
  def index
    filter_title = params[:title]
    rows_perpage = params[:perpage].to_i
    number_page = params[:page].to_i
    totalRows = 0

    @properties = Property.paginate(page: number_page, per_page: rows_perpage).order(id: :desc)
    if !filter_title.nil? && filter_title.present?
      totalRows = Property.where("title like '%#{filter_title}%'").count
      @properties = PropertiesSearchService.search(@properties, filter_title)
    else
      totalRows = Property.all.count         
    end
    totalPages = (totalRows/rows_perpage).ceil()
    rptabody = PropertySerializer.new(@properties).serializable_hash
    rptaPagination = {
      totalPages: totalPages,
      totalItems: totalRows,
      page: number_page,
      perPage: rows_perpage
    }
    
    render json: {code: 200, body: rptabody, pagination: rptaPagination } , status: 200

  end   

  # GET /propertiesforuser [Requiere Bearer Token_autorization]
  def propertiesforuser
    filter_title = params[:title]
    rows_perpage = params[:perpage].to_i
    number_page = params[:page].to_i
    totalRows = 0
    @properties = Property.paginate(page: number_page, per_page: rows_perpage).where(user_id: Current.user.id).order(id: :desc)
    if !filter_title.nil? && filter_title.present?
      totalRows = Property.where("title like '%#{filter_title}%'").where(user_id: Current.user.id).count
      @properties = PropertiesSearchService.search(@properties, filter_title)
    else
      totalRows = Property.where(user_id: Current.user.id).count         
    end
    totalPages = (totalRows/rows_perpage).ceil()
    rptabody = PropertySerializer.new(@properties).serializable_hash
    rptaPagination = {
      totalPages: totalPages,
      totalItems: totalRows,
      page: number_page,
      perPage: rows_perpage
    }
    
    render json: {code: 200, body: rptabody, pagination: rptaPagination } , status: 200

  end   
  
  # GET /property/addvisits
  def incrementvisits
    @property = Property.find(params[:id])
    @property.visits+=1
    if @property.save
      render json: {code: 200, body: 'Se incremento el Nro de visitas'}, status: 200    
    end
  end

  # POST /property/sendemail
  def sendemail
    @property = Property.find(params[:id])
    @user = User.find(@property.user_id)    
    
    response = sendEmail_with_sendmail(@user.email,@user.name)
    render json: {code: response.status_code, body: response.body}, status: response.status_code    
    
    #UserMailer.notifications_email(@user).deliver_now
    #render json: {code: 200, body: 'Envio Email Local'}, status: 200    
  end

  # POST /create
  def create
    @property = Current.user.propertys.new(valid_params_property)

    if @property.save
      render json: {code: 200, body: 'Propiedad Grabada Correctamente'}, status: 200
    else
      render json: {code: 422, errors: @property.errors} , status: 422
    end
  end

  # GET /properties/destroy
  def destroy
    @property = Property.find(params[:id])
    if @property.destroy
      render json: {code: 200, message: 'Propiedad Borrada Correctamente'}, status: 200    
    end
  end

  private

   def valid_params_property
     params.require(:property).permit(:placehouse, :title, :mts2, :visits, :price, 
                                      :urlimage, :geolat, :geolng, :street)
   end

   def sendEmail_with_sendmail(email,name)
      
      #Enviar un correo usando SendGrid
      from = Email.new(email: 'djarabackup@gmail.com',name: 'Portal Place')
      to = Email.new(email: email)
      subject = 'Alerta por Contacto[http://portalplace.com]'

      content = Content.new(type: 'text/plain', value:  "Hola #{name}, Gracias por unirte al portal. Que tengas un gran día.")
      mail = Mail.new(from, subject, to, content)

      #sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      sg = SendGrid::API.new(api_key: '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')
      response = sg.client.mail._('send').post(request_body: mail.to_json)
   end

end