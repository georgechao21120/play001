  require 'csv'
  namespace :dev do

   task :import_test_csv_file => :environment do

     success = 0
     failed_records = []

     CSV.foreach("#{Rails.root}/tmp/test.csv") do |row|
       job = jobs.new(              :title => row[0],
                                    :num => row[1],
                                    :description => row[2],
                                    :seltrpos => row[3],
                                    :seltrcomp => row[4],
                                    :seltrecho => row[5],
                                    :apple => row[6],
                                    :seltredge => row[7],
                                    :seltrcalc => row[8],)

       if job.save
         success += 1
       else
         failed_records << [row, job]
       end
     end

     puts "总共汇入 #{success} 笔，失败 #{failed_records.size} 笔"

     failed_records.each do |record|
       puts "#{record[0]} ---> #{record[1].errors.full_messages}"
     end

   end
