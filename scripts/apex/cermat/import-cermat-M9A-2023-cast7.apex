String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD23C0T01';
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
  'CERMAT M9A 2023 – úloha 14',
  new List<String>{'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné (viz obrázek). Vyznačené úhly jsou $2\\alpha$, $\\beta$ a dvakrát $4\\alpha$.','Jaká je velikost úhlu $\\beta$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $100^\\circ$','B) $108^\\circ$','C) $116^\\circ$','D) $120^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="150" y1="290" x2="320" y2="10" stroke="#000"/> <line x1="350" y1="290" x2="180" y2="10" stroke="#000"/> <line x1="110" y1="165" x2="420" y2="165" stroke="#000"/> <line x1="110" y1="250" x2="420" y2="250" stroke="#000"/> <line x1="404" y1="158" x2="412" y2="172" stroke="#000"/> <line x1="410" y1="158" x2="418" y2="172" stroke="#000"/> <line x1="404" y1="243" x2="412" y2="257" stroke="#000"/> <line x1="410" y1="243" x2="418" y2="257" stroke="#000"/> <text x="250" y="112" font-size="16" text-anchor="middle">2&#945;</text> <text x="205" y="159" font-size="16" text-anchor="middle">&#946;</text> <text x="260" y="159" font-size="16" text-anchor="middle">4&#945;</text> <text x="188" y="243" font-size="16" text-anchor="middle">4&#945;</text> </svg>',
  'ctyri-primky.svg',
  'Dvě rovnoběžné přímky protnuté dvěma různoběžkami, které se protínají nad nimi pod úhlem 2 alfa; u horní rovnoběžky úhly beta a 4 alfa, u dolní rovnoběžky úhel 4 alfa.',
  'Schematický nákres čtyř přímek (obrázek je ilustrační)',
  new List<String>{'Obě různoběžky svírají s rovnoběžkami stejné úhly, proto vnitřní úhly trojúhelníku u obou rovnoběžek jsou $4\\alpha$ a vrcholový úhel je $2\\alpha$. Součet úhlů v trojúhelníku: $2\\alpha+4\\alpha+4\\alpha=180^\\circ$, tedy $10\\alpha=180^\\circ$ a $\\alpha=18^\\circ$. Úhel $\\beta$ je vedlejší k úhlu $4\\alpha$: $\\beta=180^\\circ-4\\alpha=180^\\circ-72^\\circ=108^\\circ$.'},
  'B) $108^\\circ$',
  2, 3, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2023 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V roce 2020 firma vyrobila $250$ výrobků. Jak v roce 2021, tak v roce 2022 vyrobila firma vždy o $20\\,\\%$ výrobků více než v předchozím roce. Kolik výrobků vyrobila firma v roce 2022?','15.2 Roman i Jana jezdili během dovolené na kole. Roman ujel $400$ km, což bylo o čtvrtinu více, než ujela Jana. Kolik km ujela na kole během dovolené Jana?','15.3 Firma během krize propouštěla zaměstnance, takže jich měla na konci krize o $40\\,\\%$ méně než před krizí. Když firma po odeznění krize přijala $42$ nových zaměstnanců, měla jich o $25\\,\\%$ více než na konci krize. Kolik zaměstnanců měla firma před krizí?'},
  new List<String>{'A) $280$','B) $300$','C) $320$','D) $350$','E) $360$','F) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 $250\\cdot 1{,}2\\cdot 1{,}2=250\\cdot 1{,}44=360$ výrobků → E.','15.2 Jana ujela $j$; $j\\cdot 1{,}25=400$, tedy $j=320$ km → C.','15.3 Před krizí $x$; na konci krize $0{,}6x$; po přijetí $42$: $0{,}6x+42=1{,}25\\cdot 0{,}6x=0{,}75x$, odtud $42=0{,}15x$, $x=280$ → A.'},
  '15.1: E ($360$); 15.2: C ($320$); 15.3: A ($280$)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
