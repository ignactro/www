require 'nokogiri'

# replace a few commonly used terms with hyperlinks

class URLFilter < Nanoc::Filter
  identifier :url
  type :text

  @@urls = {
    "(Technische Universit.t|TU) M.nchen" => "https://www.tum.de/en/",
    "Aalto University" => "https://www.aalto.fi/",
    "ACM" => "https://www.acm.org/",
    "Akamai" => "https://www.akamai.com/",
    "ANRP" => "anrp",
    "ANRW" => "anrw/",
    "AT(&amp;|\&)T( Laboratories)?" => "http://www.research.att.com/",
    "ATIS" => "https://www.atis.org/",
    "Bell Labs" => "https://www.alcatel-lucent.com/bell-labs",
    "BitTorrent" => "https://en.wikipedia.org/wiki/BitTorrent",
    "Boston University" => "https://www.bu.edu",
    "BT" => "http://www.btplc.com/innovation/",
    "CAIDA" => "https://www.caida.org/",
    "Cisco" => "https://cisco.com/",
    "Colorado State" => "https://colostate.edu/",
    "CoNEXT" => "https://sigcomm.org/events/conext-conference",
    "DARPA" => "https://www.darpa.mil/",
    "Data61/CSIRO" => "https://www.data61.csiro.au/",
    "Daydream Imagery" => "https://www.daydream.com/",
    "Dell EMC" => "https://www.dellemc.com/",
    "DMTF" => "https://www.dmtf.org/",
    "eDonkey" => "https://en.wikipedia.org/wiki/EDonkey_network",
    "eMule" => "https://en.wikipedia.org/wiki/Emule",
    "Ericsson" => "https://www.ericsson.com/",
    "ETH Z.rich" => "https://www.ethz.ch/",
    "ETHZ" => "https://www.ethz.ch/",
    "ETSI" => "https://www.etsi.org/",
    "Fastly" => "https://www.fastly.com/", 
    "FEDERICA" => "https://www.fp7-federica.eu/",
    "GENI" => "https://www.geni.net/",
    "Georgia Tech" => "https://www.gatech.edu",
    "GLOBECOM" => "https://ieee-globecom.org/",
    "Gnutella" => "https://en.wikipedia.org/wiki/Gnutella",
    "Google" => "https://www.google.com/intl/en/about/",
    "HIIT" => "https://hiit.fi/",
    "Hochschule Augsburg" => "https://www.hs-augsburg.de/",
    "Huawei" => "https://www.huawei.com/",
    "IAB" => "https://iab.org/",
    "ICIR" => "https://icir.org/",
    "ICSI" => "https://www.icsi.berkeley.edu/",
    "IEEE" => "https://www.ieee.org/",
    "IESG" => "https://www.iesg.org/",
    "IETF meetings?" => "https://ietf.org/meeting/",
    "IETF" => "https://ietf.org/",
    "IIJ" => "https://www.iij.ad.jp/",
    "Infocom" => "https://ieee-infocom.org/",
    "INRIA" => "https://www.inria.fr/",
    "Internet Society" => "https://www.internetsociety.org/",
    "IRSG" => "irsg",
    "IRTF Chair" => "chair",
    "IRTF" => "./",
    "ISI" => "https://www.isi.edu/",
    "ISOC" => "https://www.internetsociety.org/",
    "ITU-T" => "https://www.itu.int/en/ITU-T/",
    "Jacobs University Bremen" => "https://www.jacobs-university.de/", # www is needed
    "Juniper" => "https://juniper.net/",
    "Kaloom" => "https://www.kaloom.com/",
    "LabN" => "https://labn.net/",
    "LBL" => "https://lbl.gov/",
    "MEF" => "https://www.mef.net",
    "Mozilla" => "https://www.mozilla.org/",
    "Microsoft Research" => "https://research.microsoft.com/",
    "NEC Laboratories( Europe)?" => "https://www.neclab.eu/",
    "NetApp" => "https://www.netapp.com/us/",
    "Nefeli Networks" => "https://nefeli.io/",
    "NLnet Labs" => "https://www.nlnetlabs.nl/",
    "Nokia( Research Center)?" => "https://www.nokia.com/",
    "NSF" => "https://nsf.gov/",
    "ONF" => "https://www.opennetworking.org/",
    "Princeton" => "https://www.princeton.edu/",
    "Queen Mary University London" => "https://www.qmul.ac.uk/",
    "Research Groups" => "groups",
    "RFC Editor" => "https://www.rfc-editor.org/",
    "Salesforce" => "https://www.salesforce.com/",
    "SIGCOMM" => "https://sigcomm.org/",
    "Skype" => "https://en.wikipedia.org/wiki/Skype",
    "Stanford" => "https://stanford.edu/",
    "SURFnet" => "https://www.surf.nl/en/about-surf/subsidiaries/surfnet",
    "Trinity College Dublin" => "https://www.tcd.ie/",
    "UC3M" => "https://uc3m.es/",
    "UCL Louvain" => "https://uclouvain.be/",
    "UCLA" => "https://www.ucla.edu/",
    "UFRGS" => "https://www.ufrgs.br/relinter/english",
    "University of Aberdeen" => "https://www.abdn.ac.uk/",
    "University of Cambridge" => "https://www.cam.ac.uk/",
    "University of Colorado Boulder" => "https://www.colorado.edu/itp/",
    "University of Glasgow" => "https://www.gla.ac.uk/",
    "University of Helsinki" => "https://www.helsinki.fi/en",
    "University of Melbourne" => "https://unimelb.edu.au/",
    "University of Twente" => "https://www.utwente.nl/en/",
    "USC" => "https://www.usc.edu/",
    "UTS" => "https://www.uts.edu.au/",
    "W3C" => "https://www.w3.org/",
    "Yale" => "https://yale.edu/",
  }

  def run(content, params={})
    loc = ""
    if @item.path and @item.path !~ /^\/[^\/]*$/
      loc = @item.path.gsub(/\w+\.\w+$/, "").gsub(/[^\/\.]+/, "..").gsub(/^\//, "")
    end
    c = content.dup
    @@urls.keys.sort_by {|x| x.length}.reverse.each do |tag|
      doc = Nokogiri::HTML(c)
      elements = doc.xpath('//*[local-name() != "a" and not(ancestor::*[contains(concat(" ", normalize-space(@class), " "), " no-urlify ")]) and not(self::*[contains(concat(" ", normalize-space(@class), " "), " no-urlify ")])]/text()')
      elements.each do |element|
        element.content = element.content.gsub(/\b(#{tag})\b/) {
          |x| link_to(x, (@@urls[tag] =~ /^http/ ? "" : loc) + @@urls[tag])
        }
      end
      c = doc.xpath('//body')[0].inner_html.gsub("&lt;", "<").gsub("&gt;", ">")
    end
    return c
  end
end
