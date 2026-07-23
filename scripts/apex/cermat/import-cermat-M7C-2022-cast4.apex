String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD22C0T03';
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
  'CERMAT M7C 2022 – úloha 10',
  new List<String>{'Zahrádkář zakoupil několik kusů rostlin od každého ze čtyř druhů $A$, $B$, $C$ a $D$. Některé zakoupené rostliny uschly, ostatní vzrostly. Většinu vzrostlých rostlin zahrádkář později prodal. Graf udává počty zakoupených, vzrostlých a prodaných kusů rostlin jednotlivých druhů.','Rozhodněte o každém z tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).','10.1 Zahrádkáři zůstalo celkem $9$ neprodaných kusů vzrostlých rostlin.','10.2 Zahrádkář zakoupil o polovinu více kusů rostlin, než jich prodal.','10.3 Zahrádkář prodal všechny zakoupené kusy jen u jednoho druhu rostlin.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 372" font-family="sans-serif"><defs><pattern id="dot" width="6" height="6" patternUnits="userSpaceOnUse"><rect width="6" height="6" fill="#fff"/><circle cx="3" cy="3" r="1" fill="#000"/></pattern><pattern id="hatch" width="6" height="6" patternUnits="userSpaceOnUse"><rect width="6" height="6" fill="#fff"/><path d="M0,6 L6,0" stroke="#000" stroke-width="1"/></pattern></defs><line x1="62" y1="34" x2="62" y2="300" stroke="#000"/><line x1="62" y1="300" x2="520" y2="300" stroke="#000"/><line x1="58" y1="300" x2="62" y2="300" stroke="#000"/><text x="54" y="304" font-size="11" text-anchor="end">0</text><line x1="58" y1="270" x2="62" y2="270" stroke="#000"/><text x="54" y="274" font-size="11" text-anchor="end">2</text><line x1="58" y1="240" x2="62" y2="240" stroke="#000"/><text x="54" y="244" font-size="11" text-anchor="end">4</text><line x1="58" y1="210" x2="62" y2="210" stroke="#000"/><text x="54" y="214" font-size="11" text-anchor="end">6</text><line x1="58" y1="180" x2="62" y2="180" stroke="#000"/><text x="54" y="184" font-size="11" text-anchor="end">8</text><line x1="58" y1="150" x2="62" y2="150" stroke="#000"/><text x="54" y="154" font-size="11" text-anchor="end">10</text><line x1="58" y1="120" x2="62" y2="120" stroke="#000"/><text x="54" y="124" font-size="11" text-anchor="end">12</text><line x1="58" y1="90" x2="62" y2="90" stroke="#000"/><text x="54" y="94" font-size="11" text-anchor="end">14</text><line x1="58" y1="60" x2="62" y2="60" stroke="#000"/><text x="54" y="64" font-size="11" text-anchor="end">16</text><text x="20" y="170" font-size="12" text-anchor="middle" transform="rotate(-90 20 170)">počet kusů rostlin</text><rect x="92" y="90" width="17" height="210" fill="url(#dot)" stroke="#000"/><rect x="112" y="120" width="17" height="180" fill="#9a9a9a" stroke="#000"/><rect x="132" y="195" width="17" height="105" fill="url(#hatch)" stroke="#000"/><text x="120" y="318" font-size="13" text-anchor="middle">A</text><rect x="182" y="165" width="17" height="135" fill="url(#dot)" stroke="#000"/><rect x="202" y="165" width="17" height="135" fill="#9a9a9a" stroke="#000"/><rect x="222" y="165" width="17" height="135" fill="url(#hatch)" stroke="#000"/><text x="210" y="318" font-size="13" text-anchor="middle">B</text><rect x="272" y="180" width="17" height="120" fill="url(#dot)" stroke="#000"/><rect x="292" y="180" width="17" height="120" fill="#9a9a9a" stroke="#000"/><rect x="312" y="240" width="17" height="60" fill="url(#hatch)" stroke="#000"/><text x="300" y="318" font-size="13" text-anchor="middle">C</text><rect x="362" y="135" width="17" height="165" fill="url(#dot)" stroke="#000"/><rect x="382" y="180" width="17" height="120" fill="#9a9a9a" stroke="#000"/><rect x="402" y="180" width="17" height="120" fill="url(#hatch)" stroke="#000"/><text x="390" y="318" font-size="13" text-anchor="middle">D</text><rect x="90" y="339" width="13" height="13" fill="url(#dot)" stroke="#000"/><text x="108" y="350" font-size="12">zakoupené</text><rect x="215" y="339" width="13" height="13" fill="#9a9a9a" stroke="#000"/><text x="233" y="350" font-size="12">vzrostlé</text><rect x="330" y="339" width="13" height="13" fill="url(#hatch)" stroke="#000"/><text x="348" y="350" font-size="12">prodané</text></svg>',
  'graf-rostliny.svg',
  'Skupinový sloupcový graf počtu zakoupených, vzrostlých a prodaných kusů rostlin druhů A, B, C, D.',
  'Počty rostlin podle druhů (kusy)',
  new List<String>{'Z grafu: $A$ – zakoupené $14$, vzrostlé $12$, prodané $7$; $B$ – $9$, $9$, $9$; $C$ – $8$, $8$, $4$; $D$ – $11$, $8$, $8$.','10.1 Neprodané vzrostlé: $(12-7)+(9-9)+(8-4)+(8-8)=5+0+4+0=9$ → Ano.','10.2 Zakoupených $14+9+8+11=42$, prodaných $7+9+4+8=28$; $42=1{,}5\\cdot 28$, tj. o polovinu více → Ano.','10.3 Prodané se rovnají zakoupeným jen u druhu $B$ ($9=9$) → Ano.'},
  '10.1: Ano; 10.2: Ano; 10.3: Ano',
  4, 5, '3',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
