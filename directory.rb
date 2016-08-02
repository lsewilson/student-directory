require 'Date'

def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return twice."
  #create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please submit the following extra information for this student."

    puts "Which cohort is #{name} part of?"
    cohort = gets.chomp.capitalize
    if cohort == ""
      cohort = "August"
    else
      until Date::MONTHNAMES.include? cohort
        puts "Please enter a valid cohort."
        cohort = gets.chomp.capitalize
      end
    end
    cohort = cohort.to_sym
    puts "#{name}'s age:"
    age = gets.chomp
    puts "#{name}'s country of birth:"
    birthcountry = gets.chomp
    puts "#{name}'s hobbies:"
    hobbies = gets.chomp
    students << {name: name, info: {cohort: cohort, age: age, birth_country: birthcountry, hobbies: hobbies}}
    if students.count == 1
      puts "Now we have #{students.count} student."
    else
      puts "Now we have #{students.count} students."
    end
    # get another name from the user
    puts "Next name:"
    name = gets.chomp
  end
  students
end

def certain_letter(students)
  puts "With which letter does the names you wish to search for begin?"
  puts "To search for all names, just hit return."
  initial = gets.chomp.upcase
  initial_students = students.select {|student| student[:name][0] == initial}
  initial_students != [] ? twelve_chars(initial_students) : twelve_chars(students)
end

def twelve_chars(students)
  puts "Would you like to search only for students whose names are shorter than 12 characters? (Y/N)"
  response = gets.chomp.upcase
  short_names = students.select {|student| student[:name].length < 12}
  response == "Y" ? print(short_names) : print(students)
end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end

def print(students)
  print_header
  cohort_months = students.map{|entry| entry[:info][:cohort]}.uniq
  cohort_months.each do |month|
    puts "#{month} cohort"
    students.select{|student| student[:info][:cohort] == month
    }.each_with_index do |student, i|
      puts "#{i + 1}. #{student[:name]}"
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
students = input_students
certain_letter(students)
print_footer(students)
