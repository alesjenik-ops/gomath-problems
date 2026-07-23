String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M9A 2020 – úloha 1',
  new List<String>{'Vypočtěte: $(-0{,}4)^2 + 0{,}3^2 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(-0{,}4)^2 = 0{,}16$, $0{,}3^2 = 0{,}09$; součet $0{,}16 + 0{,}09 = 0{,}25$.'},
  '$0{,}25$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2020 – úloha 2.1',
  new List<String>{'Z dvouhodinové přednášky již tři pětiny uplynuly.','Vypočtěte, kolik minut zbývá do konce přednášky.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Dvě hodiny $=120$ minut. Zbývá $\\frac{2}{5}$ přednášky, tj. $\\frac{2}{5}\\cdot 120 = 48$ minut.'},
  '$48$ minut',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2020 – úloha 2.2',
  new List<String>{'Objemy dvou laboratorních nádob jsou $V_1 = 9\\,500$ mm³, $V_2 = 0{,}001$ m³.','Vypočtěte, o kolik cm³ se liší objemy $V_1$, $V_2$ těchto laboratorních nádob.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$V_1 = 9\\,500$ mm³ $= 9{,}5$ cm³ (neboť $1$ cm³ $= 1000$ mm³). $V_2 = 0{,}001$ m³ $= 1000$ cm³. Rozdíl $1000 - 9{,}5 = 990{,}5$ cm³.'},
  'o $990{,}5$ cm³',
  1, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2020 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\left(\\frac{1}{4}+\\frac{5}{6}\\right)\\cdot\\left(\\frac{5}{13}-\\frac{1}{2}\\right) =$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{4}+\\frac{5}{6}=\\frac{3+10}{12}=\\frac{13}{12}$; $\\frac{5}{13}-\\frac{1}{2}=\\frac{10-13}{26}=-\\frac{3}{26}$. Součin $\\frac{13}{12}\\cdot\\left(-\\frac{3}{26}\\right)=-\\frac{39}{312}=-\\frac{1}{8}$.'},
  '$-\\frac{1}{8}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2020 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\frac{\\frac{6}{5}}{\\frac{7}{6}\\cdot 4 - 4\\cdot\\frac{5}{12}} =$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Jmenovatel: $\\frac{7}{6}\\cdot 4 = \\frac{28}{6}=\\frac{14}{3}$; $4\\cdot\\frac{5}{12}=\\frac{20}{12}=\\frac{5}{3}$; $\\frac{14}{3}-\\frac{5}{3}=\\frac{9}{3}=3$. Celý výraz $\\frac{6/5}{3}=\\frac{6}{15}=\\frac{2}{5}$.'},
  '$\\frac{2}{5}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2020 – úloha 4.1',
  new List<String>{'Rozložte na součin:','$p^2 - 16 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$p^2-16 = p^2 - 4^2 = (p-4)(p+4)$.'},
  '$(p-4)(p+4)$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2020 – úloha 4.2',
  new List<String>{'Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky):','$(2x+5)^2 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(2x+5)^2 = (2x)^2 + 2\\cdot 2x\\cdot 5 + 5^2 = 4x^2 + 20x + 25$.'},
  '$4x^2 + 20x + 25$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2020 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$(2n+6)\\cdot(4n-5) + (3-5)\\cdot 2n - 5n\\cdot(n-2n) =$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(2n+6)(4n-5)=8n^2+14n-30$; $(3-5)\\cdot 2n = -4n$; $-5n\\cdot(n-2n)=-5n\\cdot(-n)=5n^2$. Součet $8n^2+14n-30-4n+5n^2 = 13n^2+10n-30$.'},
  '$13n^2 + 10n - 30$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2020 – úloha 5.1',
  new List<String>{'Řešte rovnici:','$3{,}2 - 0{,}5x - 1 = 0{,}6 - 1{,}3x$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$2{,}2 - 0{,}5x = 0{,}6 - 1{,}3x$; $-0{,}5x + 1{,}3x = 0{,}6 - 2{,}2$; $0{,}8x = -1{,}6$; $x = -2$.'},
  '$x = -2$',
  2, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2020 – úloha 5.2',
  new List<String>{'Řešte rovnici:','$\\frac{5y+3}{8} - \\frac{y}{2} = \\frac{4-y}{5} + \\frac{2y-1}{10}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme rovnici číslem $40$: $5(5y+3) - 20y = 8(4-y) + 4(2y-1)$; $25y+15-20y = 32-8y+8y-4$; $5y+15 = 28$; $5y = 13$; $y = \\frac{13}{5}$.'},
  '$y = \\frac{13}{5}$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
