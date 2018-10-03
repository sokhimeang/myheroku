class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = search params[:search], Room, "code", "name"
    @room = Room.new
  end

  def show; end

  def create
    @room = Room.create room_params
    if @room.save
      flash[:success] = t "flash_create"
    else
      flash[:danger] = t "flash_create_fail"
    end
    redirect_to rooms_url
  end

  def edit
    @rooms = search params[:search], Room, "code", "name"
    render :index
  end

  def update
    if @room.update room_params
      flash[:success] = t "flash_update"
    else
      flash[:danger] = t "flash_update_fail"
    end
    redirect_to edit_room_url
  end

  def destroy
    if @room.destroy
      flash[:success] = t "flash_delete"
    else
      flash[:danger] = t "!flash_delete"
    end
    redirect_to rooms_url
  end

  def room_params
    params.require(:room).permit :code, :name, :volume, :overseer_number, :state
  end

  def set_room
    @room = Room.find_by id: params[:id]
  end
end
