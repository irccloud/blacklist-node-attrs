class Blacklist
  def self.filter(data, blacklist)
    if data == nil
      return nil
    end

    new_data = data.reject { |key, value| blacklist[key] === true }
    data.each do |k,v|
        bl = blacklist[k]
        if bl.kind_of?(Hash) and v.kind_of?(Hash)
            ## If both hashes, go a level deeper:
            new_data[k] = filter(v, bl)
        else 
            new_data[k] = v unless bl
        end
    end
    new_data
  end
end

class Chef
  class Node
    alias_method :old_save, :save

    def save
      Chef::Log.info("Blacklisting node attributes")
      blacklist = self[:blacklist].to_hash
      self.default_attrs = Blacklist.filter(self.default_attrs, blacklist)
      self.normal_attrs = Blacklist.filter(self.normal_attrs, blacklist)
      self.override_attrs = Blacklist.filter(self.override_attrs, blacklist)
      self.automatic_attrs = Blacklist.filter(self.automatic_attrs, blacklist)
      old_save
    end
  end
end
