String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD26C0T01';
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
  'CERMAT M9A 2026 – úloha 6',
  new List<String>{'Cyklostezka začíná u nádraží a končí u chaty. Petr vyjel od nádraží po této cyklostezce, ujel dvě třetiny její délky a zastavil u stánku s občerstvením. Tam zjistil, že ztratil telefon. Našel ho, až když se vrátil o čtvrtinu vzdálenosti, kterou předtím ujel od nádraží ke stánku. Pak pokračoval po cyklostezce až k chatě. Délku celé cyklostezky označíme $x$.','6.1 Vyjádřete výrazem s proměnnou $x$ délku cyklostezky mezi stánkem a chatou.','6.2 Vyjádřete výrazem s proměnnou $x$ délku cyklostezky mezi stánkem a místem, kde Petr našel svůj telefon.','6.3 Ve chvíli, kdy našel svůj telefon, zbývalo Petrovi k chatě ještě $24$ km. Vypočtěte, kolik km Petr celkem najezdil, než se dostal od nádraží k chatě.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 120" font-family="sans-serif"> <text x="46" y="34" font-size="14">Nadrazi</text> <text x="404" y="34" font-size="14">Chata</text> <circle cx="55" cy="58" r="4" fill="#000"/> <circle cx="435" cy="58" r="4" fill="#000"/> <line x1="55" y1="58" x2="435" y2="58" stroke="#000" stroke-width="2"/> <line x1="55" y1="84" x2="435" y2="84" stroke="#000" stroke-width="1"/> <polygon points="55,84 66,80 66,88" fill="#000"/> <polygon points="435,84 424,80 424,88" fill="#000"/> <text x="245" y="102" font-size="16" text-anchor="middle" font-style="italic">x</text> </svg>',
  'cyklostezka.svg',
  'Úsečka znázorňující cyklostezku od nádraží k chatě, celá délka označená x.',
  'Výchozí obrázek k úloze 6',
  new List<String>{'6.1 Mezi stánkem a chatou zbývá $x-\\frac{2}{3}x=\\frac{1}{3}x=\\frac{x}{3}$.','6.2 Vzdálenost stánku a místa nálezu je čtvrtina úseku nádraží–stánek: $\\frac{1}{4}\\cdot\\frac{2}{3}x=\\frac{x}{6}$.','6.3 Místo nálezu je od nádraží $\\frac{2}{3}x-\\frac{x}{6}=\\frac{x}{2}$; k chatě odtud zbývá $x-\\frac{x}{2}=\\frac{x}{2}=24$ km, tedy $x=48$ km. Petr najezdil $\\frac{2}{3}x+\\frac{x}{6}+\\frac{x}{2}=32+8+24=64$ km.'},
  '6.1: $\\frac{x}{3}$; 6.2: $\\frac{x}{6}$; 6.3: $64$ km',
  4, 6, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2026 – úloha 7',
  new List<String>{'Adam běžel 10kilometrový okruh stálým tempem a uběhl jej za $50$ minut. Bára běžela pouze 9kilometrový okruh rovněž stálým tempem (jiným než Adam). Adam i Bára vyběhli ve stejném okamžiku a po $30$ minutách běhu jim oběma zbývala do cíle stejná vzdálenost.','7.1 Vypočtěte, kolik km uběhla Bára za $30$ minut.','7.2 Vypočtěte, za kolik minut uběhla svůj okruh Bára.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'7.1 Adam běží $\\frac{10}{50}=0{,}2$ km/min, za $30$ min uběhne $6$ km a zbývají mu $4$ km. Stejně tak Báře zbývají $4$ km, uběhla tedy $9-4=5$ km.','7.2 Bára běží $\\frac{5}{30}=\\frac{1}{6}$ km/min; celý okruh $9$ km uběhne za $9:\\frac{1}{6}=54$ minut.'},
  '7.1: $5$ km; 7.2: $54$ minut',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','fyzika'}
);

System.debug('Vytvořeno úloh: '+c.created);
