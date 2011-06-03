# replace any mention of an IRTF RG with a link to its charter

class RGFilter < Nanoc3::Filter
  identifier :rg
  type :text

  def run(content, params={})
    content.gsub!(/\b(#{$rgs.keys.join('|').upcase})\b#{$boundary}/) {
      |rg| link_to($1, "/#{$1.downcase}")
    }

    content.gsub!(/\b(#{$oldrgs.keys.join('|').upcase})\b#{$boundary}/) {
      |rg| link_to($1, "/concluded/#{$1.downcase}")
    }
    
    return content
  end
end