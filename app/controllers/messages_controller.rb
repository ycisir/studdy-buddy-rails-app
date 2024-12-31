class MessagesController < ApplicationController

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      # redirect_to request.referrer
      SendMessageJob.perform_later(@message)
    end
  end
  


  def message_params
    params.require(:message).permit(:body, :room_id, :media_file)
  end

end
