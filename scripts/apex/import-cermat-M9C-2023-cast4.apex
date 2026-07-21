String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, náhradní termín (M9C)';
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
  'CERMAT 2023 M9C · úloha 11',
  new List<String>{'Na táboře je každé dítě zařazeno do jednoho ze tří oddílů A, B a C. V oddíle A je dvakrát více dětí než v oddíle C. Poměr počtu dětí v oddíle A ku počtu dětí v oddíle B je $4:3$.','Graf udává počty chlapců a dívek v jednotlivých oddílech, dva údaje však chybí: oddíl A má $9$ chlapců a $7$ dívek, oddíl C má $3$ chlapce (počet dívek chybí), oddíl B má $4$ dívky (počet chlapců chybí).','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 V oddíle C je $5$ dívek.','11.2 V oddíle B je chlapců o polovinu více než dívek.','11.3 Na táboře je dívek o pětinu méně než chlapců.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Oddíl A $=9+7=16$ dětí. A $=2\\cdot$C $\\Rightarrow$ C $=8$; A$:$B $=4:3\\Rightarrow$ B $=12$.','C: $3$ chlapci, tedy dívek $8-3=5$. B: $4$ dívky, tedy chlapců $12-4=8$.','11.1: v oddíle C je $5$ dívek — \\textbf{A} (pravda).','11.2: v oddíle B je $8$ chlapců a $4$ dívky, tj. dvakrát více (ne o polovinu více) — \\textbf{N}.','11.3: chlapců celkem $9+3+8=20$, dívek $7+5+4=16$; $16=20-\\frac{20}{5}$, tedy o pětinu méně — \\textbf{A}.'},
  '11.1: A; 11.2: N; 11.3: A',
  4, 6, '4',
  new List<String>{'zs2','r9','pomer','aritmetika','uvazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PCD23C0T03', 2023
);
c.add(
  'CERMAT 2023 M9C · úloha 12',
  new List<String>{'Ve vlakové soupravě jsou pouze stejně dlouhé vagony a jedna lokomotiva. Lokomotiva je o čtvrtinu kratší než jeden vagon a její délka tvoří jednu sedmnáctinu délky celé vlakové soupravy.','Kolik vagonů je celkem ve vlakové soupravě?'},
  new List<String>{'A) $10$ vagonů','B) $11$ vagonů','C) $12$ vagonů','D) $13$ vagonů','E) jiný počet vagonů'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Vagon má délku $v$, lokomotiva $\\frac{3}{4}v$. Pro $n$ vagonů: $\\frac{\\frac{3}{4}v}{n\\cdot v+\\frac{3}{4}v}=\\frac{1}{17}\\Rightarrow17\\cdot\\frac{3}{4}=n+\\frac{3}{4}\\Rightarrow n=\\frac{51-3}{4}=12$.'},
  'C) $12$ vagonů',
  2, 3, '4',
  new List<String>{'zs2','r9','rovnice','aritmetika','slovni','vyber','bez-kalkulacky','bezny-zivot'},
  'M9PCD23C0T03', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
