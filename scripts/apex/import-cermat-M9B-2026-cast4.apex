String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. řádný termín (M9B)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2026 M9B · úloha 10',
  new List<String>{'V rovině leží body $A$, $B$, $D$ (viz obrázek).','Body $A$ a $B$ jsou vrcholy pravoúhlého trojúhelníku $ABC$ s pravým úhlem při vrcholu $C$. Body $B$ a $D$ jsou vrcholy pravoúhlého trojúhelníku $BCD$ s pravým úhlem při vrcholu $C$. (Vrcholy $B$ a $C$ jsou společnými vrcholy obou trojúhelníků.)','Sestrojte vrchol $C$, označte ho písmenem a narýsujte trojúhelníky $ABC$ a $BCD$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 319"><path d="M4 4L5 4L5 23L4 23Z" style="fill:#000000"/><path d="M4 314L5 314L5 315L4 315Z" style="fill:#000000"/><path d="M4 314L5 314L5 315L4 315Z" style="fill:#000000"/><path d="M5 314L467 314L467 315L5 315Z" style="fill:#000000"/><path d="M4 23L5 23L5 314L4 314Z" style="fill:#000000"/><path d="M165 132L171 138M165 138L171 132M335 132L341 138M335 138L341 132M89 272L94 278M89 278L94 272" style="fill:none;stroke:#000000;stroke-width:2"/><text x="55" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží body</text><text x="104" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="110" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="116" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="121" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="128" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="134" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="160" y="137" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="348" y="137" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="90" y="292" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text></svg>',
  'obr.svg',
  'Tři body A, B, D v rovině.',
  '',
  new List<String>{'Pravý úhel u $C$ v trojúhelníku $ABC$ znamená, že $C$ leží na Thaletově kružnici nad průměrem $AB$.','Pravý úhel u $C$ v trojúhelníku $BCD$ znamená, že $C$ leží na Thaletově kružnici nad průměrem $BD$.','Bod $C$ je průsečík obou Thaletových kružnic; ve správném řešení leží $C$ na polopřímce $DA$ a úhel $DCB$ je pravý.'},
  'Bod $C$ je průsečík Thaletových kružnic nad $AB$ a nad $BD$; leží na polopřímce $DA$ a úhel $DCB$ je pravý (viz konstrukce).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PBD26C0T02', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
