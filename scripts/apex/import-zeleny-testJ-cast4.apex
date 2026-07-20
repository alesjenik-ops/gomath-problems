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
  'Zelený J10 – čtyřúhelník dělící kružnici 4:3:3:2',
  new List<String>{'Na přímce $p$ leží body $A$ a $S$ vzdálené od sebe $6$ cm.','Sestrojte čtyřúhelník $ABCD$ tak, aby jeho vrcholy rozdělily kružnici se středem $S$ opsanou čtyřúhelníku $ABCD$ na $4$ části, jejichž délky budou v poměru $4:3:3:2$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 140" font-family="sans-serif"> <line x1="40" y1="72" x2="470" y2="72" stroke="#000" stroke-width="2"/> <line x1="90" y1="60" x2="90" y2="84" stroke="#000" stroke-width="2"/> <line x1="300" y1="60" x2="300" y2="84" stroke="#000" stroke-width="2"/> <text x="84" y="106" font-size="18" font-weight="bold">A</text> <text x="295" y="106" font-size="18" font-weight="bold">S</text> <text x="478" y="78" font-size="18" font-style="italic">p</text> <text x="195" y="52" font-size="14" text-anchor="middle">6 cm</text> </svg>',
  'primka-AS.svg',
  'Přímka p s vyznačenými body A a S ve vzdálenosti 6 cm.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Kružnice má střed $S$ a poloměr $|SA|=6$ cm (bod $A$ na ní leží). Poměr oblouků $4:3:3:2$ dává dohromady $12$ dílů; jeden díl odpovídá středovému úhlu $\\frac{360^\\circ}{12}=30^\\circ$. Oblouky mají středové úhly $120^\\circ$, $90^\\circ$, $90^\\circ$ a $60^\\circ$. Od bodu $A$ postupně naneseme tyto úhly a získáme vrcholy $B$, $C$, $D$ (viz obrázek v klíči).'},
  'Kružnice se středem $S$ a poloměrem $6$ cm; vrcholy dělí kružnici na oblouky se středovými úhly $120^\\circ$, $90^\\circ$, $90^\\circ$, $60^\\circ$ (poměr $4:3:3:2$) — viz konstrukce v klíči.',
  2, 6, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený J11 – roztoky louhu (Ano/Ne)',
  new List<String>{'V laboratoři máme k dispozici dvě litrové nádoby s louhem a litrovou nádobu C plnou destilované vody. V nádobě A je $750$ ml $60\\,\\%$ roztoku louhu, v nádobě B půl litru $20\\,\\%$ roztoku louhu.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Přelijeme-li maximální možný objem louhu z nádoby A do nádoby B a po promíchání přelijeme maximální možný objem louhu z nádoby B do nádoby A, bude v nádobě A $1$ litr $45\\,\\%$ roztoku louhu.','11.2 Dolijeme-li nádobu B destilovanou vodou a po promíchání přelijeme z nádoby B do nádoby A maximální možný objem louhu, bude v nádobě A $1$ litr louhu o koncentraci $42{,}5\\,\\%$.','11.3 Přelijeme-li z nádoby A do nádoby B $250$ ml roztoku a zbytek nádoby B doplníme destilovanou vodou, bude v nádobě B $1$ litr $25\\,\\%$ roztoku louhu.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 330" font-family="sans-serif"> <text x="110" y="30" font-size="16" font-weight="bold" text-anchor="middle">A</text> <rect x="60" y="100" width="100" height="180" fill="#bdbdbd"/> <rect x="60" y="40" width="100" height="240" fill="none" stroke="#000" stroke-width="2"/> <text x="110" y="300" font-size="13" text-anchor="middle">60% LOUH</text> <text x="110" y="316" font-size="12" text-anchor="middle">750 ml</text> <text x="260" y="30" font-size="16" font-weight="bold" text-anchor="middle">B</text> <rect x="210" y="160" width="100" height="120" fill="#dcdcdc"/> <rect x="210" y="40" width="100" height="240" fill="none" stroke="#000" stroke-width="2"/> <text x="260" y="300" font-size="13" text-anchor="middle">20% LOUH</text> <text x="260" y="316" font-size="12" text-anchor="middle">500 ml</text> <text x="410" y="30" font-size="16" font-weight="bold" text-anchor="middle">C</text> <rect x="360" y="40" width="100" height="240" fill="#eeeeee"/> <rect x="360" y="40" width="100" height="240" fill="none" stroke="#000" stroke-width="2"/> <text x="410" y="300" font-size="12" text-anchor="middle">DESTILOVANÁ</text> <text x="410" y="316" font-size="12" text-anchor="middle">VODA (1 l)</text> </svg>',
  'nadoby-ABC.svg',
  'Tři nádoby: A se 750 ml 60% louhu, B s 500 ml 20% louhu, C plná litrová nádoba destilované vody.',
  'Výchozí nádoby A, B, C',
  new List<String>{'11.1 Do B (volných $500$ ml) přelijeme $500$ ml z A ($60\\,\\%$): B má $1000$ ml a $100+300=400$ ml louhu, tj. $40\\,\\%$. Zpět do A (volných $750$ ml) přelijeme $750$ ml z B: A má $1000$ ml a $150+300=450$ ml louhu, tj. $45\\,\\%$. Pravda (A).','11.2 Doplněním B vodou vznikne $1000$ ml o koncentraci $\\frac{100}{1000}=10\\,\\%$. Do A (volných $250$ ml) přelijeme $250$ ml: A má $1000$ ml a $450+25=475$ ml louhu, tj. $47{,}5\\,\\%$, nikoli $42{,}5\\,\\%$. Nepravda (N).','11.3 Do B přelijeme $250$ ml z A ($60\\,\\%$): B má $750$ ml a $100+150=250$ ml louhu. Doplněním vodou na $1000$ ml je koncentrace $\\frac{250}{1000}=25\\,\\%$. Pravda (A).'},
  '11.1: Ano; 11.2: Ne; 11.3: Ano',
  3, 8, '4',
  new List<String>{'zs2','r9','procenta','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
