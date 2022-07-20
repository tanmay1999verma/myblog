class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable
  has_many :likes, dependent: :destroy
  has_many :articles,dependent: :destroy
  has_many :comments,dependent: :destroy
  validates :first_name, presence: true, length: {maximum: 35}
  validates :last_name, presence: true, length: {maximum: 35}
  validates :phone_number, presence: true, uniqueness: true,
            format: {with: /\A[5-9][0-9]{9}\z/}
  validates :email, presence: true, uniqueness: true
  validates :password,
            format: { with: /\A(?=.*\d)(?=.*[A-z])(?=.*\W)[^ ]{8,}\z/}

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  require 'csv'
  def self.to_csv(options = {})
    CSV.generate( headers:true) do |csv|
      headers = ['Name', 'Posts', "Comments" ,"Likes"]
      CSV.generate_line headers
      csv << headers
      all.each do |user|
          csv << [name="#{user["first_name"]} #{user["last_name"]}",user.articles.length,user.comments.length,user.likes.length]
      end
    end
  end
  def self.to_csv2(options = {})
    CSV.generate( headers:true) do |csv|
      headers = ['Name', 'Posts', "Comments" ,"Likes"]
      CSV.generate_line headers
      csv << headers
      all.each do |user|
        if user.articles.length>10
          csv << [name="#{user["first_name"]} #{user["last_name"]}",user.articles.length,user.comments.length,user.likes.length]
        end
      end
    end
  end
end
