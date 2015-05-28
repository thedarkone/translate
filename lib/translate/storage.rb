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
  
  def load_from_file
    @keys_from_file = YAML::load(IO.read(file_path))
  end

  def update_file_keys!(new_translations)
    raise "Must be loaded from #{file_path} directly!" unless @keys_from_file
    stack_new     = [new_translations]
    stack_current = [@keys_from_file]
    while new_hash = stack_new.pop
      current_hash = stack_current.pop
      new_hash.each_pair do |key, value|
        if value.kind_of?(Hash) && current_value = current_hash[key]
          stack_new << value
          stack_current << current_value
        else
          current_hash[key] = value
        end
      end
    end
  end

  private
  def keys
    @keys_from_file || {locale => deep_strip_procs(I18n.backend.send(:translations)[locale])}
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
