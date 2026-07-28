String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M7A 2015 – úloha 7',
  new List<String>{'Na tribuně je 840 sportovních diváků. Dospělých je mezi nimi o 420 více než dětí.','7.1 Vypočtěte, kolik dospělých bylo mezi sportovními diváky.','7.2 Určete v základním tvaru poměr počet dětí : počet dospělých.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet dětí $d$. Pak $d+(d+420)=840$, tedy $2d=420$ a $d=210$ dětí.','7.1 Dospělých je $210+420=630$.','7.2 $210:630=1:3$.'},
  '7.1: $630$ dospělých; 7.2: $1:3$',
  3, 4, '2',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2015 – úloha 8–9',
  new List<String>{'Čtverečkovaný papír tvaru obdélníku je potištěn čarami, které rozdělují plochu na malé čtverečky se stranou délky 0,4 cm. Rozměry papíru jsou 48 cm a 32 cm.','8 Určete počet všech malých čtverečků na čtverečkovaném papíře.','9 Obtažením některých čar je možné celou plochu čtverečkovaného papíru rozdělit na větší shodné čtverce. Určete nejmenší počet shodných čtverců pokrývajících celou plochu papíru.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 330" font-family="sans-serif"><rect x="60" y="40" width="360" height="240" fill="none" stroke="#000" stroke-width="2" stroke-dasharray="10 6"/><rect x="60" y="40" width="110" height="88" fill="#c9c9c9" stroke="#000"/><line x1="60" y1="40" x2="60" y2="128" stroke="#000"/><line x1="82" y1="40" x2="82" y2="128" stroke="#000"/><line x1="104" y1="40" x2="104" y2="128" stroke="#000"/><line x1="126" y1="40" x2="126" y2="128" stroke="#000"/><line x1="148" y1="40" x2="148" y2="128" stroke="#000"/><line x1="170" y1="40" x2="170" y2="128" stroke="#000"/><line x1="60" y1="40" x2="170" y2="40" stroke="#000"/><line x1="60" y1="62" x2="170" y2="62" stroke="#000"/><line x1="60" y1="84" x2="170" y2="84" stroke="#000"/><line x1="60" y1="106" x2="170" y2="106" stroke="#000"/><line x1="60" y1="128" x2="170" y2="128" stroke="#000"/><line x1="52" y1="40" x2="52" y2="62" stroke="#000"/><text x="46" y="56" font-size="13" text-anchor="end">0,4 cm</text><line x1="192" y1="84" x2="236" y2="84" stroke="#000" stroke-width="1.5"/><path d="M236,79 L246,84 L236,89 z" fill="#000"/><line x1="104" y1="150" x2="104" y2="194" stroke="#000" stroke-width="1.5"/><path d="M99,194 L104,204 L109,194 z" fill="#000"/><text x="430" y="160.0" font-size="14">32 cm</text><text x="240.0" y="302" font-size="14" text-anchor="middle">48 cm</text></svg>',
  'ctverecky-papir.svg',
  'Obdélníkový papír o rozměrech 48 cm a 32 cm, v rohu je vyznačena část sítě čtverečků se stranou 0,4 cm.',
  'Čtverečkovaný papír (schematicky)',
  new List<String>{'8 Podél delší strany $48:0{,}4=120$ čtverečků, podél kratší $32:0{,}4=80$ čtverečků. Celkem $120\\cdot 80=9\\,600$ čtverečků.','9 Strana většího čtverce musí dělit 48 i 32; největší taková délka je $D(48;32)=16$ cm.','Papír pak pokryje $(48:16)\\cdot(32:16)=3\\cdot 2=6$ čtverců.'},
  '8: $9\\,600$ malých čtverečků; 9: $6$ shodných čtverců',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
