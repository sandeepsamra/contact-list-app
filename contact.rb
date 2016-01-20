# require 'csv'
require 'pg'
require 'pry'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email, :id

  def initialize(id = nil, name, email)
    @id = id
    @name = name
    @email = email
  end

  def self.connection
    @@connection ||= PG.connect(
      host:'localhost',
      dbname: 'contactlist',
      user: 'development',
      password: 'development' 
    )
  end

  # Returns an Array of Contacts loaded from the database.
  def self.all
    contacts = []
    results = connection.exec("SELECT * FROM contacts;")
    results.each do |row|
      existing_contact = Contact.new(
        row['id'],
        row['name'],
        row['email']
      )
      contacts.push(existing_contact)
    end
    contacts.map do |x|
      "#{x.id}: #{x.name}, #{x.email}"
    end
  end

  def save(name, email)
    self.class.connection.exec_params("INSERT INTO contacts (name, email) VALUES ($1, $2)",
    [self.name, self.email])
  end

  # Creates a new contact, adding it to the database, returning the new contact.
  def self.create(name, email)
    new_contact = Contact.new(name, email)
    new_contact.save(name, email)
  end

  # Returns the contact with the specified id. If no contact has the id, returns nil.
  def self.find(id)
    result = connection.exec_params("SELECT * FROM contacts WHERE id = $1::int",
      [id])
    if row = result.first
      found_contact = Contact.new(
        row['id'],
        row['name'],
        row['email']
      )
      puts "#{found_contact.id}: #{found_contact.name}, #{found_contact.email}"
    else
      nil
    end
  end

  # Returns an array of contacts who match the given term.
  def self.search(term)
    contacts = []
    term = '%' + term + '%'
    result = connection.exec_params("SELECT * FROM contacts WHERE name like $1::varchar;", [term])
    result.each do |row|
      existing_contact = Contact.new(
        row['id'],
        row['name'],
        row['email']
      )
      contacts.push(existing_contact)
    end
    contacts.map do |x|
      "#{x.id}: #{x.name}, #{x.email}"
    end
  end

end