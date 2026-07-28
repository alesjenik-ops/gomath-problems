String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M7A 2016 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží přímka $AB$ a mimo ni bod $U$ (viz obrázek).','10.1 Sestrojte chybějící vrchol $C$ trojúhelníku $ABC$, jestliže velikost úhlu $ABC$ je $\\beta=70^\\circ$, strana $BC$ má délku 8 cm a bod $U$ leží uvnitř trojúhelníku $ABC$. Trojúhelník $ABC$ narýsujte.','10.2 Sestrojte osu úsečky $AB$ a označte ji $o$.','10.3 Sestrojte chybějící vrchol $D$ rovnoramenného lichoběžníku $ABCD$ se základnami $AB$, $CD$ a lichoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 280" font-family="sans-serif"> <line x1="40" y1="80" x2="470" y2="230" stroke="#000" stroke-width="2"/> <line x1="99" y1="112" x2="121" y2="96" stroke="#000" stroke-width="2"/> <line x1="379" y1="212" x2="401" y2="196" stroke="#000" stroke-width="2"/> <text x="104" y="130" font-size="17" font-style="italic">A</text> <text x="384" y="230" font-size="17" font-style="italic">B</text> <text x="326" y="146" font-size="17" font-style="italic">U</text> <text x="324" y="164" font-size="16">×</text> </svg>',
  'primka-ab-bod-u.svg',
  'Přímka procházející body A a B a bod U ležící mimo tuto přímku.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'10.1 V bodě $B$ naneseme od polopřímky $BA$ úhel velikosti $70^\\circ$ do poloroviny, v níž leží bod $U$. Na jeho rameni naneseme $|BC|=8$ cm a získáme vrchol $C$; narýsujeme trojúhelník $ABC$.','10.2 Osa $o$ úsečky $AB$ je kolmice k $AB$ procházející jejím středem.','10.3 Rovnoramenný lichoběžník se základnami $AB$ a $CD$ je osově souměrný podle osy $o$, proto vrchol $D$ je obrazem vrcholu $C$ v souměrnosti podle $o$. Doplníme lichoběžník $ABCD$.'},
  'Konstrukce podle klíče: $C$ leží na rameni úhlu $ABC=70^\\circ$ ve vzdálenosti 8 cm od $B$ v polorovině s bodem $U$; $o$ je osa úsečky $AB$; $D$ je obraz bodu $C$ v osové souměrnosti podle $o$ (viz obrázek v klíči).',
  5, 10, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2016 – úloha 11',
  new List<String>{'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 75 g je 3krát více než $\\frac{1}{4}$ kg.','11.2 450 sekund je 2krát méně než čtvrt hodiny.','11.3 Obrazec, který lze rozdělit na 4 čtverce se stranou délky 50 cm, má obsah 1 m².'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'11.1 $\\frac{1}{4}$ kg $=250$ g, 3krát více je $750$ g, nikoli 75 g – tvrzení není pravdivé.','11.2 Čtvrt hodiny $=900$ s, 2krát méně je $900:2=450$ s – tvrzení je pravdivé.','11.3 Čtverec se stranou 50 cm má obsah $0{,}5\\cdot 0{,}5=0{,}25$ m², čtyři takové mají $4\\cdot 0{,}25=1$ m² – tvrzení je pravdivé.'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  3, 4, '2',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
