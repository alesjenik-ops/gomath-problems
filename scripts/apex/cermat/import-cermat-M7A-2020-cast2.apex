String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD20C0T01';
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
  'CERMAT M7A 2020 – úloha 6',
  new List<String>{'Děti koupily mamince k narozeninám růže, bonboniéru, ozdobnou záložku a knihu, vše celkem za $340$ korun. Růže s bonboniérou stály celkem $210$ korun. Růže byly o třetinu dražší než bonboniéra. Samotná kniha byla o $100$ korun dražší než ozdobná záložka.','Vypočtěte,','6.1 kolik korun zaplatily děti za růže,','6.2 kolik korun stála ozdobná záložka.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Bonboniéra $b$, růže $\\frac{4}{3}b$. Součet $\\frac{4}{3}b+b=\\frac{7}{3}b=210\\Rightarrow b=90$ korun; růže $210-90=120$ korun.','6.2 Kniha se záložkou stály $340-210=130$ korun. Záložka $z$, kniha $z+100$: $2z+100=130\\Rightarrow z=15$ korun.'},
  '6.1: $120$ korun; 6.2: $15$ korun',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2020 – úloha 7',
  new List<String>{'Podstavou kolmého čtyřbokého hranolu je kosočtverec. Výška hranolu je $10$ cm a povrch hranolu je $360$ cm². Obsah pláště hranolu je sedmkrát větší než obsah jedné podstavy.','Vypočtěte','7.1 v cm² obsah pláště hranolu,','7.2 v cm součet délek všech $12$ hran hranolu.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 300" font-family="sans-serif"> <polygon points="120,55 190,30 260,55 190,80" fill="#eeeeee" stroke="#000" stroke-width="2"/> <line x1="120" y1="55" x2="120" y2="245" stroke="#000" stroke-width="2"/> <line x1="260" y1="55" x2="260" y2="245" stroke="#000" stroke-width="2"/> <line x1="190" y1="80" x2="190" y2="270" stroke="#000" stroke-width="2"/> <line x1="190" y1="30" x2="190" y2="220" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <polyline points="120,245 190,270 260,245" fill="none" stroke="#000" stroke-width="2"/> <polyline points="120,245 190,220 260,245" fill="none" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="92" y1="55" x2="92" y2="245" stroke="#000" stroke-width="1"/> <polygon points="92,55 88,66 96,66" fill="#000"/> <polygon points="92,245 88,234 96,234" fill="#000"/> <text x="52" y="155" font-size="15">10 cm</text> </svg>',
  'hranol.svg',
  'Schematický nákres kolmého čtyřbokého hranolu s kosočtvercovou podstavou a vyznačenou výškou 10 cm.',
  'Kolmý hranol s kosočtvercovou podstavou (výška 10 cm)',
  new List<String>{'7.1 Povrch $S=2S_p+S_{pl}$ a $S_{pl}=7S_p$, tedy $9S_p=360\\Rightarrow S_p=40$ cm²; plášť $S_{pl}=7\\cdot 40=280$ cm².','7.2 Plášť $=o\\cdot v$, kde $o$ je obvod podstavy: $o\\cdot 10=280\\Rightarrow o=28$ cm. Kosočtverec má $4$ shodné strany, tedy $a=7$ cm. Součet hran $=8\\cdot 7+4\\cdot 10=56+40=96$ cm.'},
  '7.1: $280$ cm²; 7.2: $96$ cm',
  4, 7, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2020 – úloha 8',
  new List<String>{'V rovině leží polopřímka $XY$ a bod $A$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Jiné dva vrcholy tohoto obdélníku leží na polopřímce $XY$ a délka strany $AB$ je $7$ cm.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="60" y1="252" x2="420" y2="108" stroke="#000" stroke-width="2"/> <polygon points="420,108 402,110 410,124" fill="#000"/> <line x1="60" y1="252" x2="66" y2="240" stroke="#000" stroke-width="2"/> <text x="48" y="270" font-size="16" font-style="italic">X</text> <line x1="238" y1="180" x2="246" y2="167" stroke="#000" stroke-width="2"/> <text x="250" y="182" font-size="16" font-style="italic">Y</text> <text x="226" y="246" font-size="16">×</text> <text x="228" y="266" font-size="16" font-style="italic">A</text> </svg>',
  'poloprimka-xy-a.svg',
  'Polopřímka XY směřující z bodu X vzhůru vpravo přes bod Y a bod A vyznačený křížkem pod ní.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Bod $B$ leží na polopřímce $XY$ ve vzdálenosti $|AB|=7$ cm od bodu $A$ — sestrojíme jej jako průsečík kružnice $k(A;7$ cm$)$ s polopřímkou $XY$ (dva průsečíky $B_1$, $B_2$). Vrchol $D$ je průsečík polopřímky $XY$ s kolmicí k $AB$ vedenou bodem $A$; čtvrtý vrchol dopočteme jako $C=B+D-A$. Úloha má dvě řešení: obdélníky $AB_1C_1D_1$ a $AB_2C_2D_2$.'},
  'Dvě řešení. Bod $B$ je průsečík kružnice $k(A;7$ cm$)$ s polopřímkou $XY$, vrcholy $C$, $D$ dopočteme kolmostí (obdélníky $AB_1C_1D_1$ a $AB_2C_2D_2$) — viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
