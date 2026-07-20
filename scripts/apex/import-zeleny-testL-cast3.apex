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
  'Zelený L8 – Galway, Ameland, Crancot',
  new List<String>{'Holandský ostrov Ameland a irské městečko Galway leží na $53$. rovnoběžce. Celková délka této rovnoběžky je přibližně $24\\,000$ km. Francouzské městečko Crancot je vzdálené od ostrova Ameland $750$ km a od irského Galway $1\\,250$ km. Spojnice těchto tří míst tvoří pravoúhlý trojúhelník.','8.1 Vypočtěte, jaký je obvod trojúhelníku tvořeného spojnicemi těchto tří míst.','8.2 Vypočtěte, za kolik minut vyjde slunce v Galway, jestliže právě nyní vychází nad ostrovem Ameland i městečkem Crancot.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif"> <polygon points="60,70 430,70 430,340" fill="#eef3ee" stroke="#000" stroke-width="2"/> <rect x="410" y="70" width="20" height="20" fill="none" stroke="#000" stroke-width="1"/> <text x="45" y="66" font-size="16" font-weight="bold" text-anchor="end">GALWAY</text> <text x="438" y="66" font-size="16" font-weight="bold">AMELAND</text> <text x="438" y="352" font-size="16" font-weight="bold">CRANCOT</text> <text x="245" y="60" font-size="15" text-anchor="middle" font-style="italic">?</text> <text x="440" y="215" font-size="15">750 km</text> <text x="205" y="220" font-size="15" text-anchor="middle" transform="rotate(36 205 220)">1250 km</text> </svg>',
  'ameland-galway.svg',
  'Pravoúhlý trojúhelník se spojnicemi míst Galway, Ameland a Crancot; přepona Galway–Crancot je 1250 km, odvěsna Ameland–Crancot 750 km, pravý úhel je u Amelandu.',
  'Mapka se spojnicemi tří míst (schematický nákres)',
  new List<String>{'8.1 Pravý úhel je u Amelandu. Odvěsna Ameland–Crancot $=750$ km, přepona Galway–Crancot $=1\\,250$ km. Odvěsna Ameland–Galway $=\\sqrt{1\\,250^2-750^2}=\\sqrt{1\\,000\\,000}=1\\,000$ km. Obvod $=750+1\\,000+1\\,250=3\\,000$ km.','8.2 Galway a Ameland leží na téže rovnoběžce ve vzdálenosti $1\\,000$ km. Celá rovnoběžka $24\\,000$ km odpovídá $24$ hodinám ($=1\\,440$ min). Slunce urazí $1\\,000$ km za $\\frac{1\\,000}{24\\,000}\\cdot 1\\,440=60$ minut.'},
  '8.1: $3\\,000$ km; 8.2: za $60$ minut',
  5, 9, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený L9 – pravoúhlý trojúhelník a dělicí přímka',
  new List<String>{'V rovině leží úsečka $AB$ o délce $8$ cm.','Sestrojte pravoúhlý trojúhelník $ABC$ s pravým úhlem u vrcholu $C$ tak, aby velikosti úhlů při vrcholech $A$ a $B$ byly v poměru $1:2$. Veďte trojúhelníkem přímku $p$ tak, aby rozdělila plochu trojúhelníku na dvě části, jejichž obsahy budou v poměru $1:3$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 120" font-family="sans-serif"> <line x1="60" y1="60" x2="400" y2="60" stroke="#000" stroke-width="2.5"/> <line x1="60" y1="48" x2="60" y2="72" stroke="#000" stroke-width="2"/> <line x1="400" y1="48" x2="400" y2="72" stroke="#000" stroke-width="2"/> <text x="55" y="92" font-size="18" font-weight="bold" text-anchor="middle">A</text> <text x="405" y="92" font-size="18" font-weight="bold" text-anchor="middle">B</text> <text x="230" y="45" font-size="15" text-anchor="middle">8 cm</text> </svg>',
  'usecka-ab.svg',
  'Vodorovná úsečka AB dlouhá 8 cm s krajními body A a B.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Protože úhel u $C$ je pravý, leží $C$ na Thaletově kružnici nad průměrem $AB$. Úhly při $A$ a $B$ jsou v poměru $1:2$ a jejich součet je $90^\\circ$, tedy úhel u $A$ je $30^\\circ$ a u $B$ je $60^\\circ$. U bodu $A$ sestrojíme úhel $30^\\circ$; jeho rameno protne Thaletovu kružnici v bodě $C$. Přímku $p$ vedeme tak, aby oddělený útvar měl obsah rovný čtvrtině obsahu trojúhelníku (poměr $1:3$) — např. rovnoběžně s jednou stranou nebo přes vrchol tak, že dělí protější stranu v poměru $1:3$. Úloha má více řešení.'},
  'Konstrukce pravoúhlého trojúhelníku $ABC$ (úhly $30^\\circ$, $60^\\circ$, $90^\\circ$) na Thaletově kružnici nad $AB$ a přímky $p$ dělící obsah v poměru $1:3$; úloha má tři možná řešení (viz obrázky v klíči).',
  2, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
