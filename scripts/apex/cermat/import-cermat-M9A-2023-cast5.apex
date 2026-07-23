String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD23C0T01';
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
  'CERMAT M9A 2023 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $P$ a kružnice $k$ se středem $S$ (viz obrázek). Bod $A$ je vrchol rovnoramenného trojúhelníku $ABC$, jehož základna leží na přímce $AP$. Vrcholy $B$, $C$ tohoto trojúhelníku leží na kružnici $k$.','Sestrojte vrcholy $B$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif"> <rect x="6" y="6" width="488" height="328" fill="none" stroke="#ccc"/> <circle cx="250" cy="180" r="140" fill="none" stroke="#000" stroke-width="2"/> <text x="250" y="184" font-size="16" text-anchor="middle">x</text> <text x="256" y="198" font-size="15" font-style="italic">S</text> <text x="215" y="144" font-size="16" text-anchor="middle">x</text> <text x="200" y="140" font-size="15" font-style="italic">P</text> <text x="415" y="188" font-size="16" text-anchor="middle">x</text> <text x="421" y="204" font-size="15" font-style="italic">A</text> <text x="345" y="302" font-size="15" font-style="italic">k</text> </svg>',
  'kruznice-k-AP.svg',
  'Kružnice k se středem S, uvnitř bod P a vpravo u kružnice bod A.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Základna trojúhelníku leží na přímce $AP$; jeden vrchol základny, bod $B$, je proto průsečíkem přímky $AP$ s kružnicí $k$. Trojúhelník je rovnoramenný se základnou $AB$, vrchol $C$ tedy leží na ose úsečky $AB$ a zároveň na kružnici $k$. Osa úsečky $AB$ protíná kružnici $k$ ve dvou bodech $C_1$, $C_2$, úloha má proto dvě řešení – trojúhelníky $ABC_1$ a $ABC_2$.'},
  'Bod $B$ je průsečík přímky $AP$ s kružnicí $k$; vrchol $C$ leží na ose úsečky $AB$ a na kružnici $k$; úloha má dvě řešení $C_1$, $C_2$ (viz náčrt konstrukce v klíči).',
  3, 5, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2023 – úloha 11',
  new List<String>{'Každých $3{,}5$ cm na turistické mapě rovinaté oblasti je ve skutečnosti $700$ m. Délka vycházkové trasy je přesně $6$ km, což je trojnásobek délky přímé trasy. (Uvažované trasy nemají žádné převýšení.)','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 Trasa, která na mapě měří $49$ mm, je ve skutečnosti delší než $1$ km.','11.2 Na mapě je vycházková trasa o $20$ cm delší než přímá trasa.','11.3 Měřítko turistické mapy je $1:200\\,000$.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Měřítko: $3{,}5$ cm na mapě odpovídá $700$ m $=70\\,000$ cm, tedy $1$ cm mapy $=20\\,000$ cm skutečnosti; měřítko je $1:20\\,000$.','11.1 $49$ mm $=4{,}9$ cm $\\to 4{,}9\\cdot 20\\,000=98\\,000$ cm $=980$ m, což není více než $1$ km → Ne.','11.2 Přímá trasa má $6:3=2$ km. Na mapě: vycházková $6$ km $=30$ cm, přímá $2$ km $=10$ cm; rozdíl $30-10=20$ cm → Ano.','11.3 Měřítko je $1:20\\,000$, nikoli $1:200\\,000$ → Ne.'},
  '11.1: N; 11.2: A; 11.3: N',
  4, 4, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
