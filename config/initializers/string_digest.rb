require "digest/sha1"

class String

  def digest
    Digest::SHA1.hexdigest self
  end

end
