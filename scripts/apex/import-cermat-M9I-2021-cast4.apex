String SRC   = 'CERMAT – Ilustrační test 2021, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2021 M9I · úloha 12',
  new List<String>{'V rovnoramenném trojúhelníku ABC má vnitřní úhel při základně AB velikost $70^\\circ$. Na straně AC leží vrchol D rovnoramenného trojúhelníku ABD se základnou AD. Uvnitř trojúhelníku je vyznačen úhel $\\varphi$ s rameny BC a BD (viz obrázek).','Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $30^\\circ$','B) $35^\\circ$','C) $40^\\circ$','D) $45^\\circ$','E) větší než $45^\\circ$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 83 153"><path d="M9 132L40 14L71 132L9 132M71 132L17 101" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M15 107C26 110 34 120 34 132M48 119C52 113 57 109 64 107" style="fill:none;stroke:#000000;stroke-width:1"/><text x="73" y="146" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="41" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="60" y="121" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝜑</text><text x="7" y="147" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="11" y="105" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="20" y="130" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">70</text><text x="29" y="130" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text></svg>',
  'obr.svg',
  'Rovnoramenný trojúhelník ABC s úhlem 70° při vrcholu A; bod D na straně AC, uvnitř vyznačen úhel fí s rameny BC a BD.',
  '',
  new List<String>{'V trojúhelníku ABC jsou úhly při A i B rovny $70^\\circ$, tedy $\\angle ABC=70^\\circ$.','Trojúhelník ABD má základnu AD, úhel při A je $70^\\circ$, proto i $\\angle ADB=70^\\circ$ a $\\angle ABD=180^\\circ-140^\\circ=40^\\circ$.','$\\varphi=\\angle DBC=\\angle ABC-\\angle ABD=70^\\circ-40^\\circ=30^\\circ$.'},
  'A) $30^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PID21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9I · úloha 13',
  new List<String>{'Obdélník ABCD je možné rozdělit na čtyři shodné čtverce v jedné řadě. V každém čtverci je tmavý kruh, který se dotýká všech stran tohoto čtverce. Obvod jednoho tmavého kruhu je $o=\\pi\\cdot9\\ \\mathrm{cm}$ (viz obrázek).','Jaký je obvod obdélníku ABCD?'},
  new List<String>{'A) menší než $45\\ \\mathrm{cm}$','B) $45\\ \\mathrm{cm}$','C) $60\\ \\mathrm{cm}$','D) $72\\ \\mathrm{cm}$','E) $90\\ \\mathrm{cm}$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 211 81"><path d="M11 37C11 25 21 14 34 14C47 14 57 25 57 37C57 50 47 60 34 60C21 60 11 50 11 37Z" style="fill:#a6a6a6;stroke:#ffffff;stroke-width:2"/><path d="M57 37C57 25 67 14 80 14C93 14 103 25 103 37C103 50 93 60 80 60C67 60 57 50 57 37Z" style="fill:#a6a6a6;stroke:#ffffff;stroke-width:2"/><path d="M103 37C103 25 114 14 126 14C139 14 149 25 149 37C149 50 139 60 126 60C114 60 103 50 103 37Z" style="fill:#a6a6a6;stroke:#ffffff;stroke-width:2"/><path d="M149 37C149 25 160 14 173 14C185 14 196 25 196 37C196 50 185 60 173 60C160 60 149 50 149 37Z" style="fill:#a6a6a6;stroke:#ffffff;stroke-width:2"/><path d="M11 14L195 14L195 61L11 61ZM57 14L57 61M103 14L103 61M149 14L149 61" style="fill:none;stroke:#000000;stroke-width:2"/><text x="7" y="75" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="200" y="75" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="201" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="7" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text></svg>',
  'obr.svg',
  'Obdélník ABCD rozdělený na čtyři shodné čtverce v řadě, v každém čtverci tmavý kruh vepsaný do čtverce.',
  '',
  new List<String>{'Z $o=\\pi d=\\pi\\cdot9$ plyne průměr kruhu $d=9\\ \\mathrm{cm}$, což je i strana čtverce.','Obdélník má rozměry $4\\cdot9=36\\ \\mathrm{cm}$ a $9\\ \\mathrm{cm}$; obvod $=2\\cdot(36+9)=90\\ \\mathrm{cm}$.'},
  'E) $90\\ \\mathrm{cm}$',
  2, 3, '2',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','vypocet','vyber','bez-kalkulacky'},
  'M9PID21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9I · úloha 14',
  new List<String>{'Celou plochu haly by uklidilo $10$ nepřetržitě pracujících čisticích strojů společně za $12$ hodin. Každý čisticí stroj uklidí za tentýž čas stejně velkou část plochy. V sobotu pracovalo pouze $5$ čisticích strojů a za $18$ hodin uklidilo větší část plochy haly. Zbývající plochu haly uklidily stroje v neděli.','Kolik procent plochy haly uklidily stroje v neděli?'},
  new List<String>{'A) méně než $25\\ \\%$','B) $25\\ \\%$','C) $30\\ \\%$','D) $35\\ \\%$','E) více než $35\\ \\%$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Celková práce $=10\\cdot12=120$ strojhodin.','V sobotu $5\\cdot18=90$ strojhodin, tj. $\\frac{90}{120}=75\\ \\%$ plochy.','V neděli zbývá $100\\ \\%-75\\ \\%=25\\ \\%$.'},
  'B) $25\\ \\%$',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','vyber','bez-kalkulacky','bezny-zivot'},
  'M9PID21C0T01', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
