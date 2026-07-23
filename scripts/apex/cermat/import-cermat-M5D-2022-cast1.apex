String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD22C0T04';
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
  'CERMAT M5D 2022 – úloha 1.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$96 - 3 \\cdot \\square = 18 + 36 : 3$'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$18 + 36 : 3 = 18 + 12 = 30$. Tedy $3 \\cdot \\square = 96 - 30 = 66$, a proto $\\square = 22$.'},
  '$22$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2022 – úloha 1.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$(96 : 3 - \\square) \\cdot 2 = 2 \\cdot 18$'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$2 \\cdot 18 = 36$, tedy $96 : 3 - \\square = 18$. Protože $96 : 3 = 32$, je $\\square = 32 - 18 = 14$.'},
  '$14$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2022 – úloha 2.1',
  new List<String>{'Měsíc vyšel nad obzor včera večer v 18:17 a zapadl dnes ráno v 9:48.','Vypočtěte, jak dlouho byl měsíc nad obzorem. Výsledek uveďte v hodinách a minutách.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Od 18:17 do půlnoci je $5$ h $43$ min, od půlnoci do 9:48 je $9$ h $48$ min. Celkem $14$ h $91$ min, tj. $15$ h $31$ min.'},
  '$15$ hodin $31$ minut',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2022 – úloha 2.2',
  new List<String>{'Vypočtěte v metrech:','$\\frac{1}{20}$ kilometru $+\\ 34\\,000$ centimetrů $=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{20}$ km $=50$ m a $34\\,000$ cm $=340$ m. Součet je $50 + 340 = 390$ m (tj. $39\\,000$ cm).'},
  '$390$ metrů',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2022 – úloha 3.1',
  new List<String>{'Obrazec se skládá ze čtverce, dvou rovnostranných trojúhelníků a dvou stejných obdélníků. (Sousední útvary mají společnou jednu stranu.)','Obvod celého obrazce je $54$ cm a délka strany čtverce je $5$ cm.','Vypočtěte v cm obvod jednoho obdélníku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 210" font-family="sans-serif"> <polygon points="130,30 210,30 210,110 130,110" fill="none" stroke="#000" stroke-width="2"/> <polygon points="130,30 130,110 65,70" fill="none" stroke="#000" stroke-width="2"/> <polygon points="210,30 210,110 275,70" fill="none" stroke="#000" stroke-width="2"/> <polygon points="65,70 130,110 100,190 35,150" fill="none" stroke="#000" stroke-width="2"/> <polygon points="275,70 210,110 240,190 305,150" fill="none" stroke="#000" stroke-width="2"/> <text x="170" y="80" font-size="12" text-anchor="middle">čtverec</text> </svg>',
  'obrazec.svg',
  'Obrazec ve tvaru oblouku – uprostřed čtverec, po stranách dva rovnostranné trojúhelníky a dva obdélníky (schematicky).',
  'Schematický nákres obrazce',
  new List<String>{'Všechny útvary mají jednu stranu dlouhou $5$ cm. Na obvodu obrazce leží šest stran délky $5$ cm a čtyři delší strany obdélníků délky $x$: $6 \\cdot 5 + 4x = 54$, tedy $4x = 24$ a $x = 6$ cm (delší strana obdélníku). Obvod jednoho obdélníku je $2 \\cdot (5 + 6) = 22$ cm.'},
  '$22$ cm',
  2, 4, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
