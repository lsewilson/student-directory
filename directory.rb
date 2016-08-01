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

def certain_letter
  puts "With which letter does the names you wish to search for begin?"
  puts "To search for all names, just hit return twice."
  @initial = gets.chomp.upcase
end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end

def print(students)
  students.each_with_index do |student, index|
    if student[:name][0] == @initial
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    elsif @initial == "" || @initial == nil?
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end


def print_footer(names)
  puts "Overall, we have #{names.count} great students."
end
# nothing happens until we call the methods
students = input_students
certain_letter
print_header
print(students)
print_footer(students)
