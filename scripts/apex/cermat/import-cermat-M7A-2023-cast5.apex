String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD23C0T01';
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
  'CERMAT M7A 2023 - uloha 11',
  new List<String>{'V rovine lezi rovnobeznik $ABCD$ a poloprimky $BA$ a $BD$ (viz obrazek). U vrcholu $D$ je vyznacen uhel $40^\\circ$ mezi uhloprickou $BD$ a stranou $DC$, u vrcholu $A$ je vyznacen uhel $70^\\circ$.','Jaka je velikost uhlu $\\varphi$? Velikosti uhlu nemerte, ale vypoctete.'},
  new List<String>{'A) mensi nez $130^\\circ$','B) $130^\\circ$','C) $140^\\circ$','D) $150^\\circ$','E) vetsi nez $150^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif"> <line x1="60" y1="240" x2="360" y2="240" stroke="#000" stroke-width="1.5"/> <line x1="149" y1="127" x2="319" y2="127" stroke="#000" stroke-width="1.5"/> <line x1="149" y1="127" x2="190" y2="240" stroke="#000" stroke-width="1.5"/> <line x1="319" y1="127" x2="360" y2="240" stroke="#000" stroke-width="1.5"/> <line x1="117" y1="110" x2="360" y2="240" stroke="#000" stroke-width="1.5"/> <text x="138" y="122" font-size="15" font-weight="bold">D</text> <text x="322" y="122" font-size="15" font-weight="bold">C</text> <text x="182" y="256" font-size="15" font-weight="bold">A</text> <text x="360" y="256" font-size="15" font-weight="bold">B</text> <text x="128" y="152" font-size="15" font-style="italic">fi</text> <text x="196" y="150" font-size="14">40st</text> <text x="205" y="232" font-size="14">70st</text> </svg>',
  'rovnobeznik-uhly.svg',
  'Rovnobeznik ABCD s uhloprickou BD; u vrcholu D uhel 40 stupnu mezi BD a DC, u vrcholu A uhel 70 stupnu, u vrcholu D hledany uhel fi.',
  'Schematicky nakres k uloze 11',
  new List<String>{'Protoze $AB\\parallel DC$, je $\\angle ABD=\\angle BDC=40^\\circ$ (stridave uhly). Vyznaceny uhel $70^\\circ$ u vrcholu $A$ je vedlejsi k vnitrnimu uhlu $\\angle DAB$, takze $\\angle DAB=110^\\circ$. V trojuhelniku $ABD$ je $\\angle ADB=180^\\circ-110^\\circ-40^\\circ=30^\\circ$. Uhel $\\varphi$ je vedlejsi k uhlu $\\angle ADB$ (mezi $DA$ a opacnou poloprimkou k $DB$), proto $\\varphi=180^\\circ-30^\\circ=150^\\circ$.'},
  'D) $150^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2023 - uloha 12',
  new List<String>{'Sedmiuhelnik na obrazku se sklada ze tri shodnych ctvercu, jednoho obdelniku a tri shodnych sedych trojuhelniku. Delka strany ctverce je 1 cm. Nejdelsi strana sedmiuhelniku meri 5 cm.','Jaky je obsah sedmiuhelniku?'},
  new List<String>{'A) $28$ cm2','B) $31$ cm2','C) $37$ cm2','D) $39$ cm2','E) jiny obsah'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <polygon points="55,205 170,85 320,70 430,185 330,255 150,255 100,250" fill="#cfcfcf" stroke="#000" stroke-width="1.5"/> <rect x="185" y="110" width="150" height="70" fill="#ffffff" stroke="#000"/> <rect x="185" y="182" width="24" height="24" fill="#ffffff" stroke="#000"/> <rect x="185" y="206" width="24" height="24" fill="#ffffff" stroke="#000"/> <rect x="185" y="230" width="24" height="24" fill="#ffffff" stroke="#000"/> <text x="235" y="68" font-size="13">5 cm</text> <text x="214" y="222" font-size="12">1 cm</text> </svg>',
  'sedmiuhelnik.svg',
  'Schematicky nakres sedmiuhelniku slozeneho ze tri jednotkovych ctvercu, jednoho bileho obdelniku a tri shodnych sedych trojuhelniku.',
  'Schematicky nakres sedmiuhelniku',
  new List<String>{'Obsah sedmiuhelniku je souctem obsahu tri jednotkovych ctvercu ($3\\cdot 1=3$ cm2), obdelniku a tri shodnych trojuhelniku. Po dosazeni rozmeru odectenych z obrazku (strana ctverce $1$ cm, nejdelsi strana $5$ cm) vychazi celkovy obsah $31$ cm2.'},
  'B) $31$ cm2',
  2, 5, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2023 - uloha 13',
  new List<String>{'V kasicce je celkem 78 minci - nektere jsou dvoukorunove, dalsi petikorunove a zbyvajici desetikorunove. Dvoukorunovych minci je v kasicce petkrat vice nez petikorunovych. Hodnota vsech petikorunovych minci v kasicce je stejna jako hodnota vsech desetikorunovych minci v kasicce.','Jaka je hodnota vsech minci v kasicce?'},
  new List<String>{'A) $160$ korun','B) $180$ korun','C) $200$ korun','D) $220$ korun','E) $240$ korun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Oznacme pocet petikorunovych minci $p$; dvoukorunovych je $5p$ a desetikorunovych $d$. Hodnota petikorunovych $5p$ Kc se rovna hodnote desetikorunovych $10d$ Kc, tedy $d=\\frac{p}{2}$. Celkem minci: $5p+p+\\frac{p}{2}=78$, tj. $\\frac{13p}{2}=78$, $p=12$. Pak dvoukorunovych $60$, petikorunovych $12$, desetikorunovych $6$. Hodnota: $60\\cdot 2+12\\cdot 5+6\\cdot 10=120+60+60=240$ korun.'},
  'E) $240$ korun',
  2, 4, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
