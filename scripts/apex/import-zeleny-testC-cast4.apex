String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený C11 – bodové zisky škol (graf)',
  new List<String>{'Prvního kola žákovské olympiády se účastnilo 5 škol. Jejich bodové zisky jsou zobrazeny v grafu.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Žáci ZŠ U Výtopny získali více než polovinu všech bodů.','11.2 Žáci ze ZŠ Lhotské získali pouhou osminu všech bodů.','11.3 Bodový zisk ZŠ Burešova byl o čtvrtinu nižší než výsledek žáků ze ZŠ Českodubská.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif"> <text x="250" y="20" font-size="15" text-anchor="middle" font-weight="bold">BODOVÉ ZISKY ŠKOL V 1. KOLE OLYMPIÁDY</text> <line x1="60" y1="30" x2="60" y2="340" stroke="#000" stroke-width="1.5"/> <line x1="60" y1="340" x2="470" y2="340" stroke="#000" stroke-width="1.5"/> <line x1="60" y1="297" x2="470" y2="297" stroke="#ccc" stroke-width="1"/> <text x="52" y="301" font-size="12" text-anchor="end">10</text> <line x1="60" y1="254" x2="470" y2="254" stroke="#ccc" stroke-width="1"/> <text x="52" y="258" font-size="12" text-anchor="end">20</text> <line x1="60" y1="211" x2="470" y2="211" stroke="#ccc" stroke-width="1"/> <text x="52" y="215" font-size="12" text-anchor="end">30</text> <line x1="60" y1="168" x2="470" y2="168" stroke="#ccc" stroke-width="1"/> <text x="52" y="172" font-size="12" text-anchor="end">40</text> <line x1="60" y1="125" x2="470" y2="125" stroke="#ccc" stroke-width="1"/> <text x="52" y="129" font-size="12" text-anchor="end">50</text> <line x1="60" y1="82" x2="470" y2="82" stroke="#ccc" stroke-width="1"/> <text x="52" y="86" font-size="12" text-anchor="end">60</text> <line x1="60" y1="39" x2="470" y2="39" stroke="#ccc" stroke-width="1"/> <text x="52" y="43" font-size="12" text-anchor="end">70</text> <text x="52" y="344" font-size="12" text-anchor="end">0</text> <rect x="80" y="160" width="50" height="180" fill="#8a8a8a" stroke="#000"/> <rect x="160" y="228" width="50" height="112" fill="#8a8a8a" stroke="#000"/> <rect x="240" y="108" width="50" height="232" fill="#8a8a8a" stroke="#000"/> <rect x="320" y="228" width="50" height="112" fill="#8a8a8a" stroke="#000"/> <rect x="400" y="82" width="50" height="258" fill="#8a8a8a" stroke="#000"/> <text x="105" y="356" font-size="12" text-anchor="end" transform="rotate(-40 105 356)">ZŠ Burešova</text> <text x="185" y="356" font-size="12" text-anchor="end" transform="rotate(-40 185 356)">ZŠ Lhotská</text> <text x="265" y="356" font-size="12" text-anchor="end" transform="rotate(-40 265 356)">ZŠ Českodubská</text> <text x="345" y="356" font-size="12" text-anchor="end" transform="rotate(-40 345 356)">ZŠ Petýrkova</text> <text x="425" y="356" font-size="12" text-anchor="end" transform="rotate(-40 425 356)">ZŠ U Výtopny</text> </svg>',
  'graf-skoly.svg',
  'Sloupcový graf bodových zisků pěti škol: Burešova 42, Lhotská 26, Českodubská 54, Petýrkova 26, U Výtopny 60.',
  'Bodové zisky škol v 1. kole olympiády',
  new List<String>{'Součet všech bodů: $42 + 26 + 54 + 26 + 60 = 208$.','11.1 Polovina všech bodů je $104$; ZŠ U Výtopny má $60 < 104$. Tvrzení není pravdivé (Ne).','11.2 Osmina všech bodů je $208 : 8 = 26$; ZŠ Lhotská má $26$. Tvrzení je pravdivé (Ano).','11.3 Čtvrtina zisku ZŠ Českodubská ($54$) je $13{,}5$; o čtvrtinu nižší by bylo $40{,}5$, ale ZŠ Burešova má $42$. Tvrzení není pravdivé (Ne).'},
  '11.1: Ne; 11.2: Ano; 11.3: Ne',
  3, 6, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený C12 – zateplení místnosti',
  new List<String>{'Místnost vysoká $3$ metry o rozměrech podlahy $5$ metrů $\\times$ $6$ metrů byla zateplena tím, že její stěny i strop byly obloženy polystyrenovými omítanými panely o tloušťce $10$ cm.','O kolik m³ se zateplením zmenšil objem místnosti? Výsledek zaokrouhlete na $1$ desetinné místo.'},
  new List<String>{'A) o $6{,}3$ m³','B) o $6{,}6$ m³','C) o $9{,}6$ m³','D) o $12{,}6$ m²','E) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Původní objem $= 5 \\cdot 6 \\cdot 3 = 90$ m³. Podlaha se nezateplila, strop ubere $0{,}1$ m z výšky, každá dvojice stěn $0{,}1$ m z obou stran.','Nové rozměry: $4{,}8 \\times 5{,}8 \\times 2{,}9$. Nový objem $= 4{,}8 \\cdot 5{,}8 \\cdot 2{,}9 = 80{,}736$ m³.','Zmenšení $= 90 - 80{,}736 = 9{,}264 \\doteq 9{,}3$ m³, což není žádná z variant A–D.'},
  'E) jiný výsledek',
  2, 5, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
