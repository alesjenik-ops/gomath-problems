String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD22C0T02';
Integer YEAR = 2022;

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
  'CERMAT M7B 2022 – úloha 10',
  new List<String>{'V prvních dvou lednových týdnech učitel matematiky vyzkoušel všech $30$ žáků třídy 7. A, a to každého právě jednou. Graf udává počty žáků vyzkoušených v jednotlivých dnech.','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).','10.1 V 1. týdnu učitel vyzkoušel dvě pětiny žáků třídy 7. A.','10.2 Ve 2. týdnu učitel vyzkoušel v pátek sedmkrát více žáků než ve středu.','10.3 V úterý 11. 1. učitel vyzkoušel čtvrtinu z těch žáků, kteří nebyli vyzkoušeni v žádném z předchozích dnů.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 340" font-family="sans-serif" font-size="12"><line x1="70" y1="30" x2="70" y2="270" stroke="#000"/><line x1="70" y1="270" x2="590" y2="270" stroke="#000"/><line x1="66" y1="270" x2="70" y2="270" stroke="#000"/><text x="61" y="274" text-anchor="end">0</text><line x1="66" y1="242" x2="70" y2="242" stroke="#000"/><text x="61" y="246" text-anchor="end">1</text><line x1="70" y1="242" x2="590" y2="242" stroke="#eeeeee"/><line x1="66" y1="214" x2="70" y2="214" stroke="#000"/><text x="61" y="218" text-anchor="end">2</text><line x1="70" y1="214" x2="590" y2="214" stroke="#eeeeee"/><line x1="66" y1="186" x2="70" y2="186" stroke="#000"/><text x="61" y="190" text-anchor="end">3</text><line x1="70" y1="186" x2="590" y2="186" stroke="#eeeeee"/><line x1="66" y1="158" x2="70" y2="158" stroke="#000"/><text x="61" y="162" text-anchor="end">4</text><line x1="70" y1="158" x2="590" y2="158" stroke="#eeeeee"/><line x1="66" y1="130" x2="70" y2="130" stroke="#000"/><text x="61" y="134" text-anchor="end">5</text><line x1="70" y1="130" x2="590" y2="130" stroke="#eeeeee"/><line x1="66" y1="102" x2="70" y2="102" stroke="#000"/><text x="61" y="106" text-anchor="end">6</text><line x1="70" y1="102" x2="590" y2="102" stroke="#eeeeee"/><line x1="66" y1="74" x2="70" y2="74" stroke="#000"/><text x="61" y="78" text-anchor="end">7</text><line x1="70" y1="74" x2="590" y2="74" stroke="#eeeeee"/><line x1="66" y1="46" x2="70" y2="46" stroke="#000"/><text x="61" y="50" text-anchor="end">8</text><line x1="70" y1="46" x2="590" y2="46" stroke="#eeeeee"/><rect x="84" y="186" width="34" height="84" fill="#8a8a8a" stroke="#000"/><text x="101.0" y="286" text-anchor="middle">Po</text><text x="101.0" y="300" text-anchor="middle">3. 1.</text><text x="149.0" y="286" text-anchor="middle">Út</text><text x="149.0" y="300" text-anchor="middle">4. 1.</text><rect x="180" y="130" width="34" height="140" fill="#8a8a8a" stroke="#000"/><text x="197.0" y="286" text-anchor="middle">St</text><text x="197.0" y="300" text-anchor="middle">5. 1.</text><rect x="228" y="214" width="34" height="56" fill="#8a8a8a" stroke="#000"/><text x="245.0" y="286" text-anchor="middle">Čt</text><text x="245.0" y="300" text-anchor="middle">6. 1.</text><rect x="276" y="214" width="34" height="56" fill="#8a8a8a" stroke="#000"/><text x="293.0" y="286" text-anchor="middle">Pá</text><text x="293.0" y="300" text-anchor="middle">7. 1.</text><rect x="324" y="102" width="34" height="168" fill="#8a8a8a" stroke="#000"/><text x="341.0" y="286" text-anchor="middle">Po</text><text x="341.0" y="300" text-anchor="middle">10. 1.</text><rect x="372" y="186" width="34" height="84" fill="#8a8a8a" stroke="#000"/><text x="389.0" y="286" text-anchor="middle">Út</text><text x="389.0" y="300" text-anchor="middle">11. 1.</text><text x="437.0" y="286" text-anchor="middle">St</text><text x="437.0" y="300" text-anchor="middle">12. 1.</text><rect x="468" y="214" width="34" height="56" fill="#8a8a8a" stroke="#000"/><text x="485.0" y="286" text-anchor="middle">Čt</text><text x="485.0" y="300" text-anchor="middle">13. 1.</text><rect x="516" y="74" width="34" height="196" fill="#8a8a8a" stroke="#000"/><text x="533.0" y="286" text-anchor="middle">Pá</text><text x="533.0" y="300" text-anchor="middle">14. 1.</text><line x1="317" y1="30" x2="317" y2="270" stroke="#000" stroke-dasharray="3 4"/><text x="197" y="320" text-anchor="middle">1. týden</text><text x="437" y="320" text-anchor="middle">2. týden</text><text x="24" y="150" text-anchor="middle" transform="rotate(-90 24 150)">Počet vyzkoušených žáků</text></svg>',
  'graf-vyzkouseni.svg',
  'Sloupcový graf počtu vyzkoušených žáků v deseti dnech dvou lednových týdnů: 1. týden 3, 0, 5, 2, 2; 2. týden 6, 3, 0, 2, 7.',
  'Počty vyzkoušených žáků v jednotlivých dnech',
  new List<String>{'Počty vyzkoušených: 1. týden $3+0+5+2+2=12$, 2. týden $6+3+0+2+7=18$ (celkem $30$).','10.1 $12$ je $\\frac{2}{5}$ z $30$ — pravda (A).','10.2 V pátek $7$ žáků, ve středu $0$ žáků; $7$ není sedminásobek nuly — nepravda (N).','10.3 Do úterý bylo vyzkoušeno $12+6=18$ žáků, nevyzkoušeno zbývá $30-18=12$; jejich čtvrtina je $3$, což odpovídá počtu vyzkoušených v úterý — pravda (A).'},
  '10.1: Ano; 10.2: Ne; 10.3: Ano',
  4, 5, '3',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
