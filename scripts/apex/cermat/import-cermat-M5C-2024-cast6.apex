String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD24C0T03';
Integer YEAR = 2024;

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
  'CERMAT M5C 2024 – úloha 13',
  new List<String>{'Katka jezdí každé ráno do školy a odpoledne ze školy na kole. Cesta do školy je do kopce, takže Katce trvá dvakrát déle než cesta ze školy. Obě cesty dohromady trvají Katce každý den $33$ minut.','Ke každé podúloze (13.1–13.3) přiřaďte správný výsledek (A–F).','13.1 V kolik hodin ráno nejpozději musí Katka vyjíždět do školy, aby byla ve škole právě $10$ minut před začátkem vyučování, které začíná v $8{:}00$?','13.2 V kolik hodin ráno musí Katka nejpozději vycházet pěšky do školy, pokud má její třída sraz před školou v $8{:}10$ a cesta do školy pěšky jí trvá dvakrát déle než na kole?','13.3 Pokud venku prší, jede Katka do školy autobusem. Autobusem Katce trvá cesta do školy stejně dlouho, jako jí trvá cesta ze školy na kole. V kolik hodin jí autobus vyjíždí od domu, pokud ke škole autobus přijíždí v $7{:}43$?'},
  new List<String>{'A) $7{:}24$','B) $7{:}26$','C) $7{:}28$','D) $7{:}30$','E) $7{:}32$','F) $7{:}34$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Cesta do školy trvá dvakrát déle než ze školy a součet je $33$ min: cesta ze školy $=11$ min, cesta do školy $=22$ min.','13.1 Ve škole být v $7{:}50$ (10 min před $8{:}00$); $7{:}50$ mínus $22$ min $=7{:}28$ → C.','13.2 Pěšky do školy trvá $2\\cdot 22=44$ min; u školy být v $8{:}10$; $8{:}10$ mínus $44$ min $=7{:}26$ → B.','13.3 Autobusem trvá cesta $11$ min (jako ze školy na kole); $7{:}43$ mínus $11$ min $=7{:}32$ → E.'},
  '13.1: C ($7{:}28$); 13.2: B ($7{:}26$); 13.3: E ($7{:}32$)',
  3, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2024 – úloha 14',
  new List<String>{'Tereza a Pepa šli hrát kuličky. Tereza si přinesla jen červené kuličky, měla jich $40$. Pepa si přinesl jen modré kuličky. První hru vyhrál Pepa a od Terezy vyhrál jednu čtvrtinu jejích červených kuliček. Druhou hru vyhrála Tereza a získala tak od Pepy $16$ modrých kuliček. Po těchto dvou hrách měli Pepa i Tereza stejný počet kuliček.','14.1 Kolik modrých kuliček měla Tereza po těchto dvou hrách?','14.2 Kolik kuliček měli Tereza a Pepa dohromady?','14.3 Kolik modrých kuliček si na začátku přinesl Pepa?'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'14.1 Tereza získala ve druhé hře $16$ modrých kuliček a jiné modré nemá – má tedy $16$ modrých kuliček.','14.2 Po hrách má Tereza $40-\\frac{40}{4}=30$ červených a $16$ modrých, celkem $46$ kuliček. Oba mají stejně, proto dohromady $2\\cdot 46=92$ kuliček.','14.3 Celkový počet kuliček se nemění a je $40$ (Tereziny) plus Pepovy modré. Z $40+p=92$ plyne $p=52$ modrých kuliček.'},
  '14.1: $16$; 14.2: $92$; 14.3: $52$',
  6, 7, '4',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
