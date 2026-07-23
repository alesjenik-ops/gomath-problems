String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD26C0T04';
Integer YEAR = 2026;

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
  'CERMAT M9D 2026 – úloha 11',
  new List<String>{'Pavle je $17$ let. Od $12$ let si vždy v den narozenin zapisuje svou výšku v celých cm. V grafu jsou zaznamenány tři z těchto zapsaných výšek, zbývající tři údaje chybí. Během tří let od $12.$ do $15.$ narozenin povyrostla Pavla každým rokem o stejný počet cm. Pavlina výška v den jejích $16.$ narozenin je aritmetickým průměrem výšek zapsaných ve dnech $15.$ a $17.$ narozenin.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Od $15.$ do $17.$ narozenin vyrostla Pavla celkem o $5$ cm.','11.2 V den $14.$ narozenin měřila Pavla $167$ cm.','11.3 Aritmetický průměr všech šesti výšek, které si Pavla zapsala, je $167$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 320" font-family="sans-serif"><line x1="70" y1="50" x2="70" y2="270" stroke="#000"/><line x1="70" y1="270" x2="490" y2="270" stroke="#000"/><line x1="70" y1="270.0" x2="480" y2="270.0" stroke="#dddddd"/><text x="62" y="274.0" font-size="11" text-anchor="end">158</text><line x1="70" y1="242.5" x2="480" y2="242.5" stroke="#dddddd"/><text x="62" y="246.5" font-size="11" text-anchor="end">160</text><line x1="70" y1="215.0" x2="480" y2="215.0" stroke="#dddddd"/><text x="62" y="219.0" font-size="11" text-anchor="end">162</text><line x1="70" y1="187.5" x2="480" y2="187.5" stroke="#dddddd"/><text x="62" y="191.5" font-size="11" text-anchor="end">164</text><line x1="70" y1="160.0" x2="480" y2="160.0" stroke="#dddddd"/><text x="62" y="164.0" font-size="11" text-anchor="end">166</text><line x1="70" y1="132.5" x2="480" y2="132.5" stroke="#dddddd"/><text x="62" y="136.5" font-size="11" text-anchor="end">168</text><line x1="70" y1="105.0" x2="480" y2="105.0" stroke="#dddddd"/><text x="62" y="109.0" font-size="11" text-anchor="end">170</text><line x1="70" y1="77.5" x2="480" y2="77.5" stroke="#dddddd"/><text x="62" y="81.5" font-size="11" text-anchor="end">172</text><line x1="70" y1="50.0" x2="480" y2="50.0" stroke="#dddddd"/><text x="62" y="54.0" font-size="11" text-anchor="end">174</text><text x="116" y="286" font-size="11" text-anchor="middle">12 let</text><rect x="162" y="201.2" width="44" height="68.8" fill="#c9c9c9" stroke="#000"/><text x="184" y="286" font-size="11" text-anchor="middle">13 let</text><text x="252" y="286" font-size="11" text-anchor="middle">14 let</text><text x="320" y="286" font-size="11" text-anchor="middle">15 let</text><rect x="366" y="91.2" width="44" height="178.8" fill="#c9c9c9" stroke="#000"/><text x="388" y="286" font-size="11" text-anchor="middle">16 let</text><rect x="434" y="63.8" width="44" height="206.2" fill="#c9c9c9" stroke="#000"/><text x="456" y="286" font-size="11" text-anchor="middle">17 let</text><text x="24" y="160" font-size="12" text-anchor="middle" transform="rotate(-90 24 160)">Výška v cm</text></svg>',
  'graf-vysky.svg',
  'Sloupcový graf výšky Pavly v cm; zapsané hodnoty jsou 13 let 163 cm, 16 let 171 cm, 17 let 173 cm, sloupce pro 12, 14 a 15 let chybí. Svislá osa je od 158 do 174 cm.',
  'Zapsané výšky (údaje pro 12, 14 a 15 let chybí)',
  new List<String>{'Výšky ve dnech 12.–15. narozenin tvoří posloupnost se stálým ročním přírůstkem. Ze zapsaných hodnot je výška ve 13 letech $163$ cm, v 16 letech $171$ cm a v 17 letech $173$ cm. Protože výška v 16 letech je průměrem výšek v 15 a 17 letech, platí $171=\\frac{h_{15}+173}{2}$, tedy $h_{15}=169$ cm. Roční přírůstek mezi 13. a 15. rokem je $\\frac{169-163}{2}=3$ cm, takže $h_{12}=160$ cm a $h_{14}=166$ cm. Výšky: $160, 163, 166, 169, 171, 173$ cm.','11.1 Od 15. do 17. narozenin: $173-169=4$ cm, ne $5$ cm — nepravda (N).','11.2 Ve 14 letech měřila $166$ cm, ne $167$ cm — nepravda (N).','11.3 Průměr $\\frac{160+163+166+169+171+173}{6}=\\frac{1002}{6}=167$ cm — pravda (A).'},
  '11.1: Ne; 11.2: Ne; 11.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2026 – úloha 12',
  new List<String>{'Květa si koupila čtyřdílný román. První díl románu byl o $30$ % levnější než druhý díl a třetí díl byl o $30$ % dražší než druhý díl. Čtvrtý díl stojí běžně $680$ korun, ale Květa ho sehnala v akci za $40$ % běžné ceny, a tak za něj zaplatila stejně jako za první a třetí díl dohromady.','Kolik korun stál druhý díl románu?'},
  new List<String>{'A) $172$ korun','B) $170$ korun','C) $160$ korun','D) $142$ korun','E) $136$ korun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme cenu druhého dílu $x$. První díl stojí $0{,}7x$, třetí díl $1{,}3x$. Čtvrtý díl Květa koupila za $40$ % běžné ceny: $0{,}4\\cdot 680=272$ korun, což je stejně jako první a třetí díl dohromady: $0{,}7x+1{,}3x=2x=272$, tedy $x=136$ korun.'},
  'E) $136$ korun',
  2, 5, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
