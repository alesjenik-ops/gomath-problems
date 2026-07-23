String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M9B 2019 – úloha 10',
  new List<String>{'V rovině leží přímka $p$ a kružnice $k$ se středem $S$. Bod $A$ je jedním ze dvou průsečíků přímky $p$ a kružnice $k$ (viz obrázek).','Bod $A$ je vrchol čtverce $ABCD$, bod $S$ leží uvnitř tohoto čtverce a na přímce $p$ leží strana $AB$. Právě dva ze čtyř vrcholů čtverce $ABCD$ leží na kružnici $k$.','Sestrojte a označte písmeny chybějící vrcholy čtverce $ABCD$ a čtverec narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 400" font-family="sans-serif"> <circle cx="260" cy="200" r="140" fill="none" stroke="#000" stroke-width="2"/> <text x="176" y="118" font-size="18" font-style="italic">k</text> <text x="272" y="206" font-size="20" text-anchor="middle">×</text> <text x="284" y="224" font-size="18" font-style="italic">S</text> <line x1="60" y1="300" x2="440" y2="250" stroke="#000" stroke-width="2"/> <text x="66" y="288" font-size="18" font-style="italic">p</text> <text x="150" y="296" font-size="20" text-anchor="middle">×</text> <text x="142" y="316" font-size="18" font-style="italic" text-anchor="middle">A</text> </svg>',
  'primka-kruznice-k.svg',
  'Kružnice k se středem S a přímka p, která ji protíná; bod A je levý průsečík přímky p a kružnice k.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Strana $AB$ leží na $p$, takže $B$ je na přímce $p$ (druhý průsečík s $k$ nebo bod na $p$ tak, aby právě dva vrcholy ležely na $k$). Čtverec dostavíme kolmicemi a přenesením délky $|AB|$; podmínku „$S$ uvnitř čtverce a právě dva vrcholy na $k$" splňují tři různé čtverce.','Úloha má tři řešení: čtverce s vrcholy $B_1C_1D_1$, $B_2C_2D_2$ a $B_3C_3D_3$.'},
  'Tři řešení – čtverce $ABCD$ s vrcholy $B_1C_1D_1$, $B_2C_2D_2$ a $B_3C_3D_3$ (strana $AB$ na přímce $p$, $S$ uvnitř čtverce, právě dva vrcholy na kružnici $k$) – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
