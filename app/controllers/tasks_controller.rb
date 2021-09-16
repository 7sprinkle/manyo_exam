class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    if params[:sort_expired]
      @tasks = Task.order(expired_at: :desc)
    else
      @tasks = Task.where(status: params[:status])
    end

    if params[:search_title].present? && params[:search_status].present?
      @tasks = Task.search_title(params[:search_title]).search_status(params[:search_status])
    elsif params[:search_title].present?
      @tasks = Task.search_title(params[:search_title])
    elsif params[:search_status].present?
      @tasks = Task.search_status(params[:search_status])
    end
  end


  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
      if @task.save
        redirect_to @task, notice: "Task was successfully created."
      else
        render :new
      end
  end

  def update
    @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to task_path, notice: "Task was successfully updated."
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
    params.require(:task).permit(:title, :content, :expired_at, :status)
  end
end
