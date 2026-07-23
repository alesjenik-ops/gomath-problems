String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD26C0T02';
Integer YEAR = 2026;

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
  'CERMAT M9B 2026 – úloha 5',
  new List<String>{'František dal do svého salátu obsahujícího $850$ g rajčat celkem $255$ g cukru. Podle receptu však do salátu patří na každých $250$ g rajčat pouze $25$ g cukru.','5.1 Vypočtěte, kolik gramů cukru měl dát František podle receptu do svého salátu.','5.2 Vypočtěte, o kolik procent více cukru dal František do svého salátu, než měl dát podle receptu.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Na $850$ g rajčat připadá $\\frac{850}{250}\\cdot 25=3{,}4\\cdot 25=85$ g cukru.','5.2 František dal $255$ g místo $85$ g, tj. $\\frac{255}{85}=3$násobek množství podle receptu. To je o $200\\,\\%$ více.'},
  '5.1: $85$ g; 5.2: o $200\\,\\%$ více',
  3, 5, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2026 – úloha 6',
  new List<String>{'Na vánočním jarmarku prodávali ve stánku pouze čaj a punč. Čaj prodávali za $40$ korun a cena punče byla o $75\\,\\%$ vyšší než cena čaje.','6.1 Vypočtěte v korunách cenu jednoho punče.','6.2 Počet čajů, které dnes ve stánku prodali, označíme $x$. Vyjádřete výrazem s proměnnou $x$, kolik korun dnes ve stánku utržili za všechny prodané čaje.','6.3 Ve stánku dnes prodali celkem $510$ nápojů a utržili za ně dohromady $29\\,700$ korun. Vypočtěte, kolik čajů prodali dnes ve stánku.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Punč: $40\\cdot 1{,}75=70$ korun.','6.2 Za všechny prodané čaje utržili $40x$ korun.','6.3 Punčů bylo $510-x$. Rovnice $40x+70\\cdot(510-x)=29\\,700$ dává $40x+35\\,700-70x=29\\,700$, tj. $-30x=-6000$, tedy $x=200$. Prodali $200$ čajů.'},
  '6.1: $70$ korun; 6.2: $40x$; 6.3: $200$ čajů',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M9B 2026 – úloha 7',
  new List<String>{'Kruh o poloměru $10$ cm je rozdělen na tři shodné bílé části a tři shodné šedé části jako na obrázku.','7.1 Určete, kolikrát je obsah jedné bílé části kruhu větší než obsah jedné šedé části.','7.2 Vypočtěte v cm obvod jedné bílé části kruhu. Výsledek zaokrouhlete na desetiny centimetru.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 300" font-family="sans-serif"><circle cx="150" cy="150" r="120" fill="#ffffff" stroke="#000" stroke-width="2"/><polygon points="150,150 150.0,30.0 142.2,30.3 134.3,31.0 126.6,32.3 118.9,34.1 111.4,36.4 104.1,39.1 96.9,42.4 90.0,46.1" fill="#b9b9b9"/><polygon points="150,150 46.1,210.0 50.2,216.7 54.8,223.1 59.8,229.1 65.1,234.9 70.9,240.2 76.9,245.2 83.3,249.8 90.0,253.9" fill="#b9b9b9"/><polygon points="150,150 253.9,210.0 257.6,203.1 260.9,195.9 263.6,188.6 265.9,181.1 267.7,173.4 269.0,165.7 269.7,157.8 270.0,150.0" fill="#b9b9b9"/><line x1="150" y1="150" x2="270.0" y2="150.0" stroke="#000" stroke-width="1.5"/><line x1="150" y1="150" x2="150.0" y2="30.0" stroke="#000" stroke-width="1.5"/><line x1="150" y1="150" x2="90.0" y2="46.1" stroke="#000" stroke-width="1.5"/><line x1="150" y1="150" x2="46.1" y2="210.0" stroke="#000" stroke-width="1.5"/><line x1="150" y1="150" x2="90.0" y2="253.9" stroke="#000" stroke-width="1.5"/><line x1="150" y1="150" x2="253.9" y2="210.0" stroke="#000" stroke-width="1.5"/><polygon points="380,150 429.5,100.5 418.9,91.8 406.8,85.3 393.7,81.3 380.0,80.0 366.3,81.3 353.2,85.3 341.1,91.8 330.5,100.5" fill="#ffffff" stroke="#000" stroke-width="1.5"/><path d="M392,150 L392,138 L380,138" fill="none" stroke="#000"/><text x="380" y="194" font-size="12" text-anchor="middle">Jedna bila cast</text></svg>',
  'kruh-vysece.svg',
  'Kruh rozdělený na tři shodné bílé kruhové výseče a tři shodné šedé výseče; jedna bílá výseč má pravý úhel u středu.',
  'Schematický nákres (bílá výseč 90°, šedá výseč 30°)',
  new List<String>{'7.1 Jedna bílá část je kruhová výseč se středovým úhlem $90^\\circ$, jedna šedá výseč má úhel $30^\\circ$ (tři výseče po $90^\\circ$ a tři po $30^\\circ$ dají dohromady $360^\\circ$). Poměr obsahů je $90:30=3$, bílá část je tedy $3$krát větší.','7.2 Obvod bílé části tvoří dva poloměry a čtvrtkruhový oblouk: $2\\cdot 10+\\frac{1}{4}\\cdot 2\\pi\\cdot 10=20+5\\pi\\doteq 20+15{,}7=35{,}7$ cm.'},
  '7.1: $3$krát; 7.2: $35{,}7$ cm',
  3, 6, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
