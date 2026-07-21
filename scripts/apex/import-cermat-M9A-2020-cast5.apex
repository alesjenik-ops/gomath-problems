String SRC   = 'CERMAT – Jednotná přijímací zkouška 2020, řádný termín (M9A)';
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
  'CERMAT 2020 M9A · úloha 14',
  new List<String>{'Pravoúhlý trojúhelník s odvěsnami délek $12\\ \\mathrm{cm}$ a $6\\ \\mathrm{cm}$ je dvěma úsečkami rovnoběžnými s kratší odvěsnou rozdělen na tři rovinné útvary. Úsečky rozdělily delší odvěsnu na tři úseky délek $6\\ \\mathrm{cm}$, $4\\ \\mathrm{cm}$ a $2\\ \\mathrm{cm}$ (viz obrázek).','Jaký je obsah tmavého útvaru (prostředního)?'},
  new List<String>{'A) $16\\ \\mathrm{cm}^2$','B) $18\\ \\mathrm{cm}^2$','C) $20\\ \\mathrm{cm}^2$','D) $21\\ \\mathrm{cm}^2$','E) jiný obsah'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 197 112"><path d="M146 89L124 89C124 89 124 89 124 90C124 90 124 90 124 90L146 90C146 90 146 90 146 90C146 89 146 89 146 89M140 92L147 90L140 87C140 87 140 87 140 87C139 87 140 87 140 87L146 90L146 89L140 92C140 92 139 92 140 92C140 92 140 93 140 92M130 87L123 90L130 92C130 93 130 92 130 92C130 92 130 92 130 92L124 89L124 90L130 87C130 87 130 87 130 87C130 87 130 87 130 87Z" style="fill:#231f20"/><path d="M122 89L76 89C76 89 76 89 76 90C76 90 76 90 76 90L122 90C122 90 122 90 122 90C122 89 122 89 122 89M116 92L123 90L116 87C116 87 116 87 116 87C116 87 116 87 116 87L122 90L122 89L116 92C116 92 116 92 116 92C116 92 116 93 116 92M82 87L75 90L82 92C82 93 83 92 83 92C83 92 83 92 83 92L77 89L77 90L83 87C83 87 83 87 83 87C83 87 82 87 82 87Z" style="fill:#231f20"/><path d="M74 89L5 89C5 89 5 89 5 90C5 90 5 90 5 90L74 90C75 90 75 90 75 90C75 89 75 89 74 89M69 92L75 90L69 87C68 87 68 87 68 87C68 87 68 87 68 87L74 90L74 89L68 92C68 92 68 92 68 92C68 92 68 93 69 92M11 87L4 90L11 92C11 93 11 92 11 92C11 92 11 92 11 92L5 89L5 90L11 87C11 87 11 87 11 87C11 87 11 87 11 87Z" style="fill:#231f20"/><path d="M153 5L153 83C153 83 153 83 153 83C152 83 152 83 152 83L152 5C152 5 152 5 153 5C153 5 153 5 153 5M150 11L153 4L155 11C155 11 155 11 155 11C155 11 155 11 155 11L152 5L153 5L150 11C150 11 150 11 150 11C150 11 150 11 150 11M155 77L153 84L150 77C150 77 150 77 150 77C150 77 150 77 150 77L153 83L152 83L155 77C155 77 155 77 155 77C155 77 155 77 155 77Z" style="fill:#231f20"/><path d="M123 17L75 44L75 84L123 84L123 17Z" style="fill:#dcddde"/><path d="M123 17L123 84M75 44L75 84M147 84L147 4L4 84L147 84" style="fill:none;stroke:#231f20;stroke-width:2"/><text x="135" y="106" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2 cm</text><text x="99" y="106" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4 cm</text><text x="42" y="106" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6 cm</text><text x="169" y="50" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6 cm</text></svg>',
  'obr.svg',
  'Pravoúhlý trojúhelník s odvěsnami 12 cm a 6 cm rozdělený dvěma svislými úsečkami; delší odvěsna je rozdělena na úseky 6 cm, 4 cm, 2 cm, prostřední útvar je šedý.',
  '',
  new List<String>{'Výška trojúhelníku roste podél delší odvěsny lineárně od $0$ do $6\\ \\mathrm{cm}$ (výška ve vzdálenosti $d$ od vrcholu s nulovou výškou je $\\frac{d}{2}$).','Ve vzdálenosti $6\\ \\mathrm{cm}$ je výška $3\\ \\mathrm{cm}$, ve vzdálenosti $10\\ \\mathrm{cm}$ je výška $5\\ \\mathrm{cm}$.','Tmavý útvar je lichoběžník se základnami $3\\ \\mathrm{cm}$ a $5\\ \\mathrm{cm}$ a výškou $4\\ \\mathrm{cm}$: $S=\\frac{3+5}{2}\\cdot4=16\\ \\mathrm{cm}^2$.'},
  'A) $16\\ \\mathrm{cm}^2$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','vypocet','vyber','bez-kalkulacky'},
  'M9PAD20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9A · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 \\quad Roční čtenářský poplatek již zaplatilo $40\\ \\%$ všech čtenářů knihovny, a poplatek tak musí zaplatit ještě zbývajících $264$ čtenářů. Kolik čtenářů má knihovna?','15.2 \\quad Do školní družiny se přihlásilo $540$ žáků, což je o pětinu více, než činí kapacita družiny. Kolik žáků činí kapacita družiny?','15.3 \\quad Do školního tanečního kroužku chodí $25$ žáků, což je $5\\ \\%$ všech žáků školy. Kroužek juda navštěvuje $20$ žáků školy, přičemž čtvrtina z nich chodí navíc do tanečního kroužku. Kolik žáků školy nechodí ani do tanečního kroužku, ani do kroužku juda?','Nabídka: A) $400$; B) $420$; C) $440$; D) $450$; E) $460$; F) jiný počet.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: zbývajících $264$ čtenářů tvoří $60\\ \\%$; celkem $264:0{,}6=440$ — \\textbf{C}.','15.2: $540=1{,}2\\cdot$kapacita; kapacita $=540:1{,}2=450$ — \\textbf{D}.','15.3: $25$ žáků $=5\\ \\%\\Rightarrow$ všech žáků $500$; taneční $25$, juda $20$, oba kroužky $\\frac{1}{4}\\cdot20=5$; alespoň jeden kroužek $25+20-5=40$; ani jeden $500-40=460$ — \\textbf{E}.'},
  '15.1: C; 15.2: D; 15.3: E',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PAD20C0T01', 2020
);

System.debug('Vytvořeno úloh: '+c.created);
