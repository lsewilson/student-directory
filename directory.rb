def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return twice."
  #create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    students << {name: name, cohort: :August}
    puts "Now we have #{students.count} students."
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def certain_letter(students)
  puts "With which letter does the names you wish to search for begin?"
  puts "To search for all names, just hit return twice."
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
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students."
end
# nothing happens until we call the methods
students = input_students
certain_letter(students)
print_footer(students)
