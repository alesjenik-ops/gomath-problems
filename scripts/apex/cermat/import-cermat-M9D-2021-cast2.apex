String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD21C0T04';
Integer YEAR = 2021;

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
  'CERMAT M9D 2021 – úloha 5.2',
  new List<String>{'Řešte rovnici:','$\\dfrac{5}{3}\\cdot(y-1)+\\dfrac{5}{6}\\cdot(11-2y)-\\dfrac{3}{4}\\cdot y=0$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobením dvanácti: $20(y-1)+10(11-2y)-9y=0$; $20y-20+110-20y-9y=0$; $-9y+90=0$, tedy $y=10$.'},
  '$y=10$',
  2, 5, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2021 – úloha 6',
  new List<String>{'Na trati závodila $3$ autíčka. První autíčko ujelo závod za $1$ minutu a $42$ sekund. Druhé autíčko ujelo závod za dobu o třetinu kratší než první autíčko. První autíčko ujelo závod za dobu o třetinu kratší než třetí autíčko.','Vypočtěte v minutách a sekundách, za jakou dobu ujelo závod','6.1 druhé autíčko,','6.2 třetí autíčko.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'První autíčko: $1$ min $42$ s $=102$ s.','6.1 Druhé autíčko je o třetinu kratší: $102-\\dfrac{1}{3}\\cdot 102=68$ s $=1$ min $8$ s.','6.2 První je o třetinu kratší než třetí, tedy $102=\\dfrac{2}{3}\\cdot t_3$, odtud $t_3=153$ s $=2$ min $33$ s.'},
  '6.1: $1$ min $8$ s; 6.2: $2$ min $33$ s',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2021 – úloha 7',
  new List<String>{'V bílé krabičce jsou jen bílé kuličky, v zelené jen zelené a v modré jen modré. Bílých kuliček je $12$ a modrých $60$. Do bílé krabičky přendáme ze zelené a modré krabičky tolik kuliček, aby byl ve všech třech krabičkách stejný počet kuliček. Ze zelené krabičky přitom musíme přendat o $9$ kuliček více než z modré krabičky.','7.1 Určete počet všech zelených kuliček.','7.2 Vypočtěte, kolik kuliček zůstane v modré krabičce.','7.3 Vypočtěte, kolik zelených kuliček přendáme do bílé krabičky.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Po přendání má každá krabička stejný počet $t$. Z modré (mělo $60$) přendáme $60-t$; do bílé (mělo $12$) přidáme celkem $t-12$ kuliček, přičemž zelených o $9$ více než modrých. Tedy $(60-t)+\\big((60-t)+9\\big)=t-12$, odkud $t=47$.','7.2 V modré krabičce zůstane $t=47$ kuliček.','7.3 Modrých přendáme $60-47=13$, zelených o $9$ více, tj. $22$.','7.1 Všech zelených bylo $47+22=69$.'},
  '7.1: $69$ zelených; 7.2: $47$; 7.3: $22$ zelených',
  3, 6, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2021 – úloha 8',
  new List<String>{'V pravoúhlém lichoběžníku $ABCD$ se základnou $AB$ platí: $|AB|=15$ cm, $|CD|=10$ cm, $|AD|=12$ cm, $|\\angle BAD|=90^\\circ$ (viz obrázek).','Vypočtěte','8.1 v cm² obsah lichoběžníku $ABCD$,','8.2 v cm obvod lichoběžníku $ABCD$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 320" font-family="sans-serif"> <polygon points="70,270 280,270 210,102 70,102" fill="#eef3ef" stroke="#000" stroke-width="2"/> <rect x="70" y="256" width="14" height="14" fill="none" stroke="#000" stroke-width="1"/> <text x="62" y="290" font-size="15" font-weight="bold" text-anchor="end">A</text> <text x="286" y="290" font-size="15" font-weight="bold">B</text> <text x="214" y="98" font-size="15" font-weight="bold">C</text> <text x="54" y="100" font-size="15" font-weight="bold" text-anchor="end">D</text> <text x="175" y="291" font-size="14" text-anchor="middle">15 cm</text> <text x="140" y="92" font-size="14" text-anchor="middle">10 cm</text> <text x="44" y="192" font-size="14" text-anchor="middle">12 cm</text> </svg>',
  'lichobeznik.svg',
  'Pravoúhlý lichoběžník ABCD se základnou AB délky 15 cm, kratší základnou CD délky 10 cm a ramenem AD délky 12 cm kolmým k základnám.',
  'Pravoúhlý lichoběžník ABCD',
  new List<String>{'8.1 Rameno $AD=12$ cm je výška. Obsah $=\\dfrac{|AB|+|CD|}{2}\\cdot v=\\dfrac{15+10}{2}\\cdot 12=150$ cm².','8.2 Vodorovný rozdíl základen je $15-10=5$ cm, výška $12$ cm, tedy $|BC|=\\sqrt{5^2+12^2}=13$ cm. Obvod $=15+13+10+12=50$ cm.'},
  '8.1: $150$ cm²; 8.2: $50$ cm',
  3, 6, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
