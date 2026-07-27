String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD17C0T02';
Integer YEAR = 2017;

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
  'CERMAT M5B 2017 – úloha 5',
  new List<String>{'Tři stejně těžké bedny váží tolik jako pět stejných krabic. Nejtěžší náklad, který se smí převážet ve výtahu, váží tolik jako 35 krabic.','5.1 Určete největší počet beden, které se smí naložit do prázdného výtahu.','5.2 Určete největší počet krabic, které se smí do výtahu přidat k 6 bednám.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Jedna bedna váží jako $\\frac{5}{3}$ krabice. Do výtahu (nejvýše 35 krabic) se vejde $35:\\frac{5}{3} = 35\\cdot\\frac{3}{5} = 21$ beden.','5.2 Šest beden váží jako $6\\cdot\\frac{5}{3} = 10$ krabic. K nim lze přidat ještě $35 - 10 = 25$ krabic.'},
  '5.1: $21$ beden; 5.2: $25$ krabic',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2017 – úloha 6',
  new List<String>{'Tři tyče dlouhé 112 cm, 72 cm a 56 cm byly beze zbytku rozřezány na stejně dlouhé špalíčky. Vzniklo tak 60 špalíčků. Ze všech těchto špalíčků děti postavily 12 stejně vysokých sloupků.','6.1 Určete v cm délku jednoho špalíčku.','6.2 Určete, z kolika špalíčků se skládá jeden sloupek.','6.3 Určete v cm výšku jednoho sloupku.','6.4 Určete počet špalíčků, které vznikly rozřezáním nejkratší tyčky.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Celková délka tyčí je $112 + 72 + 56 = 240$ cm, špalíčků je 60, jeden měří $240:60 = 4$ cm (délka 4 cm dělí beze zbytku 112, 72 i 56).','6.2 Na 12 sloupků připadá $60:12 = 5$ špalíčků na jeden sloupek.','6.3 Výška sloupku je $5\\cdot 4 = 20$ cm.','6.4 Nejkratší tyč (56 cm) dá $56:4 = 14$ špalíčků.'},
  '6.1: $4$ cm; 6.2: $5$ špalíčků; 6.3: $20$ cm; 6.4: $14$ špalíčků',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2017 – úloha 7',
  new List<String>{'V rovině leží bod $S$ a přímka $p$, která prochází bodem $N$ (viz obrázek). Úlohu rýsujte přímo do záznamového archu.','7.1 Sestrojte kružnici $k$ se středem $S$, která prochází bodem $N$. Další průsečík kružnice $k$ a přímky $p$ označte $K$.','7.2 Body $K$, $N$ jsou dva ze čtyř vrcholů obdélníku $KLMN$. Všechny vrcholy tohoto obdélníku leží na kružnici $k$. Sestrojte chybějící vrcholy $L$, $M$ a obdélník narýsujte.','7.3 Body $M$, $N$ jsou vrcholy trojúhelníku $MNO$, který má stejně dlouhé strany $MN$ a $NO$. Chybějící vrchol $O$ leží na polopřímce $SN$. Sestrojte bod $O$ a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 360" font-family="sans-serif"> <line x1="120" y1="80" x2="380" y2="320" stroke="#000" stroke-width="2"/> <text x="132" y="112" font-size="17" font-style="italic">p</text> <circle cx="250" cy="200" r="3" fill="#000"/> <text x="236" y="220" font-size="16" font-style="italic">N</text> <text x="330" y="176" font-size="15">×</text> <text x="345" y="174" font-size="16" font-style="italic">S</text> </svg>',
  'bod-primka.svg',
  'Bod S a přímka p procházející bodem N.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'7.1 Kružnice $k$ má střed $S$ a poloměr $|SN|$; její druhý průsečík s přímkou $p$ je bod $K$.','7.2 Obdélník vepsaný do kružnice má úhlopříčky procházející jejím středem, proto je $M$ obrazem $K$ a $L$ obrazem $N$ ve středové souměrnosti se středem $S$ (oba leží na $k$).','7.3 Bod $O$ leží na polopřímce $SN$ za bodem $N$ tak, že $|NO| = |MN|$; trojúhelník $MNO$ je rovnoramenný. Náčrt viz klíč.'},
  'Konstrukce: kružnice $k$ se středem $S$ a poloměrem $|SN|$, průsečík $K$ na přímce $p$; obdélník $KLMN$ vepsaný do $k$ ($M$, $L$ jsou obrazy $K$, $N$ ve středové souměrnosti podle $S$); bod $O$ na polopřímce $SN$ s $|NO| = |MN|$. Viz obrázek v klíči.',
  6, 12, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
