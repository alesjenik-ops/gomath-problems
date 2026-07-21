String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 1. řádný termín (M9A)';
String STYPE = 'CERMAT';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'CERMAT 2024 M9A · úloha 6',
  new List<String>{'Pravoúhlý lichoběžník $ABCD$ se základnami $AB$ a $CD$ má pravý úhel při vrcholu $B$. Základna $AB$ má délku $40\\ \\mathrm{cm}$, základna $CD$ délku $28\\ \\mathrm{cm}$ a úhlopříčka $AC$ délku $41\\ \\mathrm{cm}$ (viz obrázek).','6.1 Vypočítejte obsah lichoběžníku $ABCD$ (v $\\mathrm{cm}^2$).','6.2 Vypočítejte délku ramene $AD$ (v cm).'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 363 168"><path d="M358 4L359 4L359 164L358 164Z" style="fill:#231f20"/><path d="M4 132L260 132M104 68L260 68M260 68L260 132M5 132L260 68" style="fill:none;stroke:#231f20;stroke-width:2"/></svg>',
  'obr.svg',
  'Pravoúhlý lichoběžník ABCD se základnami AB=40 cm, CD=28 cm, úhlopříčkou AC=41 cm a pravým úhlem při vrcholu B.',
  '',
  new List<String>{'V pravoúhlém trojúhelníku $ABC$ (pravý úhel u $B$): $BC=\\sqrt{AC^2-AB^2}=\\sqrt{41^2-40^2}=9\\ \\mathrm{cm}$ (výška lichoběžníku).','6.1: $S=\\frac{40+28}{2}\\cdot9=306\\ \\mathrm{cm}^2$.','6.2: vodorovný rozdíl základen je $40-28=12\\ \\mathrm{cm}$; $AD=\\sqrt{12^2+9^2}=\\sqrt{225}=15\\ \\mathrm{cm}$.'},
  '6.1: $306\\ \\mathrm{cm}^2$; 6.2: $15\\ \\mathrm{cm}$',
  4, 5, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 7',
  new List<String>{'Žáci třídy 8. B se dělí na dvě stejně velké skupiny podle toho, zda chodí na němčinu, nebo na angličtinu. Ve třídě je $14$ chlapců a $5$ z nich chodí na angličtinu. Na němčinu chodí $4$ dívky.','7.1 Kolik dívek celkem chodí na angličtinu?','7.2 Kolik má třída 8. B celkem žáků?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Skupina němčiny: $9$ chlapců $+4$ dívky $=13$ žáků; obě skupiny jsou stejně velké, tedy každá $13$ žáků, celkem $26$ žáků.','7.1: skupina angličtiny má $13$ žáků, z toho $5$ chlapců, tedy $8$ dívek.','7.2: celkem $26$ žáků.'},
  '7.1: $8$ dívek; 7.2: $26$ žáků',
  4, 5, '4',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 8',
  new List<String>{'Šedý obrazec je ohraničen vodorovnou úsečkou délky $20\\ \\mathrm{cm}$ (nahoře) a dvěma shodnými čtvrtkružnicemi o poloměru $10\\ \\mathrm{cm}$, které se dotýkají uprostřed dole (obrazec je vepsán do obdélníku $20\\ \\mathrm{cm}\\times10\\ \\mathrm{cm}$).','8.1 Vypočítejte obsah šedého obrazce (v $\\mathrm{cm}^2$, zaokrouhlete na celé $\\mathrm{cm}^2$, $\\pi\\doteq3{,}14$).','8.2 Vypočítejte obvod šedého obrazce (v cm, zaokrouhlete na celé cm).'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: obsah $=$ obdélník $-$ dvě čtvrtkružnice $=20\\cdot10-\\frac{1}{2}\\pi\\cdot10^2=200-157=43\\ \\mathrm{cm}^2$.','8.2: obvod $=$ úsečka $20\\ \\mathrm{cm}+2$ čtvrtkruhové oblouky $=20+2\\cdot\\frac{1}{4}\\cdot2\\pi\\cdot10\\doteq20+31{,}4=51\\ \\mathrm{cm}$.'},
  '8.1: $43\\ \\mathrm{cm}^2$; 8.2: $51\\ \\mathrm{cm}$',
  4, 5, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 9',
  new List<String>{'V rovině leží body $C$ a $S$. Bod $C$ je vrchol rovnostranného trojúhelníku $ABC$, bod $S$ je středem strany $AB$ (viz obrázek).','Sestrojte vrcholy $A$, $B$ rovnostranného trojúhelníku $ABC$ a trojúhelník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 462 321"><path d="M4 4L5 4L5 316L4 316Z" style="fill:#231f20"/><path d="M4 316L5 316L5 317L4 317Z" style="fill:#231f20"/><path d="M4 316L5 316L5 317L4 317Z" style="fill:#231f20"/><path d="M5 316L456 316L456 317L5 317Z" style="fill:#231f20"/><path d="M456 4L458 4L458 316L456 316Z" style="fill:#231f20"/><path d="M456 316L458 316L458 317L456 317Z" style="fill:#231f20"/><path d="M456 316L458 316L458 317L456 317Z" style="fill:#231f20"/><path d="M185 117L192 124M192 117L185 124M272 206L278 213M278 206L272 213" style="fill:none;stroke:#231f20;stroke-width:2"/></svg>',
  'obr.svg',
  'Body C a S v rovině.',
  '',
  new List<String>{'Úsečka $CS$ je výška (i těžnice) rovnostranného trojúhelníku, kolmá k $AB$; strana $AB$ prochází bodem $S$ kolmo k $CS$.','Ve rovnostranném trojúhelníku platí $|AS|=|SB|=\\frac{|CS|}{\\sqrt{3}}$; vrcholy $A$, $B$ naneseme na přímku $AB$ symetricky kolem $S$.'},
  'Přímka $AB\\perp CS$ prochází bodem $S$; vrcholy $A$, $B$ jsou symetricky kolem $S$ ve vzdálenosti $\\frac{|CS|}{\\sqrt{3}}$ (rovnostranný trojúhelník).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PAD24C0T01', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
