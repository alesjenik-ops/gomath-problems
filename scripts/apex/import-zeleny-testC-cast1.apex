String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený C1 – čtvrtina zbytku po dělení',
  new List<String>{'Vypočtěte čtvrtinu zbytku po dělení čísla $59$ číslem $17$.'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$59 = 17 \\cdot 3 + 8$, zbytek je $8$. Jeho čtvrtina je $8 : 4 = 2$.'},
  '$2$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený C2.1 – desetinný výpočet',
  new List<String>{'Vypočtěte: $0{,}4 + 0{,}1 \\cdot (0{,}4 - 0{,}1) : 0{,}01 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}4 + 0{,}1 \\cdot 0{,}3 : 0{,}01 = 0{,}4 + 0{,}03 : 0{,}01 = 0{,}4 + 3 = 3{,}4$.'},
  '$3{,}4$',
  1, 2, '2',
  new List<String>{'zs2','r9','desetinna-cisla','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený C2.2 – odmocnina a mocnina',
  new List<String>{'Vypočtěte: $\\dfrac{12}{\\sqrt{9}} - 0{,}2^2 : 0{,}01 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{12}{3} - 0{,}04 : 0{,}01 = 4 - 4 = 0$.'},
  '$0$',
  1, 3, '2',
  new List<String>{'zs2','r9','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený C3.1 – zlomkový výraz',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(0{,}125 + \\dfrac{3}{4}\\right) : 3\\dfrac{1}{2} =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\left(\\dfrac{1}{8} + \\dfrac{6}{8}\\right) : \\dfrac{7}{2} = \\dfrac{7}{8} \\cdot \\dfrac{2}{7} = \\dfrac{2}{8} = \\dfrac{1}{4}$.'},
  '$\\dfrac{1}{4}$',
  1, 3, '2',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený C3.2 – složený zlomek',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{2}{3} - 0{,}5 + \\frac{3}{4}}{\\frac{2}{3} : \\frac{6}{11}} =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\dfrac{2}{3} - \\dfrac{1}{2} + \\dfrac{3}{4} = \\dfrac{8 - 6 + 9}{12} = \\dfrac{11}{12}$.','Jmenovatel: $\\dfrac{2}{3} : \\dfrac{6}{11} = \\dfrac{2}{3} \\cdot \\dfrac{11}{6} = \\dfrac{11}{9}$.','Podíl: $\\dfrac{11}{12} : \\dfrac{11}{9} = \\dfrac{11}{12} \\cdot \\dfrac{9}{11} = \\dfrac{9}{12} = \\dfrac{3}{4}$.'},
  '$\\dfrac{3}{4}$',
  2, 4, '3',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený C4.1 – zjednodušení výrazu',
  new List<String>{'Zjednodušte výraz: $-(4x-6)^2 \\cdot 0{,}25 + 2x + (6-2x)^2 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$-(16x^2 - 48x + 36) \\cdot 0{,}25 = -4x^2 + 12x - 9$.','$(6-2x)^2 = 4x^2 - 24x + 36$.','Součet: $-4x^2 + 12x - 9 + 2x + 4x^2 - 24x + 36 = -10x + 27$.'},
  '$-10x + 27$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený C4.2 – zjednodušení zlomku s výrazy',
  new List<String>{'Zjednodušte výraz: $\\dfrac{(1+x^2)^2 - x^2 \\cdot (x-1)^2 - 1}{2x+1} =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $(1 + 2x^2 + x^4) - x^2(x^2 - 2x + 1) - 1 = 1 + 2x^2 + x^4 - x^4 + 2x^3 - x^2 - 1 = 2x^3 + x^2$.','$2x^3 + x^2 = x^2(2x+1)$, tedy $\\dfrac{x^2(2x+1)}{2x+1} = x^2$.'},
  '$x^2$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený C5.1 – lineární rovnice',
  new List<String>{'Řešte rovnici: $x + 4 - 3 \\cdot (x-2) = 5 \\cdot (x+2)$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$x + 4 - 3x + 6 = 5x + 10 \\Rightarrow -2x + 10 = 5x + 10 \\Rightarrow -7x = 0 \\Rightarrow x = 0$.'},
  '$x = 0$',
  2, 3, '2',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený C5.2 – rovnice se zlomky',
  new List<String>{'Řešte rovnici: $2 \\cdot \\left(b - \\dfrac{2}{3}\\right) + \\dfrac{b-2}{2} = \\dfrac{3b-7}{4}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $12$: $24b - 16 + 6(b-2) = 3(3b-7)$.','$24b - 16 + 6b - 12 = 9b - 21 \\Rightarrow 30b - 28 = 9b - 21 \\Rightarrow 21b = 7 \\Rightarrow b = \\dfrac{1}{3}$.'},
  '$b = \\dfrac{1}{3}$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice-se-zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
