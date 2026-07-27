String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD17C0T01';
Integer YEAR = 2017;

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
  'CERMAT M7A 2017 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží přímka $q$, na ní bod $C$ a mimo ni bod $P$ (viz obrázek).','Bod $C$ je vrchol pravoúhlého trojúhelníku $ABC$ s pravým úhlem při vrcholu $C$. Strana $AC$ leží na přímce $q$. Bod $P$ je pata výšky na stranu $AB$.','Sestrojte chybějící vrcholy $A$, $B$ trojúhelníku $ABC$ a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 300" font-family="sans-serif"> <line x1="60" y1="222" x2="470" y2="86" stroke="#000" stroke-width="2.5"/> <text x="62" y="248" font-size="17" font-style="italic">q</text> <line x1="372" y1="106" x2="386" y2="130" stroke="#000" stroke-width="2.5"/> <text x="372" y="98" font-size="17" font-style="italic">C</text> <text x="292" y="236" font-size="18" text-anchor="middle">x</text> <text x="292" y="256" font-size="17" text-anchor="middle" font-style="italic">P</text> </svg>',
  'primka-q.svg',
  'Přímka q stoupající zleva doprava, bod C na přímce a bod P pod přímkou.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Bod $P$ je pata výšky z vrcholu $C$, proto je $CP$ kolmá na stranu $AB$. Narýsujeme úsečku $CP$.','Bodem $P$ vedeme kolmici k přímce $CP$ – na ní leží strana $AB$. Průsečík této kolmice s přímkou $q$ je vrchol $A$.','Bodem $C$ vedeme kolmici k přímce $q$ (pravý úhel při vrcholu $C$); její průsečík s přímkou $AB$ je vrchol $B$. Trojúhelník $ABC$ narýsujeme.'},
  'Konstrukce trojúhelníku $ABC$: $AB$ je kolmice k $CP$ vedená bodem $P$, $A$ je průsečík této kolmice s přímkou $q$, $B$ je průsečík kolmice k $q$ v bodě $C$ s přímkou $AB$ – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2017 – úloha 11',
  new List<String>{'Čtverec je rozdělen na tmavé a světlé díly. Všechny díly mají stejný obsah. Podíl tmavé (světlé) části ve čtverci lze vyjádřit zlomkem nebo desetinným číslem.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 Zlomek vyjadřující podíl tmavé části ve čtverci je roven součtu $\\frac{1}{2}+\\frac{1}{8}$.','11.2 Světlá část tvoří $0{,}3$ čtverce.','11.3 Když $\\frac{1}{5}$ tmavé části nahradíme světlou, světlá část vyplní $\\frac{1}{2}$ čtverce.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400" font-family="sans-serif"> <polygon points="200,30 115,115 200,200" fill="#cfcfcf"/> <polygon points="30,200 115,115 200,200" fill="#cfcfcf"/> <polygon points="30,200 200,200 285,285" fill="#cfcfcf"/> <polygon points="30,200 285,285 115,285" fill="#cfcfcf"/> <polygon points="115,285 285,285 200,370" fill="#cfcfcf"/> <polygon points="200,30 200,200 285,115" fill="#fff"/> <polygon points="285,115 200,200 370,200" fill="#fff"/> <polygon points="370,200 200,200 285,285" fill="#fff"/> <polygon points="30,200 200,30 370,200 200,370" fill="none" stroke="#000" stroke-width="3"/> <line x1="200" y1="30" x2="200" y2="200" stroke="#000" stroke-width="2"/> <line x1="115" y1="115" x2="200" y2="200" stroke="#000" stroke-width="2"/> <line x1="30" y1="200" x2="200" y2="200" stroke="#000" stroke-width="2"/> <line x1="285" y1="115" x2="200" y2="200" stroke="#000" stroke-width="2"/> <line x1="370" y1="200" x2="200" y2="200" stroke="#000" stroke-width="2"/> <line x1="285" y1="285" x2="200" y2="200" stroke="#000" stroke-width="2"/> <line x1="285" y1="285" x2="30" y2="200" stroke="#000" stroke-width="2"/> <line x1="285" y1="285" x2="115" y2="285" stroke="#000" stroke-width="2"/> </svg>',
  'ctverec-dily.svg',
  'Čtverec otočený o 45 stupňů rozdělený na osm shodných trojúhelníků, z nichž pět je tmavých a tři světlé.',
  'Výchozí obrázek k úloze 11',
  new List<String>{'Čtverec je rozdělen na 8 dílů stejného obsahu, z nichž 5 je tmavých a 3 světlé. Tmavá část je $\\frac{5}{8}$, světlá $\\frac{3}{8}$.','11.1 $\\frac{1}{2}+\\frac{1}{8}=\\frac{5}{8}$ – souhlasí, tvrzení je pravdivé (A).','11.2 $\\frac{3}{8}=0{,}375\\neq 0{,}3$ – tvrzení není pravdivé (N).','11.3 $\\frac{1}{5}$ z $\\frac{5}{8}$ je $\\frac{1}{8}$; světlá část pak tvoří $\\frac{3}{8}+\\frac{1}{8}=\\frac{4}{8}=\\frac{1}{2}$ – pravdivé (A).'},
  '11.1: Ano; 11.2: Ne; 11.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
