String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. náhradní termín (M9D)';
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
  'CERMAT 2026 M9D · úloha 11',
  new List<String>{'Pavle je $17$ let. Od $12$ let si vždy v den narozenin zapisuje svou výšku v celých cm. V grafu jsou zaznamenány tři z těchto výšek, zbývající tři chybí. Během tří let od $12.$ do $15.$ narozenin povyrostla Pavla každým rokem o stejný počet cm. Pavlina výška v den $16.$ narozenin je aritmetickým průměrem výšek zapsaných ve dnech $15.$ a $17.$ narozenin.','Rozhodněte o každém z tvrzení, zda je pravdivé (A), nebo nepravdivé (N):','11.1 Od $15.$ do $17.$ narozenin vyrostla Pavla celkem o $5\\ \\mathrm{cm}$.','11.2 V den $14.$ narozenin měřila Pavla $167\\ \\mathrm{cm}$.','11.3 Aritmetický průměr všech šesti zapsaných výšek je $167\\ \\mathrm{cm}$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 169"><path d="M4 164L466 164L466 165L4 165Z" style="fill:#000000"/><path d="M8 4L334 4L334 160L8 160ZM74 135L74 16M70 135L74 135M70 120L74 120M70 105L74 105M70 91L74 91M70 76L74 76M70 61L74 61M70 46L74 46M70 31L74 31M70 17L74 17M74 135L323 135M74 135L74 139M115 135L115 139M157 135L157 139M198 135L198 139M240 135L240 139M282 135L282 139M323 135L323 139" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M74 128L323 128M74 113L323 113M74 98L323 98M74 83L323 83M74 68L323 68M74 54L323 54M74 39L323 39M74 24L323 24" style="fill:none;stroke:#bfbfbf;stroke-width:1"/><path d="M74 120L323 120M74 105L323 105M74 91L323 91M74 76L323 76M74 61L323 61M74 46L323 46M74 31L323 31M74 17L323 17" style="fill:none;stroke:#7f7f7f;stroke-width:1"/><path d="M85 14L104 14L104 135L85 135Z" style="fill:#ffffff;stroke:#000000;stroke-width:1"/><path d="M169 14L187 14L187 135L169 135Z" style="fill:#ffffff;stroke:#000000;stroke-width:1"/><path d="M210 14L229 14L229 135L210 135Z" style="fill:#ffffff;stroke:#000000;stroke-width:1"/><path d="M127 98L145 98L145 135L127 135ZM252 39L270 39L270 135L252 135ZM293 24L312 24L312 135L293 135Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:1"/><text x="54" y="141" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">158</text><text x="54" y="126" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">160</text><text x="54" y="111" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">162</text><text x="54" y="96" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">164</text><text x="54" y="81" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">166</text><text x="54" y="67" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">168</text><text x="54" y="52" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">170</text><text x="54" y="37" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">172</text><text x="95" y="152" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">12 let</text><text x="136" y="152" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">13 let</text><text x="178" y="152" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">14 let</text><text x="219" y="152" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">15 let</text><text x="261" y="152" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">16 let</text><text x="303" y="152" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">17 let</text><text x="29" y="102" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Výška v cm</text></svg>',
  'obr.svg',
  'Sloupcový graf výšky Pavly v cm ve dnech 12. až 17. narozenin; tři údaje (12, 14, 15 let) chybí.',
  '',
  new List<String>{'Z grafu: výška ve $13$ letech $163\\ \\mathrm{cm}$, v $16$ letech $171\\ \\mathrm{cm}$, v $17$ letech $173\\ \\mathrm{cm}$. Od $12$ do $15$ přírůstek stejný, výška v $16$ je průměr výšek v $15$ a $17$.','Dopočtené výšky: $12\\!:\\!161$, $14\\!:\\!165$, $15\\!:\\!167$ cm.','11.1: $173-167=6\\ \\mathrm{cm}$, nikoli $5$ — N. 11.2: v $14$ letech $165\\ \\mathrm{cm}$, nikoli $167$ — N. 11.3: průměr $\\frac{161+163+165+167+171+173}{6}=167\\ \\mathrm{cm}$ — A.'},
  '11.1: N; 11.2: N; 11.3: A',
  4, 5, '4',
  new List<String>{'zs2','r9','statistika','posloupnosti','porozumeni','bez-kalkulacky','bezny-zivot'},
  'M9PDD26C0T04', 2026
);
c.add(
  'CERMAT 2026 M9D · úloha 12',
  new List<String>{'Květa si koupila čtyřdílný román. První díl byl o $30\\ \\%$ levnější než druhý díl, třetí díl o $30\\ \\%$ dražší než druhý díl. Čtvrtý díl stojí běžně $680$ korun, ale Květa ho koupila v akci za $40\\ \\%$ běžné ceny a zaplatila za něj stejně jako za první a třetí díl dohromady.','Kolik korun stál druhý díl románu?'},
  new List<String>{'A) $172$ korun','B) $170$ korun','C) $160$ korun','D) $142$ korun','E) $136$ korun'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Čtvrtý díl v akci: $0{,}4\\cdot680=272$ korun.','První $+$ třetí díl: $0{,}7d_2+1{,}3d_2=2d_2=272\\Rightarrow d_2=136$ korun.'},
  'E) $136$ korun',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD26C0T04', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
