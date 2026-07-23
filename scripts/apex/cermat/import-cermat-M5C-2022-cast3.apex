String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD22C0T03';
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
  'CERMAT M5C 2022 – úloha 8',
  new List<String>{'Zahrádkář zakoupil několik kusů rostlin od každého ze čtyř druhů $A$, $B$, $C$ a $D$. Některé zakoupené rostliny uschly, ostatní vzrostly. Většinu vzrostlých rostlin zahrádkář později prodal. Graf udává počty zakoupených, vzrostlých a prodaných kusů rostlin jednotlivých druhů.','Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Zahrádkáři zůstalo celkem $9$ neprodaných kusů vzrostlých rostlin.','8.2 Zahrádkář zakoupil o polovinu více kusů rostlin, než jich prodal.','8.3 Zahrádkář prodal všechny zakoupené kusy jen u jednoho druhu rostlin.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 350" font-family="sans-serif"><line x1="70" y1="40" x2="70" y2="280" stroke="#000"/><line x1="70" y1="280" x2="520" y2="280" stroke="#000"/><line x1="66" y1="280.0" x2="70" y2="280.0" stroke="#000"/><text x="62" y="284.0" font-size="11" text-anchor="end">0</text><line x1="66" y1="252.0" x2="70" y2="252.0" stroke="#000"/><text x="62" y="256.0" font-size="11" text-anchor="end">2</text><line x1="66" y1="224.0" x2="70" y2="224.0" stroke="#000"/><text x="62" y="228.0" font-size="11" text-anchor="end">4</text><line x1="66" y1="196.0" x2="70" y2="196.0" stroke="#000"/><text x="62" y="200.0" font-size="11" text-anchor="end">6</text><line x1="66" y1="168.0" x2="70" y2="168.0" stroke="#000"/><text x="62" y="172.0" font-size="11" text-anchor="end">8</text><line x1="66" y1="140.0" x2="70" y2="140.0" stroke="#000"/><text x="62" y="144.0" font-size="11" text-anchor="end">10</text><line x1="66" y1="112.0" x2="70" y2="112.0" stroke="#000"/><text x="62" y="116.0" font-size="11" text-anchor="end">12</text><line x1="66" y1="84.0" x2="70" y2="84.0" stroke="#000"/><text x="62" y="88.0" font-size="11" text-anchor="end">14</text><line x1="66" y1="56.0" x2="70" y2="56.0" stroke="#000"/><text x="62" y="60.0" font-size="11" text-anchor="end">16</text><text x="26" y="150" font-size="12" text-anchor="middle" transform="rotate(-90 26 150)">počet kusů rostlin</text><defs><pattern id="hatch" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><rect width="6" height="6" fill="#ffffff"/><line x1="0" y1="0" x2="0" y2="6" stroke="#555" stroke-width="2"/></pattern></defs><rect x="100" y="84.0" width="16" height="196.0" fill="#ffffff" stroke="#000"/><rect x="119" y="112.0" width="16" height="168.0" fill="#8a8a8a" stroke="#000"/><rect x="138" y="182.0" width="16" height="98.0" fill="url(#hatch)" stroke="#000"/><text x="127.0" y="296" font-size="12" text-anchor="middle">A</text><rect x="187" y="154.0" width="16" height="126.0" fill="#ffffff" stroke="#000"/><rect x="206" y="154.0" width="16" height="126.0" fill="#8a8a8a" stroke="#000"/><rect x="225" y="154.0" width="16" height="126.0" fill="url(#hatch)" stroke="#000"/><text x="214.0" y="296" font-size="12" text-anchor="middle">B</text><rect x="274" y="168.0" width="16" height="112.0" fill="#ffffff" stroke="#000"/><rect x="293" y="168.0" width="16" height="112.0" fill="#8a8a8a" stroke="#000"/><rect x="312" y="224.0" width="16" height="56.0" fill="url(#hatch)" stroke="#000"/><text x="301.0" y="296" font-size="12" text-anchor="middle">C</text><rect x="361" y="126.0" width="16" height="154.0" fill="#ffffff" stroke="#000"/><rect x="380" y="168.0" width="16" height="112.0" fill="#8a8a8a" stroke="#000"/><rect x="399" y="168.0" width="16" height="112.0" fill="url(#hatch)" stroke="#000"/><text x="388.0" y="296" font-size="12" text-anchor="middle">D</text><rect x="150" y="320" width="12" height="12" fill="#ffffff" stroke="#000"/><text x="168" y="331" font-size="11">zakoupené</text><rect x="255" y="320" width="12" height="12" fill="#8a8a8a" stroke="#000"/><text x="273" y="331" font-size="11">vzrostlé</text><rect x="350" y="320" width="12" height="12" fill="url(#hatch)" stroke="#000"/><text x="368" y="331" font-size="11">prodané</text></svg>',
  'graf-rostliny.svg',
  'Skupinový sloupcový graf: pro druhy A, B, C, D počty zakoupených, vzrostlých a prodaných kusů rostlin.',
  'Počty zakoupených, vzrostlých a prodaných kusů rostlin jednotlivých druhů',
  new List<String>{'Z grafu: A $(14; 12; 7)$, B $(9; 9; 9)$, C $(8; 8; 4)$, D $(11; 8; 8)$ (zakoupené; vzrostlé; prodané).','8.1 Neprodané vzrostlé: $(12-7)+(9-9)+(8-4)+(8-8)=5+0+4+0=9$ → Ano.','8.2 Zakoupené celkem $14+9+8+11=42$, prodané $7+9+4+8=28$; $28 \\cdot 1{,}5 = 42$ → Ano.','8.3 Prodané $=$ zakoupené jen u druhu B ($9=9$) → Ano.'},
  '8.1: Ano; 8.2: Ano; 8.3: Ano',
  4, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
