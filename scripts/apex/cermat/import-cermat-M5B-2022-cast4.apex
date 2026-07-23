String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD22C0T02';
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
  'CERMAT M5B 2022 – úloha 8',
  new List<String>{'V prvních dvou lednových týdnech učitel matematiky vyzkoušel všech 30 žáků třídy 5. A, a to každého právě jednou. Graf udává počty žáků vyzkoušených v jednotlivých dnech.','Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).','8.1 V 1. týdnu učitel vyzkoušel o 6 žáků méně než ve 2. týdnu.','8.2 Ve 2. týdnu učitel vyzkoušel v pátek sedmkrát více žáků než ve středu.','8.3 V úterý 11. 1. učitel vyzkoušel čtvrtinu z těch žáků, kteří nebyli vyzkoušeni v žádném z předchozích dnů.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 320" font-family="sans-serif"><line x1="62" y1="24" x2="62" y2="250" stroke="#000"/><line x1="62" y1="250" x2="632" y2="250" stroke="#000"/><line x1="58" y1="250" x2="62" y2="250" stroke="#000"/><text x="54" y="254" font-size="12" text-anchor="end">0</text><line x1="58" y1="224" x2="62" y2="224" stroke="#000"/><text x="54" y="228" font-size="12" text-anchor="end">1</text><line x1="58" y1="198" x2="62" y2="198" stroke="#000"/><text x="54" y="202" font-size="12" text-anchor="end">2</text><line x1="58" y1="172" x2="62" y2="172" stroke="#000"/><text x="54" y="176" font-size="12" text-anchor="end">3</text><line x1="58" y1="146" x2="62" y2="146" stroke="#000"/><text x="54" y="150" font-size="12" text-anchor="end">4</text><line x1="58" y1="120" x2="62" y2="120" stroke="#000"/><text x="54" y="124" font-size="12" text-anchor="end">5</text><line x1="58" y1="94" x2="62" y2="94" stroke="#000"/><text x="54" y="98" font-size="12" text-anchor="end">6</text><line x1="58" y1="68" x2="62" y2="68" stroke="#000"/><text x="54" y="72" font-size="12" text-anchor="end">7</text><line x1="58" y1="42" x2="62" y2="42" stroke="#000"/><text x="54" y="46" font-size="12" text-anchor="end">8</text><rect x="76" y="172" width="44" height="78" fill="#6f6f6f" stroke="#000"/><text x="98.0" y="266" font-size="11" text-anchor="middle">Po</text><text x="98.0" y="280" font-size="10" text-anchor="middle">3. 1.</text><text x="152.0" y="266" font-size="11" text-anchor="middle">Út</text><text x="152.0" y="280" font-size="10" text-anchor="middle">4. 1.</text><rect x="184" y="120" width="44" height="130" fill="#6f6f6f" stroke="#000"/><text x="206.0" y="266" font-size="11" text-anchor="middle">St</text><text x="206.0" y="280" font-size="10" text-anchor="middle">5. 1.</text><rect x="238" y="198" width="44" height="52" fill="#6f6f6f" stroke="#000"/><text x="260.0" y="266" font-size="11" text-anchor="middle">Čt</text><text x="260.0" y="280" font-size="10" text-anchor="middle">6. 1.</text><rect x="292" y="198" width="44" height="52" fill="#6f6f6f" stroke="#000"/><text x="314.0" y="266" font-size="11" text-anchor="middle">Pá</text><text x="314.0" y="280" font-size="10" text-anchor="middle">7. 1.</text><rect x="364" y="94" width="44" height="156" fill="#6f6f6f" stroke="#000"/><text x="386.0" y="266" font-size="11" text-anchor="middle">Po</text><text x="386.0" y="280" font-size="10" text-anchor="middle">10. 1.</text><rect x="418" y="172" width="44" height="78" fill="#6f6f6f" stroke="#000"/><text x="440.0" y="266" font-size="11" text-anchor="middle">Út</text><text x="440.0" y="280" font-size="10" text-anchor="middle">11. 1.</text><text x="494.0" y="266" font-size="11" text-anchor="middle">St</text><text x="494.0" y="280" font-size="10" text-anchor="middle">12. 1.</text><rect x="526" y="198" width="44" height="52" fill="#6f6f6f" stroke="#000"/><text x="548.0" y="266" font-size="11" text-anchor="middle">Čt</text><text x="548.0" y="280" font-size="10" text-anchor="middle">13. 1.</text><rect x="580" y="68" width="44" height="182" fill="#6f6f6f" stroke="#000"/><text x="602.0" y="266" font-size="11" text-anchor="middle">Pá</text><text x="602.0" y="280" font-size="10" text-anchor="middle">14. 1.</text><text x="26" y="150" font-size="11" text-anchor="middle" transform="rotate(-90 26 150)">Počet vyzkoušených žáků</text><text x="200" y="300" font-size="12" text-anchor="middle">1. týden</text><text x="480" y="300" font-size="12" text-anchor="middle">2. týden</text></svg>',
  'graf-vyzkouseni.svg',
  'Sloupcový graf počtu vyzkoušených žáků v deseti dnech dvou lednových týdnů.',
  'Počty vyzkoušených žáků v jednotlivých dnech',
  new List<String>{'8.1 V 1. týdnu vyzkoušel $3+0+5+2+2=12$ žáků, ve 2. týdnu $6+3+0+2+7=18$ žáků; $18-12=6$, tvrzení platí (Ano).','8.2 Ve středu 2. týdne vyzkoušel 0 žáků, v pátek 7 žáků; 7 není sedminásobek nuly, tvrzení neplatí (Ne).','8.3 Před úterým 11. 1. nebylo vyzkoušeno $30-(3+0+5+2+2+6)=12$ žáků; jejich čtvrtina je $3$, což je počet vyzkoušených v úterý 11. 1., tvrzení platí (Ano).'},
  '8.1: Ano; 8.2: Ne; 8.3: Ano',
  4, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
