require_relative 'translator'

class BlockTranslator < Translator
  attr_reader :block_size
  
  def initialize(target, block_size)
    @target = target
    @block_size = block_size
  end

  def read(length, offset = nil)
    oddsize = (length % @block_size != 0) || (offset && (offset % @block_size != 0))
    reads = length / @block_size
    reads += oddsize ? 1 : 0
    s = ""
    
    if offset
      # Seek to the nearest block_size before offset
      @target.seek offset - (offset % @block_size)
    end
    
    reads.times do
      s << @target.read(@block_size)
    end
    
    if oddsize
      offset ||= 0
      s[offset % @block_size, length] # trim to expected offset and result size
    else
      s
    end
  end
  
  def write(s, offset = nil)
    length = s.length
    oddsize = (length % @block_size != 0) || (offset && (offset % @block_size != 0))
    writes = length / @block_size
    writes += oddsize ? 1 : 0

    if offset
      # Seek to the nearest block_size before offset
      @target.seek offset - (offset % @block_size)

      if offset % @block_size != 0
        # Pre-pad to align s to block size
        s = s.prepend "\0" * (@block_size - offset % @block_size)
      end
    end

    if s.length % @block_size != 0
      # Pad to next larger block size
      s << "\0" * (@block_size - s.length % @block_size)
    end
    
    writes.times do |i|
      @target.write s[i * @block_size, @block_size]
    end
  end
  
end