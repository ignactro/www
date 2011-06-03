# replace a few commonly used terms with hyperlinks

class URLFilter < Nanoc3::Filter
  identifier :url
  type :text

  @@urls = {
    "Gnutella" => "http://en.wikipedia.org/wiki/Gnutella",
    "BitTorrent" => "http://en.wikipedia.org/wiki/BitTorrent",
    "eDonkey" => "http://en.wikipedia.org/wiki/EDonkey_network",
    "eMule" => "http://en.wikipedia.org/wiki/Emule",
    "Skype" => "http://en.wikipedia.org/wiki/Skype",
    "ACM" => "http://acm.org/",
    "IEEE" => "http://ieee.org/",
    "SIGCOMM" => "http://sigcomm.org/",
    "INFOCOM" => "http://ieee-infocom.org/",
    "GLOBECOM" => "http://ieee-globecom.org/",
    "NSF" => "http://nsf.gov/",
    "GENI" => "http://geni.net/",
    "CoNEXT" => "http://sigcomm.org/events/conext-conference",
    "IAB" => "https://iab.org/",
    "IESG" => "http://iesg.org/",
    "IETF" => "http://ietf.org/",
    "W3C" => "http://w3.org/",
    "IRTF" => "./",
    "ISOC" => "http://isoc.org/",
    "IRTF Chair" => "chair",
    "IETF meetings?" => "http://ietf.org/meeting/",
    "IRSG" => "irsg",
    "Research Groups" => "groups",
#    "TCP" => "http://ietf.org/dyn/wg/charter/tcpm-charter",
    "RFC Editor" => "http://rfc-editor.org/",
    "ANRP" => "anrp",
    "ICIR" => "http://icir.org/",
    "HIIT" => "http://hiit.fi/",
    "LabN" => "http://labn.net/",
    "AT&T Laboratories" => "http://research.att.com/",
    "Juniper" => "http://juniper.net/",
    "Cisco" => "http://cisco.com/",
    "INRIA" => "http://inria.fr/",
    "LBL" => "http://lbl.gov/",
    "Aalto University" => "http://aalto.fi/",
    "Nokia Research Center" => "http://research.nokia.com/",
    "NEC Laboratories" => "http://neclab.eu/"
  }

  def run(content, params={})
    @@urls.keys.sort_by {|x| x.length}.reverse.each do |tag|
      content.gsub!(/\b(#{tag})\b#{$boundary}/) {
        |x| link_to($1, @@urls[tag])
      } 
    end
    return content
  end
end