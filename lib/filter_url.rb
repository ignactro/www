require 'nokogiri'

# replace a few commonly used terms with hyperlinks

class URLFilter < Nanoc::Filter
  identifier :url
  type :text

  @@urls = {
    # ANRP 2023 winners:
    "Simon Scherrer"           => "https://netsec.ethz.ch/people/simon/",
    "Boris Pismenny"           => "https://borispis.github.io/",
    "Siva Kakarla"             => "https://www.sivak.dev/",
    "Dennis Trautwein"         => "https://dtrautwein.eu/",
    "Arthur Selle Jacobs"      => "https://asjacobs92.github.io/",
    "Ram Sundara Raman"        => "https://ramakrishnansr.com/",
    # People:
    "Maria Apostolaki"         => "https://ece.princeton.edu/people/maria-apostolaki",
    "Sangeetha Abdu Jyothi"    => "https://www.ics.uci.edu/~sabdujyo/",
    "Gautam Akiwate"           => "https://cseweb.ucsd.edu/~gakiwate/",
    "Venkat Arun"              => "https://www.cs.utexas.edu/~venkatar/",
    "Mark Allman"              => "https://www.icir.org/mallman/",
    "Johanna Amann"            => "https://www.icir.org/johanna/",
    "Grenville Armitage"       => "http://gja.space4me.com",
    "Vaibhav Bajpai"           => "https://vaibhavbajpai.com",
    "Aruna Balasubramanian"    => "https://www3.cs.stonybrook.edu/~arunab/",
    "Ali C. Begen"             => "https://ali.begen.net",
    "Benjamin Beurdouche"      => "https://scholar.google.fr/citations?user=rh47X8QAAAAJ&hl=en", 
    "Debopam Bhattacherjee"    => "https://bdebopam.github.io",
    "Zachary Bischof"          => "https://www.zbischof.com",
    "Kevin Bock"               => "https://www.cs.umd.edu/~kbock/",
    "Theophilus Benson"        => "https://cs.brown.edu/~tab/",
    "R.diger Birkner"          => "https://www.rbirkner.ch",
    "Anna Brunstr.m"           => "https://www.kau.se/en/researchers/anna-brunstrom",
    "Ignacio Castro"           => "https://icastro.info",
    "Corinne Cath"             => "https://corinnecath.com",
    "Sof.a Celi"               => "https://www.sofiaceli.com",
    "Steven Chien"             => "https://scholar.google.se/citations?user=xBJ9FM0AAAAJ&hl=en",
    "Marco Chiesa"             => "https://marchiesa.bitbucket.io",
    "Sandra C.spedes"          => "https://www.cec.uchile.cl/~scespedes/",
    "Taejoong .Tijay. Chung"   => "https://taejoong.github.io",
    "Jay Daley"                => "https://datatracker.ietf.org/person/Jay%20Daley",
    "Spencer Dawkins"          => "https://datatracker.ietf.org/person/Spencer%20Dawkins",
    "Quentin De Coninck"       => "https://qdeconinck.github.io",
    "Lars Eggert"              => "https://eggert.org",
    "Theresa Enghardt"         => "https://tenghardt.net/",
    "Reese Enghardt"           => "https://tenghardt.net/",
    "Sawsan El-Zahr"           => "https://eng.ox.ac.uk/people/sawsan-el-zahr/",
    "Stephen Farrell"          => "https://www.scss.tcd.ie/Stephen.Farrell/",
    "Marwan Fayed"             => "https://research.cloudflare.com/about/people/marwan-fayed/",
    "Mat Ford"                 => "https://www.internetsociety.org/author/ford/",
    "Sadjad Fouladi"           => "https://sadjad.org",
    "Nick Feamster"            => "https://people.cs.uchicago.edu/~feamster/",
    "Simone Ferlin-Reiter"     => "https://ferlin.io",
    "Georgia Fragkouli"        => "https://georgia-fragkouli.github.io",
    "Alex Gamero-Garrido"      => "https://www.gamero-garrido.com",
    "Oliver Gasser"            => "https://olivergasser.net",
    "Phillipa Gill"            => "https://people.cs.umass.edu/~phillipa/",
    "Sharon Goldberg"          => "http://www.cs.bu.edu/~goldbe/",
    "Vidhi Goel"               => "https://datatracker.ietf.org/person/vidhi_goel@apple.com",
    "Dongqi Han"               => "https://dongqihan.top/",
    "Kurtis Heimerl"           => "https://kurti.sh",
    "Michio Honda"             => "https://micchie.net",
    "Ralph Holz"               => "https://ralphholz.science",
    "Shumon Huque"             => "https://www.huque.com",
    "Jana Iyengar"             => "https://github.com/janaiyengar",
    "Dennis Jackson"           => "https://dennis-jackson.uk",
    "Mattijs Jonker"           => "http://mattijsjonker.com",
    "Ethan Katz-Bassett"       => "http://www.columbia.edu/~ebk2141/",
    "Bruno Kimura"             => "https://scholar.google.com/citations?user=GFWOPxYAAAAJ&hl=en",
    "Konstantinos Kousias"     => "https://kostaskousias.wordpress.com",
    "Fernando Kuipers"         => "https://fernandokuipers.nl",
    "Sam Kumar"                => "https://people.eecs.berkeley.edu/~samkumar/",
    "Mirja K.hlewind"          => "http://mirja.kuehlewind.net",
    "Chaoyi Lu"                => "https://luchaoyi.com",
    "Andra Lutu"               => "https://andralutu.com",
    "Yevheniya Nosyk"          => "https://www.linkedin.com/in/yevheniya-nosyk/",
    "Harjasleen Malvai"        => "https://jasleenmalvai.com/",
    "Allison Mankin"           => "https://datatracker.ietf.org/person/Allison%20Mankin",
    "Stephen McQuistin"        => "https://smcquistin.uk",
    "Zili Meng"                => "https://zilimeng.com",
    "Nitinder Mohan"           => "https://www.nitindermohan.com",
    "Alexa Morris"             => "https://datatracker.ietf.org/person/Alexa%20Morris",
    "Veelasha Moonsamy"        => "https://veelasha.org",
    "Moritz M.ller"            => "https://scholar.google.com/citations?user=W5qkJ0EAAAAJ&hl=en",
    "Akshay Narayan"           => "https://akshayn.xyz",
    "J.ferson Campos Nobre"    => "https://www.inf.ufrgs.br/~jcnobre/",
    "J.rg Ott"                 => "https://www.ce.cit.tum.de/en/cm/research-group/joerg-ott/",
    "David Oran"               => "https://datatracker.ietf.org/person/David%20R.%20Oran",
    "Christoph Paasch"         => "http://be.linkedin.com/in/christophpaasch",
    "Hannah B. Pasandi"        => "https://hannahpasandi.com",
    "Cristel Pelsser"          => "https://cristel.pelsser.eu",
    "Colin Perkins"            => "https://csperkins.org/",
    "Amreesh Phokeer"          => "https://amreesh.github.io",
    "Diana Andreea Popescu"    => "https://www.cl.cam.ac.uk/~dap53/",
    "Audrey Randall"           => "https://audrey-randall.github.io",
    "Jingjing Ren"             => "https://www.jingjingren.com",
    "Eric Rescorla"            => "https://www.rtfm.com",
    "Philipp Richter"          => "https://people.csail.mit.edu/richterp/",
    "Cigdem Sengul"            => "https://www.cigdemsengul.com",
    "Jayasree Sengupta"        => "https://sites.google.com/view/jayasreesengupta/home",
    "Justine Sherry"           => "http://www.justinesherry.com",
    "Melinda Shore"            => "https://datatracker.ietf.org/person/Melinda%20Shore",
    "Tanya Shreedhar"          => "https://tanyashreedhar.github.io",
    "Rachee Singh"             => "https://www.racheesingh.com",
    "Joel Sommers"             => "https://cs.colgate.edu/~jsommers/",
    "Bruce Spang"              => "https://brucespang.com",
    "Anna Sperotto"            => "https://annasperotto.org",
    "Stephen Strowes"          => "https://sdstrowes.co.uk",
    "Nick Sullivan"            => "https://crypto.dance/about",
    "Tushar Swamy"             => "https://www.linkedin.com/in/tushar-swamy-b4aa51b1/",
    "Tony Tauber"              => "https://www.linkedin.com/in/tonytauber",
    "Brian Trammell"           => "https://trammell.ch",
    "Ranysha Ware"             => "https://www.cs.cmu.edu/~rware/",
    "Christopher Wood"         => "https://www.caw.fyi",
    "Jeroen van der Ham"       => "https://jvdham.nl",
    "Roland van Rijswijk-Deij" => "https://rijswijk.github.io",
    "Lisandro Zambenedetti Granville" => "http://www.inf.ufrgs.br/~granville/",
    "Daniel Wagner"            => "https://www.mpi-inf.mpg.de/departments/inet/people/daniel-wagner",
    "Thomas Wirtgen"           => "https://inl.info.ucl.ac.be/thomas.html",
    "Laurent Vanbever"         => "https://vanbever.eu",
    "Matthias W.hlisch"        => "https://www.mi.fu-berlin.de/en/inf/groups/ilab/members/waehlisch.html",
    "Mingshi Wu"               => "https://gfw.report/",
    "Xieyang Xu"               => "https://xieyangxu.github.io/",
    "Francis Y. Yan"           => "https://francisyyan.org",
    "Johannes Zirngibl"        => "https://zirngibl.github.io",
    # Places:
    "(Technische Universit.t|TU) M.nchen" => "https://www.tum.de/en/",
    "Aalto University" => "https://www.aalto.fi/",
    "ACLU" => "https://www.aclu.org",
    "ACM" => "https://www.acm.org/",
    "Akamai" => "https://www.akamai.com/",
    "Apple" => "https://www.apple.com/",
    "AT(&amp;|\&)T( Laboratories)?" => "http://www.research.att.com/",
    "ATIS" => "https://www.atis.org/",
    "Bell Labs" => "https://www.alcatel-lucent.com/bell-labs",
    "BitTorrent" => "https://en.wikipedia.org/wiki/BitTorrent",
    "Boston University" => "https://www.bu.edu",
    "Brown University" => "https://www.brown.edu/",
    "BT" => "http://www.btplc.com/",
    "CAIDA" => "https://www.caida.org/",
    "Carnegie Mellon University" => "https://www.cmu.edu",
    "Cisco" => "https://cisco.com/",
    "Cloudflare" => "https://www.cloudflare.com/",
    "Colorado State" => "https://colostate.edu/",
    "CoNEXT" => "https://sigcomm.org/events/conext-conference",
    "Comcast" => "https://www.comcast.com/",
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
    "GENI" => "https://www.geni.net/",
    "Georgia Tech" => "https://www.gatech.edu",
    "Gnutella" => "https://en.wikipedia.org/wiki/Gnutella",
    "Google" => "https://www.google.com/intl/en/about/",
    "Hebrew University of Jerusalem" => "https://new.huji.ac.il/en",
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
    "IETF LLC" => "https://www.ietf.org/about/administration/",
    "IIJ" => "https://www.iij.ad.jp/",
    "INRIA" => "https://www.inria.fr/",
    "Internet Initiative Japan" => "https://www.iij.ad.jp/",
    "Internet Society" => "https://www.internetsociety.org/",
    "ISI" => "https://www.isi.edu/",
    "ISOC" => "https://www.internetsociety.org/",
    "ITU-T" => "https://www.itu.int/en/ITU-T/",
    "Jacobs University Bremen" => "https://www.jacobs-university.de/", # www is needed
    "Juniper" => "https://juniper.net/",
    "Kaloom" => "https://www.kaloom.com/",
    "Karlstad University" => "https://www.kau.se/en",
    "LabN" => "https://labn.net/",
    "LBL" => "https://lbl.gov/",
    "MPI f.r Informatik Saarland" => "https://www.mpi-inf.mpg.de/",
    "MEF" => "https://www.mef.net",
    "MIT" => "https://www.mit.edu/",
    "Mozilla" => "https://www.mozilla.org/",
    "Microsoft Research" => "https://research.microsoft.com/",
    "NEC Laboratories( Europe)?" => "https://www.neclab.eu/",
    "NetApp" => "https://www.netapp.com/us/",
    "Nefeli Networks" => "https://nefeli.io/",
    "Netflix" => "https://www.netflix.com/",
    "NIC Labs Chile" => "https://niclabs.cl",
    "NLnet Labs" => "https://www.nlnetlabs.nl/",
    "Nokia( Research Center)?" => "https://www.nokia.com/",
    "NSF" => "https://nsf.gov/",
    "ONF" => "https://www.opennetworking.org/",
    "Özyegin University" => "https://www.ozyegin.edu.tr/en",
    "Princeton" => "https://www.princeton.edu/",
    "Princeton University" => "https://www.princeton.edu/",
    "Queen Mary University London" => "https://www.qmul.ac.uk/",
    "Radboud University Nijmegen" => "https://www.ru.nl/english/",
    "RFC Editor" => "https://www.rfc-editor.org/",
    "RIPE NCC" => "https://www.ripe.net",
    "Rochester Institute of Technology" => "https://www.rit.edu",
    "Salesforce" => "https://www.salesforce.com/",
    "SIGCOMM" => "https://sigcomm.org/",
    "Skype" => "https://en.wikipedia.org/wiki/Skype",
    "Stanford" => "https://stanford.edu/",
    "SURFnet" => "https://www.surf.nl/en/",
    "Trinity College Dublin" => "https://www.tcd.ie/",
    "Tsinghua University" => "https://www.tsinghua.edu.cn/",
    "Technische Universit.t Berlin" => "https://www.tu-berlin.de/",
    "UC3M" => "https://uc3m.es/",
    "UCL Louvain" => "https://uclouvain.be/",
    "UCLA" => "https://www.ucla.edu/",
    "UMass Amherst" => "https://www.umass.edu",
    "Universidad de Chile" => "https://www.uchile.cl",
    "University of Massachusetts - Amherst" => "https://www.umass.edu",
    "University of Aberdeen" => "https://www.abdn.ac.uk/",
    "University of Cambridge" => "https://www.cam.ac.uk/",
    "University of Colorado Boulder" => "https://www.colorado.edu/itp/",
    "University of Glasgow" => "https://www.gla.ac.uk/",
    "University of Helsinki" => "https://www.helsinki.fi/en",
    "University of Melbourne" => "https://unimelb.edu.au/",
    "University of Strasbourg" => "http://www.unistra.fr/",
    "University of Sydney" => "https://sydney.edu.au",
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
