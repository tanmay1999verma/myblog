class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  VALID_STATUSES = %w[public private]

  validates :status, inclusion: { in: VALID_STATUSES }

  # require 'csv'
  def self.to_csv3(options = {})
    CSV.generate( headers:true) do |csv|
      headers = ['Title','Description', "Comments" ,"Likes"]
      CSV.generate_line headers
      csv << headers
      all.each do |article|
          csv << [article.title,article.body,article.comments.length,article.likes.length]
      end
    end
  end

  def private?
    status == 'private'
  end
end
