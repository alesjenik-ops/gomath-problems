String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD18C0T02';
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
  'CERMAT M7B 2018 – úloha 16',
  new List<String>{'Ze stejně velkých čtverečků se podle jednotného pravidla sestavují obdélníky. První obdélník obsahuje 2 čtverečky. Každý další obdélník vznikne tak, že se k předchozímu obdélníku přidá nejprve dole jedna řada tmavých čtverečků a poté vpravo jeden sloupec bílých čtverečků. Číslo nahoře nad obdélníkem vždy uvádí počet všech čtverečků v obdélníku, číslo vpravo uvádí počet bílých čtverečků v nejdelším z přidaných sloupců. U každého z následujících obdélníků je chybějící počet nahrazen otazníkem.','16.1 Obdélník obsahuje celkem 110 čtverečků. Určete počet bílých čtverečků v nejdelším z přidaných sloupců.','16.2 Nejdelší z přidaných sloupců obsahuje 20 bílých čtverečků. Určete počet všech čtverečků v obdélníku.','16.3 Počet čtverečků v obdélníku je větší než 900, ale menší než 1 000. Určete přesný počet čtverečků v obdélníku. Najděte všechna možná řešení.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 130" font-family="sans-serif"><rect x="20" y="84" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="36" y="84" width="16" height="16" fill="#ffffff" stroke="#000"/><text x="36" y="78" font-size="14" text-anchor="middle">2</text><rect x="96" y="68" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="112" y="68" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="128" y="68" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="96" y="84" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="112" y="84" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="128" y="84" width="16" height="16" fill="#ffffff" stroke="#000"/><text x="120" y="62" font-size="14" text-anchor="middle">6</text><text x="148" y="88" font-size="13">2</text><rect x="188" y="52" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="204" y="52" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="220" y="52" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="236" y="52" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="188" y="68" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="204" y="68" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="220" y="68" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="236" y="68" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="188" y="84" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="204" y="84" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="220" y="84" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="236" y="84" width="16" height="16" fill="#ffffff" stroke="#000"/><text x="220" y="46" font-size="14" text-anchor="middle">12</text><text x="256" y="80" font-size="13">3</text><rect x="296" y="36" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="312" y="36" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="328" y="36" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="344" y="36" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="360" y="36" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="296" y="52" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="312" y="52" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="328" y="52" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="344" y="52" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="360" y="52" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="296" y="68" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="312" y="68" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="328" y="68" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="344" y="68" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="360" y="68" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="296" y="84" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="312" y="84" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="328" y="84" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="344" y="84" width="16" height="16" fill="#cfcfcf" stroke="#000"/><rect x="360" y="84" width="16" height="16" fill="#ffffff" stroke="#000"/><text x="336" y="30" font-size="14" text-anchor="middle">20</text><text x="380" y="72" font-size="13">4</text><text x="422" y="94" font-size="20">...</text></svg>',
  'obdelniky-vzor.svg',
  'Čtyři obdélníky sestavené z tmavých a bílých čtverečků s počty 2, 6, 12, 20 nahoře a 2, 3, 4 vpravo.',
  'Pravidlo sestavování obdélníků',
  new List<String>{'$n$-tý obdélník má $n$ řádků a $n+1$ sloupců, tedy $n(n+1)$ čtverečků; číslo vpravo (bílé čtverečky v přidaném sloupci) je $n$.','16.1 $n(n+1)=110\\Rightarrow n=10$; bílých čtverečků je $10$.','16.2 $n=20\\Rightarrow n(n+1)=20\\cdot 21=420$ čtverečků.','16.3 $900<n(n+1)<1000$: $30\\cdot 31=930$ a $31\\cdot 32=992$. Řešení jsou $930$ a $992$.'},
  '16.1: $10$; 16.2: $420$; 16.3: $930$ a $992$',
  4, 6, '3',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
