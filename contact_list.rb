require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  puts "What would you like to do?"
  command = gets.chomp

  case command
  when "new"
    puts "What is the contact's name?"
    name = gets.chomp
    puts "What is the contact's email?"
    email = gets.chomp
    Contact.create(name, email)
  when "list"
    Contact.all
  when "show"
    puts "What is the contact ID?"
    id = gets.chomp
    Contact.find(id)
  when "search"
    puts "Please enter a search term"
    term = gets.chomp
    Contact.search(term)
  else
    puts "Here is a list of available commands:", "new - Create a new contact", "list - List all contacts", "show - Show a contact", "search - Search contacts"
  end

end