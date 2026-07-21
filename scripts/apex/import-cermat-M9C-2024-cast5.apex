String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 1. náhradní termín (M9C)';
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
  'CERMAT 2024 M9C · úloha 9',
  new List<String>{'V rovině leží bod $E$ a kružnice $k$ se středem $S$, procházející bodem $A$. Bod $A$ je vrchol pravoúhlého lichoběžníku $ABCD$ se základnami $AB$, $CD$ a pravým úhlem při vrcholu $A$. Vrcholy $C$, $D$ leží na kružnici $k$, bod $E$ je střed ramene $BC$ (viz obrázek).','Sestrojte zbývající vrcholy $B$, $C$, $D$ lichoběžníku $ABCD$, označte je a lichoběžník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 516 427"><path d="M4 4L5 4L5 423L4 423Z" style="fill:#000000"/><path d="M456 4L458 4L458 423L456 423Z" style="fill:#000000"/><path d="M146 245L157 245L157 255L146 255Z" style="fill:#ffffff"/><path d="M149 247L155 253M155 247L149 253M272 229L278 236M278 229L272 236" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M268 228L279 228L279 238L268 238Z" style="fill:#ffffff"/><text x="53" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží bod</text><text x="98" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">E</text><text x="129" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a kružnice</text><text x="160" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">k</text><text x="192" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">se středem</text><text x="225" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="286" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">, která prochází bodem</text><text x="348" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="365" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">. Bod</text><text x="383" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="410" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je vrchol</text><text x="77" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">pravoúhlého lichoběžníku</text><text x="157" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABCD</text><text x="209" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">se základnami</text><text x="253" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AB</text><text x="265" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="278" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">CD</text><text x="356" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a pravým úhlem při vrcholu</text><text x="431" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="437" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="30" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Vrcholy</text><text x="54" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="63" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="72" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="167" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">tohoto lichoběžníku leží na kružnici</text><text x="260" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">k</text><text x="277" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">, bod</text><text x="293" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">E</text><text x="338" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je střed ramene</text><text x="386" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">BC</text><text x="395" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text></svg>',
  'obr.svg',
  'Bod E a kružnice k se středem S procházející bodem A.',
  '',
  new List<String>{'Strana $AD$ je kolmá k $AB$ (pravý úhel u $A$); $D$ leží na kružnici $k$.','Kružnice $k$ je Thaletova kružnice trojúhelníku $ACD$ s přeponou $AC$ a pravým úhlem u $D$; vrchol $D$ i $C$ leží na $k$.','Bod $E$ jako střed ramene $BC$ a kolmost stran určí vrcholy $B$ a $C$; lichoběžník dokreslíme.'},
  'Konstrukce pravoúhlého lichoběžníku $ABCD$; $D$ na kružnici $k$ (Thaletova kružnice trojúhelníku $ACD$), $E$ střed $BC$ (viz postup).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PCD24C0T03', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
