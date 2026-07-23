String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD25C0T03';
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
  'CERMAT M7C 2025 – úloha 10',
  new List<String>{'Rodný dům slavného spisovatele je otevřen pouze v letní sezoně od května do září. V pokladně zaznamenávají počet prodaných vstupenek dětským a dospělým návštěvníkům. V grafu je uvedena návštěvnost v jedné sezoně (Květen: děti 30, dospělí 80; Červen: 10, 60; Červenec: 30, 70; Srpen: 50, 90; Září: 40, 100).','Rozhodněte o každém z následujících tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).','10.1 V prvních třech měsících sezony bylo mezi návštěvníky rodného domu třikrát více dospělých než dětí.','10.2 Za celou sezonu bylo dospělých návštěvníků rodného domu průměrně 80 za měsíc.','10.3 Za celou sezonu tvořily děti 40 % všech návštěvníků rodného domu.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 490 300" font-family="sans-serif"><line x1="62" y1="30" x2="62" y2="260" stroke="#000"/><line x1="62" y1="260" x2="450" y2="260" stroke="#000"/><line x1="58" y1="260.0" x2="62" y2="260.0" stroke="#000"/><text x="54" y="264.0" font-size="10" text-anchor="end">0</text><line x1="58" y1="240.0" x2="62" y2="240.0" stroke="#000"/><text x="54" y="244.0" font-size="10" text-anchor="end">10</text><line x1="58" y1="220.0" x2="62" y2="220.0" stroke="#000"/><text x="54" y="224.0" font-size="10" text-anchor="end">20</text><line x1="58" y1="200.0" x2="62" y2="200.0" stroke="#000"/><text x="54" y="204.0" font-size="10" text-anchor="end">30</text><line x1="58" y1="180.0" x2="62" y2="180.0" stroke="#000"/><text x="54" y="184.0" font-size="10" text-anchor="end">40</text><line x1="58" y1="160.0" x2="62" y2="160.0" stroke="#000"/><text x="54" y="164.0" font-size="10" text-anchor="end">50</text><line x1="58" y1="140.0" x2="62" y2="140.0" stroke="#000"/><text x="54" y="144.0" font-size="10" text-anchor="end">60</text><line x1="58" y1="120.0" x2="62" y2="120.0" stroke="#000"/><text x="54" y="124.0" font-size="10" text-anchor="end">70</text><line x1="58" y1="100.0" x2="62" y2="100.0" stroke="#000"/><text x="54" y="104.0" font-size="10" text-anchor="end">80</text><line x1="58" y1="80.0" x2="62" y2="80.0" stroke="#000"/><text x="54" y="84.0" font-size="10" text-anchor="end">90</text><line x1="58" y1="60.0" x2="62" y2="60.0" stroke="#000"/><text x="54" y="64.0" font-size="10" text-anchor="end">100</text><line x1="58" y1="40.0" x2="62" y2="40.0" stroke="#000"/><text x="54" y="44.0" font-size="10" text-anchor="end">110</text><rect x="84" y="200.0" width="20" height="60.0" fill="#555" stroke="#000"/><rect x="104" y="100.0" width="20" height="160.0" fill="#dddddd" stroke="#000"/><text x="104" y="274" font-size="10" text-anchor="middle">Květen</text><rect x="146" y="240.0" width="20" height="20.0" fill="#555" stroke="#000"/><rect x="166" y="140.0" width="20" height="120.0" fill="#dddddd" stroke="#000"/><text x="166" y="274" font-size="10" text-anchor="middle">Červen</text><rect x="208" y="200.0" width="20" height="60.0" fill="#555" stroke="#000"/><rect x="228" y="120.0" width="20" height="140.0" fill="#dddddd" stroke="#000"/><text x="228" y="274" font-size="10" text-anchor="middle">Červenec</text><rect x="270" y="160.0" width="20" height="100.0" fill="#555" stroke="#000"/><rect x="290" y="80.0" width="20" height="180.0" fill="#dddddd" stroke="#000"/><text x="290" y="274" font-size="10" text-anchor="middle">Srpen</text><rect x="332" y="180.0" width="20" height="80.0" fill="#555" stroke="#000"/><rect x="352" y="60.0" width="20" height="200.0" fill="#dddddd" stroke="#000"/><text x="352" y="274" font-size="10" text-anchor="middle">Září</text><rect x="378" y="42" width="12" height="12" fill="#555" stroke="#000"/><text x="396" y="52" font-size="11">Děti</text><rect x="378" y="60" width="12" height="12" fill="#dddddd" stroke="#000"/><text x="396" y="70" font-size="11">Dospělí</text><text x="18" y="150" font-size="10" text-anchor="middle" transform="rotate(-90 18 150)">Počet prodaných vstupenek</text></svg>',
  'graf-navstevnost.svg',
  'Skupinový sloupcový graf prodaných vstupenek pro děti a dospělé za měsíce květen až září.',
  'Prodané vstupenky v jednotlivých měsících',
  new List<String>{'10.1 První tři měsíce: děti $30+10+30=70$, dospělí $80+60+70=210=3\\cdot 70$. Pravda → Ano.','10.2 Dospělí celkem $80+60+70+90+100=400$; průměr $400:5=80$. Pravda → Ano.','10.3 Děti celkem $160$, dospělí $400$, všichni $560$; podíl dětí $\\frac{160}{560}\\approx 28{,}6\\,\\%$, ne $40\\,\\%$ → Ne.'},
  '10.1: Ano; 10.2: Ano; 10.3: Ne',
  4, 6, '3',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
