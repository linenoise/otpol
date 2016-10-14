#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "one thousand points of light"
    xml.description "An experiment in textured, familiar, impermanent prose of the senses."
    xml.link "http://www.onethousandpointsoflight.com"
    xml.language "en"
    
    for point in @points
      xml.item do
	      xml.title       point.moment.to_s + '; ' + point.location.to_s
        xml.author      point.user.display_name.to_s
        xml.pubDate     point.created_at.to_s(:rfc822)
        xml.link        "https://www.onethousandpointsoflight.com/point/" + point.id.to_s
        xml.guid        point.id.to_s
        xml.description point.description.to_s
      end
    end
  end
end