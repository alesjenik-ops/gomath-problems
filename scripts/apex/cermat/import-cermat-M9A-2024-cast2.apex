String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD24C0T01';
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
  'CERMAT M9A 2024 – úloha 4.3',
  new List<String>{'Zjednodušte a výsledek rozložte na součin vytýkáním. Uveďte celý postup řešení.','$(c-5)\\cdot(2-3c)-(c-2c)\\cdot 3c-c\\cdot 7=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(c-5)\\cdot(2-3c)=-3c^2+17c-10$; $-(c-2c)\\cdot 3c=-(-c)\\cdot 3c=3c^2$; $-c\\cdot 7=-7c$. Součet: $-3c^2+17c-10+3c^2-7c=10c-10=10\\cdot(c-1)$.'},
  '$10\\cdot(c-1)$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2024 – úloha 5.1',
  new List<String>{'Řešte rovnici. Uveďte celý postup řešení. Zkoušku nezapisujte.','$-2\\cdot(x+4)-3\\cdot(x+1)^2=x\\cdot(2-3x)$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$-2x-8-3(x^2+2x+1)=2x-3x^2$; $-3x^2-8x-11=2x-3x^2$; $-8x-11=2x$; $-11=10x$; $x=-\\frac{11}{10}=-1{,}1$.'},
  '$x=-1{,}1$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2024 – úloha 5.2',
  new List<String>{'Řešte rovnici. Uveďte celý postup řešení. Zkoušku nezapisujte.','$6-\\dfrac{3-2y}{5}\\cdot 2=4y$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme pěti: $30-2\\cdot(3-2y)=20y$; $30-6+4y=20y$; $24+4y=20y$; $24=16y$; $y=\\frac{24}{16}=\\frac{3}{2}$.'},
  '$y=\\dfrac{3}{2}$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2024 – úloha 6',
  new List<String>{'Pravoúhlý lichoběžník $ABCD$ se základnami $AB$ a $CD$ má pravý úhel při vrcholu $B$. Základna $AB$ má délku $40$ cm, základna $CD$ délku $28$ cm a úhlopříčka $AC$ délku $41$ cm.','6.1 Vypočítejte obsah lichoběžníku $ABCD$. Výsledek uveďte v cm².','6.2 Vypočítejte délku ramene $AD$. Výsledek uveďte v cm.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 280" font-family="sans-serif"> <polygon points="60,220 560,220 560,70 210,70" fill="none" stroke="#000" stroke-width="2"/> <line x1="60" y1="220" x2="560" y2="70" stroke="#000"/> <rect x="543" y="203" width="17" height="17" fill="none" stroke="#000"/> <text x="46" y="238" font-size="16" font-style="italic">A</text> <text x="566" y="238" font-size="16" font-style="italic">B</text> <text x="566" y="66" font-size="16" font-style="italic">C</text> <text x="192" y="66" font-size="16" font-style="italic">D</text> <text x="300" y="242" font-size="14">40 cm</text> <text x="360" y="60" font-size="14">28 cm</text> <text x="330" y="150" font-size="14">41 cm</text> </svg>',
  'lichobeznik-ABCD.svg',
  'Pravoúhlý lichoběžník ABCD s pravým úhlem při B, základnami AB rovnou 40 cm a CD rovnou 28 cm a úhlopříčkou AC rovnou 41 cm.',
  'Pravoúhlý lichoběžník ABCD',
  new List<String>{'6.1 Pravý úhel je při $B$, proto výška $BC$ je odvěsna pravoúhlého trojúhelníku $ABC$ s přeponou $AC=41$ cm a odvěsnou $AB=40$ cm: $BC=\\sqrt{41^2-40^2}=\\sqrt{81}=9$ cm. Obsah: $S=\\frac{AB+CD}{2}\\cdot BC=\\frac{40+28}{2}\\cdot 9=34\\cdot 9=306$ cm².','6.2 Vodorovný rozdíl základen je $40-28=12$ cm, výška $9$ cm, proto rameno $AD=\\sqrt{12^2+9^2}=\\sqrt{225}=15$ cm.'},
  '6.1: $306$ cm²; 6.2: $15$ cm',
  4, 7, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2024 – úloha 7',
  new List<String>{'Žáci třídy 8. B se dělí na dvě skupiny podle toho, zda chodí na němčinu, nebo na angličtinu. V obou skupinách je stejný počet žáků. Ve třídě je $14$ chlapců a $5$ z nich chodí na angličtinu. Na němčinu chodí $4$ dívky.','7.1 Kolik dívek celkem chodí na angličtinu?','7.2 Kolik má třída 8. B celkem žáků?'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Na němčinu chodí $14-5=9$ chlapců a $4$ dívky, skupina němčiny má tedy $13$ žáků. Obě skupiny jsou stejně velké, takže i angličtina má $13$ žáků.','7.1 V angličtině je $5$ chlapců, tedy dívek $13-5=8$.','7.2 Celkem $13+13=26$ žáků.'},
  '7.1: $8$ dívek; 7.2: $26$ žáků',
  4, 5, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
