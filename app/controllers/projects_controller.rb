class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  include ProjectsHelper
  before_filter :authenticate_user!
  before_filter :correct_user, :only => [:show, :destroy,:edit]
  before_filter :have_some_accounts, :only => [:new]

  def index
    @projects = current_user.projects

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
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

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @accounts = @project.user.accounts.map {|account| [account.name, account.id]}
  end

  # POST /projects
  # POST /projects.xml
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

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

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

  # DELETE /projects/1
  # DELETE /projects/1.xml
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
