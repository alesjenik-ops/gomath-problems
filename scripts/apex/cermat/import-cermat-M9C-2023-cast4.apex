String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD23C0T03';
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
  'CERMAT M9C 2023 – úloha 11',
  new List<String>{'Na táboře je každé dítě zařazeno do jednoho ze tří oddílů $A$, $B$ a $C$. V oddíle $A$ je dvakrát více dětí než v oddíle $C$. Poměr počtu dětí v oddíle $A$ ku počtu dětí v oddíle $B$ je $4:3$. Graf udává počty chlapců a dívek v jednotlivých oddílech, dva údaje však chybí (viz obrázek).','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 V oddíle $C$ je $5$ dívek.','11.2 V oddíle $B$ je chlapců o polovinu více než dívek.','11.3 Na táboře je dívek o pětinu méně než chlapců.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 330" font-family="sans-serif"><path d="M250.0 47.0 A118 118 0 0 1 290.4 275.9 L267.1 212.0 A50 50 0 0 0 250.0 115.0 Z" fill="#ffffff" stroke="#000"/><text x="333" y="150" font-size="16" text-anchor="middle" font-style="italic">A</text><path d="M290.4 275.9 A118 118 0 0 1 133.8 144.5 L200.8 156.3 A50 50 0 0 0 267.1 212.0 Z" fill="#9a9a9a" stroke="#000"/><text x="196" y="229" font-size="16" text-anchor="middle" font-style="italic">B</text><path d="M133.8 144.5 A118 118 0 0 1 250.0 47.0 L250.0 115.0 A50 50 0 0 0 200.8 156.3 Z" fill="#d8d8d8" stroke="#000"/><text x="196" y="101" font-size="16" text-anchor="middle" font-style="italic">C</text><text x="352" y="63" font-size="11" text-anchor="middle">chlapci 9</text><text x="368" y="248" font-size="11" text-anchor="middle">divky 7</text><text x="189" y="296" font-size="11" text-anchor="middle">chlapci ?</text><text x="111" y="202" font-size="11" text-anchor="middle">divky 4</text><text x="125" y="93" font-size="11" text-anchor="middle">chlapci 3</text><text x="189" y="34" font-size="11" text-anchor="middle">divky ?</text></svg>',
  'graf-oddily.svg',
  'Mezikružní (koláčový) graf tří oddílů A, B, C s počty chlapců a dívek; u oddílu A je 9 chlapců a 7 dívek, u oddílu B jsou 4 dívky, u oddílu C jsou 3 chlapci, dva údaje chybí.',
  'Počty chlapců a dívek v oddílech (dva údaje chybí)',
  new List<String>{'Oddíl $A$ má $9$ chlapců a $7$ dívek, celkem $16$ dětí. Oddíl $C$ má poloviční počet, tj. $8$ dětí; z toho $3$ chlapci, takže dívek je $8-3=5$. Poměr $A:B=4:3$ dává $B=\\frac{3}{4}\\cdot 16=12$ dětí; z toho $4$ dívky, takže chlapců je $12-4=8$.','11.1 V oddíle $C$ je $5$ dívek — pravdivé (Ano).','11.2 V oddíle $B$ je $8$ chlapců a $4$ dívky; chlapců je dvakrát více (o $100\\,\\%$), ne o polovinu — nepravdivé (Ne).','11.3 Dívek je celkem $7+4+5=16$ a chlapců $9+8+3=20$; $16$ je o pětinu (o $4$) méně než $20$ — pravdivé (Ano).'},
  '11.1: Ano; 11.2: Ne; 11.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2023 – úloha 12',
  new List<String>{'Ve vlakové soupravě jsou pouze stejně dlouhé vagony a jedna lokomotiva. Lokomotiva je o čtvrtinu kratší než jeden vagon a její délka tvoří jednu sedmnáctinu délky celé vlakové soupravy.','Kolik vagonů je celkem ve vlakové soupravě?'},
  new List<String>{'A) $10$ vagonů','B) $11$ vagonů','C) $12$ vagonů','D) $13$ vagonů','E) jiný počet vagonů'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Délku vagonu označme $1$, pak lokomotiva má délku $\\frac{3}{4}$. Je-li ve vlaku $n$ vagonů, souprava má délku $n+\\frac{3}{4}$ a lokomotiva tvoří její sedmnáctinu: $\\frac{3}{4}=\\frac{1}{17}\\cdot\\left(n+\\frac{3}{4}\\right)$. Odtud $17\\cdot\\frac{3}{4}=n+\\frac{3}{4}$, tj. $n=\\frac{51}{4}-\\frac{3}{4}=\\frac{48}{4}=12$.'},
  'C) $12$ vagonů',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
