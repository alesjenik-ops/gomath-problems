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
  'Zelený L10 – trojúhelník ze středních příček',
  new List<String>{'V rovině leží trojúhelník $STU$.','Sestrojte trojúhelník $ABC$, jehož střední příčky jsou strany trojúhelníku $STU$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 380" font-family="sans-serif"> <polygon points="300,50 90,210 360,330" fill="none" stroke="#000" stroke-width="2.5"/> <text x="305" y="42" font-size="18" font-weight="bold">S</text> <text x="66" y="214" font-size="18" font-weight="bold">T</text> <text x="368" y="348" font-size="18" font-weight="bold">U</text> </svg>',
  'trojuhelnik-stu.svg',
  'Trojúhelník STU s vrcholem S nahoře, T vlevo a U vpravo dole.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Trojúhelník $ABC$ je tzv. antikomplementární trojúhelník k $STU$: každým vrcholem trojúhelníku $STU$ vedeme rovnoběžku s protější stranou. Průsečíky těchto rovnoběžek jsou vrcholy $A$, $B$, $C$. Body $S$, $T$, $U$ jsou pak středy stran trojúhelníku $ABC$ a úsečky $ST$, $TU$, $US$ jeho středními příčkami.'},
  'Konstrukce trojúhelníku $ABC$, jehož středními příčkami jsou strany trojúhelníku $STU$ (vrcholy $A$, $B$, $C$ vzniknou vedením rovnoběžek s protějšími stranami $STU$; viz obrázek v klíči).',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený L11 – etapy závodu (Ano/Ne)',
  new List<String>{'Délky prvních tří etap závodu byly ve vzájemném poměru $2:3:4$. Průměrná rychlost našeho vozu v jednotlivých etapách však byla v poměru $3:4:5$.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Třetí etapa nám trvala ve srovnání s první etapou o pětinu déle.','11.2 Čas dosažený v první i druhé etapě byl stejný.','11.3 Abychom dosáhli ve třetí etapě stejného času jako v první, museli bychom jet o $20\\,\\%$ rychleji, než jsme jeli.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Čas je podíl dráhy a rychlosti. V poměrových jednotkách: $t_1=\\frac{2}{3}$, $t_2=\\frac{3}{4}$, $t_3=\\frac{4}{5}$.','11.1 $\\frac{t_3}{t_1}=\\frac{4/5}{2/3}=\\frac{12}{10}=1{,}2$, tj. o pětinu déle — pravda (A).','11.2 $t_1=\\frac{2}{3}$ a $t_2=\\frac{3}{4}$ nejsou stejné — nepravda (N).','11.3 Pro stejný čas jako v $1$. etapě při dráze $4$ je potřeba rychlost $\\frac{4}{2/3}=6$; jeli jsme rychlostí $5$, tedy o $\\frac{6}{5}=1{,}2$, o $20\\,\\%$ rychleji — pravda (A).'},
  '11.1: Ano; 11.2: Ne; 11.3: Ano',
  3, 6, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený L12 – napouštění vázy (graf)',
  new List<String>{'Na obrázku je metr vysoká skleněná váza ve tvaru komolého kužele (širší u dna, užší nahoře). Do vázy napouštíme pomalu stejným proudem vodu a každou vteřinu zaznamenáváme do grafu výšku hladiny vody ve váze.','Vyberte z pěti grafů (A–E) závislosti výšky vodního sloupce na době napouštění ten, který odpovídá podmínkám pokusu.'},
  new List<String>{'A) graf, kde výška roste nejprve rychle a postupně se růst zpomaluje','B) graf, kde výška roste rovnoměrně (přímka)','C) graf, kde výška roste nejprve pomalu a postupně stále rychleji','D) graf tvaru písmene S (nejprve pomalu, uprostřed rychle, na konci opět pomalu)','E) graf, kde výška roste nejprve rychle, pak pomaleji a nakonec opět rychleji'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 410" font-family="sans-serif"> <polygon points="120,50 180,50 240,340 60,340" fill="#dfe8ef" stroke="#000" stroke-width="2"/> <ellipse cx="150" cy="340" rx="90" ry="16" fill="#cdd9e2" stroke="#000" stroke-width="2"/> <ellipse cx="150" cy="50" rx="30" ry="7" fill="none" stroke="#000" stroke-width="1.5"/> <text x="150" y="385" font-size="14" text-anchor="middle">váza (komolý kužel), výška 1 m</text> </svg>',
  'vaza.svg',
  'Skleněná váza tvaru komolého kužele, širší u dna a užší u hrdla, vysoká 1 metr.',
  'Váza ve tvaru komolého kužele',
  new List<String>{'Váza je širší u dna a užší nahoře, proto se stejným proudem plní spodní široká část pomalu (hladina stoupá zvolna) a horní úzká část rychle (hladina stoupá rychle). Výška hladiny tedy roste nejprve pomalu a postupně stále rychleji — graf je konkávní nahoru, odpovídá variantě C.'},
  'C) graf, kde výška roste nejprve pomalu a postupně stále rychleji',
  2, 4, '3',
  new List<String>{'zs2','r9','funkce','porozumeni','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
