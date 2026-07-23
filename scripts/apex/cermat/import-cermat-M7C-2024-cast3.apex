String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD24C0T03';
Integer YEAR = 2024;

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
  'CERMAT M7C 2024 – úloha 6',
  new List<String>{'Rodina Novotných si koupila pozemek ve tvaru obdélníku na stavbu domu. Plocha pozemku je $988$ m² a kratší strana měří $26$ m (viz obrázek). Pozemek chtějí oplotit tak, aby spotřebovali co nejméně sloupků a mezi dvěma sousedními sloupky po celém obvodu byla vždy stejná mezera, kterou lze změřit v celých metrech.','Kolik sloupků musí rodina Novotných koupit, aby bylo možné za uvedených podmínek pozemek oplotit?'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 290" font-family="sans-serif"> <rect x="100" y="55" width="110" height="180" fill="#eeeeee" stroke="#000" stroke-width="2"/> <text x="155" y="45" font-size="15" text-anchor="middle">26 m</text> <text x="155" y="150" font-size="15" text-anchor="middle">988 m²</text> </svg>',
  'pozemek.svg',
  'Obdélníkový pozemek o obsahu 988 m² s kratší stranou 26 m.',
  'Pozemek rodiny Novotných',
  new List<String>{'Delší strana pozemku je $988:26=38$ m, obvod $2\\cdot(26+38)=128$ m. Aby sloupků bylo co nejméně a mezera byla stejná v celých metrech (i v rozích), musí mezera dělit obě strany; největší taková je největší společný dělitel čísel $26$ a $38$, tj. $2$ m. Počet sloupků $128:2=64$.'},
  '$64$ sloupků',
  3, 5, '3',
  new List<String>{'zs2','r7','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2024 – úloha 7',
  new List<String>{'Z kvádru se čtvercovou podstavou byl vyříznut trojboký hranol. Body $S$ a $S^{\\prime}$ jsou průsečíky úhlopříček podstav tohoto kvádru (viz obrázek). Platí $|AB|=8$ cm, $|AE|=1{,}3$ dm.','7.1 Vypočítejte povrch kvádru $ABCDEFGH$. Výsledek uveďte v dm².','7.2 Vypočítejte objem hranolu s podstavou $ABSCD$. Výsledek uveďte v cm³.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif"> <line x1="120" y1="250" x2="280" y2="250" stroke="#000" stroke-width="2"/> <line x1="280" y1="250" x2="280" y2="110" stroke="#000" stroke-width="2"/> <line x1="280" y1="110" x2="120" y2="110" stroke="#000" stroke-width="2"/> <line x1="120" y1="110" x2="120" y2="250" stroke="#000" stroke-width="2"/> <line x1="280" y1="250" x2="338" y2="208" stroke="#000" stroke-width="2"/> <line x1="338" y1="208" x2="338" y2="68" stroke="#000" stroke-width="2"/> <line x1="338" y1="68" x2="280" y2="110" stroke="#000" stroke-width="2"/> <line x1="120" y1="110" x2="178" y2="68" stroke="#000" stroke-width="2"/> <line x1="178" y1="68" x2="338" y2="68" stroke="#000" stroke-width="2"/> <line x1="120" y1="250" x2="178" y2="208" stroke="#555" stroke-width="1" stroke-dasharray="5 4"/> <line x1="178" y1="208" x2="338" y2="208" stroke="#555" stroke-width="1" stroke-dasharray="5 4"/> <line x1="178" y1="208" x2="178" y2="68" stroke="#555" stroke-width="1" stroke-dasharray="5 4"/> <line x1="229" y1="89" x2="280" y2="110" stroke="#000" stroke-width="1.2"/> <line x1="229" y1="89" x2="338" y2="68" stroke="#000" stroke-width="1.2"/> <line x1="229" y1="229" x2="280" y2="250" stroke="#555" stroke-width="1" stroke-dasharray="3 3"/> <line x1="229" y1="229" x2="338" y2="208" stroke="#555" stroke-width="1" stroke-dasharray="3 3"/> <text x="112" y="266" font-size="14" font-style="italic">A</text> <text x="284" y="266" font-size="14" font-style="italic">B</text> <text x="344" y="214" font-size="14" font-style="italic">C</text> <text x="182" y="222" font-size="14" font-style="italic">D</text> <text x="106" y="108" font-size="14" font-style="italic">E</text> <text x="284" y="108" font-size="14" font-style="italic">F</text> <text x="344" y="66" font-size="14" font-style="italic">G</text> <text x="164" y="66" font-size="14" font-style="italic">H</text> <text x="222" y="245" font-size="13" font-style="italic">S</text> <text x="216" y="86" font-size="13" font-style="italic">S´</text> </svg>',
  'kvadr-hranol.svg',
  'Kvádr se čtvercovou podstavou ABCD a horní podstavou EFGH s vyříznutým trojbokým hranolem; S a S´ jsou průsečíky úhlopříček podstav.',
  'Kvádr s vyříznutým trojbokým hranolem (schematický nákres)',
  new List<String>{'Podstava je čtverec se stranou $|AB|=8$ cm $=0{,}8$ dm, výška $|AE|=1{,}3$ dm.','7.1 Povrch $=2\\cdot 0{,}8^2+4\\cdot 0{,}8\\cdot 1{,}3=1{,}28+4{,}16=5{,}44$ dm².','7.2 Vyříznutý trojboký hranol má podstavu (trojúhelník $SBC$) o obsahu $\\frac{1}{2}\\cdot 8\\cdot 4=16$ cm² a výšku $13$ cm, tedy objem $16\\cdot 13=208$ cm³. Hranol s podstavou $ABSCD$ (pětiúhelník) má objem $8\\cdot 8\\cdot 13-208=832-208=624$ cm³.'},
  '7.1: $5{,}44$ dm²; 7.2: $624$ cm³',
  4, 7, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
