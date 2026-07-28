String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M5A 2015 – úloha 14',
  new List<String>{'Na každé stěně hrací kostky je napsáno jedno z čísel 1, 2, 3, 4, 5 nebo 6. Součet čísel na protějších stěnách hrací kostky je vždy 7, tedy proti číslu 1 je 6, proti 3 je 4 a proti 5 je 2.','Milan postavil z pěti hracích kostek stavbu (viz obrázek). Všechny kostky natočil stejně, a to tak, že nahoře je číslo 1, vpředu 5 a vpravo 3.','Jaký je součet všech čísel na povrchu stojící stavby? (Nepřičítají se čísla na spodní ploše stavby.)'},
  new List<String>{'A) 50','B) 59','C) 63','D) 65','E) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 290" font-family="sans-serif"><polygon points="110,182 166,182 194,162 138,162" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="152.0" y="179.0" font-size="20" font-weight="bold" text-anchor="middle">1</text><polygon points="110,238 166,238 166,182 110,182" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="138.0" y="217.0" font-size="20" font-weight="bold" text-anchor="middle">5</text><polygon points="166,238 194,218 194,162 166,182" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="180.0" y="207.0" font-size="20" font-weight="bold" text-anchor="middle">3</text><polygon points="54,182 110,182 110,126 54,126" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="82.0" y="161.0" font-size="20" font-weight="bold" text-anchor="middle">5</text><polygon points="110,182 138,162 138,106 110,126" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="124.0" y="151.0" font-size="20" font-weight="bold" text-anchor="middle">3</text><polygon points="54,70 110,70 138,50 82,50" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="96.0" y="67.0" font-size="20" font-weight="bold" text-anchor="middle">1</text><polygon points="54,126 110,126 110,70 54,70" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="82.0" y="105.0" font-size="20" font-weight="bold" text-anchor="middle">5</text><polygon points="110,126 138,106 138,50 110,70" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="124.0" y="95.0" font-size="20" font-weight="bold" text-anchor="middle">3</text><polygon points="26,202 82,202 110,182 54,182" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="68.0" y="199.0" font-size="20" font-weight="bold" text-anchor="middle">1</text><polygon points="26,258 82,258 82,202 26,202" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="54.0" y="237.0" font-size="20" font-weight="bold" text-anchor="middle">5</text><polygon points="82,258 110,238 110,182 82,202" fill="#fff" stroke="#000" stroke-width="2.5"/><text x="96.0" y="227.0" font-size="20" font-weight="bold" text-anchor="middle">3</text></svg>',
  'stavba-kostky.svg',
  'Stavba z pěti stejných hracích kostek: sloupec tří kostek vzadu vlevo, jedna kostka vpředu a jedna vpravo.',
  'Schematický nákres stavby z pěti hracích kostek',
  new List<String>{'Součet čísel na všech stěnách jedné kostky je $1+2+3+4+5+6=21$, u pěti kostek tedy $5\\cdot 21=105$.','Všechny kostky jsou natočeny stejně, dole je proto u každé z 3 kostek stojících na podložce číslo 6, celkem $3\\cdot 6=18$.','V každém ze 4 dotyků se skryjí dvě protilehlé stěny, jejichž součet je 7, celkem tedy $4\\cdot 7=28$.','Součet čísel na povrchu je $105-18-28=59$.'},
  'B) 59',
  2, 5, '4',
  new List<String>{'zs1','stereometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
