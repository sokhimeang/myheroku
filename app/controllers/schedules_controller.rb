class SchedulesController < ApplicationController
  def index
    @schedules = schedule_search params[:search]
  end

  def edit; end

  def show
    @schedule = Schedule.find_by id: params[:id]
    @users = @schedule.users.paginate page: params[:page], per_page:
      Settings.per_page.long
  end

  def create
    times_start = params[:times_start]
    if times_start.empty?
      flash[:danger] = t "flash_create_fail"
    else
      rooms = Room.where(state: true).order(volume: :ASC)
      subjects = Subject.order_id_desc
      vertices = create_vertices subjects
      list_group = create_group vertices
      Schedule.delete_all
      scheduling(rooms, list_group, times_start)
      flash[:success] = t "flash_create"
    end
    redirect_to schedules_url
  end

  def destroy
    @schedule = Schedule.find_by id: params[:id]
    if @schedule.destroy
      flash[:success] = t "flash_delete"
    else
      flash[:danger] = t "flash_delete_fail"
    end
    redirect_to schedules_url
  end

  def schedule_search search
    if search.blank?
      Schedule.paginate page: params[:page], per_page: Settings.per_page.long
    else
      user = User.find_by(code: search)
      if user
        user.schedules.paginate page: params[:page],
          per_page: Settings.per_page.long
      else
        Schedule.paginate page: params[:page], per_page: Settings.per_page.long
      end
    end
  end

end
