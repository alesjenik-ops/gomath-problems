String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD25C0T04';
Integer YEAR = 2025;

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
  'CERMAT M7D 2025 - uloha 6',
  new List<String>{'Vedomostni souteze, ktera mela dve kola, se zucastnil $10$clenny tym. V kazdem kole ziskali jednotlivi soutezici $8$, $9$, nebo $10$ bodu. Nektere udaje jsou v tabulce.','6.1 V 1. kole bylo soutezicich, kteri ziskali $8$ bodu, o jednoho mene nez tech, kteri ziskali $10$ bodu. Urcete soucet bodu celeho tymu v 1. kole.','6.2 Urcete, kolik soutezicich mohlo ve 2. kole ziskat $9$ bodu. Najdete vsechna reseni.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 425 156" font-family="sans-serif" font-size="11"><rect x="10" y="10" width="405" height="136" fill="none" stroke="#000"/><line x1="90" y1="10" x2="90" y2="146" stroke="#000"/><line x1="160" y1="44" x2="160" y2="146" stroke="#000"/><line x1="230" y1="44" x2="230" y2="146" stroke="#000"/><line x1="305" y1="10" x2="305" y2="146" stroke="#000"/><line x1="90" y1="44" x2="305" y2="44" stroke="#000"/><line x1="10" y1="78" x2="415" y2="78" stroke="#000"/><line x1="10" y1="112" x2="415" y2="112" stroke="#000"/><text x="197" y="32" font-size="10" text-anchor="middle">Pocet soutezicich, kteri ziskali</text><text x="125" y="65" text-anchor="middle">8 bodu</text><text x="195" y="65" text-anchor="middle">9 bodu</text><text x="267" y="65" text-anchor="middle">10 bodu</text><text x="360" y="40" font-size="10" text-anchor="middle">Soucet bodu</text><text x="360" y="56" font-size="10" text-anchor="middle">celeho tymu</text><text x="16" y="99" font-size="10">1. kolo</text><text x="195" y="99" text-anchor="middle">5</text><text x="16" y="133" font-size="10">2. kolo</text><text x="360" y="133" text-anchor="middle">95</text></svg>',
  'tabulka-soutez.svg',
  'Tabulka: 1. kolo ma u 9 bodu hodnotu 5; 2. kolo ma soucet bodu tymu 95.',
  'Vychozi tabulka k uloze 6',
  new List<String>{'6.1 V 1. kole ziskalo $5$ soutezicich $9$ bodu, zbyva $5$ soutezicich. Osmibodovych je o jednoho mene nez desetibodovych: $2$ a $3$. Soucet $2\\cdot 8+5\\cdot 9+3\\cdot 10=16+45+30=91$ bodu.','6.2 Ve 2. kole je $10$ soutezicich se souctem $95$ bodu. Pro pocty $a$ (8 b.), $b$ (9 b.), $c$ (10 b.) plati $a+b+c=10$ a $8a+9b+10c=95$, odkud $b+2c=15$ a $a=c-5$. Reseni: $c=5,b=5$; $c=6,b=3$; $c=7,b=1$. Devet bodu tak mohlo ziskat $1$, $3$, nebo $5$ soutezicich.'},
  '6.1: $91$ bodu; 6.2: $1$ soutezici, $3$ soutezici, nebo $5$ soutezicich',
  4, 7, '4',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2025 - uloha 7',
  new List<String>{'Povrch male krychle je o $42$ cm$^2$ mensi nez povrch velke krychle. Soucet delek vsech hran velke krychle je $48$ cm.','7.1 Vypoctete v cm delku hrany velke krychle.','7.2 Vypoctete v cm$^2$ povrch male krychle.','7.3 Vypoctete v cm$^3$, o kolik se lisi objem male a velke krychle.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'7.1 Krychle ma $12$ hran, delka hrany velke krychle je $48:12=4$ cm.','7.2 Povrch velke krychle je $6\\cdot 4^2=96$ cm$^2$; povrch male krychle je $96-42=54$ cm$^2$.','7.3 Z $6a^2=54$ plyne hrana male krychle $a=3$ cm. Objemy $3^3=27$ cm$^3$ a $4^3=64$ cm$^3$ se lisi o $64-27=37$ cm$^3$.'},
  '7.1: $4$ cm; 7.2: $54$ cm$^2$; 7.3: o $37$ cm$^3$',
  4, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
