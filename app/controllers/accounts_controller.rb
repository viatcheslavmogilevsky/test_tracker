class AccountsController < ApplicationController
  # GET /accounts
  # GET /accounts.xml
  before_filter :authenticate_user!
  def index
    @accounts = Account.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.xml
  def show
    @account = Account.find(params[:id])
    @projects = @account.projects
    new_member = nil
    if params[:request_from]
       new_member = Member.new(:user_id => params[:request_from], :account_id => params[:id],:status => false)
    end

    if params[:accept]
        old_member = @account.members.where(:user_id => params[:accept].to_i.abs)
        if params[:accept].to_i > 0
            old_member[0].status = true
            old_member[0].save
        else
            old_member[0].destroy    
        end     
    end
  
    respond_to do |format|
      if new_member and new_member.save
        format.html # show.html.erb
        format.xml  { render :xml => @account }
      else
        format.html {render :notice => "User has already been taken!"}
        format.xml {render :xml => @account}
      end
    end
  end

  # GET /accounts/new
  # GET /accounts/new.xml
  def new
    @account = Account.new
    @user_id = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.xml
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

  # PUT /accounts/1
  # PUT /accounts/1.xml
  def update
    @account = Account.find(params[:id])

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

  # DELETE /accounts/1
  # DELETE /accounts/1.xml
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml  { head :ok }
    end
  end
end
