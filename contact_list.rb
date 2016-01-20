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
    puts Contact.all
  when "show"
    puts "What is the contact ID?"
    id = gets.chomp
    found_contact = Contact.find(id)
    puts "#{found_contact.id}: #{found_contact.name}, #{found_contact.email}"
  when "search"
    puts "Please enter a search term"
    term = gets.chomp
    puts Contact.search(term)
  when "update" #ARGV = id
    puts "Please enter the id of the contact you would like to update"
    contact_id = gets.chomp
    puts "Please enter a new name"
    new_name = gets.chomp
    puts "Please enter a new email"
    new_email = gets.chomp
    the_contact = Contact.find(contact_id)
    the_contact.name = new_name
    the_contact.email = new_email
    the_contact.save
  else
    puts "Here is a list of available commands:", "new - Create a new contact", "list - List all contacts", "show - Show a contact", "search - Search contacts"
  end

end