String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M9 nanečisto 2025 – úloha 6',
  new List<String>{'Zahradník sázel na záhon sazenice. Sazenic salátů zasadil o 4 více než sazenic okurek. Na záhoně čtvrtinu sazenic salátů zlikvidovali slimáci a šestina sazenic okurek uschla. Všechny ostatní sazenice se ujaly. Na záhoně se tak ujal stejný počet sazenic salátů a okurek.','Určete:','6.1 kolik sazenic salátů zahradník zasadil,','6.2 kolik sazenic okurek se ujalo.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet sazenic okurek $o$, salátů $o+4$. Ujalo se salátů $\\frac{3}{4}(o+4)$, okurek $\\frac{5}{6}o$. Rovnost $\\frac{3}{4}(o+4)=\\frac{5}{6}o$; po vynásobení 12 je $9(o+4)=10o$, tedy $o=36$.','6.1 Salátů zahradník zasadil $o+4=40$.','6.2 Okurek se ujalo $\\frac{5}{6}\\cdot 36=30$.'},
  '6.1: $40$ sazenic salátů; 6.2: $30$ sazenic okurek',
  3, 6, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 7',
  new List<String>{'Stejné výrobky jsou po 12 kusech baleny do stejných krabic. Na váhu se položily tři krabice, z nichž dvě byly plné, ale ve třetí krabici 5 výrobků chybělo. Tyto tři krabice i s výrobky vážily dohromady 2 kg. Když se z váhy odebraly obě plné krabice, displej váhy ukazoval 480 g.','Vypočtěte, jaká je hmotnost v gramech:','7.1 jedné plné krabice,','7.2 jednoho výrobku,','7.3 jedné prázdné krabice.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Třetí krabice se 7 výrobky váží 480 g. Obě plné krabice tedy váží $2000-480=1520$ g, jedna plná krabice $760$ g.','7.1 Jedna plná krabice $=760$ g.','7.2 Rozdíl plné a třetí krabice je 5 výrobků: $760-480=280$ g, jeden výrobek $280:5=56$ g.','7.3 Prázdná krabice $=760-12\\cdot 56=760-672=88$ g.'},
  '7.1: $760$ g; 7.2: $56$ g; 7.3: $88$ g',
  4, 7, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 8',
  new List<String>{'Z rohů čtverce se stranou délky 27 cm se nejprve odstřihnou čtyři shodné trojúhelníky a poté se vykreslí ornament.','Ornament obsahuje jeden tmavý čtyřúhelník uprostřed, čtyři shodné bílé obdélníky a čtyři shodné bílé trojúhelníky, jejichž kratší strany mají délky 9 cm a 12 cm.','Vypočtěte:','8.1 v cm obvod ornamentu (zakresleného vpravo),','8.2 v cm² celkový obsah bílých ploch ornamentu (zakresleného vpravo).'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 300" font-family="sans-serif"> <polygon points="110,20 190,20 280,110 280,190 190,280 110,280 20,190 20,110" fill="#ffffff" stroke="#000" stroke-width="2"/> <rect x="110" y="110" width="80" height="80" fill="#bdbdbd" stroke="#000"/> <line x1="110" y1="20" x2="110" y2="110" stroke="#000"/> <line x1="190" y1="20" x2="190" y2="110" stroke="#000"/> <line x1="280" y1="110" x2="190" y2="110" stroke="#000"/> <line x1="280" y1="190" x2="190" y2="190" stroke="#000"/> <line x1="190" y1="280" x2="190" y2="190" stroke="#000"/> <line x1="110" y1="280" x2="110" y2="190" stroke="#000"/> <line x1="20" y1="190" x2="110" y2="190" stroke="#000"/> <line x1="20" y1="110" x2="110" y2="110" stroke="#000"/> </svg>',
  'ornament.svg',
  'Schematický nákres ornamentu tvaru osmiúhelníku s tmavým čtvercem uprostřed, bílými obdélníky a trojúhelníky.',
  'Schematický nákres ornamentu (zakresleného vpravo)',
  new List<String>{'8.1 Odstřižené trojúhelníky mají odvěsny 9 cm a 12 cm, přepona $\\sqrt{9^2+12^2}=15$ cm. Na každé straně čtverce zůstane $27-9-12=6$ cm. Obvod osmiúhelníku $=4\\cdot 6+4\\cdot 15=84$ cm.','8.2 Obsah osmiúhelníku $=27^2-4\\cdot\\frac{1}{2}\\cdot 9\\cdot 12=729-216=513$ cm². Tmavý čtverec uprostřed má stranu 9 cm a obsah $81$ cm². Bílé plochy: $513-81=432$ cm².'},
  '8.1: $84$ cm; 8.2: $432$ cm²',
  3, 7, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
