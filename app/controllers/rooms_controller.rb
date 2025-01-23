class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
    # @rooms = Room.order(created_at: :desc)
    
    if params[:q].blank?
      @rooms = Room.paginate(page: params[:page]).order(created_at: :desc)
    else
      @search = Room.where("name LIKE ? or description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%").order(created_at: :desc)
      @rooms = @search.paginate(page: params[:page]).order(created_at: :desc)
    end

    unless params[:query].blank?
      @topics = Topic.where("name LIKE ?", "%#{params[:q]}%")
    end

  end
  
  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    topic_name = params[:room][:topic_name].capitalize
    @room.name = @room.name.capitalize
    @topic = Topic.find_or_create_by(name: topic_name)
    @room.topic_id = @topic.id
    if @room.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    # @participants = @room.users.uniq.count
  end



  

  private
  def room_params
    params.require(:room).permit(:topic_name, :name, :description, :topic_id)
  end
end
