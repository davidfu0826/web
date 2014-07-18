admin = User.new(email: "administrator@lunicore.se",
            password:              "testtest",
            password_confirmation: "testtest",
            role: :admin, name: "admin")
if admin.save
  puts "Admin User Created"
else
  admin.valid?
  puts "Could not create admin user #{admin.errors.full_messages}"
end
