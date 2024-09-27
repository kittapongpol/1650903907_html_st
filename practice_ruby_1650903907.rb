class User
  attr_accessor :name, :email, :password, :rooms

  def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
  end

  def enter_room(room)
      room.users << self
  end

  def send_message(room, content)
      Message.new(self, room, content)
      room.broadcast(self, content)
  end

  def acknowledge_message(message)
      puts "#{name} seen "
  end
end

class Room
  attr_accessor :name, :description, :users

  def initialize(name, description)
      @name = name
      @description = description
      @users = []
  end

  def broadcast(user, content)
      puts " #{user.name}: sent '#{content}'"
      users.each do |user|
          user.acknowledge_message(content)
      end
  end
end

class Message
  attr_accessor :user, :room, :content

  def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
  end
end

# สร้างผู้ใช้
user1 = User.new("wangwangjeng", "wangwangjeng@example.com", "Jengsuresure")
user2 = User.new("Rik", "Rik&morty@example.com", "incorrect")

# สร้างห้อง
room = Room.new("Newroom", "This is a new room.")

# ผู้ใช้เข้าห้อง
user1.enter_room(room)
user2.enter_room(room)

# ผู้ใช้ส่งข้อความ
user1.send_message(room, "Hello everybody!")
user2.send_message(room, "Hi Alice!")