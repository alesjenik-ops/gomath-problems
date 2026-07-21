String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. řádný termín (M9A)';
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
  'CERMAT 2025 M9A · úloha 13',
  new List<String>{'Tábory se pořádaly ve dvou termínech se stejným počtem nabízených míst. Sešlo se celkem $375$ přihlášek. V prvním termínu počet přihlášek překročil počet míst o pětinu, ve druhém termínu o $30\\ \\%$.','Kolik přihlášek celkem muselo být kvůli nedostatku míst odmítnuto?'},
  new List<String>{'A) $65$ přihlášek','B) $75$ přihlášek','C) $80$ přihlášek','D) $85$ přihlášek','E) jiný počet přihlášek'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť je $m$ míst v každém termínu: $1{,}2m+1{,}3m=2{,}5m=375\\Rightarrow m=150$.','Odmítnuto: $0{,}2m+0{,}3m=0{,}5m=75$ přihlášek.'},
  'B) $75$ přihlášek',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PAD25C0T01', 2025
);
c.add(
  'CERMAT 2025 M9A · úloha 14',
  new List<String>{'Test z matematiky psalo $20$ žáků. Nejhorší známka byla $3$ (známky $4$ a $5$ nikdo nedostal). Počet jedniček a dvojek byl stejný. Aritmetický průměr známek byl $1{,}8$.','Kolik žáků dostalo z testu známku $1$?'},
  new List<String>{'A) $5$ žáků','B) $6$ žáků','C) $7$ žáků','D) $8$ žáků','E) $9$ žáků'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť je $k$ jedniček i dvojek, pak trojek je $20-2k$.','$\\frac{1\\cdot k+2\\cdot k+3\\cdot(20-2k)}{20}=1{,}8\\Rightarrow 60-3k=36\\Rightarrow k=8$.'},
  'D) $8$ žáků',
  2, 4, '3',
  new List<String>{'zs2','r9','statistika','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PAD25C0T01', 2025
);
c.add(
  'CERMAT 2025 M9A · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Nastoupilo $10$ družstev po $11$ hráčích a všichni organizátoři, dohromady $200$ osob. Kolik procent osob tvořili organizátoři?','15.2 Soutěže se účastnilo $20$ tříčlenných družstev, v každém aspoň jeden muž a aspoň jedna žena. Družstev s jedním mužem bylo čtyřikrát více než družstev s jednou ženou. Kolik procent soutěžících tvořily ženy?','15.3 Každý atlet soutěžil v jedné ze tří disciplín. V hodu oštěpem $12$ atletů. Skokanů bylo o $40\\ \\%$ méně než běžců, ale o $50\\ \\%$ více než oštěpařů. Kolik procent soutěžících tvořili běžci?'},
  new List<String>{'A) $40\\ \\%$','B) $45\\ \\%$','C) $50\\ \\%$','D) $55\\ \\%$','E) $60\\ \\%$','F) více než $60\\ \\%$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: hráčů $10\\cdot11=110$, organizátorů $200-110=90$; $\\frac{90}{200}=45\\ \\%$ — B.','15.2: družstev s $1$ ženou (tj. $2$M$1$Ž) je $x$, s $1$ mužem (tj. $1$M$2$Ž) $4x$; $5x=20\\Rightarrow x=4$. Žen $4\\cdot1+16\\cdot2=36$ z $60$, tj. $60\\ \\%$ — E.','15.3: skokanů $1{,}5\\cdot12=18$; $18=0{,}6\\cdot$běžců $\\Rightarrow$ běžců $30$; celkem $30+18+12=60$; běžci $\\frac{30}{60}=50\\ \\%$ — C.'},
  '15.1: B ($45\\ \\%$); 15.2: E ($60\\ \\%$); 15.3: C ($50\\ \\%$)',
  6, 6, '4',
  new List<String>{'zs2','r9','procenta','slovni','modelovani','s-kalkulackou','bezny-zivot'},
  'M9PAD25C0T01', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
