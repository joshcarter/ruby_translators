# Ruby Translators #

Description of Translators:

- *Translator:* this is a simple class that allows stacking of IO
transformations, implemented with `read` and `write` methods. The base
class applies no transformation.

- *Rot13Translator:* demonstrates translation using everyone's favorite
super-strong encryption algorithm.

- *BlockTranslator:* a more involved example. Given a block size, all
seek/read/write operations to the underlying target are on multiples
of that block size.
