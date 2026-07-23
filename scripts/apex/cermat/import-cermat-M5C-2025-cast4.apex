String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD25C0T03';
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
  'CERMAT M5C 2025 – úloha 8',
  new List<String>{'Rodný dům slavného spisovatele je otevřen pouze v letní sezoně od května do září. V pokladně zaznamenávají počet prodaných vstupenek dětským a dospělým návštěvníkům. V grafu je uvedena návštěvnost v jedné sezoně (počet prodaných vstupenek): Květen – děti 30, dospělí 80; Červen – děti 10, dospělí 60; Červenec – děti 30, dospělí 70; Srpen – děti 50, dospělí 90; Září – děti 40, dospělí 100.','Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 V prvních třech měsících sezony bylo mezi návštěvníky rodného domu třikrát více dospělých než dětí.','8.2 Dospělých návštěvníků rodného domu bylo v srpnu o polovinu více než v červnu.','8.3 Za celou sezonu bylo dětských návštěvníků rodného domu o 340 méně než dospělých.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 350" font-family="sans-serif"><line x1="60" y1="40" x2="60" y2="300" stroke="#000"/><line x1="60" y1="300" x2="620" y2="300" stroke="#000"/><line x1="56" y1="300" x2="60" y2="300" stroke="#000"/><text x="52" y="304" font-size="10" text-anchor="end">0</text><line x1="56" y1="278" x2="60" y2="278" stroke="#000"/><text x="52" y="282" font-size="10" text-anchor="end">10</text><line x1="56" y1="256" x2="60" y2="256" stroke="#000"/><text x="52" y="260" font-size="10" text-anchor="end">20</text><line x1="56" y1="234" x2="60" y2="234" stroke="#000"/><text x="52" y="238" font-size="10" text-anchor="end">30</text><line x1="56" y1="212" x2="60" y2="212" stroke="#000"/><text x="52" y="216" font-size="10" text-anchor="end">40</text><line x1="56" y1="190" x2="60" y2="190" stroke="#000"/><text x="52" y="194" font-size="10" text-anchor="end">50</text><line x1="56" y1="168" x2="60" y2="168" stroke="#000"/><text x="52" y="172" font-size="10" text-anchor="end">60</text><line x1="56" y1="146" x2="60" y2="146" stroke="#000"/><text x="52" y="150" font-size="10" text-anchor="end">70</text><line x1="56" y1="124" x2="60" y2="124" stroke="#000"/><text x="52" y="128" font-size="10" text-anchor="end">80</text><line x1="56" y1="102" x2="60" y2="102" stroke="#000"/><text x="52" y="106" font-size="10" text-anchor="end">90</text><line x1="56" y1="80" x2="60" y2="80" stroke="#000"/><text x="52" y="84" font-size="10" text-anchor="end">100</text><line x1="56" y1="58" x2="60" y2="58" stroke="#000"/><text x="52" y="62" font-size="10" text-anchor="end">110</text><rect x="88" y="234" width="24" height="66" fill="#555" stroke="#000"/><rect x="112" y="124" width="24" height="176" fill="#dddddd" stroke="#000"/><text x="112" y="316" font-size="11" text-anchor="middle">Květen</text><rect x="200" y="278" width="24" height="22" fill="#555" stroke="#000"/><rect x="224" y="168" width="24" height="132" fill="#dddddd" stroke="#000"/><text x="224" y="316" font-size="11" text-anchor="middle">Červen</text><rect x="312" y="234" width="24" height="66" fill="#555" stroke="#000"/><rect x="336" y="146" width="24" height="154" fill="#dddddd" stroke="#000"/><text x="336" y="316" font-size="11" text-anchor="middle">Červenec</text><rect x="424" y="190" width="24" height="110" fill="#555" stroke="#000"/><rect x="448" y="102" width="24" height="198" fill="#dddddd" stroke="#000"/><text x="448" y="316" font-size="11" text-anchor="middle">Srpen</text><rect x="536" y="212" width="24" height="88" fill="#555" stroke="#000"/><rect x="560" y="80" width="24" height="220" fill="#dddddd" stroke="#000"/><text x="560" y="316" font-size="11" text-anchor="middle">Září</text><rect x="560" y="120" width="14" height="14" fill="#555" stroke="#000"/><text x="580" y="132" font-size="12">Děti</text><rect x="560" y="142" width="14" height="14" fill="#dddddd" stroke="#000"/><text x="580" y="154" font-size="12">Dospělí</text><text x="20" y="175" font-size="11" text-anchor="middle" transform="rotate(-90 20 175)">Počet prodaných vstupenek</text></svg>',
  'graf-navstevnost.svg',
  'Skupinový sloupcový graf počtu prodaných vstupenek (děti a dospělí) v květnu až září.',
  'Návštěvnost rodného domu v jedné sezoně (počet vstupenek)',
  new List<String>{'8.1 První tři měsíce: dětí $30+10+30=70$, dospělých $80+60+70=210$; $210=3\\cdot 70$ – tvrzení platí (Ano).','8.2 V srpnu bylo dospělých $90$, v červnu $60$; $90=60+\\frac{1}{2}\\cdot 60$, tj. o polovinu více – tvrzení platí (Ano).','8.3 Za celou sezonu dětí $30+10+30+50+40=160$, dospělých $80+60+70+90+100=400$; rozdíl $400-160=240$, nikoli $340$ – tvrzení neplatí (Ne).'},
  '8.1: Ano; 8.2: Ano; 8.3: Ne',
  4, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
