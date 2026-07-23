String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD18C0T01';
Integer YEAR = 2018;

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
  'CERMAT M9A 2018 – úloha 12',
  new List<String>{'Čtyřúhelník $ABCD$ je lichoběžník se základnami $AB$ a $DC$ ($AB\\parallel DC$). Strana $AD$ svírá s prodloužením základny $AB$ za vrcholem $A$ úhel $112^\\circ$. Úhlopříčka $DB$ je kolmá ke straně $AD$ ($\\angle ADB=90^\\circ$). U vrcholu $B$ je $\\angle ABD=\\varphi$ a $\\angle DBC=2\\varphi$. Úhel u vrcholu $C$ je označen $\\gamma$.','Jaká je velikost úhlu $\\gamma$? Úhly neměřte, ale vypočtěte.'},
  new List<String>{'A) $114^\\circ$','B) $117^\\circ$','C) $120^\\circ$','D) $126^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 200" font-family="sans-serif"> <line x1="10" y1="160" x2="360" y2="160" stroke="#000" stroke-width="1"/> <polygon points="60,160 300,160 250,60 120,60" fill="none" stroke="#000" stroke-width="2"/> <line x1="120" y1="60" x2="300" y2="160" stroke="#000" stroke-width="1.5"/> <text x="110" y="54" font-size="14" font-style="italic">D</text> <text x="252" y="54" font-size="14" font-style="italic">C</text> <text x="50" y="176" font-size="14" font-style="italic">A</text> <text x="304" y="174" font-size="14" font-style="italic">B</text> <text x="66" y="150" font-size="12">112°</text> <text x="236" y="82" font-size="13">γ</text> <text x="262" y="120" font-size="12">2φ</text> <text x="276" y="152" font-size="12">φ</text> <circle cx="130" cy="72" r="2.5" fill="#000"/> </svg>',
  'lichobeznik-uhly.svg',
  'Lichoběžník ABCD se základnami AB a DC, úhlopříčka DB, vyznačené úhly u vrcholů A, B, C a pravý úhel u D.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'Vnitřní úhel u vrcholu $A$ je $\\angle DAB=180^\\circ-112^\\circ=68^\\circ$. V trojúhelníku $ABD$ je $\\angle ADB=90^\\circ$, tedy $\\varphi=\\angle ABD=180^\\circ-68^\\circ-90^\\circ=22^\\circ$. Úhel $\\angle ABC=\\varphi+2\\varphi=3\\varphi=66^\\circ$. Protože $AB\\parallel DC$, je $\\gamma=180^\\circ-66^\\circ=114^\\circ$.'},
  'A) $114^\\circ$',
  2, 6, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 13',
  new List<String>{'Traktor najel na přímé silnici zadním kolem na tubu s červenou barvou. Tuba se zaklínila do pneumatiky a praskla. Traktor pak na silnici vytvořil každých $252$ cm maličkou červenou skvrnu.','V jaké výšce nad zemí je střed zadního kola traktoru? Výsledek je zaokrouhlen na celé cm.'},
  new List<String>{'A) menší než $35$ cm','B) $35$ cm','C) $40$ cm','D) $44$ cm','E) větší než $44$ cm'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Červená skvrna vznikne právě jednou za otáčku kola, obvod kola je proto $252$ cm. Z $o=2\\pi r$ plyne $r=\\frac{252}{2\\pi}\\doteq 40{,}1$ cm. Střed kola je ve výšce rovné poloměru, tj. po zaokrouhlení $40$ cm.'},
  'C) $40$ cm',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2018 – úloha 14',
  new List<String>{'Čtyřúhelník $ABCD$ je osově souměrný podle osy $o$. Úhlopříčky $AC$ a $BD$ se protínají v bodě $P$. Platí: $|CP|=12$ cm; $|BP|=16$ cm; $|AD|=13$ cm.','Jaký je obsah čtyřúhelníku $ABCD$?'},
  new List<String>{'A) $244$ cm²','B) $252$ cm²','C) $258$ cm²','D) $288$ cm²','E) jiný obsah'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 280" font-family="sans-serif"> <line x1="20" y1="140" x2="340" y2="140" stroke="#000" stroke-width="1"/> <text x="330" y="134" font-size="13" font-style="italic">o</text> <polygon points="200,50 300,140 200,230 90,140" fill="none" stroke="#000" stroke-width="2"/> <line x1="200" y1="50" x2="200" y2="230" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <text x="196" y="44" font-size="13" font-style="italic">C</text> <text x="196" y="248" font-size="13" font-style="italic">A</text> <text x="76" y="145" font-size="13" font-style="italic">D</text> <text x="306" y="145" font-size="13" font-style="italic">B</text> <text x="186" y="135" font-size="12" font-style="italic">P</text> <text x="208" y="100" font-size="12">12 cm</text> <text x="242" y="134" font-size="12">16 cm</text> <text x="118" y="198" font-size="12">13 cm</text> </svg>',
  'deltoid-abcd.svg',
  'Osově souměrný čtyřúhelník ABCD (deltoid) s osou o; úhlopříčky AC a BD se protínají v bodě P.',
  'Výchozí obrázek k úloze 14',
  new List<String>{'Osou souměrnosti je přímka $DB$, proto $AC\\perp DB$ a bod $P$ je střed $AC$: $|AP|=|PC|=12$ cm, $|AC|=24$ cm. V pravoúhlém trojúhelníku $APD$ je $|DP|=\\sqrt{13^2-12^2}=5$ cm. Úhlopříčka $|BD|=|DP|+|PB|=5+16=21$ cm. Obsah deltoidu $=\\frac{1}{2}\\cdot|AC|\\cdot|BD|=\\frac{1}{2}\\cdot 24\\cdot 21=252$ cm².'},
  'B) $252$ cm²',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
