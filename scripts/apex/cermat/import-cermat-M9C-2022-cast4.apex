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
  'CERMAT M9C 2022 – úloha 11',
  new List<String>{'Zahrádkář zakoupil několik kusů rostlin od každého ze čtyř druhů A, B, C a D. Některé zakoupené rostliny uschly, ostatní vzrostly. Většinu vzrostlých rostlin zahrádkář později prodal. Graf udává počty zakoupených, vzrostlých a prodaných kusů rostlin jednotlivých druhů.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 Zahrádkáři zůstalo celkem 9 neprodaných kusů vzrostlých rostlin.','11.2 Zahrádkář zakoupil o polovinu více kusů rostlin, než jich prodal.','11.3 Zahrádkář prodal všechny zakoupené kusy jen u jednoho druhu rostlin.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 360" font-family="sans-serif"><defs><pattern id="d" width="6" height="6" patternUnits="userSpaceOnUse"><circle cx="3" cy="3" r="1.1" fill="#000"/></pattern><pattern id="h" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><line x1="0" y1="0" x2="0" y2="6" stroke="#000" stroke-width="1.3"/></pattern></defs><line x1="70" y1="55" x2="70" y2="300" stroke="#000"/><line x1="70" y1="300" x2="515" y2="300" stroke="#000"/><line x1="66" y1="300" x2="70" y2="300" stroke="#000"/><text x="62" y="304" font-size="11" text-anchor="end">0</text><line x1="66" y1="272" x2="70" y2="272" stroke="#000"/><text x="62" y="276" font-size="11" text-anchor="end">2</text><line x1="66" y1="244" x2="70" y2="244" stroke="#000"/><text x="62" y="248" font-size="11" text-anchor="end">4</text><line x1="66" y1="216" x2="70" y2="216" stroke="#000"/><text x="62" y="220" font-size="11" text-anchor="end">6</text><line x1="66" y1="188" x2="70" y2="188" stroke="#000"/><text x="62" y="192" font-size="11" text-anchor="end">8</text><line x1="66" y1="160" x2="70" y2="160" stroke="#000"/><text x="62" y="164" font-size="11" text-anchor="end">10</text><line x1="66" y1="132" x2="70" y2="132" stroke="#000"/><text x="62" y="136" font-size="11" text-anchor="end">12</text><line x1="66" y1="104" x2="70" y2="104" stroke="#000"/><text x="62" y="108" font-size="11" text-anchor="end">14</text><line x1="66" y1="76" x2="70" y2="76" stroke="#000"/><text x="62" y="80" font-size="11" text-anchor="end">16</text><text x="24" y="175" font-size="12" text-anchor="middle" transform="rotate(-90 24 175)">pocet kusu rostlin</text><rect x="100" y="104" width="15" height="196" fill="url(#d)" stroke="#000"/><rect x="118" y="132" width="15" height="168" fill="#8a8a8a" stroke="#000"/><rect x="136" y="202" width="15" height="98" fill="url(#h)" stroke="#000"/><text x="125.5" y="318" font-size="14" text-anchor="middle">A</text><rect x="210" y="174" width="15" height="126" fill="url(#d)" stroke="#000"/><rect x="228" y="174" width="15" height="126" fill="#8a8a8a" stroke="#000"/><rect x="246" y="174" width="15" height="126" fill="url(#h)" stroke="#000"/><text x="235.5" y="318" font-size="14" text-anchor="middle">B</text><rect x="320" y="188" width="15" height="112" fill="url(#d)" stroke="#000"/><rect x="338" y="188" width="15" height="112" fill="#8a8a8a" stroke="#000"/><rect x="356" y="244" width="15" height="56" fill="url(#h)" stroke="#000"/><text x="345.5" y="318" font-size="14" text-anchor="middle">C</text><rect x="430" y="146" width="15" height="154" fill="url(#d)" stroke="#000"/><rect x="448" y="188" width="15" height="112" fill="#8a8a8a" stroke="#000"/><rect x="466" y="188" width="15" height="112" fill="url(#h)" stroke="#000"/><text x="455.5" y="318" font-size="14" text-anchor="middle">D</text><rect x="120" y="336" width="14" height="12" fill="url(#d)" stroke="#000"/><text x="138" y="346" font-size="12">zakoupené</text><rect x="265" y="336" width="14" height="12" fill="#8a8a8a" stroke="#000"/><text x="283" y="346" font-size="12">vzrostlé</text><rect x="400" y="336" width="14" height="12" fill="url(#h)" stroke="#000"/><text x="418" y="346" font-size="12">prodané</text></svg>',
  'graf-rostliny.svg',
  'Skupinový sloupcový graf – zakoupené, vzrostlé a prodané kusy rostlin druhů A, B, C, D.',
  'Počty zakoupených, vzrostlých a prodaných kusů rostlin',
  new List<String>{'Z grafu: A – zakoupené 14, vzrostlé 12, prodané 7; B – 9, 9, 9; C – 8, 8, 4; D – 11, 8, 8.','11.1 Neprodané vzrostlé $(12-7)+(9-9)+(8-4)+(8-8)=5+0+4+0=9$. Pravdivé (A).','11.2 Zakoupeno $14+9+8+11=42$, prodáno $7+9+4+8=28$; $42=1{,}5\\cdot 28$, tedy o polovinu více. Pravdivé (A).','11.3 Prodané se rovnají zakoupeným jen u druhu B ($9=9$). Pravdivé (A).'},
  '11.1: Ano; 11.2: Ano; 11.3: Ano',
  4, 5, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
