class FanLocation < ActiveRecord::Base



  def self.top_three
    rval = self.all(:select => "count(*) as occurences, city, state, country_code, '' as created", :group => "city, state, country_code", :order => "occurences DESC", :limit => 3)
    rval.each do |fl|
      candidate = self.find(:first, :conditions => {:city => fl.city, :state => fl.state, :country_code => fl.country_code}, :order => "updated_at DESC")
      fl[:updated] = candidate.updated_at.strftime("%m/%d/%Y") 
    end
    if rval.size < 3
      rval[0] = FanLocation.new(:city => "Chico", :state => "CA", :country_code => "US", :updated => Time.now.strftime("%m%d%Y"))
      rval[1] = FanLocation.new(:city => "Los Angeles", :state => "CA", :country_code => "US", :updated  => Time.now.strftime("%m%d%Y"))
      rval[2] = FanLocation.new(:city => "Austin", :state => "TX", :country_code => "US", :updated => Time.now.strftime("%m%d%Y"))
    end
    return rval
  end

end
