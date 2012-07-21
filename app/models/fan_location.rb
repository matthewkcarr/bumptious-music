class FanLocation < ActiveRecord::Base


  def self.newest_three
    retarry = []
    rval = self.all(:select => "distinct(city) as city, state, country_code, max(created_at) as created_at, '' as occurences, '' as updated", :group => 'city', :order => "created_at DESC", :limit => 3)
    unless rval.size < 3
      retarry = self.all(:select => "count(*) as occurences, city", :conditions => ["city in (?)", rval.collect { |e| e.city }], :group => "city, state, country_code")
      #retarry.reverse
      if retarry.size == 3
        for i in 0..2
          occ = retarry[i]['occurences']
          rval[i]['occurences'] = occ
          rval[i]['updated'] = rval[i].created_at.strftime("%m/%d/%Y") 
        end
      end
    end
    if rval.size < 3
      rval[0] = FanLocation.new(:city => "San Francisco", :state => "CA", :country_code => "US", :updated => Time.now.strftime("%m%d%Y"))
      rval[1] = FanLocation.new(:city => "Los Angeles", :state => "CA", :country_code => "US", :updated  => Time.now.strftime("%m%d%Y"))
      rval[2] = FanLocation.new(:city => "Austin", :state => "TX", :country_code => "US", :updated => Time.now.strftime("%m%d%Y"))
    end
    return rval
  end

  def self.top_three
    rval = self.all(:select => "count(*) as occurences, city, state, country_code, '' as created", :group => "city, state, country_code", :order => "occurences DESC", :limit => 3)
    rval.each do |fl|
      candidate = self.find(:first, :conditions => {:city => fl.city, :state => fl.state, :country_code => fl.country_code}, :order => "updated_at DESC")
      fl[:updated] = candidate.updated_at.strftime("%m/%d/%Y") 
    end
    if rval.size < 3
      rval[0] = FanLocation.new(:city => "San Francisco", :state => "CA", :country_code => "US", :updated => Time.now.strftime("%m%d%Y"))
      rval[1] = FanLocation.new(:city => "Los Angeles", :state => "CA", :country_code => "US", :updated  => Time.now.strftime("%m%d%Y"))
      rval[2] = FanLocation.new(:city => "Austin", :state => "TX", :country_code => "US", :updated => Time.now.strftime("%m%d%Y"))
    end
    return rval
  end

end
