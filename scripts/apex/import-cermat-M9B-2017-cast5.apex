String SRC   = 'CERMAT – Jednotná přijímací zkouška 2017, 2. řádný termín (M9B)';
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
  'CERMAT 2017 M9B · úloha 11',
  new List<String>{'Balení, které obsahuje $15\\ \\mathrm{kg}$ granulí, vystačí čtyřem psům na $15$ dnů. Všichni čtyři psi dostávají denně stejné množství granulí.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Jeden pes dostává denně $250\\ \\mathrm{g}$ granulí.','11.2 Pouze dvěma psům by $15\\mathrm{kg}$ balení granulí vystačilo na $30$ dnů.','11.3 Jednomu psovi vystačí desetina $15\\mathrm{kg}$ balení granulí na $10$ dnů.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Denní spotřeba všech čtyř psů: $15\\,000\\ \\mathrm{g}:15=1\\,000\\ \\mathrm{g}$ za den; jeden pes tedy $1\\,000:4=250\\ \\mathrm{g}$ za den.','11.1: jeden pes $250\\ \\mathrm{g}$ denně — \\textbf{A} (pravda).','11.2: dva psi spotřebují $2\\cdot250=500\\ \\mathrm{g}$ denně; $15\\,000:500=30$ dnů — \\textbf{A}.','11.3: desetina balení $=1\\,500\\ \\mathrm{g}$; jeden pes $250\\ \\mathrm{g}$ denně, tj. $1\\,500:250=6$ dnů (ne $10$) — \\textbf{N}.'},
  '11.1: A; 11.2: A; 11.3: N',
  4, 5, '3',
  new List<String>{'zs2','r9','aritmetika','pomer','uvazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PBD17C0T02', 2017
);
c.add(
  'CERMAT 2017 M9B · úloha 12',
  new List<String>{'V trojúhelníku (viz obrázek) je vyznačena vnitřní úsečka spojující bod na základně s bodem na pravé straně trojúhelníku. Dvojité čárky vyznačují dvě shodné (stejně dlouhé) úsečky — část levé strany a tuto vnitřní úsečku. Úhel při levém dolním vrcholu má velikost $52^\\circ$; vnitřní úsečka svírá s pravou stranou trojúhelníku (směrem k hornímu vrcholu) úhel $88^\\circ$. Úhel při pravém dolním vrcholu je $\\beta$.','Jaká je velikost úhlu $\\beta$? Úhel neměřte, ale vypočtěte.'},
  new List<String>{'A) $36^\\circ$','B) $38^\\circ$','C) $40^\\circ$','D) $48^\\circ$','E) jiný výsledek'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 236 95"><path d="M193 86L193 85L193 83L193 82L193 80L193 79L194 77L194 76L194 74L195 73L195 71L196 70L196 68L197 67L198 66L199 64L199 63L201 64L200 65L199 66L198 67L198 69L197 70L197 72L196 73L196 74L195 76L195 77L195 79L195 80L194 82L194 83L194 85L194 86Z" style="fill:#000000"/><path d="M43 58L44 60L46 61L47 63L48 64L49 66L49 68L50 70L51 71L51 73L52 75L52 77L53 79L53 81L53 83L53 85L53 87L52 87L52 83L51 81L51 79L51 77L50 76L50 74L49 72L49 70L48 69L47 67L46 65L45 64L44 62L43 61L42 59Z" style="fill:#000000"/><path d="M123 24L154 24L154 44L123 44Z" style="fill:#ffffff"/><path d="M120 4L232 86L231 87L119 5Z" style="fill:#000000"/><path d="M5 87L120 5L119 4L4 86Z" style="fill:#000000"/><path d="M63 51L56 41L55 42L62 52Z" style="fill:#000000"/><path d="M59 54L52 45L53 44L60 53Z" style="fill:#000000"/><path d="M80 87L157 33L156 32L79 86Z" style="fill:#000000"/><path d="M102 79L95 69L94 70L101 80Z" style="fill:#000000"/><path d="M97 82L91 72L92 71L99 81Z" style="fill:#000000"/><path d="M132 49L131 48L130 47L130 46L129 45L129 44L128 43L128 42L127 41L127 40L127 38L127 37L127 36L126 34L126 31L127 29L127 27L128 24L128 22L129 20L130 18L132 16L133 14L134 15L133 17L132 19L131 21L130 23L129 25L128 27L128 29L128 31L128 34L128 36L128 37L128 38L129 39L129 40L129 41L130 42L130 43L130 44L131 46L132 46L132 48L133 49Z" style="fill:#000000"/><path d="M4 86L231 86L231 87L4 87Z" style="fill:#000000"/></svg>',
  'obr.svg',
  'Trojúhelník; z bodu na základně vede vnitřní úsečka k bodu na pravé straně. Úhel při levém dolním vrcholu je 52°, vnitřní úsečka svírá s pravou stranou (k hornímu vrcholu) úhel 88°, úhel při pravém dolním vrcholu je β. Dvě dvojité čárky vyznačují dvě shodné úsečky (část levé strany a vnitřní úsečku).',
  '',
  new List<String>{'Ze shodných úseček plyne, že vnitřní úsečka je rovnoběžná s levou stranou trojúhelníku. Se základnou proto svírá (v souhlasné poloze) stejný úhel $52^\\circ$ jako levá strana.','Úhel, který vnitřní úsečka svírá s pravou stranou směrem k dolnímu (pravému) vrcholu, je vedlejší k úhlu $88^\\circ$, tedy $180^\\circ-88^\\circ=92^\\circ$.','V trojúhelníku tvořeném vnitřní úsečkou, částí základny a pravou stranou platí $\\beta=180^\\circ-52^\\circ-92^\\circ=36^\\circ$.'},
  'A) $36^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PBD17C0T02', 2017
);

System.debug('Vytvořeno úloh: '+c.created);
