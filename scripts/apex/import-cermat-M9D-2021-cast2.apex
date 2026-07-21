String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, druhý náhradní termín (M9D)';
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
  'CERMAT 2021 M9D · úloha 7',
  new List<String>{'V bílé krabičce jsou jen bílé kuličky, v zelené krabičce jen zelené a v modré krabičce jen modré kuličky. Bílých kuliček je $12$ a modrých $60$.','Do bílé krabičky přendáme ze zelené a modré krabičky tolik kuliček, aby byl ve všech třech krabičkách stejný počet kuliček. Ze zelené krabičky tak musíme přendat o $9$ kuliček více než z modré krabičky.','7.1 Určete počet všech zelených kuliček.','7.2 Vypočtěte, kolik kuliček zůstane v modré krabičce.','7.3 Vypočtěte, kolik zelených kuliček přendáme do bílé krabičky.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Počet zelených označme $Z$. Celkem je $12+60+Z=72+Z$ kuliček, po vyrovnání je v každé krabičce $\\frac{72+Z}{3}$.','Z modré přendáme $60-\\frac{72+Z}{3}$, ze zelené $Z-\\frac{72+Z}{3}$; jejich rozdíl je $\\left(Z-\\frac{72+Z}{3}\\right)-\\left(60-\\frac{72+Z}{3}\\right)=Z-60=9$, tedy $Z=69$.','7.1: zelených je $69$.','7.2: v každé krabičce nakonec $\\frac{72+69}{3}=47$ kuliček, v modré tedy zůstane $47$.','7.3: ze zelené přendáme $69-47=22$ kuliček.'},
  '7.1: $69$ zelených kuliček; 7.2: $47$ kuliček; 7.3: $22$ zelených kuliček',
  3, 6, '4',
  new List<String>{'zs2','r9','rovnice','aritmetika','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PDD21C0T04', 2021
);
c.add(
  'CERMAT 2021 M9D · úloha 8',
  new List<String>{'V pravoúhlém lichoběžníku ABCD se základnou AB platí: $|AB|=15\\ \\mathrm{cm}$, $|CD|=10\\ \\mathrm{cm}$, $|AD|=12\\ \\mathrm{cm}$, $|\\angle BAD|=90^\\circ$ (viz obrázek).','Vypočtěte','8.1 v $\\mathrm{cm}^2$ obsah lichoběžníku ABCD,','8.2 v cm obvod lichoběžníku ABCD.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 143 125"><path d="M8 89C17 89 24 96 24 105" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M16 98C16 99 15 99 15 99C14 99 14 99 14 98C14 97 14 97 15 97C15 97 16 97 16 98Z" style="fill:#000000;stroke:#000000;stroke-width:1"/><path d="M8 14L8 105L127 105L82 14Z" style="fill:none;stroke:#000000;stroke-width:2"/><text x="69" y="119" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">15 cm</text><text x="46" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">10 cm</text><text x="7" y="119" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="133" y="119" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="87" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="7" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text></svg>',
  'obr.svg',
  'Pravoúhlý lichoběžník ABCD se základnou AB = 15 cm, kratší rovnoběžnou stranou CD = 10 cm, ramenem AD = 12 cm kolmým k AB (pravý úhel při vrcholu A).',
  '',
  new List<String>{'8.1: rovnoběžné strany $|AB|=15$ a $|CD|=10$, výška $|AD|=12$; obsah $S=\\frac{15+10}{2}\\cdot12=12{,}5\\cdot12=150\\ \\mathrm{cm}^2$.','8.2: rameno BC je přeponou pravoúhlého trojúhelníku s odvěsnami $15-10=5$ a $12$: $|BC|=\\sqrt{5^2+12^2}=\\sqrt{169}=13\\ \\mathrm{cm}$; obvod $=15+10+12+13=50\\ \\mathrm{cm}$.'},
  '8.1: $150\\ \\mathrm{cm}^2$; 8.2: $50\\ \\mathrm{cm}$',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','vypocet','bez-kalkulacky'},
  'M9PDD21C0T04', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
