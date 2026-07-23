String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD23C0T01';
Integer YEAR = 2023;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M7A 2023 - uloha 14',
  new List<String>{'Maminka koupila v cukrarne tri ruzne zakusky. Prvni zakusek stal 72 korun. Druhy zakusek byl o ctvrtinu levnejsi nez prvni. Cena tretiho zakusku byla tretinou celkove ceny vsech tri zakusku.','O kolik korun byl treti zakusek drazsi nez druhy?'},
  new List<String>{'A) o mene nez $12$ korun','B) o $12$ korun','C) o $15$ korun','D) o $18$ korun','E) o vice nez $18$ korun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Druhy zakusek: $72-\\frac{1}{4}\\cdot 72=72-18=54$ korun. Oznacme celkovou cenu $s$; treti $=\\frac{s}{3}$, takze $s=72+54+\\frac{s}{3}$, odtud $\\frac{2}{3}s=126$, $s=189$. Treti zakusek $\\frac{189}{3}=63$ korun. Rozdil $63-54=9$ korun, coz je mene nez $12$ korun.'},
  'A) o mene nez $12$ korun',
  2, 4, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M7A 2023 - uloha 15',
  new List<String>{'Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).','15.1 Kniha ma 1 200 stran, z nichz Roza jiz 60 % precetla. Kolik stran Roza dosud neprecetla?','15.2 Detske vstupne predstavuje 70 % vstupneho pro dospele. Vstupne pro dospele je o 210 korun vyssi nez detske. Kolik korun cini detske vstupne?','15.3 K dvoudennim volbam mohli prijit vsichni dospeli obyvatele obce. Prvni den prislo 25 % z nich, coz bylo 500 obyvatel. Druhy den prislo jeste 70 % ze zbyvajicich dospelych obyvatel obce. Kolik dospelych obyvatel obce k volbam neprislo?'},
  new List<String>{'A) mene nez $450$','B) $450$','C) $480$','D) $490$','E) $500$','F) vice nez $500$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Neprecetla $40\\,\\%$ z $1\\,200$, tj. $0{,}4\\cdot 1\\,200=480$ stran, tedy C.','15.2 Dospele vstupne $d$, detske $0{,}7d$; $d-0{,}7d=210$, $0{,}3d=210$, $d=700$. Detske $0{,}7\\cdot 700=490$ korun, tedy D.','15.3 $25\\,\\%$ je $500$, celkem $2\\,000$ dospelych. Zbyva $1\\,500$; druhy den prislo $70\\,\\%$ z $1\\,500=1\\,050$. Neprislo $1\\,500-1\\,050=450$, tedy B.'},
  '15.1: C ($480$); 15.2: D ($490$); 15.3: B ($450$)',
  6, 9, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
