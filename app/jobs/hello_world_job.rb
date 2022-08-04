class HelloWorldJob < ApplicationJob
  # include Sidekiq::Worker
  queue_as :default

  # def perform(row)
  #        User.import(:row)
  # end

   # def perform(row)
   #       User.import(:row)
  # end
end