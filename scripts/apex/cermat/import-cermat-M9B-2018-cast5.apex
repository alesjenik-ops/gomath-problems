String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD18C0T02';
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
  'CERMAT M9B 2018 – úloha 11',
  new List<String>{'Na kružnici $k$, jejíž délka je $20\\pi$ cm, leží vrcholy čtverce $ABCD$. Čtverec je rozdělen na dva trojúhelníky a lichoběžník $DBEF$. Délka úsečky $BD$ je dvojnásobkem délky úsečky $EF$.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Výška lichoběžníku $DBEF$ je $10$ cm.','11.2 Lichoběžník $DBEF$ má obsah $75$ cm².','11.3 Obsah lichoběžníku $DBEF$ tvoří tři osminy obsahu čtverce $ABCD$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 470" font-family="sans-serif"> <circle cx="250" cy="230" r="140" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="151,329 349,329 349,131 151,131" fill="none" stroke="#000" stroke-width="2"/> <polygon points="151,131 349,329 349,230 250,131" fill="#bdbdbd" stroke="#000" stroke-width="1.6"/> <text x="136" y="345" font-size="14" font-style="italic">A</text> <text x="354" y="345" font-size="14" font-style="italic">B</text> <text x="354" y="128" font-size="14" font-style="italic">C</text> <text x="134" y="128" font-size="14" font-style="italic">D</text> <text x="358" y="235" font-size="14" font-style="italic">E</text> <text x="246" y="122" font-size="14" font-style="italic">F</text> <text x="96" y="234" font-size="14" font-style="italic">k</text> </svg>',
  'ctverec-kruznice-lichobeznik.svg',
  'Kružnice k s vepsaným čtvercem ABCD; čtverec je úhlopříčkou BD a úsečkou EF rozdělen, šedý lichoběžník DBEF.',
  'Výchozí obrázek k úloze 11',
  new List<String>{'Délka kružnice $20\\pi$ cm znamená průměr $20$ cm. Úhlopříčka čtverce $|BD|=20$ cm (je průměrem), strana čtverce $a=\\frac{20}{\\sqrt2}=10\\sqrt2$ cm, obsah čtverce $a^2=200$ cm². Dále $|EF|=\\frac{1}{2}|BD|=10$ cm.','11.1 Výška lichoběžníku je vzdálenost rovnoběžných úseček $BD$ a $EF$, ta je $5$ cm (ne $10$ cm) – Ne.','11.2 Obsah $=\\frac{|BD|+|EF|}{2}\\cdot v=\\frac{20+10}{2}\\cdot 5=75$ cm² – Ano.','11.3 $\\frac{75}{200}=\\frac{3}{8}$ – Ano.'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  4, 7, '4',
  new List<String>{'zs2','r9','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 12',
  new List<String>{'Rovinný obrazec $ABCDE$ je osově souměrný podle osy $o$ procházející bodem $B$. U vrcholu $A$ je vnitřní úhel $110^\\circ$, u vrcholu $C$ je vnitřní úhel $100^\\circ$ (viz obrázek).','Jaká je velikost úhlu $\\beta$ u vrcholu $B$? (Úhly neměřte, ale vypočtěte.)'},
  new List<String>{'A) menší než $100^\\circ$','B) $100^\\circ$','C) $110^\\circ$','D) $120^\\circ$','E) větší než $120^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 360" font-family="sans-serif"> <line x1="70" y1="110" x2="430" y2="110" stroke="#000" stroke-width="1.4"/> <line x1="60" y1="180" x2="122" y2="180" stroke="#000" stroke-width="1.4"/> <line x1="250" y1="62" x2="250" y2="350" stroke="#000" stroke-width="1" stroke-dasharray="5 5"/> <polygon points="150,110 120,180 250,330 380,180 350,110" fill="none" stroke="#000" stroke-width="2"/> <line x1="96" y1="103" x2="104" y2="117" stroke="#000"/><line x1="103" y1="103" x2="111" y2="117" stroke="#000"/> <line x1="82" y1="173" x2="90" y2="187" stroke="#000"/><line x1="89" y1="173" x2="97" y2="187" stroke="#000"/> <text x="136" y="150" font-size="12">110°</text> <text x="350" y="150" font-size="12">100°</text> <text x="245" y="292" font-size="13" font-style="italic">β</text> <text x="243" y="312" font-size="14" font-style="italic">B</text> <text x="140" y="103" font-size="14" font-style="italic">E</text> <text x="352" y="103" font-size="14" font-style="italic">D</text> <text x="103" y="192" font-size="14" font-style="italic">A</text> <text x="386" y="192" font-size="14" font-style="italic">C</text> <text x="256" y="76" font-size="14" font-style="italic">o</text> </svg>',
  'petiuhelnik-osa.svg',
  'Pětiúhelník ABCDE souměrný podle svislé osy o procházející vrcholem B; u vrcholu A úhel 110 stupňů, u vrcholu C úhel 100 stupňů, u vrcholu B úhel beta.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'Součet vnitřních úhlů pětiúhelníku je $540^\\circ$. Přímka procházející vrcholy $E$ a $D$ je rovnoběžná s přímkou procházející vrcholem $A$ (vyznačeno); z rovnoběžnosti a daných úhlů $110^\\circ$ a $100^\\circ$ dopočteme zbývající vnitřní úhly a pro úhel u vrcholu $B$ vyjde $\\beta=120^\\circ$.'},
  'D) $120^\\circ$',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
