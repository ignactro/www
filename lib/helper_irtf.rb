module IRTF

  class Person
    attr_reader :first, :last, :email, :web, :fb

    def initialize(first, last, email, web, fb)
      @first = first  # first name
      @last = last    # last name
      @email = email  # email address
      @web = web      # web page
      @fb = fb        # Facebook ID
    end

    def <=>(other)
      @last <=> other.last or @first <=> other.first
    end

    def name
      "#{first} #{last}"
    end

    def hamlify()
      # XXX can we return HAML here instead of HTML?
      if web then
        result = link_to(name, web)
      else
        result = name
      end
      if email then
        result += " (" + link_to(email.downcase, "mailto:#{email.downcase}") +
                  ")"
      end
      return result
    end
  end

  class RG
    attr_reader :acronym, :name, :list, :listweb, :web, :chairs, :chartered, :concluded

    def initialize(acronym, name, list, listweb, web, chairs, chartered, concluded)
      @acronym = acronym.upcase
      @name = name + " Research Group"
      @list = list
      # handle IRTF lists by default
      if list =~ /irtf.org$/ then
        @listweb = "/mailman/listinfo/" + list.split("@").first.downcase
      else
        @listweb = listweb.downcase
      end
      @web = web
      @chairs = chairs
      @chartered = chartered
      @concluded = concluded
    end

    def <=>(other)
      @acronym <=> other.acronym
    end

    def url(loc = "")
      link_to(acronym, loc + acronym.downcase, :title => name)
    end
    
    def contacts
      result = @acronym.downcase + "\n" +
             "    Research Group Name:\n" +
             "        " + @name + "\n" + 
             "    Chair(s):\n"
      @chairs.each {|c|
        result += "        " + c.first + " " + c.last + " <" + c.email + ">\n"
      }
      result += "    List:\n" +
                "        " + @list
    return result      
    end
  end

  # ASRG
  levine = Person.new("John", "Levine", "johnl@iecc.com", "http://johnlevine.com/", nil)
  asrg = RG.new(
    "asrg",
    "Anti-Spam",
    "asrg@irtf.org",
    nil,
    "http://asrg.sp.am/",
    [ levine ],
    nil,
    "2013-3-18"
  )

  # CFRG
  # canetti = Person.new("Ran", "Canetti", "canetti@watson.ibm.com")
  mcgrew = Person.new("David", "McGrew", "mcgrew@cisco.com", "http://mindspring.com/~dmcgrew/dam.htm", nil)
  igoe = Person.new("Kevin", "Igoe", "kmigoe@nsa.gov", nil, nil)
  cfrg = RG.new(
    "cfrg",
    "Crypto Forum",
    "cfrg@irtf.org",
    nil,
    nil, # retired "rg/cfrg/", there is nothing there that is not on the charter
    [ mcgrew, igoe ],
    nil,
    nil
  )

  # DTNRG
  fall = Person.new("Kevin", "Fall", "kfall@acm.org", "http://kfall.net/ucbpage/", nil)
  farrell = Person.new("Stephen", "Farrell", "stephen.farrell@cs.tcd.ie", "https://cs.tcd.ie/Stephen.Farrell/", nil)
  ott = Person.new("Jörg", "Ott", "jo@netlab.tkk.fi", "http://www.netlab.tkk.fi/~jo/", nil) # www is needed
  dtnrg = RG.new(
    "dtnrg",
    "Delay-Tolerant Networking",
    "dtn-interest@irtf.org",
    nil,
    "http://dtnrg.org/",
    [ fall, farrell, ott ],
    nil,
    nil
  )

  # HIPRG
  gurtov = Person.new("Andrei", "Gurtov", "gurtov@cs.helsinki.fi", "http://cs.helsinki.fi/u/gurtov/", nil)
  henderson = Person.new("Tom", "Henderson", "thomas.r.henderson@boeing.com", "http://tomh.org/", nil)
  hiprg = RG.new(
    "hiprg",
    "Host Identity Protocol",
    "hiprg@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/hiprg",
    [ gurtov, henderson ],
    nil,
    "2012-7-24"
  )

  # ICCRG
  welzl = Person.new("Michael", "Welzl", "michawe@ifi.uio.no", "http://heim.ifi.uio.no/michawe/", nil)
  ros = Person.new("David", "Ros", "david.ros@telecom-bretagne.eu", "http://www.telecom-bretagne.eu/studies/msc/professors/ros.php", nil)
  iccrg = RG.new(
    "iccrg",
    "Internet Congestion Control",
    "iccrg@irtf.org",
    nil,
    "http://tools.ietf.org/group/irtf/trac/wiki/ICCRG",
    [ welzl, ros ],
    nil,
    nil
  )

  # ICNRG
  kutscher = Person.new("Dirk", "Kutscher", "Dirk.Kutscher@neclab.eu", "http://dirk-kutscher.info/", nil)
  ohlman = Person.new("Börje", "Ohlman", "borje.ohlman@ericsson.com", "http://www.linkedin.com/pub/börje-ohlman/0/270/283", nil)
  oran = Person.new("Dave", "Oran", "oran@cisco.com", "http://www.linkedin.com/pub/david-oran/0/b7/7b4", nil)
  icnrg = RG.new(
    "icnrg",
    "Information-Centric Networking",
    "icnrg@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/icnrg",
    [ kutscher, ohlman, oran ],
    "2012-4-17",
    nil
  )

  # MOBOPTS
  koodli = Person.new("Rajeev", "Koodli", "rkoodli@cisco.com", "http://linkedin.com/in/rajeevkoodli", nil)
  krishnan = Person.new("Suresh", "Krishnan", "suresh.krishnan@ericsson.com", nil, nil)
  mobopts = RG.new(
    "mobopts",
    "IP Mobility Optimizations",
    "mobopts@irtf.org",
    nil,
    nil,
    [ koodli, krishnan ],
    nil,
    "2012-6-8"
  )

  # NCRG
  behringer = Person.new("Michael", "Behringer", "mbehring@cisco.com", "http://linkedin.com/in/mbehringer", nil)
  # huston = Person.new("Geoff", "Huston", "gih@apnic.net", "http://potaroo.net/", nil)
  meyer = Person.new("David", "Meyer", "dmm@1-4-5.net", "http://www.1-4-5.net/~dmm/vita.html", nil)
  ncrg = RG.new(
    "ncrg",
    "Network Complexity",
    "ncrg@irtf.org",
    nil,
    "http://networkcomplexity.org/",
    [ behringer, meyer ],
    "2011-10-4",
    nil
  )

  # NMRG
  granville = Person.new("Lisandro", "Granville", "granville@inf.ufrgs.br", "http://inf.ufrgs.br/~granville/", nil)
  festor = Person.new("Olivier", "Festor", "Olivier.Festor@inria.fr", "http://www.loria.fr/~festor/Site/Welcome.html", nil) # www is needed
  nmrg = RG.new(
    "nmrg",
    "Network Management",
    "nmrg@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/NetworkManagementResearchGroup",
    [ granville, festor ],
    nil,
    nil
  )

  # P2PRG
  hiltl = Person.new("Volker", "Hilt", "volkerh@bell-labs.com", nil, nil)
  previdi = Person.new("Stefano", "Previdi", "sprevidi@cisco.com", "http://linkedin.com/in/sprevidi", nil)
  p2prg = RG.new(
    "p2prg",
    "Peer-to-Peer",
    "p2prg@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/PeerToPeerResearchGroup",
    [ hiltl, previdi ],
    nil,
    "2013-2-25"
  )

  # RRG
  # zhang = Person.new("Lixia", "Zhang", "lixia@CS.UCLA.EDU")
  li = Person.new("Tony", "Li", "tony.li@tony.li", "http://linkedin.com/pub/tony-li/0/130/2a9", nil)
  rrg = RG.new(
    "rrg",
    "Routing",
    "rrg@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/RoutingResearchGroup",
    [ li ],
    nil,
    nil
  )

  # SAMRG
  buford = Person.new("John", "Buford", "buford@samrg.org", "http://samrg.org/buford/index.html", nil)
  schmidt = Person.new("Thomas", "Schmidt", "schmidt@informatik.haw-hamburg.de", "http://users.informatik.haw-hamburg.de/~schmidt/", nil)
  samrg = RG.new(
    "samrg",
    "Scalable Adaptive Multicast",
    "sam@irtf.org",
    nil,
    "http://samrg.org/",
    [ buford, schmidt ],
    nil,
    nil
  )

  # SDNRG
  feamster = Person.new("Nick", "Feamster", "feamster@cc.gatech.edu", "http://www.cc.gatech.edu/~feamster/", nil)
  sdnrg = RG.new(
    "sdnrg",
    "Software-Defined Networking",
    "sdn@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/sdnrg",
    [ meyer, feamster ],
    "2013-1-14",
    nil
  )

  # TMRG
  andrew = Person.new("Lachlan", "Andrew", "lachlan.andrew@gmail.com", "http://caia.swin.edu.au/cv/landrew/", nil)
  tmrg = RG.new(
    "tmrg",
    "Transport Modeling",
    "tmrg@irtf.org",
    nil,
    "http://tools.ietf.org/group/irtf/trac/wiki/tmrg",
    [ andrew ],
    nil,
    "2011-9-26"
  )

  # VNRG
  touch = Person.new("Joe", "Touch", "touch@isi.edu", "http://isi.edu/touch/", nil)
  stiemerling = Person.new("Martin", "Stiemerling", "stiemerling@nw.neclab.eu", "http://ietf.stiemerling.org/", nil)
  vnrg = RG.new(
    "vnrg",
    "Virtual Networks",
    "vnrg@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/vnrg",
    [ touch, stiemerling ],
    nil,
    "2012-2-8"
  )

  # RG list
  $rgs = {
    "cfrg"  => cfrg,
    "dtnrg" => dtnrg,
    "iccrg" => iccrg,
    "icnrg" => icnrg,
    "ncrg"  => ncrg,
    "nmrg"  => nmrg,
    "rrg"   => rrg,
    "samrg" => samrg,
    "sdnrg" => sdnrg
  }

  # ls concluded/irtf.org/charter\?gtype=old-rg\&group=* | cut -f3 -d=
  $oldrgs = {
    "aaaarch" => "AAA Architecture", # Authentication Authorisation Accounting
    "buds"    => "Building Differentiated Services",
    "eme"     => "End Middle End",
    "end2end" => "End-to-End",
    "gsec"    => "Group Security",
    "idrm"    => "Internet Digital Rights Management",
    "iiarg"   => "Information Infrastructure Architecture",
    "imrg"    => "Internet Measurement",
    "ipnrg"   => "Interplanetary Internet",
    "ird"     => "Internet Resource Discovery",
    "nsrg"    => "Namespace",
    "pkng"    => "Public Key Next-Generation",
    "psrg"    => "Privacy and Security",
    "rmrg"    => "Reliable Multicast",
    "siren"   => "Searchable Internet Resource Names",
    "smrg"    => "Services Management",
    "tmrg"    => "Transport Modeling",

  }
  $oldrgs.keys.each do |n|
    $oldrgs[n] += " Research Group"
  end

  # These RGs concluded since the web page redesign. They are rendered based on the data in this file.
  $oldrgs["tmrg"] = tmrg;
  $oldrgs["vnrg"] = vnrg;
  $oldrgs["mobopts"] = mobopts;
  $oldrgs["hiprg"] = hiprg;
  $oldrgs["p2prg"] = p2prg;
  $oldrgs["asrg"] = asrg;

  # RG pattern
  $rgpat = Regexp.new('\b(' + $rgs.keys.compact.join("|") + ')\b', true);

  # IRSG
  eggert = Person.new("Lars", "Eggert", "irtf-chair@irtf.org", "http://eggert.org/", "584143839")
  $chair = eggert
  falk = Person.new("Aaron", "Falk", "aaron.falk@gmail.com", "http://linkedin.com/in/aaronfalk", nil)
  allman = Person.new("Mark", "Allman", "mallman@icir.org", "http://www.icir.org/mallman/", nil)
  dawkins = Person.new("Spencer", "Dawkins", "spencer@wonderhamster.org", "http://linkedin.com/in/spencerdawkins", nil)
  # arkko = Person.new("Jari", "Arkko", "jari.arkko@piuha.net", "http://www.arkko.com/", nil)
  li = Person.new("Xing", "Li", "xing@cernet.edu.cn", "http://www.net-glyph.org/lixing/", nil)
  lear = Person.new("Eliot", "Lear", "lear@cisco.com", "http://www.linkedin.com/pub/eliot-lear/0/81/b0a", nil)
  housley = Person.new("Russ", "Housley", "housley@vigilsec.com", "http://www.linkedin.com/pub/russ-housley/0/69/419", nil)
  $atlarge = [ falk, allman, dawkins, li, lear, housley ]

  def atlarge_contacts
    result = "irsg\n" +
           "    Research Group Name:\n" +
           "        Non-RG Chair IRSG members\n" + 
           "    Chair(s):\n" +
           "        " + $chair.first + " " + $chair.last + " <" + $chair.email + ">\n" +
           "    Members:\n"
    $atlarge.each {|c|
      result += "        " + c.first + " " + c.last + " <" + c.email + ">\n"
    }
    result += "    List:\n" +
              "        irsg@irtf.org"
    return result      
  end  

  # lookahead pattern for filter regexps to make sure we don't replace in links or headings
  $boundary = "(?![^<'\"]*?(?:(?:<\/(?:a|h2|h3|span|dt)>))|['\"])"

end
