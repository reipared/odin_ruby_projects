require 'date'
require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
    address: zip,
    levels: 'country',
    roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_number(phone_number)
  phone_number.gsub!(/[^\d]/,'')
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 11 && phone_number[0] == "1"
    phone_number[1..10]
  else
    "Wrong phone number!"
  end
end

def count_frequency(array)
  array.max_vy {|a| array.count(a)}
  # arr = Hash.new(0)
  # array.each { |a| arr[a] += 1}
  # array.uniq.map { |n| array.count(n)}.max
end
puts 'Event Manager Initialized.'

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
contents_size = CSV.read('event_attendees.csv').length
template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
contents_size -= 1
hour_of_day = Array.new(contents_size)
day_of_week = Array.new(contents_size)
j = 0
cal = {0 => "Sunday", 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday", 6 => "Saturday"}
contents.each do |row|

  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  reg_date = row[:regdate]
  untidy_numbers = row[:homephone]
  phone_number = clean_phone_number(row[:homephone])
  i = ((row[0].to_f/contents_size) * 100)
  puts "----------#{i.round(2)}%-----------"

  reg_date_to_print = DateTime.strptime(reg_date, "%m/%d/%Y %H:%M")
  hour_of_day[j] = req_date_to_print.hour
  day_of_week[j] = reg_date_to_print.wday
  j += 1

  # puts reg_date
  # puts "Day = #{reg_date_to_print.day} Month = #{reg_date_to_print.month} Year = #{reg_date_to_print.year}"
  # puts "Hour of day = #{reg_date_to_print.hour}"
  # puts "Day of the week = #{cal[reg_date_to_print.wday].capitalize}"

  form_letter = erb_template.result(binding)
  save_thank_you_letter(id.form_letter)
end

puts "Most active hour is: #{count_frequency(hour_of_day)}"
puts "Most active day is: #{cal[count_frequency(day_of_week)].capitalize}"