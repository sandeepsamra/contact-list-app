# require 'csv'
require 'pg'
require 'pry'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end

  # Provides functionality for managing a list of Contacts in a database.
  class << self

    def connection
      @@connection ||= PG.connect(        
        host:'localhost',
        dbname: 'contactlist',
        user: 'development',
        password: 'development' 
      )
    end

    # Returns an Array of Contacts loaded from the database.
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      contacts = []

      results = connection.exec("SELECT * FROM contacts;")
      results.each do |row|
        contact = Contact.new(
          row['id'],
          row['name'],
          row['email']
        )
        contacts.push(contact)
      end
      contacts
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      new_contact = Contact.new(name, email)
      new_contact_array = [name, email]
      CSV.open('new_contact_index.csv', 'w') do |csv_object|
        csv_object << new_contact_array
        puts "Contact successfully created"
      end
      return new_contact
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      CSV.foreach('contact_index.csv') do |row|
        if $. == id.to_i
          return row
        else
          return "Contact not found"
        end
      end
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      CSV.foreach('contact_index.csv') do |row|
        if row.include?(term)
          puts $.
          puts row
        end
      end
    end

  end

end