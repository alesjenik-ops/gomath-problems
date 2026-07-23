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
  'CERMAT M7B 2022 – úloha 7',
  new List<String>{'Dřevěná hlava robota byla slepena z jedné velké a $7$ shodných malých krychlí. Po slepení byly části vyčnívající z velké krychle obarveny na šedo, všechny ostatní plochy na bílo. (Bílá je i spodní stěna velké krychle, neobarvené zůstaly jen slepené plochy.)','Jedna stěna malé krychle má obsah $9$ cm². Velká krychle má hranu délky $10$ cm.','Vypočtěte:','7.1 v cm² celkový obsah všech šedých ploch,','7.2 v cm² celkový obsah všech bílých ploch,','7.3 v cm³ objem celé hlavy robota (tj. objem všech krychlí dohromady).'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 300" font-family="sans-serif" font-size="12"><polygon points="200,100 250,50 390,50 340,100" fill="#eeeeee" stroke="#000"/><polygon points="340,100 390,50 390,190 340,240" fill="#d5d5d5" stroke="#000"/><rect x="200" y="100" width="140" height="140" fill="#f5f5f5" stroke="#000"/><polygon points="150,150 159,141 185,141 176,150" fill="#eeeeee" stroke="#000"/><polygon points="176,150 185,141 185,167 176,176" fill="#d5d5d5" stroke="#000"/><rect x="150" y="150" width="26" height="26" fill="#a9a9a9" stroke="#000"/><polygon points="150,104 159,95 185,95 176,104" fill="#eeeeee" stroke="#000"/><polygon points="176,104 185,95 185,121 176,130" fill="#d5d5d5" stroke="#000"/><rect x="150" y="104" width="26" height="26" fill="#a9a9a9" stroke="#000"/><polygon points="252,52 261,43 287,43 278,52" fill="#eeeeee" stroke="#000"/><polygon points="278,52 287,43 287,69 278,78" fill="#d5d5d5" stroke="#000"/><rect x="252" y="52" width="26" height="26" fill="#a9a9a9" stroke="#000"/><polygon points="250,172 259,163 285,163 276,172" fill="#eeeeee" stroke="#000"/><polygon points="276,172 285,163 285,189 276,198" fill="#d5d5d5" stroke="#000"/><rect x="250" y="172" width="26" height="26" fill="#a9a9a9" stroke="#000"/><polygon points="392,112 401,103 427,103 418,112" fill="#eeeeee" stroke="#000"/><polygon points="418,112 427,103 427,129 418,138" fill="#d5d5d5" stroke="#000"/><rect x="392" y="112" width="26" height="26" fill="#a9a9a9" stroke="#000"/><polygon points="392,164 401,155 427,155 418,164" fill="#eeeeee" stroke="#000"/><polygon points="418,164 427,155 427,181 418,190" fill="#d5d5d5" stroke="#000"/><rect x="392" y="164" width="26" height="26" fill="#a9a9a9" stroke="#000"/><polygon points="252,252 261,243 287,243 278,252" fill="#eeeeee" stroke="#000"/><polygon points="278,252 287,243 287,269 278,278" fill="#d5d5d5" stroke="#000"/><rect x="252" y="252" width="26" height="26" fill="#a9a9a9" stroke="#000"/></svg>',
  'robot.svg',
  'Schematický nákres hlavy robota: velká krychle o hraně 10 cm, na jejíchž stěnách je nalepeno sedm malých krychlí se stěnou o obsahu 9 cm².',
  'Hlava robota z velké a sedmi malých krychlí (schematicky)',
  new List<String>{'Stěna malé krychle má $9$ cm², malá krychle tedy má hranu $3$ cm; velká krychle hranu $10$ cm.','7.1 Šedé (vyčnívající) plochy tvoří dohromady $33$ stěn malých krychlí: $33\\cdot9=297$ cm².','7.2 Bílé plochy: povrch velké krychle bez zakrytých míst $6\\cdot100-7\\cdot9=537$ cm² a $2$ stěny malých krychlí v rovině spodní stěny $2\\cdot9=18$ cm², celkem $537+18=555$ cm².','7.3 Objem $=10^3+7\\cdot3^3=1000+189=1189$ cm³.'},
  '7.1: $297$ cm²; 7.2: $555$ cm²; 7.3: $1\\,189$ cm³',
  4, 9, '4',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
