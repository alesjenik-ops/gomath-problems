String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD26C0T04';
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
  'CERMAT M7D 2026 – úloha 10',
  new List<String>{'Pavle je $17$ let. Od $12$ let si vždy v den narozenin zapisuje svou výšku v celých cm. V grafu jsou zaznamenány tři z těchto zapsaných výšek, zbývající tři údaje chybí. Během tří let od $12$. do $15$. narozenin povyrostla Pavla každým rokem o stejný počet cm. Pavlina výška v den jejích $16$. narozenin je aritmetickým průměrem výšek zapsaných ve dnech $15$. a $17$. narozenin.','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), nebo nepravdivé (N).','10.1 Od $15$. do $17$. narozenin vyrostla Pavla celkem o $5$ cm.','10.2 V den $14$. narozenin měřila Pavla $167$ cm.','10.3 Aritmetický průměr všech šesti výšek, které si Pavla zapsala, je $167$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 300" font-family="sans-serif"><line x1="70" y1="70" x2="70" y2="250" stroke="#000"/><line x1="70" y1="250" x2="490" y2="250" stroke="#000"/><line x1="66" y1="250" x2="490" y2="250" stroke="#ccc"/><text x="62" y="254" font-size="11" text-anchor="end">158</text><line x1="66" y1="230" x2="490" y2="230" stroke="#ccc"/><text x="62" y="234" font-size="11" text-anchor="end">160</text><line x1="66" y1="210" x2="490" y2="210" stroke="#ccc"/><text x="62" y="214" font-size="11" text-anchor="end">162</text><line x1="66" y1="190" x2="490" y2="190" stroke="#ccc"/><text x="62" y="194" font-size="11" text-anchor="end">164</text><line x1="66" y1="170" x2="490" y2="170" stroke="#ccc"/><text x="62" y="174" font-size="11" text-anchor="end">166</text><line x1="66" y1="150" x2="490" y2="150" stroke="#ccc"/><text x="62" y="154" font-size="11" text-anchor="end">168</text><line x1="66" y1="130" x2="490" y2="130" stroke="#ccc"/><text x="62" y="134" font-size="11" text-anchor="end">170</text><line x1="66" y1="110" x2="490" y2="110" stroke="#ccc"/><text x="62" y="114" font-size="11" text-anchor="end">172</text><line x1="66" y1="90" x2="490" y2="90" stroke="#ccc"/><text x="62" y="94" font-size="11" text-anchor="end">174</text><text x="113.0" y="266" font-size="11" text-anchor="middle">12 let</text><rect x="156" y="200" width="46" height="50" fill="#c9c9c9" stroke="#000"/><text x="179.0" y="266" font-size="11" text-anchor="middle">13 let</text><text x="245.0" y="266" font-size="11" text-anchor="middle">14 let</text><text x="311.0" y="266" font-size="11" text-anchor="middle">15 let</text><rect x="354" y="120" width="46" height="130" fill="#c9c9c9" stroke="#000"/><text x="377.0" y="266" font-size="11" text-anchor="middle">16 let</text><rect x="420" y="100" width="46" height="150" fill="#c9c9c9" stroke="#000"/><text x="443.0" y="266" font-size="11" text-anchor="middle">17 let</text><text x="26" y="160" font-size="12" text-anchor="middle" transform="rotate(-90 26 160)">Výška v cm</text></svg>',
  'graf-vyska.svg',
  'Sloupcový graf výšek v cm od 12 do 17 let; zapsané hodnoty 13 let 163 cm, 16 let 171 cm, 17 let 173 cm, ostatní chybí.',
  'Zapsané výšky Pavly (cm)',
  new List<String>{'Výška v $16$ letech $=171=\\frac{v_{15}+173}{2}\\Rightarrow v_{15}=169$. Od $12$ do $15$ stejný přírůstek $d$: $v_{15}-v_{13}=2d=169-163=6\\Rightarrow d=3$. Výšky: $160,163,166,169,171,173$.','10.1 Od $15$ do $17$: $173-169=4$ cm, ne $5$ → Ne.','10.2 V $14$ letech $166$ cm, ne $167$ → Ne.','10.3 Průměr $\\frac{160+163+166+169+171+173}{6}=\\frac{1002}{6}=167$ cm → Ano.'},
  '10.1: Ne; 10.2: Ne; 10.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2026 – úloha 11',
  new List<String>{'Děti, které se účastnily soutěže, se měly rozdělit do stejně početných skupin. Když se rozdělily do trojic, jedno z dětí zbylo. Když se však rozdělily do pětic, nikdo nezbyl. Počet dětmi vytvořených pětic byl o $9$ menší než počet trojic.','Kolik pětic děti vytvořily?'},
  new List<String>{'A) $11$ pětic','B) $12$ pětic','C) $13$ pětic','D) $14$ pětic','E) jiný počet pětic'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť je $p$ pětic (počet dětí $5p$) a $t$ trojic. Platí $5p=3t+1$ a $p=t-9$, tedy $t=p+9$. Dosazením $5p=3(p+9)+1\\Rightarrow 2p=28\\Rightarrow p=14$ (dětí $70$; $70=3\\cdot 23+1$).'},
  'D) $14$ pětic',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
