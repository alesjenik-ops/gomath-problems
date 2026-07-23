String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD24C0T02';
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
  'CERMAT M7B 2024 - uloha 9',
  new List<String>{'V grafu je uveden pocet chlapcu a pocet divek podle rocniku ZS, jehoz jsou zaky.','9.1 Kolik zaku celkem navstevuje druhy stupen ZS?','9.2 Kolik procent zaku druheho stupne ZS tvori divky?','9.3 Jakou cast zaku druheho stupne tvori zaci $9.$ rocniku? Vysledek vyjadrete zlomkem v zakladnim tvaru.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 340" font-family="sans-serif"><line x1="60" y1="40" x2="60" y2="300" stroke="#000"/><line x1="60" y1="300" x2="500" y2="300" stroke="#000"/><line x1="56" y1="300" x2="60" y2="300" stroke="#000"/><text x="52" y="304" font-size="11" text-anchor="end">0</text><line x1="56" y1="260" x2="60" y2="260" stroke="#000"/><text x="52" y="264" font-size="11" text-anchor="end">5</text><line x1="56" y1="220" x2="60" y2="220" stroke="#000"/><text x="52" y="224" font-size="11" text-anchor="end">10</text><line x1="56" y1="180" x2="60" y2="180" stroke="#000"/><text x="52" y="184" font-size="11" text-anchor="end">15</text><line x1="56" y1="140" x2="60" y2="140" stroke="#000"/><text x="52" y="144" font-size="11" text-anchor="end">20</text><line x1="56" y1="100" x2="60" y2="100" stroke="#000"/><text x="52" y="104" font-size="11" text-anchor="end">25</text><line x1="56" y1="60" x2="60" y2="60" stroke="#000"/><text x="52" y="64" font-size="11" text-anchor="end">30</text><rect x="84" y="108" width="26" height="192" fill="#b8b8b8" stroke="#000"/><rect x="114" y="132" width="26" height="168" fill="#fff" stroke="#000"/><text x="112" y="316" font-size="11" text-anchor="middle">6. rocnik</text><rect x="194" y="116" width="26" height="184" fill="#b8b8b8" stroke="#000"/><rect x="224" y="84" width="26" height="216" fill="#fff" stroke="#000"/><text x="222" y="316" font-size="11" text-anchor="middle">7. rocnik</text><rect x="304" y="100" width="26" height="200" fill="#b8b8b8" stroke="#000"/><rect x="334" y="100" width="26" height="200" fill="#fff" stroke="#000"/><text x="332" y="316" font-size="11" text-anchor="middle">8. rocnik</text><rect x="414" y="116" width="26" height="184" fill="#b8b8b8" stroke="#000"/><rect x="444" y="124" width="26" height="176" fill="#fff" stroke="#000"/><text x="442" y="316" font-size="11" text-anchor="middle">9. rocnik</text><rect x="330" y="16" width="12" height="12" fill="#b8b8b8" stroke="#000"/><text x="348" y="26" font-size="11">Chlapci</text><rect x="410" y="16" width="12" height="12" fill="#fff" stroke="#000"/><text x="428" y="26" font-size="11">Divky</text></svg>',
  'graf-rocniky.svg',
  'Sloupcovy graf: pocet chlapcu a divek v 6. az 9. rocniku (chlapci 24, 23, 25, 23; divky 21, 27, 25, 22).',
  'Pocet chlapcu a divek podle rocniku',
  new List<String>{'Pocty zaku: $6.$ rocnik $24+21=45$, $7.$ rocnik $23+27=50$, $8.$ rocnik $25+25=50$, $9.$ rocnik $23+22=45$.','9.1 Celkem $45+50+50+45 = 190$ zaku.','9.2 Divek je $21+27+25+22 = 95$, coz je $\\frac{95}{190} = 50\\,\\%$.','9.3 Zaku $9.$ rocniku je $45$, tedy $\\frac{45}{190} = \\frac{9}{38}$.'},
  '9.1: $190$ zaku; 9.2: $50\\,\\%$; 9.3: $\\frac{9}{38}$',
  3, 5, '2',
  new List<String>{'zs2','r7','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
