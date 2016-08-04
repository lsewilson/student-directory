require 'Date'

@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save student list"
  puts "4. Load student list"
  puts "5. Print source code"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      puts "What do you want to save the file as?"
      filename = STDIN.gets.chomp
      save_students(filename)
    when "4"
      puts "What file do you want to load?"
      filename = STDIN.gets.chomp
      load_students(filename)
    when "5"
      print_source_code
    when "9"
      puts "Program ended."
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return twice."
  name = STDIN.gets.chomp   # get the first name
  while !name.empty? do # while the name is not empty, repeat this code
    puts "Which cohort is #{name} part of?"
    cohort = STDIN.gets.chomp.capitalize
    cohort == "" ? cohort = "August" : cohort = valid_cohort(cohort)
    add_info_to_array(name, cohort)
    student_count
    puts "Next name:" # get another name from the user
    name = STDIN.gets.chomp
  end
end

def valid_cohort(cohort)
  until Date::MONTHNAMES.include? cohort
    puts "Please enter a valid cohort."
    cohort = STDIN.gets.chomp.capitalize
  end
  cohort
end

def student_count
  if @students.count == 1
    puts "Now we have #{@students.count} student."
  else
    puts "Now we have #{@students.count} students."
  end
end

def add_info_to_array(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def show_students
  print_header
  print_students
  print_footer
end

def print_header
  header = "The students of each cohort at Makers Academy"
  puts header.center(header.length)
  puts "-------------".center(header.length)
end

def print_students
  if @students != []
    cohort_months = @students.map{|entry| entry[:cohort]}.uniq # Map unique cohort months to a new array
    cohort_months.each do |month|     # For each cohort, list students within cohort
      puts "#{month} cohort"
        @students.select{|student| student[:cohort] == month}.each_with_index do
        |student, i| puts "#{i + 1}. #{student[:name]}"
      end
    end
  end
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student."
  else
    puts "Overall, we have #{@students.count} great students."
  end
end

def save_students(filename)
  File.open(filename, "w") do |f|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      f.puts csv_line
    end
  end
  puts "#{filename} saved!"
end

def load_students(filename)
  File.open(filename, "r") do |f|
    f.readlines.each do |line|
      name, cohort = line.chomp.split(',')
      add_info_to_array(name, cohort)
    end
  end
  puts "#{filename} loaded!"
end

def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def print_source_code
  puts "Current file:     #{$0}"
end

try_load_students
interactive_menu
