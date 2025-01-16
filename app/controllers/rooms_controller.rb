class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @rooms = Room.order(created_at: :desc)
    
    if params[:q].present?
      @rooms = Room.where("name LIKE ? or description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%").order(created_at: :desc)
    end

  end
  
  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    topic_name = params[:room][:topic_name]
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
