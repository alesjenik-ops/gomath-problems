String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD21C0T01';
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
  'CERMAT M9A 2021 – úloha 6',
  new List<String>{'Firma zaměstnává $200$ osob. Během epidemie museli někteří pracovat z domova. Včera byla na pracovišti jedna třetina žen zaměstnaných ve firmě a dvě pětiny mužů zaměstnaných ve firmě, všichni ostatní pracovali z domova.','Počet všech žen zaměstnaných ve firmě označte $x$.','6.1 V závislosti na veličině $x$ vyjádřete počet žen, které byly včera na pracovišti.','6.2 V závislosti na veličině $x$ vyjádřete počet mužů, kteří byli včera na pracovišti.','6.3 Včera bylo na pracovišti celkem $70$ osob zaměstnaných ve firmě. Vypočtěte, kolik žen firma zaměstnává.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Žen na pracovišti byla třetina ze $x$, tj. $\\dfrac{x}{3}$.','6.2 Mužů je $200-x$, na pracovišti byly dvě pětiny, tj. $\\dfrac{2}{5}\\cdot(200-x)$.','6.3 Rovnice $\\dfrac{x}{3}+\\dfrac{2}{5}(200-x)=70$; po vynásobení $15$: $5x+6(200-x)=1\\,050$; $5x+1\\,200-6x=1\\,050$; $-x=-150$; $x=150$.'},
  '6.1: $\\dfrac{x}{3}$; 6.2: $\\dfrac{2}{5}\\cdot(200-x)$; 6.3: $150$ žen',
  3, 6, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2021 – úloha 7',
  new List<String>{'Farmářka chová $3$ koně, ale nemá již pro ně žádné krmivo. Chovatel, který má pro svých $5$ koní krmivo na $120$ dní, farmářce dvě pětiny tohoto krmiva prodá. (Každý kůň spotřebuje za den stejné množství krmiva.)','Vypočtěte, za kolik dní','7.1 by veškeré chovatelovo krmivo spotřebovalo všech $8$ koní společně,','7.2 spotřebují chovatelovi koně krmivo, které chovatel neprodá,','7.3 spotřebují farmářčini koně krmivo, které farmářka zakoupí od chovatele.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Celkové krmivo vystačí $5$ koním na $120$ dní, tj. $5\\cdot 120=600$ krmných dávek (koňodní).','7.1 Všech $8$ koní: $600:8=75$ dní.','7.2 Chovatel neprodá $\\dfrac{3}{5}$ krmiva $=360$ dávek pro své $5$ koně: $360:5=72$ dní.','7.3 Farmářka zakoupí $\\dfrac{2}{5}$ krmiva $=240$ dávek pro své $3$ koně: $240:3=80$ dní.'},
  '7.1: za $75$ dní; 7.2: za $72$ dní; 7.3: za $80$ dní',
  4, 6, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2021 – úloha 8',
  new List<String>{'Síť kolmého čtyřbokého hranolu se skládá ze dvou shodných čtverců a obdélníku s rozměry $40$ cm a $8$ cm (viz náčrt obrysu sítě).','Vypočtěte','8.1 v cm² povrch hranolu,','8.2 v cm³ objem hranolu.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 240" font-family="sans-serif"> <rect x="85" y="101" width="255" height="44" fill="#f4f4f4" stroke="#000" stroke-width="2"/> <rect x="340" y="68" width="55" height="55" fill="#f4f4f4" stroke="#000" stroke-width="2"/> <rect x="340" y="123" width="55" height="55" fill="#f4f4f4" stroke="#000" stroke-width="2"/> <line x1="65" y1="101" x2="65" y2="145" stroke="#444" stroke-width="1"/> <polygon points="65,101 61,109 69,109" fill="#444"/><polygon points="65,145 61,137 69,137" fill="#444"/> <text x="40" y="128" font-size="14">8 cm</text> <line x1="85" y1="205" x2="340" y2="205" stroke="#444" stroke-width="1"/> <polygon points="85,205 93,201 93,209" fill="#444"/><polygon points="340,205 332,201 332,209" fill="#444"/> <text x="188" y="223" font-size="14">40 cm</text> </svg>',
  'sit-hranol.svg',
  'Náčrt obrysu sítě: vodorovný obdélník 40 cm krát 8 cm a na jeho pravém konci dva shodné čtverce (podstavy hranolu).',
  'Náčrt obrysu sítě kolmého čtyřbokého hranolu',
  new List<String>{'Obdélník $40$ cm $\\times$ $8$ cm je plášť hranolu, jeho delší strana je obvod podstavy: $40:4=10$ cm je strana čtvercové podstavy, výška hranolu je $8$ cm.','8.1 Povrch $=2\\cdot 10\\cdot 10+40\\cdot 8=200+320=520$ cm².','8.2 Objem $=10\\cdot 10\\cdot 8=800$ cm³.'},
  '8.1: $520$ cm²; 8.2: $800$ cm³',
  3, 5, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
