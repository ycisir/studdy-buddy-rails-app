class SearchController < ApplicationController
  def index
    @results = search_for_rooms
    # debugger
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
            turbo_stream.update('rooms',
                                partial: 'rooms/rooms',
                                locals: { rooms: @results })
      end
    end
  end

  private

  def search_for_rooms
    if params[:query].blank?
      Room.all
    else
      Room.search(params[:query], fields: %i[name description], operator: 'or', match: :text_middle)
    end
  end
end