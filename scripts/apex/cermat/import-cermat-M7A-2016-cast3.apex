String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M7A 2016 – úloha 8',
  new List<String>{'Cesta na nádraží po silnici je dlouhá 1 500 m a Mirkovi trvala 20 minut. Nyní Mirek chodí lesní pěšinou, a cestu si tak zkrátil o 225 m.','Mirek chodí stále stejně rychle. Délka každého jeho kroku je $\\frac{3}{4}$ metru.','Uveďte postup řešení.','8.1 Vypočtěte, o kolik kroků si Mirek zkrátil cestu na nádraží.','8.2 Vypočtěte, o kolik minut si Mirek zkrátil cestu na nádraží.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'8.1 Počet kroků na 225 m: $225:\\frac{3}{4}=225\\cdot\\frac{4}{3}=300$ kroků.','8.2 Mirek ujde za minutu $1\\,500:20=75$ metrů, tedy $225:75=3$ minuty.'},
  '8.1: o $300$ kroků; 8.2: o $3$ minuty',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2016 – úloha 9',
  new List<String>{'Těleso je slepeno ze dvou shodných kvádrů s délkami hran 3 cm, 3 cm a 5 cm (viz obrázek).','Uveďte postup řešení.','9.1 Vypočtěte v cm³ objem slepeného tělesa.','9.2 Vypočtěte v cm² povrch slepeného tělesa.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 210" font-family="sans-serif"><polygon points="60,170 60,70 120,70 120,110 220,110 220,170" fill="#f2f2f2" stroke="#000" stroke-width="2"/><polyline points="98,42 158,42 158,82 258,82 258,142" fill="none" stroke="#000" stroke-width="2"/><line x1="60" y1="70" x2="98" y2="42" stroke="#000" stroke-width="2"/><line x1="120" y1="70" x2="158" y2="42" stroke="#000" stroke-width="2"/><line x1="120" y1="110" x2="158" y2="82" stroke="#000" stroke-width="2"/><line x1="220" y1="110" x2="258" y2="82" stroke="#000" stroke-width="2"/><line x1="220" y1="170" x2="258" y2="142" stroke="#000" stroke-width="2"/><line x1="60" y1="170" x2="98" y2="142" stroke="#888" stroke-width="1.5" stroke-dasharray="5,4"/><line x1="98" y1="142" x2="98" y2="42" stroke="#888" stroke-width="1.5" stroke-dasharray="5,4"/><line x1="98" y1="142" x2="258" y2="142" stroke="#888" stroke-width="1.5" stroke-dasharray="5,4"/><text x="46" y="126" font-size="14" text-anchor="end">5 cm</text><text x="176" y="104" font-size="14" text-anchor="middle">5 cm</text><text x="266" y="146" font-size="14">3 cm</text><text x="240" y="186" font-size="14">3 cm</text><text x="140" y="192" font-size="14" text-anchor="middle">8 cm</text></svg>',
  'teleso-kvadry.svg',
  'Těleso slepené ze dvou shodných kvádrů 3 krát 3 krát 5 cm; stojící kvádr je vysoký 5 cm, ležící kvádr je vysoký 3 cm, celková délka je 8 cm a hloubka 3 cm.',
  'Těleso slepené ze dvou shodných kvádrů',
  new List<String>{'9.1 Objem jednoho kvádru je $3\\cdot 3\\cdot 5=45$ cm³, objem tělesa je $2\\cdot 45=90$ cm³.','9.2 Povrch jednoho kvádru: $2\\cdot(3\\cdot 3+3\\cdot 5+3\\cdot 5)=2\\cdot 39=78$ cm², oba dohromady $156$ cm².','Slepením se skryjí dvě čtvercové plochy o obsahu $3\\cdot 3=9$ cm², proto $S=156-2\\cdot 9=138$ cm².'},
  '9.1: $90$ cm³; 9.2: $138$ cm²',
  3, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
