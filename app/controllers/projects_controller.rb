class ProjectsController < ApplicationController
  include ProjectsHelper
  before_filter :authenticate_user!
  before_filter :correct_user, :only => [:show, :destroy,:edit, :update]
  before_filter :have_some_accounts, :only => [:new]

  def index
    @projects = current_user.projects
    @title = "Your projects:"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  def show
    @finished_tasks = @project.finished_tasks
    @current_tasks = @project.current_tasks
    @started_tasks = @project.started_tasks
    @tasks_max_count = tasks_max_count(@finished_tasks,@started_tasks,@current_tasks)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  def new
    @project = Project.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  def edit
    @accounts = @project.user.accounts.map {|account| [account.name, account.id]}
  end

  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { redirect_to new_project_path }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { redirect_to edit_project_path(@project) }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end

  private

  def correct_user
    @project = Project.find(params[:id])
    redirect_to(root_path, :notice => "Access denied!") if current_user.id != @project.user.id
  end

  def have_some_accounts
    @accounts = current_user.user_accounts
    unless @accounts.present?
        redirect_to new_account_path, :notice => "First, create an account"
    end
  end
end
