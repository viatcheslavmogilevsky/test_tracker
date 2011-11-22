class TasksController < ApplicationController
  before_filter :find_project
  before_filter :define_vars_for_forms, :only => [:new,:edit]
  
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  def show
    @task = Task.find(params[:id])
    @comments = @task.comments
    @comment = Comment.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => [@project,@task] }
    end
    
  end

  def new
    @task = Task.new
   
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => [@project,@task] }
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to(@project, :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => [@project,@task] }
      else
        format.html { redirect_to new_project_task_path, :notice => "Title can't be blank" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(@project, :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(project_url) }
      format.xml  { head :ok }
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])   
  end

  def define_vars_for_forms
    @estimates = [0,1,2,3,5]
    @statuses = ["Current","Started","Finished"]
    @members = @project.account.members.map {|member| [member.user.name, member.id]}
  end
end
