String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, 2. řádný termín (M9B)';
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
  'CERMAT 2022 M9B · úloha 13',
  new List<String>{'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné (v obrázku vyznačeny značkami). Dvě různoběžky protínají rovnoběžky pod úhly $110^\\circ$ a $100^\\circ$ a navzájem se protínají ve vrcholu úhlu $\\alpha$ (viz obrázek).','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $120^\\circ$','B) $120^\\circ$','C) $130^\\circ$','D) $150^\\circ$','E) větší než $150^\\circ$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 221 136"><path d="M14 4L70 132M140 4L195 132M4 55L217 124M49 128L198 17" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M12 10L21 10M13 11L22 11M138 10L147 10M139 12L148 12M30 40C45 33 62 40 69 55C72 62 72 69 70 76M133 65C123 51 126 32 140 21C142 20 144 19 146 18M86 81C90 72 100 67 110 70C113 71 116 73 119 76" style="fill:none;stroke:#000000;stroke-width:1"/><text x="51" y="63" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">110</text><text x="62" y="63" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="139" y="49" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">100</text><text x="151" y="49" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="102" y="82" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text></svg>',
  'obr.svg',
  'Dvě rovnoběžné přímky (se značkami) protnuté dvěma různoběžkami; vyznačené úhly 110° a 100° u rovnoběžek a hledaný úhel alfa v jejich průsečíku.',
  '',
  new List<String>{'Vrcholem úhlu $\\alpha$ vedeme pomocnou přímku rovnoběžnou s oběma rovnoběžkami. Ta rozdělí úhel $\\alpha$ na dvě části.','Podle přilehlých (přímých) úhlů u rovnoběžek jsou tyto části $180^\\circ-110^\\circ=70^\\circ$ a $180^\\circ-100^\\circ=80^\\circ$.','Tedy $\\alpha=70^\\circ+80^\\circ=150^\\circ$.'},
  'D) $150^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PBD22C0T02', 2022
);
c.add(
  'CERMAT 2022 M9B · úloha 14',
  new List<String>{'V knihovně je $k$ polic. V každé polici je o $8$ knih více, než je v knihovně polic. ($k$ může nabývat různých kladných celých hodnot.)','Který výraz vyjadřuje celkový počet knih v knihovně?'},
  new List<String>{'A) $k^2+8k$','B) $k^2+16k+64$','C) $k^2+64$','D) $2k+8$','E) $8k$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'V jedné polici je $k+8$ knih, polic je $k$. Celkový počet knih $=k\\cdot(k+8)=k^2+8k$.'},
  'A) $k^2+8k$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','slovni','vyber','bez-kalkulacky'},
  'M9PBD22C0T02', 2022
);
c.add(
  'CERMAT 2022 M9B · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Včera stála sekačka $20\\,000$ korun a dnes je její cena pouze $8\\,000$ korun. O kolik procent byla snížena cena sekačky?','15.2 První skupina poseče čtvrtinu louky a druhá skupina $60\\ \\%$ zbývající části louky. Poslední část louky zůstane neposečená. Kolik procent louky zůstane neposečeno?','15.3 Nedávno byly zdraženy hřebíky. Částka, za kterou jsme dříve koupili $120$ hřebíků, nyní vystačí jen na $80$ hřebíků. O kolik procent byly hřebíky zdraženy?','Nabídka: A) méně než $30\\ \\%$; B) $30\\ \\%$; C) $40\\ \\%$; D) $50\\ \\%$; E) $60\\ \\%$; F) jiný počet procent.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: snížení o $20\\,000-8\\,000=12\\,000$ korun; $\\frac{12\\,000}{20\\,000}=0{,}6=60\\ \\%$ — \\textbf{E}.','15.2: po první skupině zbývá $\\frac{3}{4}$; druhá poseče $0{,}6\\cdot\\frac{3}{4}=0{,}45$. Posečeno celkem $0{,}25+0{,}45=0{,}70$, neposečeno $30\\ \\%$ — \\textbf{B}.','15.3: cena za kus vzrostla v poměru $\\frac{120}{80}=1{,}5$, tedy o $50\\ \\%$ — \\textbf{D}.'},
  '15.1: E; 15.2: B; 15.3: D',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD22C0T02', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
