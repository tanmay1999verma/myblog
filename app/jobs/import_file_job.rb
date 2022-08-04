class ImportFileJob < ApplicationJob
  # include Sidekiq::Importer
  queue_as :default


  # def perform(row)
  #        User.import(row)
  # end
  def perform(file)
    skip = true

    CSV.foreach(file.path, headers: false) do |row|
      unless skip
        accessible_attributes = %w[first_name last_name phone_number email password]
        hash = Hash[accessible_attributes.zip(row)]
        # ImportFileJob.perform_now(hash)
        User.import(hash)
      end
      skip = false
    end

  end

end
