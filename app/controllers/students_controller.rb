class StudentsController < ApplicationController
  before_action :find_student, only: %i(show edit update destroy)

  def index
    @students = Student.order_by_code.paginate page: params[:page],
      per_page: Settings.students.per_page
  end

  def show; end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new student_params

    if @student.save
      flash[:info] = t ".success"
      redirect_to root_url
    else
      flash[:danger] = t ".failed"
      render :new
    end
  end

  def edit; end

  def update
    if @student.update student_params
      flash[:success] = t ".update"
      redirect_to students_path
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    flash[:success] = t ".delete"
    redirect_to students_path
  end

  private

  def find_student
    @student = Student.find_by id: params[:id]

    return if @student
    flash[:danger] = t "nostudent"
    redirect_to root_url
  end

  def student_params
    params.require(:student).permit :code, :name, :email, :info,
      :password, :password_confirmation
  end
end
