String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD23C0T02';
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
  'CERMAT M9B 2023 – úloha 5.2',
  new List<String>{'Řešte rovnici. Uveďte celý postup řešení.','$3\\cdot\\frac{2y-1}{6}=\\frac{3y+2}{8}+\\frac{3}{4}\\cdot\\frac{y-1}{6}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Levá strana: $3\\cdot\\frac{2y-1}{6}=\\frac{2y-1}{2}$. Pravá strana: $\\frac{3y+2}{8}+\\frac{3(y-1)}{24}=\\frac{3y+2}{8}+\\frac{y-1}{8}=\\frac{4y+1}{8}$. Z rovnice $\\frac{2y-1}{2}=\\frac{4y+1}{8}$ po vynásobení osmi plyne $4(2y-1)=4y+1$, tj. $8y-4=4y+1$, $4y=5$, $y=\\frac{5}{4}$.'},
  '$y=\\frac{5}{4}$',
  2, 5, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2023 – úloha 6',
  new List<String>{'V chatě za polárním kruhem jsou připraveny zásoby masa pro 12člennou expedici přesně na 30 dní. Každý člen expedice spotřebuje za den z připravených zásob stejné množství masa.','6.1 Vypočtěte, za kolik dní by 12členná expedice spotřebovala pět šestin připravených zásob masa.','6.2 Vypočtěte, kolikačlenná expedice by všechny připravené zásoby masa spotřebovala za 45 dní.','6.3 Dvě expedice společně spotřebovaly všechny připravené zásoby masa. První expedice pobývala na chatě 4 dny. Druhá expedice měla dvakrát více členů než první a pobývala na chatě 8 dní. Vypočtěte, kolik členů měla první expedice.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Celkové zásoby odpovídají $12\\cdot 30=360$ člověkodnům.','6.1 Pět šestin zásob je $\\frac{5}{6}\\cdot 360=300$ člověkodnů; 12členná expedice je spotřebuje za $300:12=25$ dní.','6.2 Za 45 dní spotřebuje všechny zásoby expedice o počtu $360:45=8$ členů.','6.3 Označme počet členů první expedice $p$. Platí $4\\cdot p+8\\cdot 2p=360$, tj. $20p=360$, tedy $p=18$ členů (druhá expedice měla 36 členů).'},
  '6.1: za $25$ dní; 6.2: $8$členná expedice; 6.3: $18$ členů',
  4, 7, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2023 – úloha 7',
  new List<String>{'Ondrovi trvá cesta do práce autobusem dvakrát déle než rychlíkem. Osobním vlakem mu trvá cesta do práce o čtvrtinu déle než autobusem. Dobu Ondrovy cesty do práce autobusem označíme $x$.','7.1 Vyjádřete výrazem s proměnnou $x$, jak dlouho trvá Ondrovi cesta do práce rychlíkem.','7.2 Vyjádřete výrazem s proměnnou $x$, jak dlouho trvá Ondrovi cesta do práce osobním vlakem.','7.3 Cesta do práce trvá Ondrovi rychlíkem o 15 minut méně než osobním vlakem. Vypočtěte, kolik minut trvá Ondrovi cesta do práce autobusem.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'7.1 Autobusem trvá cesta dvakrát déle než rychlíkem, proto rychlíkem trvá $\\frac{1}{2}x$.','7.2 Osobním vlakem trvá cesta o čtvrtinu déle než autobusem: $x+\\frac{1}{4}x=\\frac{5}{4}x$.','7.3 Z podmínky $\\frac{5}{4}x-\\frac{1}{2}x=15$ plyne $\\frac{3}{4}x=15$, tedy $x=20$ minut.'},
  '7.1: $\\frac{1}{2}x$; 7.2: $\\frac{5}{4}x$; 7.3: $20$ minut',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
