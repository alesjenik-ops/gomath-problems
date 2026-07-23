String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD23C0T04';
Integer YEAR = 2023;

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
  'CERMAT M9D 2023 – úloha 14',
  new List<String>{'Kvádr s podstavou o rozměrech $6$ cm a $8$ cm a výškou $10$ cm lze dvěma svislými úhlopříčnými řezy rozdělit na čtyři trojboké hranoly s výškou $10$ cm. Odebráním jednoho z trojbokých hranolů vznikne z kvádru pětiboký hranol (viz obrázek).','O kolik cm² se liší povrch pětibokého hranolu a povrch původního kvádru?'},
  new List<String>{'A) o $4$ cm²','B) o $16$ cm²','C) o $24$ cm²','D) o $30$ cm²','E) o jiný počet cm²'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 220" font-family="sans-serif"> <g fill="#eef4fa" stroke="#000" stroke-width="1.2"> <polygon points="40,95 140,95 140,185 40,185"/> <polygon points="40,95 78,68 178,68 140,95"/> <polygon points="140,95 178,68 178,158 140,185"/> </g> <g stroke="#000" stroke-dasharray="4 3"> <line x1="40" y1="185" x2="78" y2="158"/> <line x1="78" y1="158" x2="178" y2="158"/> <line x1="78" y1="158" x2="78" y2="68"/> </g> <text x="90" y="203" font-size="12" text-anchor="middle">8 cm</text> <text x="150" y="180" font-size="12">6 cm</text> <text x="182" y="132" font-size="12">10 cm</text> <g fill="#eef4fa" stroke="#000" stroke-width="1.2"> <polygon points="360,95 427,88 427,178 360,185"/> <polygon points="460,95 427,88 427,178 460,185"/> <polygon points="360,95 395,68 495,68 460,95 427,88"/> <polygon points="460,95 495,68 495,158 460,185"/> </g> <line x1="427" y1="88" x2="427" y2="178" stroke="#000" stroke-width="1.2"/> <g stroke="#000" stroke-dasharray="4 3"> <line x1="360" y1="185" x2="395" y2="158"/> <line x1="395" y1="158" x2="495" y2="158"/> <line x1="395" y1="158" x2="395" y2="68"/> </g> <text x="424" y="60" font-size="12" text-anchor="middle">8 cm</text> <text x="500" y="132" font-size="12">10 cm</text> <text x="470" y="182" font-size="12">6 cm</text> </svg>',
  'kvadr-hranol.svg',
  'Vlevo kvádr s rozměry 8 cm, 6 cm a výškou 10 cm, vpravo pětiboký hranol vzniklý odebráním jednoho trojbokého hranolu (schematický nákres).',
  'Kvádr a z něj vzniklý pětiboký hranol (schematický nákres)',
  new List<String>{'Povrch kvádru je $S=2\\cdot(6\\cdot 8+6\\cdot 10+8\\cdot 10)=2\\cdot(48+60+80)=376$ cm².','Úhlopříčky podstavy $6\\times 8$ mají délku $\\sqrt{6^2+8^2}=10$ cm a dělí ji na čtyři trojúhelníky. Odebereme hranol, jehož vnější stěnou je celá stěna $8\\times 10$: zmizí obdélník o obsahu $8\\cdot 10=80$ cm², přibudou dvě vnitřní řezové stěny o obsahu $2\\cdot(5\\cdot 10)=100$ cm² a obě podstavy se zmenší o trojúhelník s obsahem $\\frac{1}{2}\\cdot 8\\cdot 3=12$ cm², tedy o $2\\cdot 12=24$ cm².','Změna povrchu je $-80+100-24=-4$ cm², povrchy se tedy liší o $4$ cm².'},
  'A) o $4$ cm²',
  2, 5, '4',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Letos se na gymnázium přihlásilo 420 uchazečů, což je o 40 % více, než se jich přihlásilo loni. Kolik uchazečů se na gymnázium přihlásilo loni?','15.2 On-line kurzu českého jazyka se zúčastnilo 180 žáků, což je o 25 % méně, než se jich zúčastnilo on-line kurzu matematiky. Kolik žáků se zúčastnilo on-line kurzu matematiky?','15.3 Včera navštívilo plavecký bazén celkem 680 dospělých, mezi nimiž bylo mužů o 30 % méně než žen. Kolik mužů včera navštívilo plavecký bazén?'},
  new List<String>{'A) méně než $240$','B) $240$','C) $260$','D) $280$','E) $300$','F) více než $300$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Loni se přihlásilo $x$ uchazečů; $1{,}4x=420$, tedy $x=300$ — možnost E.','15.2 On-line kurzu matematiky se zúčastnilo $y$ žáků; $180$ je o $25\\,\\%$ méně, tj. $0{,}75y=180$, odkud $y=240$ — možnost B.','15.3 Žen bylo $z$, mužů $0{,}7z$; $z+0{,}7z=680$, tj. $1{,}7z=680$, $z=400$, mužů $0{,}7\\cdot 400=280$ — možnost D.'},
  '15.1: E ($300$); 15.2: B ($240$); 15.3: D ($280$)',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
