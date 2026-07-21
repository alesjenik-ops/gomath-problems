String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 1. řádný termín (M9A)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2024 M9A · úloha 15',
  new List<String>{'Půdorys domu má tvar obdélníku. Šířka domu je $10\\ \\mathrm{m}$, v plánu je vyznačena úsečkou délky $10\\ \\mathrm{cm}$. Délka domu je v plánu zakreslena jako úsečka délky $2\\ \\mathrm{dm}$.','Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):','15.1 Měřítko plánu je $1:1\\,000$.','15.2 Skutečná délka domu je $20\\ \\mathrm{m}$.','15.3 Obsah obdélníku na plánu a obsah půdorysu domu jsou v poměru $1:100$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Šířka $10\\ \\mathrm{m}=1\\,000\\ \\mathrm{cm}$ je v plánu $10\\ \\mathrm{cm}$, měřítko $1:100$.','15.1: měřítko je $1:100$, nikoli $1:1\\,000$ — N.','15.2: délka v plánu $2\\ \\mathrm{dm}=20\\ \\mathrm{cm}$, skutečná $20\\cdot100=2\\,000\\ \\mathrm{cm}=20\\ \\mathrm{m}$ — A.','15.3: obsahy jsou v poměru $1:100^2=1:10\\,000$, nikoli $1:100$ — N.'},
  '15.1: N; 15.2: A; 15.3: N',
  3, 5, '3',
  new List<String>{'zs2','r9','pomer','geometrie','argumentace','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 16',
  new List<String>{'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).','16.1 Pan Novák si vypůjčil $20\\,000$ Kč na jeden rok. Po roce vrátí vypůjčenou částku a navíc úrok $13{,}5\\ \\%$ z vypůjčené částky. Kolik korun celkem věřiteli vrátí?','16.2 Paní Dlouhá vložila $1\\,000\\,000$ Kč s roční úrokovou sazbou $2{,}5\\ \\%$; výnosy z úroků jsou zdaněny $15\\ \\%$. Kolik korun získá navíc ke svému vkladu za jeden rok?','16.3 Kolo stálo $20\\,000$ Kč, nejdříve bylo zlevněno o $10\\ \\%$ z původní ceny, po měsíci zdraženo o $10\\ \\%$ z nové ceny. Jaká byla výsledná cena?'},
  new List<String>{'A) $22\\,700$ Kč','B) $21\\,350$ Kč','C) $21\\,250$ Kč','D) $20\\,000$ Kč','E) $19\\,800$ Kč','F) jiný výsledek'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'16.1: $20\\,000\\cdot1{,}135=22\\,700$ Kč — A.','16.2: úrok $25\\,000$ Kč, po zdanění $25\\,000\\cdot0{,}85=21\\,250$ Kč — C.','16.3: $20\\,000\\cdot0{,}9=18\\,000$, poté $18\\,000\\cdot1{,}1=19\\,800$ Kč — E.'},
  '16.1: A ($22\\,700$ Kč); 16.2: C ($21\\,250$ Kč); 16.3: E ($19\\,800$ Kč)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','finance','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PAD24C0T01', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
