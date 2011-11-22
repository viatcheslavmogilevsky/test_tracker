class AccountsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :correct_user, :only => [:destroy,:edit,:update,:accept_request,:reject_request]

  def index
    if params[:not_all]
      @accounts = current_user.available_accounts
      @title = "Your accounts"
    else  
      @accounts = Account.all
      @title = "Listing accounts"             
    end  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end


 
  def show
    @account = Account.find(params[:id])
    @projects = @account.projects
    @members = @account.members.map {|member| member.user_id}
    @title = "Projects on this account"

    respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @account }
    end
  end


  def new
    @account = Account.new
    @user_id = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end


  def edit

  end


  def create
    @account = Account.new(params[:account])
    
    respond_to do |format|
      if @account.save
        Member.create!(:user_id => current_user.id, :account_id => @account.id, :status => true)
        format.html { redirect_to(@account, :notice => 'Account was successfully created.') }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

 
  def update
    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml  { head :ok }
    end
  end

  def send_request
    new_member = Member.new(:user_id => current_user.id, :account_id => params[:id],:status => false)
    if new_member.save
      redirect_to account_path(params[:id]), :notice => "Request was successfully sended."
    else
      redirect_to account_path(params[:id]), :notice => "Error!"  
    end
  end

  def accept_request
    if params[:member_id]
      member = Member.find(params[:member_id])
      member.update_attributes!(:status => true)
      redirect_to account_path(params[:id]), :notice => "#{member.user.name} successfully added to this account"
    else
      redirect_to account_path(params[:id]), :notice => "Error!" 
    end

  end

  def reject_request
    if params[:member_id] 
      member = Member.find(params[:member_id])
      if member.user.id != @account.user.id
        member.destroy
        redirect_to account_path(params[:id]), :notice => "#{member.user.name} removed from this account"
      else
        redirect_to account_path(params[:id]), :notice => "Error!"
      end
    else
      redirect_to account_path(params[:id]), :notice => "Error!" 
    end
  end

  private

  def correct_user
    @account = Account.find(params[:id])
    redirect_to(root_path, :notice => "Access denied!") if current_user.id != @account.user.id
  end
end
