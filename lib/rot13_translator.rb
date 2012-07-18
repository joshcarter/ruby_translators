require_relative 'translator'

#
# Rot13Translator: everybody's favorite super-strong crypto!
#
class Rot13Translator < Translator
  def read
    rot13 @target.read
  end
  
  def write(s)
    @target.write rot13(s)
  end
  
  private
  
  def rot13(s)
    s2 = String.new
    
    s.each_byte do |c|
      c = case c
      when 97..109  then (c + 13).chr
      when 110..122 then (c - 13).chr
      else c
      end
      
      s2 << c
    end

    s2
  end
end
