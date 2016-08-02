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
    puts "#{name}'s age:"
    age = gets.chomp
    puts "#{name}'s country of birth:"
    birthcountry = gets.chomp
    puts "#{name}'s hobbies:"
    hobbies = gets.chomp
    students << {name: name, info: {cohort: :August, age: age, birth_country: birthcountry, hobbies: hobbies}}
    puts "Now we have #{students.count} students."
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
  i = 0
  while i < students.size
     puts "#{i + 1}. #{students[i][:name]} (#{students[i][:info][:cohort]} cohort)"
     i += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students."
end
# nothing happens until we call the methods
students = input_students
certain_letter(students)
print_footer(students)
