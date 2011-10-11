class Import < ActiveRecord::Base
  # Paperclip
  has_attached_file :csv
#    :storage => :s3,
#    :bucket => 'ptotem_dialogue',
#    :s3_credentials => {
#    :access_key_id => ENV['S3_KEY'],
#    :secret_access_key => ENV['S3_SECRET'],
#  }
  validates_attachment_presence :csv ,:message=>"Please attach a file first ! "
	validates_attachment_content_type :csv, :content_type => ['text/csv','text/comma-separated-values','text/csv','application/csv','application/excel','application/vnd.ms-excel','application/vnd.msexcel','text/anytext','text/plain']
end