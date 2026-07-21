String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, náhradní termín (M9C)';
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
  'CERMAT 2022 M9C · úloha 10',
  new List<String>{'V rovině leží body A, X a rovnoběžné přímky $c$, $p$ (viz obrázek).','Bod A je vrchol obdélníku ABCD. Bod X leží uvnitř strany AB obdélníku. Na přímce $c$ leží vrchol C obdélníku ABCD a na přímce $p$ jeden ze zbývajících dvou vrcholů obdélníku.','Sestrojte vrcholy B, C, D obdélníku ABCD, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 243"><path d="M4 238L5 238L5 239L4 239Z" style="fill:#000000"/><path d="M4 238L5 238L5 239L4 239Z" style="fill:#000000"/><path d="M5 238L467 238L467 239L5 239Z" style="fill:#000000"/><path d="M467 238L468 238L468 239L467 239Z" style="fill:#000000"/><path d="M467 238L468 238L468 239L467 239Z" style="fill:#000000"/><path d="M4 4L5 4L5 238L4 238Z" style="fill:#000000"/><path d="M467 4L468 4L468 238L467 238Z" style="fill:#000000"/><path d="M136 209L130 204M136 204L130 209M226 163L231 158M226 158L231 163M406 41L24 41M24 101L406 101" style="fill:none;stroke:#000000;stroke-width:2"/><text x="133" y="224" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="229" y="178" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">X</text><text x="29" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">c</text><text x="29" y="115" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text></svg>',
  'obr.svg',
  'V rovině leží dvě rovnoběžné vodorovné přímky c a p a pod nimi body X a A (vyznačené křížky).',
  '',
  new List<String>{'Strana AB leží na přímce určené body A a X (X je vnitřní bod strany AB). Strana AD je kolmá k AB v bodě A.','Vrchol C má ležet na přímce $c$ a zároveň jeden ze zbývajících vrcholů (B, nebo D) na přímce $p$. Rozlišíme tedy dvě možnosti — na přímce $p$ leží vrchol B, nebo vrchol D — čímž z podmínky $C\\in c$ dostaneme rozměry obdélníku. Úloha má dvě řešení.'},
  'Dvě řešení obdélníku ABCD (strana AB na přímce AX, $AD\\perp AB$, $C\\in c$ a vrchol B, resp. D, na přímce $p$).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PCD22C0T03', 2022
);
c.add(
  'CERMAT 2022 M9C · úloha 11',
  new List<String>{'Zahrádkář zakoupil několik kusů rostlin od každého ze čtyř druhů A, B, C a D. Některé zakoupené rostliny uschly, ostatní vzrostly. Většinu vzrostlých rostlin zahrádkář později prodal.','Graf udává počty zakoupených, vzrostlých a prodaných kusů rostlin jednotlivých druhů: druh A – zakoupené $14$, vzrostlé $12$, prodané $7$; druh B – zakoupené $9$, vzrostlé $9$, prodané $9$; druh C – zakoupené $8$, vzrostlé $8$, prodané $4$; druh D – zakoupené $11$, vzrostlé $8$, prodané $8$.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 \\quad Zahrádkáři zůstalo celkem $9$ neprodaných kusů vzrostlých rostlin.','11.2 \\quad Zahrádkář zakoupil o polovinu více kusů rostlin, než jich prodal.','11.3 \\quad Zahrádkář prodal všechny zakoupené kusy jen u jednoho druhu rostlin.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Neprodané vzrostlé (vzrostlé $-$ prodané): A $12-7=5$, B $9-9=0$, C $8-4=4$, D $8-8=0$; celkem $5+0+4+0=9$ — 11.1 je pravdivé (\\textbf{A}).','Zakoupené celkem $14+9+8+11=42$, prodané celkem $7+9+4+8=28$; $42=1{,}5\\cdot28$, tedy o polovinu více — 11.2 je pravdivé (\\textbf{A}).','Prodané se rovná zakoupeným pouze u druhu B ($9=9$); u A, C i D nikoli — tedy právě u jednoho druhu — 11.3 je pravdivé (\\textbf{A}).'},
  '11.1: A; 11.2: A; 11.3: A',
  4, 6, '4',
  new List<String>{'zs2','r9','grafy','aritmetika','uvazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PCD22C0T03', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
