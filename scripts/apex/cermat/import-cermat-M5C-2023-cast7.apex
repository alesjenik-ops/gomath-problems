String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD23C0T03';
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
  'CERMAT M5C 2023 – úloha 14',
  new List<String>{'Každý obrazec tvaru obdélníku je složen z malých šedých čtverečků a větších bílých čtverečků. Všechny šedé čtverečky jsou stejné a jsou poskládány do spodní řady a do levého sloupce. Zbytek obrazce tvoří bílé čtverečky. Každý bílý čtvereček má dvakrát delší stranu než šedý. První obrazec má ve spodní řadě 5 šedých čtverečků a v levém sloupci 3 šedé čtverečky. Skládá se celkem z 9 čtverečků (bílých i šedých dohromady). Každý další obrazec má oproti předchozímu vždy o 2 šedé čtverečky více jak ve spodní řadě, tak i v levém sloupci.','14.1 Obrazec má ve spodní řadě 41 šedých čtverečků. Určete počet bílých čtverečků v obrazci.','14.2 V obrazci je 90 bílých čtverečků. Určete počet šedých čtverečků v obrazci.','14.3 Počet všech čtverečků (bílých i šedých dohromady) v posledním a v předposledním obrazci se liší o 106. Určete počet šedých čtverečků v posledním obrazci.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 150" font-family="sans-serif"><rect x="30" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="46" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="62" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="78" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="94" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="30" y="62" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="30" y="78" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="46" y="62" width="32" height="32" fill="#ffffff" stroke="#000"/><rect x="78" y="62" width="32" height="32" fill="#ffffff" stroke="#000"/><rect x="160" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="176" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="192" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="208" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="224" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="240" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="256" y="94" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="160" y="30" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="160" y="46" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="160" y="62" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="160" y="78" width="16" height="16" fill="#b9b9b9" stroke="#000"/><rect x="176" y="30" width="32" height="32" fill="#ffffff" stroke="#000"/><rect x="208" y="30" width="32" height="32" fill="#ffffff" stroke="#000"/><rect x="240" y="30" width="32" height="32" fill="#ffffff" stroke="#000"/><rect x="176" y="62" width="32" height="32" fill="#ffffff" stroke="#000"/><rect x="208" y="62" width="32" height="32" fill="#ffffff" stroke="#000"/><rect x="240" y="62" width="32" height="32" fill="#ffffff" stroke="#000"/><text x="292" y="80" font-size="20">…</text><text x="70" y="132" font-size="12" text-anchor="middle">1. obrazec</text><text x="216" y="132" font-size="12" text-anchor="middle">2. obrazec</text></svg>',
  'obrazce-14.svg',
  'První a druhý obrazec: šedé čtverečky ve spodní řadě a levém sloupci, zbytek tvoří větší bílé čtverečky.',
  '1. a 2. obrazec (schematický nákres)',
  new List<String>{'V $n$-tém obrazci je ve spodní řadě $2n+3$ šedých čtverečků a v levém sloupci $2n+1$; šedých je celkem $4n+3$. Bílá oblast má $n+1$ sloupců a $n$ řad bílých čtverečků, tedy $n(n+1)$ bílých. Všech čtverečků je $n^2+5n+3$.','14.1 $2n+3=41\\Rightarrow n=19$; bílých $19\\cdot 20=380$.','14.2 $n(n+1)=90\\Rightarrow n=9$; šedých $4\\cdot 9+3=39$.','14.3 Rozdíl počtů všech čtverečků $=2n+4=106\\Rightarrow n=51$; šedých $4\\cdot 51+3=207$.'},
  '14.1: $380$ bílých čtverečků; 14.2: $39$ šedých čtverečků; 14.3: $207$ šedých čtverečků',
  4, 7, '4',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
