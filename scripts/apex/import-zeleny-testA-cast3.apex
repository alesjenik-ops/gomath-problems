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
  'Zelený A11 – lyžařský kurz (Vennův diagram)',
  new List<String>{'Na lyžařský kurz nás z celého ročníku jelo pouze $60$. Měli jsme si s sebou vzít buď sjezdovky, nebo snowboard, nebo běžky, popř. libovolnou kombinaci tohoto lyžařského „nádobíčka". Večer jsme si udělali statistiku, jak jsme vybaveni, a zakreslili vše do grafu. Z něj vidíme např. to, že $27$ žáků si vzalo jenom sjezdovky, zatímco $12$ žáků si vzalo sjezdovky a snowboard a $3$ žáci k tomu ještě běžky.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Každý čtvrtý účastník kurzu si s sebou nevzal sjezdovky.','11.2 Na běžky mohly vyrazit nejvýše tři šestičlenné skupiny.','11.3 $45\\,\\%$ účastníků mohlo během kurzu vystřídat dva lyžařské sporty, aniž by si museli půjčovat vybavení od spolužáků.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 470" font-family="sans-serif"> <circle cx="190" cy="195" r="150" fill="#3a3a3a" fill-opacity="0.85" stroke="#000"/> <circle cx="350" cy="195" r="150" fill="#ffffff" fill-opacity="0" stroke="#000"/> <circle cx="270" cy="320" r="150" fill="#000000" fill-opacity="0" stroke="#000"/> <text x="150" y="60" font-size="20" font-weight="bold">SJEZDOVKY</text> <text x="405" y="60" font-size="20" font-weight="bold">BĚŽKY</text> <text x="205" y="460" font-size="20" font-weight="bold">SNOWBOARD</text> <text x="135" y="185" font-size="22" fill="#fff" text-anchor="middle">27</text> <text x="270" y="150" font-size="22" text-anchor="middle">6</text> <text x="405" y="185" font-size="22" text-anchor="middle">3</text> <text x="270" y="225" font-size="22" text-anchor="middle">3</text> <text x="205" y="270" font-size="22" fill="#fff" text-anchor="middle">12</text> <text x="335" y="270" font-size="22" text-anchor="middle">6</text> <text x="270" y="360" font-size="22" text-anchor="middle">3</text> </svg>',
  'venn-lyze.svg',
  'Vennův diagram tří množin sjezdovky, běžky, snowboard s počty 27, 6, 3, 3, 12, 6, 3.',
  'Vybavení účastníků kurzu',
  new List<String>{'11.1 Sjezdovky nemá $3+6+3=12$ z $60$, tj. $\\frac{12}{60}=\\frac{1}{5}$, ne každý čtvrtý. Tvrzení je nepravdivé (Ne).','11.2 Běžky má $6+3+3+6=18$ žáků, tj. právě tři šestičlenné skupiny. Pravdivé (Ano).','11.3 Dva sporty (dvě z vybavení) má $12+6+6+3=27$ žáků; $\\frac{27}{60}=45\\,\\%$. Pravdivé (Ano).'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  3, 6, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený A12 – kancelářská budova (hranol)',
  new List<String>{'Nová kancelářská budova má tvar hranolu vysokého $100$ metrů s podstavou pravoúhlého trojúhelníku o obsahu $2400$ m². Délky stěn budovy svírající pravý úhel jsou v poměru $4:3$.','Jaký je obsah plochy všech tří stěn budovy?'},
  new List<String>{'A) $12\\,000$ m²','B) $14\\,000$ m²','C) $21\\,000$ m²','D) $24\\,000$ m²','E) jiný obsah'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Odvěsny v poměru $4:3$, tj. $4k$ a $3k$: $\\frac{1}{2}\\cdot 4k\\cdot 3k=2400\\Rightarrow 6k^2=2400\\Rightarrow k=20$. Odvěsny $80$ m a $60$ m, přepona $\\sqrt{80^2+60^2}=100$ m. Obvod podstavy $80+60+100=240$ m, tři obdélníkové stěny mají obsah $240\\cdot 100=24\\,000$ m².'},
  'D) $24\\,000$ m²',
  2, 6, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený A13 – tětivový čtyřúhelník (úhly)',
  new List<String>{'Do kružnice je vepsán čtyřúhelník. Na obrázku jsou vyznačeny známé velikosti úhlů.','Jak velký je úhel na obrázku označený symbolem „?"?'},
  new List<String>{'A) $105^\\circ$','B) $112^\\circ$','C) $117^\\circ$','D) $132^\\circ$','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 430" font-family="sans-serif"> <circle cx="250" cy="235" r="175" fill="none" stroke="#777" stroke-width="1" stroke-dasharray="4 5"/> <line x1="40" y1="235" x2="460" y2="235" stroke="#000" stroke-width="1.5" stroke-dasharray="6 6"/> <polygon points="110,235 315,80 395,235 250,400" fill="none" stroke="#000" stroke-width="2.5"/> <text x="128" y="222" font-size="19" font-weight="bold">165°</text> <text x="355" y="220" font-size="20" font-style="italic">?</text> <text x="402" y="262" font-size="19" font-weight="bold">138°</text> </svg>',
  'tetivovy-ctyruhelnik.svg',
  'Čtyřúhelník vepsaný do kružnice; u dvou vrcholů jsou vyznačeny vnější úhly 165° a 138°, u jednoho vrcholu úhel označený otazníkem.',
  'Schematický nákres k úloze 13',
  new List<String>{'Z vnějších úhlů získáme vnitřní úhly čtyřúhelníku u příslušných vrcholů: $180^\\circ-165^\\circ=15^\\circ$ a $180^\\circ-138^\\circ=42^\\circ$. V tětivovém čtyřúhelníku je součet protilehlých úhlů $180^\\circ$; dopočtem hledaný úhel $?=117^\\circ$.'},
  'C) $117^\\circ$',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
