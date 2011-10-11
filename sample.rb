class Sample

  @@x='sample'

  def start(name)
    @name=name

  end

  def call
    puts @name
  end


  def self.call1
    @@x
  end
end

s1=Sample.new
s1.start("arijt")
puts Sample.call1
s1.call





