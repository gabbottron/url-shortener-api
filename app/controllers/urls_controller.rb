class UrlsController < SecuredController
  skip_before_action :authorize_request, only: [:go]

  # attempt to redirect to the original URL
  def go
    u = Url.find_by(slug: params[:slug])
    if u != nil and u.original_url != nil and u.original_url.length > 0
      redirect_to(u.original_url)
    else
      render :json => {:error => "URL not found!"}.to_json, :status => 404
    end
  end

  def index
    urls = Url.where(user_id: user_id)

    render json: urls
  end

  def show
    url = Url.find(params[:id])
    render json: url
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def create
    # Merge the user id into the passed parameters
    url_obj = url_params.to_h.merge({user_id: user_id}.to_h)

    # create the object
    url = Url.create!(url_obj)
    
    # render the JSON payload
    render json: url, status: :created
  end

  def update
    @url = Url.where(id: params[:id].to_i, user_id: user_id).first

    if @url
      update_params = {}
      update_params[:original_url] = params[:original_url] if params.key?(:original_url)
      update_params[:slug] = params[:slug] if params.key?(:slug)
      update_params[:active] = params[:active] if params.key?(:active)
      if @url.update(update_params)
        #render :json => {:message => "URL Updated!"}, status: :ok
        render json: @url
      else
        render :json => @url.errors.to_json, status: :unprocessable_entity
      end
    else
      render :json => {:error => "URL not found!"}.to_json, :status => 404
    end
  end

  def destroy
    @url = Url.where(id: params[:id].to_i, user_id: user_id).first

    if @url
      @url.destroy
      render :json => {:message => "URL Deleted!"}, status: :ok
    else
      render :json => {:error => "URL not found!"}.to_json, :status => 404
    end
  end

  private

  # returns id of current user
  def user_id
    claims = JsonWebToken.get_userid(request.headers)
    
    claims[0]["id"].to_i
  end

  def url_params
    params.permit(:original_url, :slug, :active)
  end
end
