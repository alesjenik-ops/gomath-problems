String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, 1. řádný termín (M9A)';
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
  'CERMAT 2021 M9A · úloha 16',
  new List<String>{'Každý díl stavebnice se skládá ze tří stejných krychliček; všechny díly jsou stejné. Z dílů stavíme stále větší pyramidy (viz obrázek). Nejmenší pyramidu tvoří jediný díl. Druhá pyramida sestavená ze $3$ dílů má $1$ otvor, $4$ řady a ve spodní řadě $4$ krychličky. Každá další pyramida bude o dvě řady vyšší než předchozí.','16.1 Pyramida má ve spodní řadě $50$ krychliček. Určete počet otvorů ve druhé řadě zdola.','16.2 Pyramida má celkem $10$ otvorů. Určete počet krychliček v celé pyramidě.','16.3 Pyramida je sestavena z $21$ dílů. Určete počet krychliček ve spodní řadě.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 182"><path d="M4 4L5 4L5 23L4 23Z" style="fill:#000000"/><path d="M4 23L5 23L5 149L4 149Z" style="fill:#000000"/><path d="M4 177L5 177L5 178L4 178Z" style="fill:#000000"/><path d="M4 177L5 177L5 178L4 178Z" style="fill:#000000"/><path d="M5 177L468 177L468 178L5 178Z" style="fill:#000000"/><path d="M4 149L5 149L5 177L4 177Z" style="fill:#000000"/><path d="M40 125L54 125L54 139L40 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M54 125L69 125L69 139L54 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M47 110L61 110L61 125L47 125Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M111 125L125 125L125 139L111 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M125 125L139 125L139 139L125 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M118 110L132 110L132 125L118 125Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M139 125L153 125L153 139L139 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M153 125L168 125L168 139L153 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M146 110L161 110L161 125L146 125Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M125 96L139 96L139 110L125 110Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M139 96L153 96L153 110L139 110Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M132 82L146 82L146 96L132 96Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M207 125L221 125L221 139L207 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M221 125L236 125L236 139L221 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M214 110L229 110L229 125L214 125Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M236 125L250 125L250 139L236 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M250 125L264 125L264 139L250 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M243 110L257 110L257 125L243 125Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M264 125L278 125L278 139L264 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M278 125L292 125L292 139L278 139Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M271 110L285 110L285 125L271 125Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M222 96L236 96L236 110L222 110Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M236 96L250 96L250 110L236 110Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M229 82L243 82L243 96L229 96Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M250 96L264 96L264 110L250 110Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M264 96L278 96L278 110L264 110Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M257 82L271 82L271 96L257 96Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M236 68L250 68L250 82L236 82Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M250 68L264 68L264 82L250 82Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M243 54L257 54L257 68L243 68Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><text x="338" y="101" font-size="24" fill="#000" text-anchor="middle" font-family="sans-serif">…</text><text x="56" y="89" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1. pyramida</text><text x="56" y="102" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">(jeden díl)</text><text x="140" y="60" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2. pyramida</text><text x="140" y="75" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">(tři díly)</text><text x="252" y="47" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3. pyramida</text></svg>',
  'obr.svg',
  'Posloupnost pyramid z krychliček: 1., 2. a 3. pyramida a tři tečky; ve větších pyramidách jsou otvory.',
  '',
  new List<String>{'$k$-tá pyramida má $2k$ řad, ve spodní řadě $2k$ krychliček, $\\frac{k(k+1)}{2}$ dílů (tj. $\\frac{3k(k+1)}{2}$ krychliček) a $\\frac{k(k-1)}{2}$ otvorů; ve druhé řadě zdola je $k-1$ otvorů.','16.1: $2k=50\\Rightarrow k=25$; otvorů $=k-1=24$.','16.2: $\\frac{k(k-1)}{2}=10\\Rightarrow k=5$; krychliček $=\\frac{3\\cdot5\\cdot6}{2}=45$.','16.3: $\\frac{k(k+1)}{2}=21\\Rightarrow k=6$; ve spodní řadě $2k=12$.'},
  '16.1: $24$ otvorů; 16.2: $45$ krychliček; 16.3: $12$ krychliček',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','algebra','vypocet','uvazovani','slovni','bez-kalkulacky'},
  'M9PAD21C0T01', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
