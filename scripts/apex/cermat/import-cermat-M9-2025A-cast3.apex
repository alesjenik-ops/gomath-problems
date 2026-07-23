String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M9A 2025 - uloha 8',
  new List<String>{'Zahon v parku ma tvar ctyruhelniku, jehoz tri strany jsou stejne dlouhe. Kazda z techto tri stran je o ctvrtinu kratsi, nez je ctvrta strana ctyruhelniku. Po obvodu zahonu je ve stejnych rozestupech vysazeno celkem $65$ rostlin, z nichz je po jedne rostline i v kazdem rohu zahonu. Rozestupy mezi rostlinami meri $40$ cm.','8.1 Vypoctete v metrech obvod zahonu.','8.2 Urcete, o kolik se lisi pocet rostlin na nejdelsi strane zahonu od poctu rostlin na protejsi strane zahonu.','8.3 Po obvodu zahonu se pravidelne stridaji stejne pocetne skupinky cervene kvetoucich rostlin s dvojicemi bile kvetoucich rostlin. Urcete nejmensi mozny pocet cervene kvetoucich rostlin po obvodu zahonu.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 240" font-family="sans-serif"> <polygon points="70,40 200,46 214,180 46,182" fill="none" stroke="#000" stroke-width="1.5"/> <circle cx="70" cy="40" r="3" fill="#000"/><circle cx="135" cy="43" r="3" fill="#000"/><circle cx="200" cy="46" r="3" fill="#000"/> <circle cx="207" cy="113" r="3" fill="#000"/><circle cx="214" cy="180" r="3" fill="#000"/> <circle cx="130" cy="181" r="3" fill="#000"/><circle cx="46" cy="182" r="3" fill="#000"/> <circle cx="58" cy="111" r="3" fill="#000"/> <text x="120" y="210" font-size="13" text-anchor="middle">zahon (4 strany)</text> <circle cx="310" cy="90" r="9" fill="#ddd" stroke="#000"/><circle cx="370" cy="90" r="9" fill="#ddd" stroke="#000"/><circle cx="430" cy="90" r="9" fill="#ddd" stroke="#000"/> <line x1="310" y1="115" x2="370" y2="115" stroke="#000"/><line x1="370" y1="115" x2="430" y2="115" stroke="#000"/> <text x="340" y="130" font-size="12" text-anchor="middle">40 cm</text><text x="400" y="130" font-size="12" text-anchor="middle">40 cm</text> </svg>',
  'zahon.svg',
  'Ctyruhelnikovy zahon s rostlinami (puntiky) rozmistenymi po obvodu v rozestupech 40 cm.',
  'Schematicky nakres zahonu s rozestupy rostlin',
  new List<String>{'8.1 Rostliny tvori uzavrenou linii, rozestupU je tedy $65$. Obvod $=65\\cdot 0{,}4=26$ m.','8.2 Nejdelsi strana $L$ a tri strany $\\frac{3}{4}L$: $L+3\\cdot\\frac{3}{4}L=\\frac{13}{4}L=26$, tedy $L=8$ m a kratsi strany $6$ m. Rostlin na nejdelsi strane $8:0{,}4=20$, na protejsi kratsi strane $6:0{,}4=15$; rozdil $20-15=5$.','8.3 Opakuje se skupinka $k$ cervenych a dvojice bilych, tj. $65=m\\cdot(k+2)$. Nejmene cervenych je pri nejvetsim $m$: $65=13\\cdot 5$, tj. $m=13$, $k=3$; cervenych $65-2\\cdot 13=39$.'},
  '8.1: $26$ m; 8.2: o $5$ rostlin; 8.3: $39$ cervene kvetoucich rostlin',
  4, 8, '4',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2025 - uloha 9 (konstrukce)',
  new List<String>{'V rovine lezi ruznobezky $p$, $q$ a bod $R$ (viz obrazek).','9.1 Sestrojte osu vetsiho uhlu, ktery sviraji primky $p$, $q$, a oznacte ji pismenem $o$.','9.2 Na primkach $p$, $q$ lezi vsechny ctyri vrcholy obdelniku $KLMN$. Bod $R$ lezi uvnitr strany $MN$ tohoto obdelniku. Sestrojte vrcholy obdelniku $KLMN$, oznacte je pismeny a obdelnik narysujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif"> <line x1="120" y1="35" x2="285" y2="230" stroke="#000" stroke-width="1.5"/><text x="108" y="35" font-size="15" font-style="italic">q</text> <line x1="55" y1="180" x2="365" y2="118" stroke="#000" stroke-width="1.5"/><text x="372" y="118" font-size="15" font-style="italic">p</text> <text x="212" y="112" font-size="15" text-anchor="middle">x</text> <text x="212" y="128" font-size="15" font-style="italic" text-anchor="middle">R</text> </svg>',
  'primky-pqR.svg',
  'Dve ruznobezne primky p a q a bod R lezici v rovine.',
  'Vychozi obrazek k uloze 9',
  new List<String>{'9.1 Osa $o$ vetsiho z uhlU sevrenych primkami $p$, $q$ prochazi jejich prusecikem a je osou soumernosti obou primek.','9.2 Obdelnik $KLMN$ je soumerny podle osy $o$ a jeho vrcholy lezi na primkach $p$, $q$. Bodem $R$ vedeme kolmici k ose $o$; ta protne primky $p$, $q$ ve vrcholech $M$, $N$ (strana $MN$ prochazi bodem $R$). Vrcholy $K$, $L$ jsou obrazy $M$, $N$ v osove soumernosti podle $o$. Obdelnik $KLMN$ narysujeme.'},
  '9.1: osa $o$ vetsiho uhlu primek $p$, $q$; 9.2: obdelnik $KLMN$ soumerny podle osy $o$, strana $MN$ prochazi bodem $R$ (viz nakres v klici).',
  3, 8, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
