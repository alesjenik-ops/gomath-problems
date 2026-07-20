String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený B16 – počet obyvatel v regionu (tabulka)',
  new List<String>{'V našem regionu je šest obcí. Po druhé světové válce a zejména po listopadové revoluci se významně změnila struktura osídlení v našem regionu, a tedy i počet obyvatel v jednotlivých obcích, jak dokumentuje přiložená tabulka.','Na základě informací obsažených ve výchozím textu a tabulce nahraďte v následujících větách (16.1–16.3) symbol ***** správným výrazem nebo číslem.','16.1 Zatímco do listopadové revoluce celkový počet obyvatel v našem regionu *****, po roce 1989 se zvýšil o jednu *****.','16.2 Ve třech obcích, které měly po válce více než $1\\,000$ obyvatel, za posledních $67$ let klesl počet obyvatel o ***** % a staly se z nich v podstatě rekreační oblasti.','16.3 Koncentrace obyvatelstva do ***** a do ***** po listopadu 1989 výrazně zesílila. Jestliže po válce v nich žila jen necelá ***** obyvatel regionu, nyní v obou městečkách žije *****krát více obyvatel než ve zbývajících čtyřech obcích našeho regionu.'},
  null,
  5,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300" font-family="sans-serif" font-size="15"> <rect x="20" y="20" width="460" height="250" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="180" y1="50" x2="180" y2="270" stroke="#000" stroke-width="1"/> <line x1="280" y1="50" x2="280" y2="270" stroke="#000" stroke-width="1"/> <line x1="380" y1="50" x2="380" y2="270" stroke="#000" stroke-width="1"/> <line x1="20" y1="50" x2="480" y2="50" stroke="#000" stroke-width="1"/> <line x1="20" y1="80" x2="480" y2="80" stroke="#000" stroke-width="1.5"/> <line x1="20" y1="110" x2="480" y2="110" stroke="#000" stroke-width="1"/> <line x1="20" y1="140" x2="480" y2="140" stroke="#000" stroke-width="1"/> <line x1="20" y1="170" x2="480" y2="170" stroke="#000" stroke-width="1"/> <line x1="20" y1="200" x2="480" y2="200" stroke="#000" stroke-width="1"/> <line x1="20" y1="230" x2="480" y2="230" stroke="#000" stroke-width="1"/> <text x="250" y="40" text-anchor="middle" font-weight="bold">POČET OBYVATEL V LETECH</text> <text x="230" y="70" text-anchor="middle">1950</text> <text x="330" y="70" text-anchor="middle">1989</text> <text x="430" y="70" text-anchor="middle">2016</text> <text x="28" y="100">Borovnice</text><text x="230" y="100" text-anchor="middle">2500</text><text x="330" y="100" text-anchor="middle">1200</text><text x="430" y="100" text-anchor="middle">300</text> <text x="28" y="130">Chudenice</text><text x="230" y="130" text-anchor="middle">800</text><text x="330" y="130" text-anchor="middle">800</text><text x="430" y="130" text-anchor="middle">400</text> <text x="28" y="160">Janoslavice</text><text x="230" y="160" text-anchor="middle">2100</text><text x="330" y="160" text-anchor="middle">1600</text><text x="430" y="160" text-anchor="middle">400</text> <text x="28" y="190">Petrcíle</text><text x="230" y="190" text-anchor="middle">2000</text><text x="330" y="190" text-anchor="middle">3000</text><text x="430" y="190" text-anchor="middle">6300</text> <text x="28" y="220">Sedmilhářov</text><text x="230" y="220" text-anchor="middle">4000</text><text x="330" y="220" text-anchor="middle">5000</text><text x="430" y="220" text-anchor="middle">6500</text> <text x="28" y="252">Zubyboly</text><text x="230" y="252" text-anchor="middle">1400</text><text x="330" y="252" text-anchor="middle">1200</text><text x="430" y="252" text-anchor="middle">500</text> </svg>',
  'tabulka-obyvatele.svg',
  'Tabulka počtu obyvatel šesti obcí v letech 1950, 1989 a 2016.',
  'Počet obyvatel v letech 1950, 1989 a 2016',
  new List<String>{'16.1 Součet 1950 i 1989 je $12\\,800$ (počet stagnoval). V roce 2016 je $14\\,400$, nárůst $1\\,600$, tj. $\\frac{1\\,600}{12\\,800}=\\frac{1}{8}$ (osmina).','16.2 Obce s poklesem a více než $1\\,000$ obyvateli po válce: Borovnice, Janoslavice, Zubyboly — dohromady $6\\,000$ v roce 1950 a $1\\,200$ v roce 2016. Pokles $\\frac{4\\,800}{6\\,000}=0{,}8=80\\,\\%$.','16.3 Rostoucí obce jsou Petrcíle a Sedmilhářov. V roce 1950 v nich žilo $6\\,000$ z $12\\,800$, tj. necelá polovina. V roce 2016 je to $12\\,800$, zatímco zbylé čtyři obce mají $1\\,600$; poměr $\\frac{12\\,800}{1\\,600}=8$ (osmkrát více).'},
  '16.1: stagnoval (neměnil se); o osminu; 16.2: o $80\\,\\%$; 16.3: Petrcíle a Sedmilhářov; (necelá) polovina; osmkrát',
  6, 9, '4',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
