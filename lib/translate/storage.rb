class Translate::Storage
  attr_accessor :locale
  
  def initialize(locale)
    self.locale = locale.to_sym
  end
  
  def write_to_file
    Translate::File.new(file_path).write(keys)
  end
  
  def self.file_paths(locale)
    Dir.glob(File.join(root_dir, "config", "locales", "**","#{locale}.yml"))
  end
  
  def self.root_dir
    Rails.root
  end
  
  private
  def keys
    {locale => deep_strip_procs(I18n.backend.send(:translations)[locale])}
  end
  
  def file_path
    File.join(Translate::Storage.root_dir, "config", "locales", "#{locale}.yml")
  end

  def deep_strip_procs(hash)
    hash = hash.deep_dup
    stack = [hash]
    while current_hash = stack.pop
      current_hash.each_key do |key|
        if (value = current_hash[key]).kind_of?(Hash)
          stack << value
        elsif value.kind_of?(Proc)
          current_hash.delete(key)
        end
      end
    end
    hash
  end
end
