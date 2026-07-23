String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD24C0T01';
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
  'CERMAT M5A 2024 - uloha 12',
  new List<String>{'Graf znazornuje prirustek a ubytek obyvatel v obcich Lidov, Damov a Panov v letech 2019-2022 (viz obrazek).','12.1 Jak se zmenil pocet obyvatel v Panove behem roku 2021? (A) Ubylo $5$ obyvatel; (B) Ubylo $10$ obyvatel; (C) Pocet obyvatel se nezmenil; (D) Pribylo $5$ obyvatel; (E) Pribylo $10$ obyvatel.','12.2 Jestlize na pocatku ctyrleteho obdobi $1$. ledna $2019$ zilo v Lidove $300$ obyvatel, kolik obyvatel zilo ve stejne obci po trech letech $31$. prosince $2021$? (A) $290$; (B) $295$; (C) $305$; (D) $310$; (E) $315$.','12.3 Jak se zmenil pocet obyvatel v Damove za vsechny ctyri roky dohromady? (A) Ubylo $5$ obyvatel; (B) Pocet obyvatel se nezmenil; (C) Pribylo $5$ obyvatel; (D) Pribylo $15$ obyvatel; (E) Jiny vysledek.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 330" font-family="sans-serif"><defs><pattern id="hatch" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><line x1="0" y1="0" x2="0" y2="6" stroke="#333" stroke-width="1.6"/></pattern></defs><line x1="60" y1="45" x2="60" y2="295" stroke="#000"/><line x1="60" y1="170" x2="520" y2="170" stroke="#000"/><line x1="56" y1="130" x2="60" y2="130" stroke="#000"/><text x="52" y="134" font-size="11" text-anchor="end">5</text><line x1="56" y1="210" x2="60" y2="210" stroke="#000"/><text x="52" y="214" font-size="11" text-anchor="end">5</text><line x1="56" y1="90" x2="60" y2="90" stroke="#000"/><text x="52" y="94" font-size="11" text-anchor="end">10</text><line x1="56" y1="250" x2="60" y2="250" stroke="#000"/><text x="52" y="254" font-size="11" text-anchor="end">10</text><line x1="56" y1="50" x2="60" y2="50" stroke="#000"/><text x="52" y="54" font-size="11" text-anchor="end">15</text><line x1="56" y1="290" x2="60" y2="290" stroke="#000"/><text x="52" y="294" font-size="11" text-anchor="end">15</text><rect x="90" y="90" width="24" height="80" fill="#eeeeee" stroke="#000"/><rect x="118" y="170" width="24" height="40" fill="url(#hatch)" stroke="#000"/><rect x="146" y="170" width="24" height="80" fill="#8a8a8a" stroke="#000"/><text x="130" y="315" font-size="12" text-anchor="middle">2019</text><rect x="196" y="130" width="24" height="40" fill="#eeeeee" stroke="#000"/><rect x="224" y="170" width="24" height="80" fill="url(#hatch)" stroke="#000"/><rect x="252" y="130" width="24" height="40" fill="#8a8a8a" stroke="#000"/><text x="236" y="315" font-size="12" text-anchor="middle">2020</text><rect x="302" y="170" width="24" height="40" fill="#eeeeee" stroke="#000"/><rect x="330" y="90" width="24" height="80" fill="url(#hatch)" stroke="#000"/><rect x="358" y="90" width="24" height="80" fill="#8a8a8a" stroke="#000"/><text x="342" y="315" font-size="12" text-anchor="middle">2021</text><rect x="408" y="130" width="24" height="40" fill="#eeeeee" stroke="#000"/><rect x="436" y="130" width="24" height="40" fill="url(#hatch)" stroke="#000"/><rect x="464" y="90" width="24" height="80" fill="#8a8a8a" stroke="#000"/><text x="448" y="315" font-size="12" text-anchor="middle">2022</text><text x="22" y="98" font-size="11" text-anchor="middle" transform="rotate(-90 22 98)">prirustek</text><text x="22" y="242" font-size="11" text-anchor="middle" transform="rotate(-90 22 242)">ubytek</text><rect x="430" y="25" width="14" height="14" fill="#eeeeee" stroke="#000"/><text x="450" y="37" font-size="12">Lidov</text><rect x="430" y="45" width="14" height="14" fill="url(#hatch)" stroke="#000"/><text x="450" y="57" font-size="12">Damov</text><rect x="430" y="65" width="14" height="14" fill="#8a8a8a" stroke="#000"/><text x="450" y="77" font-size="12">Panov</text></svg>',
  'graf-obyvatel.svg',
  'Sloupcovy graf prirustku a ubytku obyvatel obci Lidov, Damov a Panov v letech 2019 az 2022.',
  'Prirustek a ubytek obyvatel (2019-2022)',
  new List<String>{'12.1 Panov ma v roce $2021$ sloupec $+10$, pribylo tedy $10$ obyvatel -> E.','12.2 Lidov: $2019$ pribylo $10$, $2020$ pribylo $5$, $2021$ ubylo $5$. $300+10+5-5=310$ -> D.','12.3 Damov: $2019$ $-5$, $2020$ $-10$, $2021$ $+10$, $2022$ $+5$; celkem $-5-10+10+5=0$, pocet se nezmenil -> B.'},
  '12.1: E (pribylo $10$ obyvatel); 12.2: D ($310$); 12.3: B (pocet obyvatel se nezmenil)',
  3, 5, '3',
  new List<String>{'zs1','statistika','vypocet','pocetni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
