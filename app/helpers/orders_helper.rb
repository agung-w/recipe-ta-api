module OrdersHelper
  def distance(loc1, loc2)
    rad_per_deg = Math::PI/180
    earth_radius = 6371             
  
    dlat = (loc2[0]-loc1[0]) * rad_per_deg 
    dlon = (loc2[1]-loc1[1]) * rad_per_deg
  
    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }
  
    a = Math.sin(dlat/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
  
    (earth_radius * c).round(1) 
  end
end
