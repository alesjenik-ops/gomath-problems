String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD24C0T04';
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
  'CERMAT M5D 2024 – úloha 7 (konstrukce)',
  new List<String>{'Jsou dány body $A$, $C$ a $D$, které tvoří vrcholy rovnoramenného pravoúhlého trojúhelníku s rameny $AD$ a $DC$ a s pravým úhlem při vrcholu $D$ (viz obrázek).','7.1 Sestrojte čtverec $ABCD$.','7.2 Narýsujte přímku $p$, která prochází body $B$ a $D$. Na přímce $p$ vyznačte bod $X$, který je ve stejné vzdálenosti od bodu $B$ jako bod $D$. Na polopřímce $CB$ vyznačte bod $Y$, který je ve stejné vzdálenosti od bodu $B$ jako bod $X$. Najděte všechny body $X$ a $Y$, které odpovídají zadání.','7.3 Sestrojte trojúhelník $XYB$. Narýsujte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 330" font-family="sans-serif"> <text x="52" y="42" font-size="16" font-style="italic">D</text> <text x="60" y="60" font-size="16" text-anchor="middle">×</text> <text x="300" y="42" font-size="16" font-style="italic">C</text> <text x="300" y="60" font-size="16" text-anchor="middle">×</text> <text x="52" y="306" font-size="16" font-style="italic">A</text> <text x="60" y="292" font-size="16" text-anchor="middle">×</text> </svg>',
  'body-DCA.svg',
  'Body D a C nahoře vedle sebe a bod A pod bodem D; tvoří rovnoramenný pravoúhlý trojúhelník s pravým úhlem u D.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'7.1 Čtvrtý vrchol $B$ doplníme tak, aby $ABCD$ byl čtverec, tj. úsečka $AB$ je rovnoběžná s $DC$ a úsečka $CB$ s $DA$.','7.2 Přímka $p$ je přímka $BD$. Na $p$ leží dva body ve vzdálenosti $|BD|$ od $B$: bod $X_2=D$ a bod $X_1$ na opačné straně od $B$. Bod $Y$ leží na polopřímce $CB$ ve vzdálenosti $|BD|$ od $B$ (za bodem $B$).','7.3 Vzniknou dva trojúhelníky $X_1YB$ a $X_2YB$ (kde $X_2=D$).'},
  'Čtverec $ABCD$ (čtvrtý vrchol $B$); přímka $p=BD$; body $X_1$, $X_2=D$ na $p$ ve vzdálenosti $|BD|$ od $B$; bod $Y$ na polopřímce $CB$ ve vzdálenosti $|BD|$ od $B$; dvě řešení trojúhelníku $XYB$ – viz nákres v klíči.',
  6, 12, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
