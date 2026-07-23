String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD22C0T03';
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
  'CERMAT M9C 2022 – úloha 12',
  new List<String>{'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné a zbývající dvě jsou na sebe kolmé (viz obrázek).','Jaká je velikost úhlu $\\beta$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $20^\\circ$','B) $20^\\circ$','C) $28^\\circ$','D) $34^\\circ$','E) větší než $34^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 380" font-family="sans-serif"><line x1="115" y1="261" x2="482" y2="127" stroke="#000" stroke-width="1.8"/><line x1="149" y1="89" x2="244" y2="352" stroke="#000" stroke-width="1.8"/><line x1="41" y1="209" x2="230" y2="62" stroke="#000" stroke-width="1.8"/><line x1="305" y1="231" x2="495" y2="83" stroke="#000" stroke-width="1.8"/><line x1="75.1" y1="174.9" x2="82.5" y2="184.3" stroke="#000" stroke-width="1.6"/><line x1="86.5" y1="166.0" x2="93.8" y2="175.5" stroke="#000" stroke-width="1.6"/><line x1="339.3" y1="196.7" x2="346.7" y2="206.1" stroke="#000" stroke-width="1.6"/><line x1="350.7" y1="187.8" x2="358.1" y2="197.3" stroke="#000" stroke-width="1.6"/><polyline points="188,236 201,231 206,244" fill="none" stroke="#000" stroke-width="1.4"/><text x="166" y="86" font-size="16" font-style="italic">2α</text><text x="132" y="134" font-size="16" font-style="italic">3α</text><text x="414" y="150" font-size="16" font-style="italic">β</text></svg>',
  'ctyri-primky.svg',
  'Čtyři přímky – dvě rovnoběžné (s ryskami) a dvě na sebe kolmé; vyznačeny úhly 2α, 3α a β.',
  'Schematický nákres k úloze 12',
  new List<String>{'Úhly $2\\alpha$ a $3\\alpha$ jsou vedlejší, tedy $2\\alpha+3\\alpha=180^\\circ$, odtud $\\alpha=36^\\circ$ a $2\\alpha=72^\\circ$. Rovnoběžka svírá s jednou z kolmých přímek úhel $72^\\circ$, a proto s druhou (na ni kolmou) přímkou úhel $90^\\circ-72^\\circ=18^\\circ$. Vzhledem k rovnoběžnosti je $\\beta=18^\\circ$, tj. menší než $20^\\circ$.'},
  'A) menší než $20^\\circ$',
  2, 5, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2022 – úloha 13',
  new List<String>{'Kvádr o rozměrech $6$ cm, $4$ cm a $5$ cm jsme dvěma svislými řezy rozdělili na tři kolmé trojboké hranoly. Z těchto trojbokých hranolů vybereme ten, který má největší objem (viz obrázek).','Jaký je objem vybraného trojbokého hranolu?'},
  new List<String>{'A) $40$ cm³','B) $60$ cm³','C) $80$ cm³','D) $120$ cm³','E) jiný objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 300" font-family="sans-serif"> <polygon points="100,120 340,120 340,280 100,280" fill="#c9c9c9" stroke="#000" stroke-width="1.6"/> <polygon points="100,120 170,75 410,75 340,120" fill="#dedede" stroke="#000" stroke-width="1.6"/> <polygon points="340,120 410,75 410,235 340,280" fill="#bdbdbd" stroke="#000" stroke-width="1.6"/> <line x1="100" y1="120" x2="290" y2="75" stroke="#000" stroke-width="1.2" stroke-dasharray="5 4"/> <line x1="340" y1="120" x2="290" y2="75" stroke="#000" stroke-width="1.2" stroke-dasharray="5 4"/> <text x="72" y="205" font-size="15" text-anchor="middle">5 cm</text> <text x="220" y="300" font-size="15" text-anchor="middle">6 cm</text> <text x="392" y="270" font-size="15">4 cm</text> </svg>',
  'kvadr-hranoly.svg',
  'Kvádr 6×4×5 cm rozdělený dvěma svislými řezy na tři trojboké hranoly.',
  'Kvádr rozdělený na tři trojboké hranoly',
  new List<String>{'Podstavou každého hranolu je trojúhelník v obdélníku $6\\times 4$ cm (obsah $24$ cm²), výška hranolů je $5$ cm. Největší podstavu má trojúhelník o obsahu poloviny obdélníku, tj. $12$ cm². Objem $=12\\cdot 5=60$ cm³.'},
  'B) $60$ cm³',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
