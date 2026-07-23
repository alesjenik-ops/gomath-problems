String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD23C0T04';
Integer YEAR = 2023;

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
  'CERMAT M9D 2023 – úloha 12',
  new List<String>{'Velký obdélník lze rozdělit na dva shodné menší obdélníky, nebo na dva čtverce (viz obrázek). Obvod jednoho z menších obdélníků je 30 cm.','Jaký je obvod velkého obdélníku?'},
  new List<String>{'A) menší než $36$ cm','B) $36$ cm','C) $40$ cm','D) $60$ cm','E) větší než $60$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 120" font-family="sans-serif"> <g fill="none" stroke="#000" stroke-width="1.5"> <rect x="20" y="30" width="120" height="60"/> <rect x="200" y="30" width="120" height="60"/> </g> <line x1="20" y1="60" x2="140" y2="60" stroke="#000"/> <line x1="260" y1="30" x2="260" y2="90" stroke="#000"/> </svg>',
  'obdelnik-deleni.svg',
  'Vlevo obdélník rozdělený vodorovnou čárou na dva menší obdélníky, vpravo stejný obdélník rozdělený svislou čárou na dva čtverce.',
  'Dvojí rozdělení velkého obdélníku',
  new List<String>{'Velký obdélník lze rozdělit na dva čtverce, je tedy dvakrát delší, než širší; kratší stranu označíme $b$, delší strana je $2b$.','Rozdělením na dva shodné menší obdélníky (řezem rovnoběžným s delší stranou) vznikne obdélník $2b\\times\\frac{b}{2}$ s obvodem $2\\cdot\\left(2b+\\frac{b}{2}\\right)=5b=30$ cm, odkud $b=6$ cm.','Velký obdélník má strany $6$ cm a $12$ cm, jeho obvod je $2\\cdot(6+12)=36$ cm.'},
  'B) $36$ cm',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 13',
  new List<String>{'Přímka $p$ prochází vrcholy $A$, $B$ trojúhelníku $ABC$, jehož vnitřní úhly mají velikosti $\\alpha$, $\\beta$, $\\gamma$. Bodem $B$ prochází rovnoběžka se stranou $AC$. U vrcholu $B$ jsou vyznačeny úhly $2\\beta+\\gamma$ a $30^\\circ$ (viz obrázek).','Jaká je velikost úhlu $\\gamma$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $115^\\circ$','B) $120^\\circ$','C) $135^\\circ$','D) $140^\\circ$','E) $150^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250" font-family="sans-serif"> <g stroke="#000" stroke-width="1.4"> <line x1="150" y1="35" x2="560" y2="220"/> <line x1="250" y1="82" x2="300" y2="215"/> <line x1="300" y1="215" x2="560" y2="220"/> <line x1="255" y1="80" x2="470" y2="72"/> </g> <g font-style="italic"> <text x="140" y="34">p</text> <text x="248" y="70">B</text> <text x="291" y="232">C</text> <text x="562" y="230">A</text> <text x="272" y="120">β</text> <text x="312" y="205">γ</text> <text x="536" y="210">α</text> </g> <text x="202" y="104" font-size="13">2β + γ</text> <text x="286" y="74" font-size="12">30°</text> <text x="452" y="66" font-size="12">//</text> <text x="416" y="222" font-size="12">//</text> </svg>',
  'trojuhelnik-uhly.svg',
  'Trojúhelník ABC, přímka p vedená vrcholy A a B, bodem B rovnoběžka se stranou AC; u vrcholu B jsou úhly 2β+γ a 30 stupňů.',
  'Trojúhelník ABC (schematický nákres)',
  new List<String>{'Přímka $p$ obsahuje stranu $AB$. Úhel $2\\beta+\\gamma$ leží u vrcholu $B$ na přímce $p$ vně trojúhelníku a je vedlejší k vnitřnímu úhlu $\\beta$: $2\\beta+\\gamma=180^\\circ-\\beta$, odkud $3\\beta+\\gamma=180^\\circ$.','Rovnoběžka se stranou $AC$ vedená bodem $B$ svírá s přímkou $p$ úhel shodný s úhlem $\\alpha$ (souhlasné úhly); tím je vyznačených $30^\\circ$, takže $\\alpha=30^\\circ$.','Ze součtu úhlů $\\alpha+\\beta+\\gamma=180^\\circ$ plyne $\\beta+\\gamma=150^\\circ$. Spolu s $3\\beta+\\gamma=180^\\circ$ dostaneme $2\\beta=30^\\circ$, tedy $\\beta=15^\\circ$ a $\\gamma=135^\\circ$.'},
  'C) $135^\\circ$',
  2, 5, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
