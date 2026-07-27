String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD17C0T02';
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
  'CERMAT M9B 2017 – úloha 12',
  new List<String>{'V trojúhelníku je vyznačen úhel $52^\\circ$ při levém vrcholu a úhel $\\beta$ při pravém vrcholu. Úsečka uvnitř trojúhelníku (vyznačená dvojicí shodných značek) je rovnoběžná s levou stranou trojúhelníku; svírá s pravou stranou trojúhelníku úhel $88^\\circ$.','Jaká je velikost úhlu $\\beta$? Úhel neměřte, ale vypočtěte.'},
  new List<String>{'A) $36^\\circ$','B) $38^\\circ$','C) $40^\\circ$','D) $48^\\circ$','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 250" font-family="sans-serif"> <polygon points="40,220 440,220 185,35" fill="none" stroke="#000" stroke-width="2.5"/> <line x1="150" y1="220" x2="255" y2="86" stroke="#000" stroke-width="2"/> <path d="M 82 220 A 42 42 0 0 0 66 187" fill="none" stroke="#000"/> <path d="M 398 220 A 42 42 0 0 1 406 195" fill="none" stroke="#000"/> <path d="M 228 66 A 34 34 0 0 0 234 113" fill="none" stroke="#000"/> <line x1="121" y1="129" x2="109" y2="120" stroke="#000" stroke-width="2"/> <line x1="116" y1="136" x2="104" y2="126" stroke="#000" stroke-width="2"/> <line x1="211" y1="155" x2="199" y2="145" stroke="#000" stroke-width="2"/> <line x1="206" y1="161" x2="194" y2="151" stroke="#000" stroke-width="2"/> <text x="90" y="205" font-size="16" text-anchor="middle">52°</text> <text x="200" y="99" font-size="16" text-anchor="middle">88°</text> <text x="386" y="208" font-size="17" text-anchor="middle" font-style="italic">β</text> </svg>',
  'trojuhelnik-uhly.svg',
  'Trojúhelník s úhlem 52 stupňů vlevo a úhlem beta vpravo, uvnitř úsečka rovnoběžná s levou stranou svírající s pravou stranou úhel 88 stupňů.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'Vyznačená úsečka je rovnoběžná s levou stranou trojúhelníku, proto svírá se základnou souhlasný úhel $52^\\circ$.','Úhel, který svírá tato úsečka s pravou stranou na druhou stranu, je vedlejší k úhlu $88^\\circ$, tedy $180^\\circ-88^\\circ=92^\\circ$.','V menším trojúhelníku vpravo tak platí $\\beta=180^\\circ-52^\\circ-92^\\circ=36^\\circ$.'},
  'A) $36^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
