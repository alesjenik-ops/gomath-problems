String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD24C0T02';
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
  'CERMAT M5B 2024 – úloha 7 (konstrukce)',
  new List<String>{'Jsou dány body $A$, $E$, $F$ (viz obrázek).','7.1 Narýsujte úsečku $EF$. Sestrojte přímku $p$ procházející bodem $A$, která je kolmá na úsečku $EF$. Průsečík úsečky $EF$ a přímky $p$ označte písmenem $Y$.','7.2 Na úsečce $EF$ vyznačte bod $B$, který má od bodu $A$ stejnou vzdálenost, jakou má bod $Y$ od bodu $E$.','7.3 Sestrojte čtverec $ABCD$ tak, aby bod $Y$ neležel uvnitř čtverce $ABCD$.','7.4 Do stejného obrázku narýsujte rovnoramenný trojúhelník $FGE$ tak, aby rameny trojúhelníku byly úsečky $EF$ a $EG$ a zároveň bod $G$ ležel na polopřímce $AY$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 380" font-family="sans-serif"> <rect x="10" y="10" width="440" height="360" fill="none" stroke="#bbb"/> <text x="230" y="34" font-size="13" text-anchor="middle">Jsou dany body A, E, F.</text> <text x="232" y="152" font-size="16" text-anchor="middle">×</text><text x="242" y="146" font-size="15" font-style="italic">E</text> <text x="150" y="260" font-size="16" text-anchor="middle">×</text><text x="146" y="278" font-size="15" font-style="italic">A</text> <text x="300" y="270" font-size="16" text-anchor="middle">×</text><text x="296" y="288" font-size="15" font-style="italic">F</text> </svg>',
  'body-AEF.svg',
  'Tři body A, E, F v rovině: E nahoře uprostřed, A vlevo dole, F vpravo od bodu A.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'7.1 Bod $Y$ je pata kolmice $p$ vedené z bodu $A$ na úsečku $EF$.','7.2 Na úsečce $EF$ vyznačíme bod $B$ tak, že $|AB|=|EY|$.','7.3 Nad stranou $AB$ sestrojíme čtverec $ABCD$ na tu polorovinu, aby bod $Y$ neležel uvnitř čtverce.','7.4 Na polopřímce $AY$ najdeme bod $G$ tak, že $|EG|=|EF|$; trojúhelník $FGE$ je rovnoramenný s rameny $EF$ a $EG$.'},
  'Konstrukce (viz náčrt v klíči): $Y$ = pata kolmice $p$ z $A$ na $EF$; $B$ na $EF$ s $|AB|=|EY|$; čtverec $ABCD$ tak, aby $Y$ nebyl uvnitř; bod $G$ na polopřímce $AY$ s $|EG|=|EF|$ a rovnoramenný trojúhelník $FGE$.',
  6, 12, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
