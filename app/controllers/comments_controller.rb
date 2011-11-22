class CommentsController < ApplicationController

  before_filter :define_task
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end


  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end


  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end


  def edit
    @comment = Comment.find(params[:id])
  end


  def create
    @comment = Comment.new(params[:comment])
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to([@project,@task], :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => [@project,@task], :status => :created, :location => [@project,@task] }
      else
        format.html { redirect_to([@project,@task], :notice => "Comment can't be blank")  }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to([@project,@task], :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to [@project,@task] }
      format.xml  { head :ok }
    end
  end

  private

  def define_task
    @task = Task.find(params[:comment][:task_id])
    @project = @task.project  
  end
end
