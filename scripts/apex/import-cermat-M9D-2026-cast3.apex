String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. náhradní termín (M9D)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2026 M9D · úloha 7',
  new List<String>{'Na bílé krychli $ABCDEFGH$ jsme vyznačili středy $M$, $N$ hran $AB$ a $FG$. Na třech stěnách krychle jsme zakreslili šedé pravoúhlé lichoběžníky $MBFE$, $BCNF$ a $HEFN$ (viz obrázek). Ostatní stěny zůstaly bílé.','7.1 Zapište zlomkem v základním tvaru, jakou část plochy přední stěny tvoří šedý lichoběžník $MBFE$.','7.2 Určete poměr obsahu šedé plochy ku obsahu bílé plochy na povrchu celé krychle (v základním tvaru).'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 186"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 58L466 58Z" style="fill:#000000"/><path d="M466 58L467 58L467 74L466 74Z" style="fill:#000000"/><path d="M466 74L467 74L467 90L466 90Z" style="fill:#000000"/><path d="M466 90L467 90L467 109L466 109Z" style="fill:#000000"/><path d="M466 109L467 109L467 128L466 128Z" style="fill:#000000"/><path d="M466 128L467 128L467 153L466 153Z" style="fill:#000000"/><path d="M4 181L466 181L466 182L4 182Z" style="fill:#000000"/><path d="M466 181L467 181L467 182L466 182Z" style="fill:#000000"/><path d="M466 181L467 181L467 182L466 182Z" style="fill:#000000"/><path d="M466 153L467 153L467 181L466 181Z" style="fill:#000000"/><path d="M412 157L446 123L429 44L412 61L412 157Z" style="fill:#b2b2b2"/><path d="M316 61L350 27L429 43L412 61L316 61Z" style="fill:#b2b2b2"/><path d="M412 157L364 157L316 61L412 61L412 157Z" style="fill:#b2b2b2"/><path d="M429 44L446 123M350 27L429 43M316 61L364 157" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M446 123L446 27M446 27L350 27M412 157L446 123M316 61L350 27M412 61L446 27M316 61L412 61L412 157L316 157Z" style="fill:none;stroke:#000000;stroke-width:2"/><text x="313" y="171" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="415" y="171" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="450" y="137" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="313" y="58" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">E</text><text x="450" y="24" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">G</text><text x="348" y="24" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">H</text><text x="365" y="172" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="428" y="41" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">N</text><text x="411" y="58" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">F</text></svg>',
  'obr.svg',
  'Krychle ABCDEFGH se středy M, N hran AB a FG a se třemi šedými pravoúhlými lichoběžníky MBFE, BCNF, HEFN.',
  '',
  new List<String>{'Nechť hrana krychle je $a$. Lichoběžník $MBFE$ má rovnoběžné strany $MB=\\frac{a}{2}$ a $EF=a$, výšku $a$; jeho obsah je $\\frac{1}{2}\\left(\\frac{a}{2}+a\\right)a=\\frac{3}{4}a^2$.','7.1: podíl na přední stěně je $\\frac{3}{4}$.','7.2: součet obsahů tří shodných lichoběžníků je $\\frac{9}{4}a^2$; povrch krychle je $6a^2$, bílá plocha $\\frac{15}{4}a^2$; poměr $\\frac{9}{4}:\\frac{15}{4}=3:5$.'},
  '7.1: $\\frac{3}{4}$; 7.2: $3:5$',
  3, 5, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD26C0T04', 2026
);
c.add(
  'CERMAT 2026 M9D · úloha 8',
  new List<String>{'V parku běží dva běžci trasu dlouhou $8\\ \\mathrm{km}$; žádný z nich nemění rychlost. Rychlejší běžec uběhne celou trasu za $40$ minut. Rychlejší běžec uběhne $3\\ \\mathrm{km}$ za čas, za který pomalejší běžec uběhne $2\\,500\\ \\mathrm{m}$.','8.1 Vypočtěte v minutách, za jaký čas uběhne rychlejší běžec $3\\ \\mathrm{km}$.','8.2 Vypočtěte v minutách, za jaký čas uběhne pomalejší běžec celou trasu.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: rychlejší $8\\ \\mathrm{km}$ za $40$ min, tedy $3\\ \\mathrm{km}$ za $40\\cdot\\frac{3}{8}=15$ minut.','8.2: za $15$ minut uběhne pomalejší $2\\,500\\ \\mathrm{m}$; celou trasu $8\\,000\\ \\mathrm{m}$ uběhne za $15\\cdot\\frac{8\\,000}{2\\,500}=48$ minut.'},
  '8.1: $15$ minut; 8.2: $48$ minut',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD26C0T04', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
