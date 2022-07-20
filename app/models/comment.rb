class Comment < ApplicationRecord
  belongs_to :article
  # belongs_to :user

  # VALID_STATUSES = ['public', 'private']
  #
  # validates :status, inclusion: { in: VALID_STATUSES }
  #
  # def private?
  #   status == 'private'
  # end
end
