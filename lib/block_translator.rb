require_relative 'translator'

#
# BlockTranslator: does IO operations on multiples of a given block
# size. Subclasses should override `read_block` and `write_block`, and
# possibly also `initialize` so that they can pin their block size.
#
# NOTE: this translator does no caching. If it needs to expand a read
# to fill out the block size, the extra is simply thrown away.
#
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
      s << read_block
    end
    
    if oddsize
      offset ||= 0
      s[offset % @block_size, length] # trim to expected offset and result size
    else
      s
    end
  end

  def read_block
    @target.read @block_size
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
      write_block s[i * @block_size, @block_size]
    end
  end
  
  def write_block(s)
    @target.write s
  end
end
