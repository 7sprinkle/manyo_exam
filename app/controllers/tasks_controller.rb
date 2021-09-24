class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user, only: %i[edit update destroy]

  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.order(expired_at: :desc).page(params[:page]).per(3)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :desc).page(params[:page]).per(3)
    elsif
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(3)
    end

    if params[:search_title].present? && params[:search_status].present?
      @tasks = current_user.tasks.search_title(params[:search_title]).search_status(params[:search_status]).page(params[:page]).per(3)
    elsif params[:search_title].present?
      @tasks = current_user.tasks.search_title(params[:search_title]).page(params[:page]).per(3)
    elsif params[:search_status].present?
      @tasks = current_user.tasks.search_status(params[:search_status]).page(params[:page]).per(3)
    elsif params[:label_id].present?
      @tasks = Task.joins(:labels).where(labels:{id: params[:label_id]}).page(params[:page]).per(3)
    end
  end


  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "Task was successfully created."
      else
        render :new
      end
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:task, :title, :content, :expired_at, :status, :priority, :user, label_ids:[])
  end
end
