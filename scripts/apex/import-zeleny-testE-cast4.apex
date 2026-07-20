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
  'Zelený E10 – konstrukce trojúhelníku',
  new List<String>{'V rovině leží úsečka $AB$ o délce $8$ cm.','Sestrojte trojúhelník $ABC$, víme-li, že výška $v_a=6$ cm a těžnice $t_c=5$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 330" font-family="sans-serif"> <line x1="90" y1="290" x2="340" y2="80" stroke="#000" stroke-width="2.5"/> <line x1="82" y1="282" x2="98" y2="298" stroke="#000" stroke-width="2"/> <line x1="332" y1="72" x2="348" y2="88" stroke="#000" stroke-width="2"/> <text x="72" y="308" font-size="18" font-weight="bold">A</text> <text x="350" y="82" font-size="18" font-weight="bold">B</text> <text x="232" y="178" font-size="15">8 cm</text> </svg>',
  'usecka-ab-8.svg',
  'Úsečka AB o délce 8 cm v rovině, šikmo orientovaná, bod A vlevo dole a bod B vpravo nahoře.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Strana $c=|AB|=8$ cm je dána; $S_c$ je střed úsečky $AB$. Bod $C$ leží na kružnici $k(S_c;5$ cm$)$ (těžnice $t_c$) a zároveň na tečně vedené z bodu $B$ ke kružnici $l(A;6$ cm$)$, neboť vzdálenost bodu $A$ od přímky $BC$ musí být rovna výšce $v_a=6$ cm. Průsečík určuje vrchol $C$.'},
  'Konstrukce trojúhelníku $ABC$: $C$ je průsečík kružnice $k(S_c;5$ cm$)$ a tečny z $B$ ke kružnici $l(A;6$ cm$)$; $S_c$ je střed $AB$ (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený E11 – žáci ze tří obcí',
  new List<String>{'V naší škole jsou žáci ze tří obcí. Fryšavských je třikrát více než Kadovských, dětí ze Skleného je o polovinu méně než z Fryšavy.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (Ano), či nikoli (Ne).','11.1 Celkový počet žáků naší školy je vždy dělitelný $11$.','11.2 Děti z Fryšavy tvoří více než polovinu žáků naší školy.','11.3 Jestliže z Kadova dochází do naší školy $8$ žáků, pak je celkový počet žáků naší školy $88$.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť Kadovských je $k$. Pak Fryšavských je $3k$ a ze Skleného $\\frac{3k}{2}$. Celkem $k+3k+\\frac{3k}{2}=\\frac{11k}{2}$ žáků.','11.1 Aby byl počet ze Skleného celý, musí být $k$ sudé; pak $\\frac{11k}{2}=11\\cdot\\frac{k}{2}$ je vždy dělitelné $11$. Ano.','11.2 Fryšavských je $3k$ z $\\frac{11k}{2}$, tj. $\\frac{6}{11}>\\frac{1}{2}$. Ano.','11.3 Pro $k=8$ je celkem $\\frac{11\\cdot8}{2}=44$ žáků, nikoli $88$. Ne.'},
  '11.1: Ano; 11.2: Ano; 11.3: Ne',
  3, 6, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený E12 – kostky do válce',
  new List<String>{'Válec o vnitřním průměru $20$ cm je naplněn vodou $2$ cm pod okraj válce. Do válce budeme vkládat ocelové kostky ve tvaru krychle o hraně $2$ cm. $\\pi=3{,}14$.','Kolik kostek musíme vložit do válce, aby voda poprvé přetekla přes okraj válce?'},
  new List<String>{'A) $39$','B) $40$','C) $78$','D) $79$','E) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Prázdný prostor nad hladinou: $\\pi r^2\\cdot2=3{,}14\\cdot10^2\\cdot2=628$ cm³. Jedna kostka vytlačí $2^3=8$ cm³ vody. $628:8=78{,}5$, takže $78$ kostek nestačí ($624$ cm³), $79$ kostek ($632$ cm³) vodu přelije.'},
  'D) $79$',
  2, 6, '4',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
