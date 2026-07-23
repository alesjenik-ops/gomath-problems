String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD23C0T01';
Integer YEAR = 2023;

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
  'CERMAT M9A 2023 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky). Uveďte celý postup řešení.','$3n\\cdot(2-n+2n)+(2n+1)\\cdot(7-n)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$3n\\cdot(2+n)=6n+3n^2$; $(2n+1)\\cdot(7-n)=14n-2n^2+7-n=-2n^2+13n+7$. Součet: $3n^2-2n^2+6n+13n+7=n^2+19n+7$.'},
  '$n^2+19n+7$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2023 – úloha 5.1',
  new List<String>{'Řešte rovnici. Uveďte celý postup řešení (zkoušku nezapisujte).','$0{,}5x+2\\cdot(x+2{,}5)=2{,}5\\cdot(x+3)$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}5x+2x+5=2{,}5x+7{,}5$; $2{,}5x+5=2{,}5x+7{,}5$; po odečtení $2{,}5x$ dostaneme $5=7{,}5$, což neplatí. Rovnice nemá řešení.'},
  'rovnice nemá řešení',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2023 – úloha 5.2',
  new List<String>{'Řešte rovnici. Uveďte celý postup řešení (zkoušku nezapisujte).','$\\dfrac{y+10}{15}+\\dfrac{2y}{5}=1-\\dfrac{5-y}{3}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $15$: $(y+10)+6y=15-5\\cdot(5-y)$; $7y+10=15-25+5y$; $7y+10=5y-10$; $2y=-20$; $y=-10$.'},
  '$y=-10$',
  2, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2023 – úloha 6',
  new List<String>{'Pravoúhlý lichoběžník $ABCD$ se základnami $AB$, $CD$ má pravý úhel při vrcholu $C$. Podle obrázku je $CD=10$ cm, $CB=8$ cm a $AB=6$ cm.','6.1 Vypočtěte v cm² obsah trojúhelníku $ABD$.','6.2 Vypočtěte v cm² obsah lichoběžníku $ABCD$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 280" font-family="sans-serif"> <polygon points="136,232 280,232 280,40 40,40" fill="none" stroke="#000" stroke-width="2"/> <line x1="40" y1="40" x2="280" y2="232" stroke="#000"/> <rect x="263" y="40" width="17" height="17" fill="none" stroke="#000"/> <text x="26" y="36" font-size="16" font-style="italic">D</text> <text x="286" y="36" font-size="16" font-style="italic">C</text> <text x="286" y="246" font-size="16" font-style="italic">B</text> <text x="120" y="246" font-size="16" font-style="italic">A</text> <text x="150" y="32" font-size="14">10 cm</text> <text x="288" y="140" font-size="14">8 cm</text> <text x="196" y="252" font-size="14">6 cm</text> </svg>',
  'lichobeznik-ABCD.svg',
  'Pravoúhlý lichoběžník ABCD s pravým úhlem při vrcholu C, se základnami CD rovnou 10 cm a AB rovnou 6 cm a ramenem CB rovným 8 cm; narýsována je úhlopříčka DB.',
  'Pravoúhlý lichoběžník ABCD',
  new List<String>{'Rameno $CB$ je kolmé na obě rovnoběžné základny, je tedy výškou lichoběžníku: $v=8$ cm.','6.1 Trojúhelník $ABD$ má základnu $AB=6$ cm a výšku rovnou výšce lichoběžníku, tj. $8$ cm: $S=\\frac{1}{2}\\cdot 6\\cdot 8=24$ cm².','6.2 Obsah lichoběžníku: $S=\\frac{AB+CD}{2}\\cdot v=\\frac{6+10}{2}\\cdot 8=8\\cdot 8=64$ cm².'},
  '6.1: $24$ cm²; 6.2: $64$ cm²',
  2, 3, '2',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
