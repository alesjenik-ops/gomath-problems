String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, náhradní termín (M9C)';
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
  'CERMAT 2023 M9C · úloha 13',
  new List<String>{'Pětiúhelník ABCDE se skládá z rovnoramenného, rovnostranného a pravoúhlého trojúhelníku (viz obrázek). Základnou rovnoramenného trojúhelníku je strana AB. Strany BC a AE pětiúhelníku jsou rovnoběžné. Úhel při vrcholu A má velikost $55^\\circ$, při vrcholu C je pravý úhel.','Jaká je velikost úhlu $\\omega$ (při vrcholu D)? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $65^\\circ$','B) $70^\\circ$','C) $75^\\circ$','D) $80^\\circ$','E) jiná velikost'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 180"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 58L466 58Z" style="fill:#000000"/><path d="M466 58L467 58L467 74L466 74Z" style="fill:#000000"/><path d="M466 74L467 74L467 93L466 93Z" style="fill:#000000"/><path d="M466 93L467 93L467 109L466 109Z" style="fill:#000000"/><path d="M466 109L467 109L467 128L466 128Z" style="fill:#000000"/><path d="M466 128L467 128L467 147L466 147Z" style="fill:#000000"/><path d="M4 175L466 175L466 176L4 176Z" style="fill:#000000"/><path d="M466 175L467 175L467 176L466 176Z" style="fill:#000000"/><path d="M466 175L467 175L467 176L466 176Z" style="fill:#000000"/><path d="M466 147L467 147L467 175L466 175Z" style="fill:#000000"/><path d="M276 49L408 27L441 55L361 151L191 152L276 49M276 49L361 151M408 27L361 151" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M216 122C225 129 230 140 230 152M432 67C428 64 426 61 426 56C426 52 427 48 430 45M424 40C418 47 409 50 400 47M416 80L421 87M417 78L422 85M246 80L251 87M247 78L252 85" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M431 56C431 55 432 55 433 55C433 55 434 55 434 56C434 56 433 57 433 57C432 57 431 56 431 56Z" style="fill:#000000"/><text x="177" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">se skládá z rovnoramenného,</text><text x="189" y="166" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="364" y="166" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="449" y="61" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="410" y="25" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="276" y="47" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">E</text><text x="213" y="149" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">55</text><text x="221" y="148" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="411" y="44" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝜔</text></svg>',
  'obr.svg',
  'Pětiúhelník ABCDE složený z rovnoramenného, rovnostranného a pravoúhlého trojúhelníku; úhel při A je 55°, při C pravý úhel, hledaný úhel omega při vrcholu D.',
  '',
  new List<String>{'Rovnoramenný trojúhelník ABE se základnou AB: úhly při A i B jsou $55^\\circ$, tedy úhel AEB $=70^\\circ$.','Rovnostranný trojúhelník BDE má všechny úhly $60^\\circ$ (úhel EBD $=60^\\circ$).','Protože BC $\\parallel$ AE, jsou úhly EAB a ABC přilehlé (součet $180^\\circ$): úhel ABC $=180^\\circ-55^\\circ=125^\\circ$.','Úhel DBC $=125^\\circ-55^\\circ-60^\\circ=10^\\circ$. V pravoúhlém trojúhelníku BCD (pravý úhel při C) je $\\omega=90^\\circ-10^\\circ=80^\\circ$.'},
  'D) $80^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PCD23C0T03', 2023
);
c.add(
  'CERMAT 2023 M9C · úloha 14',
  new List<String>{'Povrch pravidelného čtyřbokého hranolu je $144\\ \\mathrm{cm}^2$. Obsah pláště tohoto hranolu je dvakrát větší než obsah jedné jeho čtvercové podstavy. (Plášť tvoří čtyři shodné boční stěny.)','Jaký je objem hranolu?'},
  new List<String>{'A) $72\\ \\mathrm{cm}^3$','B) $108\\ \\mathrm{cm}^3$','C) $144\\ \\mathrm{cm}^3$','D) $216\\ \\mathrm{cm}^3$','E) jiný objem'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Podstava je čtverec o straně $a$, výška $h$. Plášť $=4ah$, podstava $=a^2$; $4ah=2a^2\\Rightarrow a=2h$.','Povrch $=2a^2+4ah=2a^2+2a^2=4a^2=144\\Rightarrow a^2=36\\Rightarrow a=6\\ \\mathrm{cm}$, $h=3\\ \\mathrm{cm}$.','Objem $V=a^2\\cdot h=36\\cdot3=108\\ \\mathrm{cm}^3$.'},
  'B) $108\\ \\mathrm{cm}^3$',
  2, 3, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','vyber','bez-kalkulacky'},
  'M9PCD23C0T03', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
