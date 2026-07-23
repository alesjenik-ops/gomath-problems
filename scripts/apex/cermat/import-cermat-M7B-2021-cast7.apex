String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD21C0T02';
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
  'CERMAT M7B 2021 – úloha 14',
  new List<String>{'Lichoběžník $ABCD$ má základny $AB$, $CD$, vnitřní úhly při vrcholech $A$, $C$ mají velikosti $\\alpha$, $\\gamma$. Úhly označené v obrázku stejnými písmeny mají stejnou velikost (viz obrázek).','Jaký je součet velikostí úhlů $\\alpha+\\gamma$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $80^\\circ$','B) $85^\\circ$','C) $90^\\circ$','D) $100^\\circ$','E) větší než $100^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 340" font-family="sans-serif"> <polygon points="40,300 440,300 560,80 340,80" fill="none" stroke="#000" stroke-width="2"/> <line x1="340" y1="80" x2="300" y2="300" stroke="#000" stroke-width="1.5"/> <line x1="340" y1="80" x2="440" y2="300" stroke="#000" stroke-width="1.5"/> <text x="28" y="316" font-size="15" font-style="italic">A</text> <text x="436" y="318" font-size="15" font-style="italic">B</text> <text x="566" y="76" font-size="15" font-style="italic">C</text> <text x="330" y="72" font-size="15" font-style="italic">D</text> <text x="90" y="292" font-size="14" font-style="italic">α</text> <text x="316" y="150" font-size="14" font-style="italic">2α</text> <text x="350" y="152" font-size="14" font-style="italic">γ</text> <text x="386" y="122" font-size="14" font-style="italic">γ</text> <text x="452" y="272" font-size="14" font-style="italic">γ</text> <text x="532" y="112" font-size="14" font-style="italic">γ</text> </svg>',
  'lichobeznik-uhly.svg',
  'Lichoběžník ABCD se základnami AB a CD, s úhlopříčkou DB a úsečkou z vrcholu D; vyznačené úhly alfa, dva alfa a několik gama.',
  'Lichoběžník s vyznačenými úhly',
  new List<String>{'Protože $AB\\parallel CD$, je úhel $DBC=\\gamma$ (vyznačen) a úhel $DBA=\\gamma$ (střídavý úhel k úhlu $BDC$). Vnitřní úhel při vrcholu $B$ je tedy $2\\gamma$, při vrcholu $C$ je $\\gamma$; jejich součet je $180^\\circ$, takže $3\\gamma=180^\\circ$ a $\\gamma=60^\\circ$.','Vnitřní úhel při vrcholu $D$ je $2\\alpha+2\\gamma$, při vrcholu $A$ je $\\alpha$; jejich součet je $180^\\circ$: $3\\alpha+2\\gamma=180^\\circ$, odtud $\\alpha=20^\\circ$. Součet $\\alpha+\\gamma=20^\\circ+60^\\circ=80^\\circ$.'},
  'A) $80^\\circ$',
  2, 5, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2021 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Škola má celkem $250$ žáků, ale dnes je ve škole jen $200$ žáků, ostatní chybí. Kolik procent žáků školy dnes chybí?','15.2 Ze $132$ žáků školy se pět šestin zúčastnilo soutěže. Nejlepších $33$ žáků bylo za úspěch v soutěži odměněno. Kolik procent soutěžících žáků bylo odměněno?','15.3 Obor A studuje $270$ žáků, což je $18\\,\\%$ všech žáků školy. Obor B téže školy studuje $480$ žáků. Kolik procent žáků školy studuje obor B?'},
  new List<String>{'A) $20\\,\\%$','B) $25\\,\\%$','C) $27\\,\\%$','D) $30\\,\\%$','E) $32\\,\\%$','F) jiný počet procent'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Chybí $250-200=50$ žáků; $\\frac{50}{250}=20\\,\\%$ → A.','15.2 Soutěžilo $\\frac{5}{6}\\cdot 132=110$ žáků; odměněno $33$; $\\frac{33}{110}=30\\,\\%$ → D.','15.3 Všech žáků $\\frac{270}{0{,}18}=1\\,500$; obor B $\\frac{480}{1\\,500}=32\\,\\%$ → E.'},
  '15.1: A ($20\\,\\%$); 15.2: D ($30\\,\\%$); 15.3: E ($32\\,\\%$)',
  6, 8, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
