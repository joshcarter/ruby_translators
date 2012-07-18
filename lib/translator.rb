#
# Translator: generic class for stacking IO translations. Subclasses
# should override `read` and `write` to do something more interesting.
#
class Translator
  def initialize(target)
    @target = target
  end
  
  def read
    @target.read
  end
  
  def write(s)
    @target.write(s)
  end
end
