String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD19C0T01';
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
  'CERMAT M9A 2019 – úloha 1',
  new List<String>{'Vypočtěte tři pětiny z dvojnásobku čísla $15$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Dvojnásobek čísla $15$ je $30$; tři pětiny z $30$ jsou $\\frac{3}{5}\\cdot 30 = 18$.'},
  '$18$',
  1, 1, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 2.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','11 hodin 17 minut − 9 hodin 45 minut = ______ minut'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$11$ h $17$ min $= 677$ min, $9$ h $45$ min $= 585$ min. Rozdíl $677 - 585 = 92$ min (tj. $1$ h $32$ min).'},
  '$92$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 2.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','28 m² − ______ dm² = 2 300 dm² + 2 300 cm²'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$28$ m² $= 2\\,800$ dm². Dále $2\\,300$ cm² $= 23$ dm², takže pravá strana je $2\\,300 + 23 = 2\\,323$ dm². Z rovnosti $2\\,800 - x = 2\\,323$ plyne $x = 477$.'},
  '$477$',
  1, 2, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$(6-4)\\cdot\\frac{11}{8} + \\frac{9}{14}\\cdot\\frac{7}{6} =$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(6-4)\\cdot\\frac{11}{8} = 2\\cdot\\frac{11}{8} = \\frac{11}{4}$; $\\frac{9}{14}\\cdot\\frac{7}{6} = \\frac{63}{84} = \\frac{3}{4}$. Součet $\\frac{11}{4} + \\frac{3}{4} = \\frac{14}{4} = \\frac{7}{2}$.'},
  '$\\frac{7}{2}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\dfrac{\\frac{2\\cdot 3}{6} - \\frac{4}{2\\cdot 3}}{\\frac{2+3}{6}} =$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{2\\cdot 3}{6} - \\frac{4}{2\\cdot 3} = 1 - \\frac{2}{3} = \\frac{1}{3}$. Jmenovatel: $\\frac{2+3}{6} = \\frac{5}{6}$. Celý výraz $\\frac{1/3}{5/6} = \\frac{1}{3}\\cdot\\frac{6}{5} = \\frac{6}{15} = \\frac{2}{5}$.'},
  '$\\frac{2}{5}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 4.1',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$(3a-2)\\cdot(-2a) =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(3a-2)\\cdot(-2a) = -6a^2 + 4a$.'},
  '$-6a^2 + 4a$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 4.2',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$(3x-4)^2 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(3x-4)^2 = (3x)^2 - 2\\cdot 3x\\cdot 4 + 4^2 = 9x^2 - 24x + 16$.'},
  '$9x^2 - 24x + 16$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$(2+n)\\cdot(3n-3) + (3n-n)\\cdot 2 - n\\cdot(3-5) =$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(2+n)(3n-3) = 3n^2 + 3n - 6$; $(3n-n)\\cdot 2 = 2n\\cdot 2 = 4n$; $-n\\cdot(3-5) = -n\\cdot(-2) = 2n$. Součet $3n^2 + 3n - 6 + 4n + 2n = 3n^2 + 9n - 6$.'},
  '$3n^2 + 9n - 6$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 5.1',
  new List<String>{'Řešte rovnici:','$0{,}6x - \\frac{1}{2} = 1{,}4x + 1{,}5$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}6x - 0{,}5 = 1{,}4x + 1{,}5$; $-0{,}5 - 1{,}5 = 1{,}4x - 0{,}6x$; $-2 = 0{,}8x$; $x = -2{,}5$.'},
  '$x = -2{,}5$',
  2, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 5.2',
  new List<String>{'Řešte rovnici:','$\\frac{3-2y}{3} = \\frac{1-2y}{4} + \\frac{y+3}{6}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme rovnici číslem $12$: $4(3-2y) = 3(1-2y) + 2(y+3)$; $12 - 8y = 3 - 6y + 2y + 6$; $12 - 8y = 9 - 4y$; $3 = 4y$; $y = \\frac{3}{4} = 0{,}75$.'},
  '$y = 0{,}75$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
