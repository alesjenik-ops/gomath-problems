String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M9A 2016 – úloha 10',
  new List<String>{'V rovině leží přímka $BD$ (viz obrázek).','Sestrojte chybějící vrcholy $A$, $C$ čtverce $ABCD$. Čtverec narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 290" font-family="sans-serif"> <g stroke="#000" stroke-width="2"> <line x1="160" y1="30" x2="292" y2="262"/> <line x1="172" y1="76" x2="196" y2="62"/> <line x1="252" y1="222" x2="276" y2="208"/> </g> <g font-size="16" font-style="italic"> <text x="200" y="62">D</text><text x="282" y="206">B</text> </g> </svg>',
  'primka-bd.svg',
  'Přímka procházející dvěma vyznačenými body D a B.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Úsečka $BD$ je úhlopříčka čtverce $ABCD$.','Úhlopříčky čtverce jsou shodné, navzájem kolmé a navzájem se půlí.','Sestrojíme osu úsečky $BD$; ta protne $BD$ ve středu $S$.','Na osu naneseme od bodu $S$ na obě strany vzdálenost $|SB|$ a získáme vrcholy $A$ a $C$.'},
  'Vrcholy $A$, $C$ leží na ose úsečky $BD$ ve vzdálenosti $\\frac{|BD|}{2}$ od jejího středu $S$ (úhlopříčky čtverce jsou shodné, kolmé a půlí se) – viz obrázek v klíči správných řešení.',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 11',
  new List<String>{'Stará fotografie tvaru obdélníku má délku $a=12$ cm a šířku $b=9$ cm. Při kopírování vznikla nová fotografie, jejíž rozměry jsou $1{,}5$krát větší než u staré fotografie.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (Ano), či nikoli (Ne).','11.1 Šířka nové fotografie je stejná jako délka staré fotografie.','11.2 Délky nové a staré fotografie jsou v poměru $3:2$.','11.3 Délka a šířka nové fotografie jsou v poměru $4:3$.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Nová fotografie má délku $1{,}5\\cdot 12=18$ cm a šířku $1{,}5\\cdot 9=13{,}5$ cm.','11.1 Šířka nové fotografie je $13{,}5$ cm, délka staré je $12$ cm → Ne.','11.2 $18:12=3:2$ → Ano.','11.3 $18:13{,}5=180:135=4:3$ → Ano.'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2016 – úloha 12',
  new List<String>{'Ze čtverce se středem $S$ byl vystřižen kruh s největším možným poloměrem (viz obrázek). Obvod kruhu je $o=\\pi\\cdot 10$ cm.','Rozhodněte o každém z následujících tvrzení (12.1–12.3), zda je pravdivé (Ano), či nikoli (Ne).','12.1 Obsah kruhu je $\\pi\\cdot 25$ cm².','12.2 Obsah čtverce je $400$ cm².','12.3 Obvod čtverce je $40$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 220" font-family="sans-serif"> <rect x="40" y="20" width="180" height="180" fill="#b3b3b3" stroke="#000" stroke-width="2"/> <circle cx="130" cy="110" r="90" fill="#ffffff" stroke="#000" stroke-width="2"/> <line x1="66" y1="46" x2="194" y2="174" stroke="#000" stroke-width="2"/> <g stroke="#000" stroke-width="2"> <line x1="122" y1="102" x2="138" y2="118"/><line x1="138" y1="102" x2="122" y2="118"/> </g> <g font-size="15"> <text x="108" y="126" font-style="italic">S</text> <text x="140" y="80">10 cm</text> </g> </svg>',
  'ctverec-kruh.svg',
  'Čtverec se středem S a do něj vepsaný kruh s vyznačeným průměrem 10 cm.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'Z $o=\\pi d$ a $o=\\pi\\cdot 10$ cm plyne průměr $d=10$ cm, tedy poloměr $r=5$ cm.','12.1 $S=\\pi r^2=\\pi\\cdot 5^2=\\pi\\cdot 25$ cm² → Ano.','Kruh má největší možný poloměr, proto strana čtverce je rovna průměru kruhu, tj. $10$ cm.','12.2 Obsah čtverce je $10^2=100$ cm², nikoli $400$ cm² → Ne.','12.3 Obvod čtverce je $4\\cdot 10=40$ cm → Ano.'},
  '12.1: Ano; 12.2: Ne; 12.3: Ano',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
