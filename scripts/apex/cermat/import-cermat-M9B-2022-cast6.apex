String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD22C0T02';
Integer YEAR = 2022;

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
  'CERMAT M9B 2022 – úloha 12',
  new List<String>{'Reklamní plochu pro vylepování plakátů tvoří plášť rotačního válce. Podstava válce má poloměr $50$ cm. Plakát, který přesně pokryje celou reklamní plochu, má tvar čtverce (viz obrázek).','Jaká je výška válce? Výsledek je zaokrouhlen na celé cm.'},
  new List<String>{'A) $157$ cm','B) $236$ cm','C) $314$ cm','D) $390$ cm','E) větší než $390$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 200" font-family="sans-serif"> <ellipse cx="90" cy="45" rx="45" ry="16" fill="#eee" stroke="#000"/> <line x1="45" y1="45" x2="45" y2="150" stroke="#000"/> <line x1="135" y1="45" x2="135" y2="150" stroke="#000"/> <path d="M45,150 A45,16 0 0 0 135,150" fill="#eee" stroke="#000"/> <text x="90" y="102" font-size="12" text-anchor="middle">válec</text> <rect x="155" y="45" width="105" height="105" fill="#cfcfcf" stroke="#000"/> <text x="207" y="100" font-size="12" text-anchor="middle">plakát</text> </svg>',
  'valec-plakat.svg',
  'Rotační válec, vedle něj čtvercový plakát tvořící plášť válce.',
  'Válcová reklamní plocha a čtvercový plakát',
  new List<String>{'Rozvinutý plášť je obdélník o šířce rovné obvodu podstavy $o=2\\pi r=2\\pi\\cdot50=100\\pi\\doteq314$ cm a o výšce rovné výšce válce. Aby byl plakát čtvercový, musí být výška válce rovna obvodu podstavy, tedy $\\doteq314$ cm.'},
  'C) $314$ cm',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2022 – úloha 13',
  new List<String>{'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné (viz obrázek). Vyznačeny jsou úhly $110^\\circ$ a $100^\\circ$ a hledaný úhel $\\alpha$.','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $120^\\circ$','B) $120^\\circ$','C) $130^\\circ$','D) $150^\\circ$','E) větší než $150^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 280" font-family="sans-serif"> <line x1="60" y1="250" x2="180" y2="40" stroke="#000" stroke-width="1.5"/> <line x1="240" y1="250" x2="360" y2="40" stroke="#000" stroke-width="1.5"/> <line x1="40" y1="150" x2="330" y2="255" stroke="#000" stroke-width="1.5"/> <line x1="120" y1="255" x2="360" y2="120" stroke="#000" stroke-width="1.5"/> <line x1="112" y1="118" x2="126" y2="125" stroke="#000"/> <line x1="117" y1="110" x2="131" y2="117" stroke="#000"/> <line x1="292" y1="118" x2="306" y2="125" stroke="#000"/> <line x1="297" y1="110" x2="311" y2="117" stroke="#000"/> <text x="118" y="188" font-size="15">110°</text> <text x="278" y="150" font-size="15">100°</text> <text x="205" y="232" font-size="15" font-style="italic">α</text> </svg>',
  'ctyri-primky-uhly.svg',
  'Čtyři přímky, dvě z nich rovnoběžné (s ryskami); vyznačeny úhly 110°, 100° a úhel α.',
  'Schematický nákres k úloze 13',
  new List<String>{'Přímky protínající rovnoběžky svírají s nimi u příslušných vrcholů vnitřní úhly trojúhelníku $180^\\circ-110^\\circ=70^\\circ$ a $180^\\circ-100^\\circ=80^\\circ$. Třetí vnitřní úhel trojúhelníku je $180^\\circ-70^\\circ-80^\\circ=30^\\circ$; úhel $\\alpha$ je jeho vedlejší úhel, tedy $\\alpha=180^\\circ-30^\\circ=150^\\circ$.'},
  'D) $150^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2022 – úloha 14',
  new List<String>{'V knihovně je $k$ polic. V každé polici je o $8$ knih více, než je v knihovně polic. ($k$ může nabývat různých kladných celých hodnot.)','Který výraz vyjadřuje celkový počet knih v knihovně?'},
  new List<String>{'A) $k^2+8k$','B) $k^2+16k+64$','C) $k^2+64$','D) $2k+8$','E) $8k$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Počet polic je $k$, v každé polici je $k+8$ knih. Celkem $k\\cdot(k+8)=k^2+8k$ knih.'},
  'A) $k^2+8k$',
  2, 3, '2',
  new List<String>{'zs2','r9','vyrazy','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
