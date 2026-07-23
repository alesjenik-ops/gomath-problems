String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD23C0T03';
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
  'CERMAT M7C 2023 - uloha 16',
  new List<String>{'Kazdy obrazec tvaru obdelniku je slozen z malych sedych ctverecku a vetsich bilych ctverecku. Vsechny sede ctverecky jsou stejne a jsou poskladany do spodni rady a do leveho sloupce. Zbytek obrazce tvori bile ctverecky. Kazdy bily ctverecek ma dvakrat delsi stranu nez sedy. Prvni obrazec ma ve spodni rade $5$ sedych ctverecku a v levem sloupci $3$ sede ctverecky. Sklada se celkem z $9$ ctverecku (bilych i sedych dohromady). Kazdy dalsi obrazec ma oproti predchozimu vzdy o $2$ sede ctverecky vice jak ve spodni rade, tak i v levem sloupci.','16.1 Obrazec ma ve spodni rade $41$ sedych ctverecku. Urcete pocet bilych ctverecku v obrazci.','16.2 V obrazci je $90$ bilych ctverecku. Urcete pocet sedych ctverecku v obrazci.','16.3 Pocet vsech ctverecku (bilych i sedych dohromady) v poslednim a v predposlednim obrazci se lisi o $106$. Urcete pocet sedych ctverecku v poslednim obrazci.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 180" font-family="sans-serif"><rect x="48" y="86" width="36" height="36" fill="#fff" stroke="#000" stroke-width="1.2"/><rect x="84" y="86" width="36" height="36" fill="#fff" stroke="#000" stroke-width="1.2"/><rect x="30" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="48" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="66" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="84" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="102" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="30" y="86" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="30" y="104" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="30" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><text x="75" y="158" font-size="12" text-anchor="middle">1. obrazec</text><rect x="218" y="50" width="36" height="36" fill="#fff" stroke="#000" stroke-width="1.2"/><rect x="218" y="86" width="36" height="36" fill="#fff" stroke="#000" stroke-width="1.2"/><rect x="254" y="50" width="36" height="36" fill="#fff" stroke="#000" stroke-width="1.2"/><rect x="254" y="86" width="36" height="36" fill="#fff" stroke="#000" stroke-width="1.2"/><rect x="290" y="50" width="36" height="36" fill="#fff" stroke="#000" stroke-width="1.2"/><rect x="290" y="86" width="36" height="36" fill="#fff" stroke="#000" stroke-width="1.2"/><rect x="200" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="218" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="236" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="254" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="272" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="290" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="308" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="200" y="50" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="200" y="68" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="200" y="86" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="200" y="104" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><rect x="200" y="122" width="18" height="18" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/><text x="263" y="158" font-size="12" text-anchor="middle">2. obrazec</text><text x="410" y="115" font-size="22">...</text></svg>',
  'obrazce-ctverecky.svg',
  'Prvni obrazec (spodni rada 5, levy sloupec 3) a druhy obrazec (spodni rada 7, levy sloupec 5) ze sedych a bilych ctverecku.',
  '1. a 2. obrazec (schematicky nakres)',
  new List<String>{'V $n$-tem obrazci ma spodni rada $2n+3$ sedych a levy sloupec $2n+1$ sedych ctverecku; sedych je celkem $(2n+3)+(2n+1)-1=4n+3$. Bile ctverecky vyplnuji obdelnik o rozmerech $(2n+2)\\times 2n$ malych ctverecku, tj. $(n+1)\\cdot n$ bilych ctverecku. Vsech ctverecku je $(4n+3)+(n^2+n)=n^2+5n+3$.','16.1 Ze spodni rady $2n+3=41$ plyne $n=19$; bilych je $(n+1)\\cdot n=20\\cdot 19=380$.','16.2 Bilych $(n+1)\\cdot n=90$ dava $n=9$ (protoze $10\\cdot 9=90$); sedych je $4n+3=4\\cdot 9+3=39$.','16.3 Rozdil poctu vsech ctverecku posledniho a predposledniho obrazce je $(n^2+5n+3)-((n-1)^2+5(n-1)+3)=2n+4$. Z $2n+4=106$ plyne $n=51$; sedych je $4\\cdot 51+3=207$.'},
  '16.1: $380$ bilych ctverecku; 16.2: $39$ sedych ctverecku; 16.3: $207$ sedych ctverecku',
  4, 8, '4',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
