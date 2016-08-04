require 'Date'

@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
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
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return twice."
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Which cohort is #{name} part of?"
    cohort = STDIN.gets.chomp.capitalize
    if cohort == ""
      cohort = "August"
    else
      until Date::MONTHNAMES.include? cohort
        puts "Please enter a valid cohort."
        cohort = STDIN.gets.chomp.capitalize
      end
    end
    add_info_to_array(name, cohort)
    if @students.count == 1
      puts "Now we have #{@students.count} student."
    else
      puts "Now we have #{@students.count} students."
    end
    # get another name from the user
    puts "Next name:"
    name = STDIN.gets.chomp
  end
end

def add_info_to_array(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def show_students
  print_header
  print
  print_footer
end

def print_header
  header = "The students of each cohort at Makers Academy"
  puts header.center(header.length)
  puts "-------------".center(header.length)
end

def print
  if @students != []
    # Map unique cohort months to a new array
    cohort_months = @students.map{|entry| entry[:cohort]}.uniq
    # For each cohort, list students within cohort
    cohort_months.each do |month|
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

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:info][:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    add_info_to_array(name, cohort)
  end
  file.close
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

try_load_students
interactive_menu
