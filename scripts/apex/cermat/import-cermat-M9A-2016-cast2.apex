String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PZD16C0T01';
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
  'CERMAT M9A 2016 – úloha 7.1',
  new List<String>{'Vypočtěte, kolikrát je menší $5$ dm² než $100$ m².'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$100$ m² $=1\\,000\\,000$ cm², $5$ dm² $=500$ cm².','$1\\,000\\,000:500=2\\,000$.'},
  '$2\\,000$krát',
  1, 2, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 7.2',
  new List<String>{'Vypočtěte, kolik cm³ je jedna desetina litru.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1$ litr $=1$ dm³ $=1\\,000$ cm³.','Jedna desetina litru je $1\\,000:10=100$ cm³.'},
  '$100$ cm³',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 7.3',
  new List<String>{'Vyjádřete zlomkem, jakou část z $24$ hodin tvoří $80$ minut.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$24$ hodin $=24\\cdot 60=1\\,440$ minut.','$\\frac{80}{1\\,440}=\\frac{1}{18}$.'},
  '$\\frac{1}{18}$',
  1, 2, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 8',
  new List<String>{'Domeček na obrázku je složen ze čtverce a pravoúhlého trojúhelníku. Navzájem kolmé strany trojúhelníku měří $6$ cm a $8$ cm. Přepona trojúhelníku je zároveň horní stranou čtverce.','8.1 Vypočtěte obsah trojúhelníku.','8.2 Vypočtěte šířku domečku ($s$).'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 360" font-family="sans-serif"> <g stroke="#000" stroke-width="2" fill="none"> <rect x="80" y="120" width="200" height="200"/> <path d="M80,120 L208,24 L280,120"/> </g> <g stroke="#000" stroke-width="1" fill="none"> <path d="M197,32 L205,44 L216,35"/> <line x1="90" y1="176" x2="270" y2="176"/> <path d="M98,171 L88,176 L98,181"/> <path d="M262,171 L272,176 L262,181"/> </g> <g font-size="15"> <text x="180" y="169" font-style="italic" text-anchor="middle">s</text> <text x="104" y="66" font-size="14">8 cm</text> <text x="252" y="62" font-size="14">6 cm</text> </g> </svg>',
  'domecek.svg',
  'Domeček složený ze čtverce a pravoúhlého trojúhelníku s odvěsnami 8 cm a 6 cm; šířka domečku je označena s.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'8.1 Odvěsny jsou navzájem kolmé, proto $S=\\frac{6\\cdot 8}{2}=24$ cm².','8.2 Šířka domečku $s$ je délka přepony trojúhelníku (a zároveň strany čtverce).','Podle Pythagorovy věty $s=\\sqrt{6^2+8^2}=\\sqrt{36+64}=\\sqrt{100}=10$ cm.'},
  '8.1: $24$ cm²; 8.2: $10$ cm',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 9',
  new List<String>{'V rovině leží přímka $p$ a mimo ni dva různé body $M$, $L$ (viz obrázek).','Na přímce $p$ sestrojte všechny takové body:','9.1 $K$, aby velikost úhlu $KLM$ byla $60^\\circ$;','9.2 $N$, aby vzdálenost bodů $M$, $N$ byla stejná jako vzdálenost bodů $M$, $L$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 220" font-family="sans-serif"> <g stroke="#000" stroke-width="2"> <line x1="30" y1="70" x2="450" y2="175"/> <line x1="334" y1="54" x2="346" y2="66"/><line x1="346" y1="54" x2="334" y2="66"/> <line x1="244" y1="174" x2="256" y2="186"/><line x1="256" y1="174" x2="244" y2="186"/> </g> <g font-size="16" font-style="italic"> <text x="60" y="94">p</text><text x="356" y="56">L</text><text x="244" y="206">M</text> </g> </svg>',
  'primka-p-body-ml.svg',
  'Přímka p a dva body M a L ležící mimo tuto přímku (bod L nad přímkou, bod M pod přímkou).',
  'Výchozí obrázek k úloze 9',
  new List<String>{'9.1 Sestrojíme polopřímku $LM$ a v bodě $L$ k ní naneseme úhel o velikosti $60^\\circ$.','Hledaný bod $K$ je průsečík ramene tohoto úhlu s přímkou $p$.','9.2 Sestrojíme kružnici se středem $M$ a poloměrem $|ML|$.','Hledané body $N_1$, $N_2$ jsou průsečíky této kružnice s přímkou $p$ (dvě řešení).'},
  'Bod $K$ je průsečík přímky $p$ s ramenem úhlu o velikosti $60^\\circ$ naneseného v bodě $L$ k polopřímce $LM$; body $N_1$, $N_2$ jsou průsečíky přímky $p$ s kružnicí se středem $M$ a poloměrem $|ML|$ (viz obrázek v klíči správných řešení).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
