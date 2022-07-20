class UserController < ApplicationController
  before_action :authenticate_user!
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
         UserNotifierMailer.send_signup_email(@users).deliver
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

  end

  # def valid_password?(password)
  #   if self.legacy_password?
  #     Use Devise's secure_compare to avoid timing attacks
      # if Devise.secure_compare(self.encrypted_password, User.legacy_password(password))
      #
      #   self.password = password
      #   self.password_confirmation = password
      #   self.legacy_password = false
      #   self.save!
      #
      # else
      #   return false
      # end
    # end
    #
    # super(password)
  # end
  #
  # Put your legacy password hashing method here
  # def self.legacy_password(password)
  #   return Digest::MD5.hexdigest("#{password}-salty-herring");
  # enda

   private
   def user_params
     params.permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :role )
   end
end
