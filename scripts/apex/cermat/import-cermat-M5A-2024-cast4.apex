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
  'CERMAT M5A 2024 - uloha 9',
  new List<String>{'Tereza a jeji kamaradka Nikola pisi novorocni prani. Vsechna prani maji stejny text a kazda z divek pise stalou rychlosti. Tereza za kazdych $5$ minut napise $14$ novorocenek, zatimco Nikola $10$.','Za jak dlouho spolecne napisi $120$ novorocnich prani?'},
  new List<String>{'A) za $24$ minut','B) za $25$ minut','C) za $30$ minut','D) za $32$ minut','E) za jiny pocet minut'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Za $5$ minut napisi spolecne $14+10=24$ prani. $120:24=5$, potrebuji tedy $5\\cdot 5=25$ minut.'},
  'B) za $25$ minut',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2024 - uloha 10',
  new List<String>{'Ctverce A-E jsou rozdeleny uhloprickami na ctyri trojuhelniky; v kazdem je jeden trojuhelnik vybarveny a je v nem sipka (viz obrazek).','Ktery z uvedenych obrazku (A-E) logicky nepatri mezi ostatni?'},
  new List<String>{'A) obrazek A','B) obrazek B','C) obrazek C','D) obrazek D','E) obrazek E'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 150" font-family="sans-serif"><polygon points="20,30 20,104 57.0,67.0" fill="#b8b8b8"/><rect x="20" y="30" width="74" height="74" fill="none" stroke="#000"/><line x1="20" y1="30" x2="94" y2="104" stroke="#000"/><line x1="94" y1="30" x2="20" y2="104" stroke="#000"/><polygon points="57.0,47.0 49.0,61.0 65.0,61.0" fill="#fff" stroke="#000"/><text x="57.0" y="120" font-size="13" text-anchor="middle">A)</text><polygon points="118,104 192,104 155.0,67.0" fill="#b8b8b8"/><rect x="118" y="30" width="74" height="74" fill="none" stroke="#000"/><line x1="118" y1="30" x2="192" y2="104" stroke="#000"/><line x1="192" y1="30" x2="118" y2="104" stroke="#000"/><polygon points="155.0,87.0 147.0,73.0 163.0,73.0" fill="#fff" stroke="#000"/><text x="155.0" y="120" font-size="13" text-anchor="middle">B)</text><polygon points="216,30 216,104 253.0,67.0" fill="#b8b8b8"/><polygon points="216,104 290,104 253.0,67.0" fill="#b8b8b8"/><rect x="216" y="30" width="74" height="74" fill="none" stroke="#000"/><line x1="216" y1="30" x2="290" y2="104" stroke="#000"/><line x1="290" y1="30" x2="216" y2="104" stroke="#000"/><polygon points="253.0,87.0 245.0,73.0 261.0,73.0" fill="#fff" stroke="#000"/><text x="253.0" y="120" font-size="13" text-anchor="middle">C)</text><polygon points="314,30 388,30 351.0,67.0" fill="#b8b8b8"/><polygon points="314,30 314,104 351.0,67.0" fill="#b8b8b8"/><rect x="314" y="30" width="74" height="74" fill="none" stroke="#000"/><line x1="314" y1="30" x2="388" y2="104" stroke="#000"/><line x1="388" y1="30" x2="314" y2="104" stroke="#000"/><polygon points="331.0,67.0 345.0,59.0 345.0,75.0" fill="#fff" stroke="#000"/><text x="351.0" y="120" font-size="13" text-anchor="middle">D)</text><polygon points="412,30 486,30 449.0,67.0" fill="#b8b8b8"/><polygon points="486,30 486,104 449.0,67.0" fill="#b8b8b8"/><rect x="412" y="30" width="74" height="74" fill="none" stroke="#000"/><line x1="412" y1="30" x2="486" y2="104" stroke="#000"/><line x1="486" y1="30" x2="412" y2="104" stroke="#000"/><polygon points="469.0,67.0 455.0,59.0 455.0,75.0" fill="#fff" stroke="#000"/><text x="449.0" y="120" font-size="13" text-anchor="middle">E)</text></svg>',
  'ctverce-sipky.svg',
  'Pet ctvercu rozdelenych uhloprickami s vybarvenym trojuhelnikem a sipkou.',
  'Obrazky A-E (schematicky nakres, orientace dle testoveho sesitu)',
  new List<String>{'Porovnanim vzajemne polohy vybarveneho trojuhelniku a sipky v jednotlivych ctvercich zjistime, ze pravidlu nevyhovuje obrazek $C$.'},
  'C) obrazek C',
  2, 3, '3',
  new List<String>{'zs1','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
