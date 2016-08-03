require 'Date'

def interactive_menu
  students = []
  loop do
  # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
  # 2. red the input and save it into a variable
    selection = gets.chomp
  # 3. do what the user has asked
    case selection
      when "1"
        students = input_students
      when "2"
        filter(students)
        print_footer(students)
      when "9"
        exit
      else
        puts "I don't know what you meant, try again"
    end
  end
end


def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return twice."
  #create an empty array
  students = []
  # get the first name
  name = gets.gsub(/\n/,"")
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please submit the following extra information for this student."

    puts "Which cohort is #{name} part of?"
    cohort = gets.gsub(/\n/,"").capitalize
    if cohort == ""
      cohort = "August"
    else
      until Date::MONTHNAMES.include? cohort
        puts "Please enter a valid cohort."
        cohort = gets.gsub(/\n/,"").capitalize
      end
    end
    cohort = cohort.to_sym
    puts "#{name}'s age:"
    age = gets.gsub(/\n/,"")
    puts "#{name}'s country of birth:"
    birthcountry = gets.gsub(/\n/,"")
    puts "#{name}'s hobbies:"
    hobbies = gets.gsub(/\n/,"")
    students << {name: name, info: {cohort: cohort, age: age, birth_country: birthcountry, hobbies: hobbies}}
    if students.count == 1
      puts "Now we have #{students.count} student."
    else
      puts "Now we have #{students.count} students."
    end
    # get another name from the user
    puts "Next name:"
    name = gets.gsub(/\n/,"")
  end
  students
end

def filter(students)
  puts "With which letter does the names you wish to search for begin?"
  puts "To search for all names, just hit return."
  initial = gets.gsub(/\n/,"")
  initial_students = students.select {|student| student[:name][0] == initial}
  initial_students != [] ? twelve_chars(initial_students) : twelve_chars(students)
end

def twelve_chars(students)
  puts "Would you like to search only for students whose names are shorter than 12 characters? (Y/N)"
  response = gets.gsub(/\n/,"").upcase
  short_names = students.select {|student| student[:name].length < 12}
  response == "Y" ? print(short_names) : print(students)
end

def print_header
  header = "The students of each cohort at Makers Academy"
  puts header.center(header.length)
  puts "-------------".center(header.length)
end

def print(students)
  if students != []
    print_header
    # Map unique cohort months to a new array
    cohort_months = students.map{|entry| entry[:info][:cohort]}.uniq
    # For each cohort, list students within cohort
    cohort_months.each do |month|
      puts "#{month} cohort"
      students.select{|student| student[:info][:cohort] == month}.each_with_index do
        |student, i| puts "#{i + 1}. #{student[:name]}"
      end
    end
  end
end

def print_footer(names)
  if names.count == 1
    puts "Overall, we have #{names.count} great student."
  else
    puts "Overall, we have #{names.count} great students."
  end
end
# nothing happens until we call the methods

interactive_menu
