String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD21C0T01';
Integer YEAR = 2021;

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
  'CERMAT M7A 2021 – úloha 11',
  new List<String>{'V rovině leží rovnoběžník $ABCD$ a rovnoramenný trojúhelník $BEC$ se základnou $BE$. Body $A$, $B$, $E$ leží na jedné přímce. Vnitřní úhel rovnoběžníku při vrcholu $D$ má velikost $114^\\circ$ (viz obrázek).','Jaká je velikost úhlu $\\varphi$ (úhel $BCE$)? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $66^\\circ$','B) $57^\\circ$','C) $54^\\circ$','D) $48^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 320" font-family="sans-serif" font-size="15"> <polygon points="60,280 250,280 340,150 150,150" fill="none" stroke="#000" stroke-width="2"/> <polygon points="250,280 340,150 440,280" fill="none" stroke="#000" stroke-width="2"/> <text x="52" y="298">A</text><text x="244" y="298">B</text><text x="438" y="298">E</text> <text x="140" y="144">D</text><text x="336" y="144">C</text> <text x="166" y="178">114°</text><text x="330" y="184" font-style="italic">φ</text> </svg>',
  'rovnobeznik-trojuhelnik.svg',
  'Rovnoběžník ABCD s úhlem 114° u vrcholu D a rovnoramenný trojúhelník BEC s úhlem φ u vrcholu C; body A, B, E na jedné přímce.',
  'Výchozí obrázek k úloze 11',
  new List<String>{'Protilehlé úhly rovnoběžníku jsou shodné, takže úhel $ABC$ je roven úhlu při vrcholu $D$, tj. $114^\\circ$. Body $A$, $B$, $E$ leží na přímce, proto úhel $CBE=180^\\circ-114^\\circ=66^\\circ$.','Trojúhelník $BEC$ je rovnoramenný se základnou $BE$, úhly při základně jsou shodné: $|\\angle CBE|=|\\angle CEB|=66^\\circ$. Úhel při vrcholu $C$ je $\\varphi=180^\\circ-2\\cdot 66^\\circ=48^\\circ$.'},
  'D) $48^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
