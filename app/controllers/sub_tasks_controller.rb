class SubTasksController < ApplicationController
  # GET /sub_tasks
  # GET /sub_tasks.xml
  def index
    @sub_tasks = SubTask.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sub_tasks }
    end
  end

  # GET /sub_tasks/1
  # GET /sub_tasks/1.xml
  def show
    @sub_task = SubTask.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sub_task }
    end
  end

  # GET /sub_tasks/new
  # GET /sub_tasks/new.xml
  def new
    @sub_task = SubTask.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sub_task }
    end
  end

  # GET /sub_tasks/1/edit
  def edit
    @sub_task = SubTask.find(params[:id])
  end

  # POST /sub_tasks
  # POST /sub_tasks.xml
  def create
    @sub_task = SubTask.new(params[:sub_task])

    respond_to do |format|
      if @sub_task.save
        format.html { redirect_to(@sub_task, :notice => 'Sub task was successfully created.') }
        format.xml  { render :xml => @sub_task, :status => :created, :location => @sub_task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sub_task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sub_tasks/1
  # PUT /sub_tasks/1.xml
  def update
    @sub_task = SubTask.find(params[:id])

    respond_to do |format|
      if @sub_task.update_attributes(params[:sub_task])
        format.html { redirect_to(@sub_task, :notice => 'Sub task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sub_task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_tasks/1
  # DELETE /sub_tasks/1.xml
  def destroy
    @sub_task = SubTask.find(params[:id])
    @sub_task.destroy

    respond_to do |format|
      format.html { redirect_to(sub_tasks_url) }
      format.xml  { head :ok }
    end
  end
end
