String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD18C0T01';
Integer YEAR = 2018;

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
  'CERMAT M7A 2018 – úloha 13–14',
  new List<String>{'Třída 7. A s $20$ žáky spořila půl roku na podporu adoptovaného hrocha. Všichni žáci přispívali rovným dílem, ale každý měsíc vyšší částkou; příspěvek žáka se každý měsíc zvyšoval o stejnou částku. Z grafu lze vyčíst, jak v průběhu pěti měsíců narůstala naspořená částka celé třídy 7. A (např. za $3$ měsíce třída naspořila celkem $600$ korun).','13 O kolik korun se každý měsíc zvýšil příspěvek každého žáka třídy 7. A? A) o 5 korun; B) o 10 korun; C) o 15 korun; D) o 20 korun; E) o více než 20 korun','14 Kolika korunami přispěl každý žák během půl roku (celkem za 6 měsíců)? A) méně než 100 korunami; B) 100 korunami; C) 105 korunami; D) 110 korunami; E) více než 110 korunami'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 380" font-family="sans-serif" font-size="12"><text x="290" y="22" text-anchor="middle" font-size="15">Naspořená částka třídy 7. A</text><text x="18" y="200" transform="rotate(-90 18 200)" text-anchor="middle">Počet korun</text><line x1="70" y1="40" x2="70" y2="330" stroke="#000"/><line x1="70" y1="330" x2="540" y2="330" stroke="#000"/><line x1="70" y1="330.0" x2="540" y2="330.0" stroke="#e2e2e2"/><line x1="66" y1="330.0" x2="70" y2="330.0" stroke="#000"/><text x="62" y="334.0" text-anchor="end">0</text><line x1="70" y1="305.8333333333333" x2="540" y2="305.8333333333333" stroke="#e2e2e2"/><line x1="70" y1="281.6666666666667" x2="540" y2="281.6666666666667" stroke="#e2e2e2"/><line x1="66" y1="281.6666666666667" x2="70" y2="281.6666666666667" stroke="#000"/><text x="62" y="285.6666666666667" text-anchor="end">400</text><line x1="70" y1="257.5" x2="540" y2="257.5" stroke="#e2e2e2"/><line x1="70" y1="233.33333333333331" x2="540" y2="233.33333333333331" stroke="#e2e2e2"/><line x1="66" y1="233.33333333333331" x2="70" y2="233.33333333333331" stroke="#000"/><text x="62" y="237.33333333333331" text-anchor="end">800</text><line x1="70" y1="209.16666666666669" x2="540" y2="209.16666666666669" stroke="#e2e2e2"/><line x1="70" y1="185.0" x2="540" y2="185.0" stroke="#e2e2e2"/><line x1="66" y1="185.0" x2="70" y2="185.0" stroke="#000"/><text x="62" y="189.0" text-anchor="end">1200</text><line x1="70" y1="160.83333333333334" x2="540" y2="160.83333333333334" stroke="#e2e2e2"/><line x1="70" y1="136.66666666666666" x2="540" y2="136.66666666666666" stroke="#e2e2e2"/><line x1="66" y1="136.66666666666666" x2="70" y2="136.66666666666666" stroke="#000"/><text x="62" y="140.66666666666666" text-anchor="end">1600</text><line x1="70" y1="112.5" x2="540" y2="112.5" stroke="#e2e2e2"/><line x1="70" y1="88.33333333333334" x2="540" y2="88.33333333333334" stroke="#e2e2e2"/><line x1="66" y1="88.33333333333334" x2="70" y2="88.33333333333334" stroke="#000"/><text x="62" y="92.33333333333334" text-anchor="end">2000</text><line x1="70" y1="64.16666666666669" x2="540" y2="64.16666666666669" stroke="#e2e2e2"/><line x1="70" y1="40.0" x2="540" y2="40.0" stroke="#e2e2e2"/><line x1="66" y1="40.0" x2="70" y2="40.0" stroke="#000"/><text x="62" y="44.0" text-anchor="end">2400</text><rect x="94" y="317.9166666666667" width="44" height="12.083333333333334" fill="#9a9a9a" stroke="#000"/><text x="116.0" y="346" text-anchor="middle" font-size="11">za 1 měsíc</text><rect x="162" y="293.75" width="44" height="36.25" fill="#9a9a9a" stroke="#000"/><text x="184.0" y="346" text-anchor="middle" font-size="11">za 2 měsíce</text><rect x="230" y="257.5" width="44" height="72.5" fill="#9a9a9a" stroke="#000"/><text x="252.0" y="346" text-anchor="middle" font-size="11">za 3 měsíce</text><rect x="298" y="209.16666666666669" width="44" height="120.83333333333333" fill="#9a9a9a" stroke="#000"/><text x="320.0" y="346" text-anchor="middle" font-size="11">za 4 měsíce</text><rect x="366" y="148.75" width="44" height="181.25" fill="#9a9a9a" stroke="#000"/><text x="388.0" y="346" text-anchor="middle" font-size="11">za 5 měsíců</text><rect x="434" y="40" width="44" height="290" fill="none" stroke="#bbb" stroke-dasharray="4 4"/><text x="456.0" y="185.0" text-anchor="middle" font-size="26" font-weight="bold">?</text><text x="456.0" y="346" text-anchor="middle" font-size="11">za 6 měsíců</text></svg>',
  'graf-uspory.svg',
  'Sloupcový graf naspořené částky třídy za 1 až 6 měsíců: 100, 300, 600, 1000, 1500 korun; sloupec za 6 měsíců je označen otazníkem.',
  'Naspořená částka třídy 7. A',
  new List<String>{'Z grafu: naspořeno celkem za 1 až 5 měsíců je $100$, $300$, $600$, $1000$, $1500$ korun. Měsíční přírůstky celé třídy jsou $100$, $200$, $300$, $400$, $500$ korun, tedy každý měsíc o $100$ korun více.','13 Přírůstek celé třídy roste o $100$ korun měsíčně; na jednoho z $20$ žáků připadá $100:20=5$ korun → A).','14 Za $6$ měsíců naspoří třída celkem $1500+600=2100$ korun; na žáka $2100:20=105$ korun → C).'},
  '13: A) o 5 korun; 14: C) 105 korunami',
  4, 6, '3',
  new List<String>{'zs2','r7','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
