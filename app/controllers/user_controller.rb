class UserController < ApplicationController
  before_action :authenticate_user!
  # include ImportFileJob
   def index
     @users = User.all
   end

   def new
     @users = User.new
   end

   def create
     @users= User.new(user_params)
     @users.add_role params[:roles]
     @users.save
     if @users.save!
       # UserNotifierMailer.send_signup_email.deliver_now
       redirect_to user_index_path
       flash[:alert] = "This User was saved successfully"
     else
       @users.errors.full_messages
     end
   end

  def deactivate
     @users= User.find(params[:id])
     if @users.access_locked?
       @users.unlock_access!
       flash[:alert] = " ID Sucessfully Activated"
     else
       @users.lock_access!
       flash[:alert] = " ID Sucessfully Deactivated"
     end
     redirect_to user_index_path
  end

  def report
    @users = User.all
     respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
      format.xlsx
     end
  end

  def sorted_report
    @users = User.all
    respond_to do |format|
       format.html
       format.csv { send_data @users.to_csv2 }
       format.xlsx
     end
  end

  def profile
    @users=current_user
  end

  def edit
    @users=User.find(params[:id])
  end

   def update
    @users = User.find(params[:id])

    if @users.update(user_params)
      redirect_to @users
    else
      render :edit, status: :unprocessable_entity
    end
  end

   def import_users
     # User.import(params[:file])
     ImportFileJob.perform_now(params[:file])
     redirect_to user_index_path
   end

   # def import_users
   #  skip = true
   #
   #  CSV.foreach(params[:file].path, headers: false) do |row|
   #    unless skip
   #      accessible_attributes = %w[first_name last_name phone_number email password]
   #      hash = Hash[accessible_attributes.zip(row)]
   #      ImportFileJob.perform_now(hash)
   #    end
   #    skip = false
   #  end
   #  redirect_to user_index_path
   # end


   private
   def user_params
     params.permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :role )
   end
end
