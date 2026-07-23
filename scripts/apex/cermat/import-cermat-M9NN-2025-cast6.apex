String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND25C0T01';
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
  'CERMAT M9 nanečisto 2025 – úloha 16',
  new List<String>{'Obdélníky jsou sestaveny ze čtverečků. Pro každou dvojici obdélníků sestavených ze stejného počtu čtverečků platí: vyšší z obou obdélníků má vždy o jednu řadu čtverečků více než nižší obdélník; vyšší obdélník vznikne z nižšího přesunutím několika sloupců do horní řady; počet přesunutých sloupců je vždy o 1 menší, než je počet řad v nižším obdélníku (z obdélníku se 2 řadami se přemístí 1 sloupec, ze 3 řad 2 sloupce atd.).','16.1 V jedné dvojici obdélníků má nižší obdélník 21 řad. V této dvojici určete počet sloupců ve vyšším obdélníku.','16.2 V jiné dvojici obdélníků má vyšší obdélník 110 sloupců. V této dvojici určete počet řad v nižším obdélníku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 370 150" font-family="sans-serif"> <rect x="30" y="55" width="78" height="52" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <rect x="82" y="55" width="26" height="52" fill="#c9c9c9" stroke="#000" stroke-width="1"/> <line x1="56" y1="55" x2="56" y2="107" stroke="#000"/> <line x1="82" y1="55" x2="82" y2="107" stroke="#000"/> <line x1="30" y1="81" x2="108" y2="81" stroke="#000"/> <rect x="30" y="55" width="78" height="52" fill="none" stroke="#000" stroke-width="1.5"/> <text x="69" y="128" font-size="12" text-anchor="middle">nižší (2 řady)</text> <text x="185" y="86" font-size="24" text-anchor="middle">→</text> <rect x="250" y="30" width="52" height="78" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <rect x="250" y="30" width="52" height="26" fill="#c9c9c9" stroke="#000" stroke-width="1"/> <line x1="276" y1="30" x2="276" y2="108" stroke="#000"/> <line x1="250" y1="56" x2="302" y2="56" stroke="#000"/> <line x1="250" y1="82" x2="302" y2="82" stroke="#000"/> <rect x="250" y="30" width="52" height="78" fill="none" stroke="#000" stroke-width="1.5"/> <text x="276" y="128" font-size="12" text-anchor="middle">vyšší (3 řady)</text> </svg>',
  'obdelniky.svg',
  'Schematický nákres dvojice obdélníků ze čtverečků: nižší (2 řady, 3 sloupce) a z něj vzniklý vyšší (3 řady, 2 sloupce).',
  'Příklad dvojice obdélníků (přesun sloupce do horní řady)',
  new List<String>{'Označme počet řad nižšího obdélníku $r$. Přemístí se $r-1$ sloupců a vzniklá horní řada je plná; nižší obdélník má pak $r^2-1$ sloupců a vyšší obdélník má $r+1$ řad a $r(r-1)$ sloupců (celkový počet čtverečků $r(r^2-1)$ zůstává zachován).','16.1 Pro $r=21$ má vyšší obdélník $r(r-1)=21\\cdot 20=420$ sloupců.','16.2 Z rovnice $r(r-1)=110$ plyne $r=11$; nižší obdélník má tedy 11 řad.'},
  '16.1: $420$ sloupců; 16.2: $11$ řad',
  4, 7, '4',
  new List<String>{'zs2','r9','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
