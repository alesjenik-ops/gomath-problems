String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD17C0T01';
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
  'CERMAT M5A 2017 – úloha 6',
  new List<String>{'Na první číselné ose jsou vyznačeny tři stejně velké díly, na druhé ose čtyři. $A$, $B$, $C$, $D$ představují čtyři neznámá čísla. Šipka na první ose znamená, že číslo $A$ je nutné vynásobit dvěma, aby vzniklo číslo 36; šipka na druhé ose znamená, že k prvnímu vyznačenému číslu je nutné přičíst 36, aby vzniklo číslo $D$.','6.1 Určete neznámá čísla $A$ a $B$.','6.2 Určete neznámá čísla $C$ a $D$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 200" font-family="sans-serif"> <line x1="30" y1="110" x2="325" y2="110" stroke="#000" stroke-width="2"/> <path d="M80 98V122M130 98V122M180 98V122M230 98V122" stroke="#000" stroke-width="2"/> <text x="80" y="84" font-size="19" text-anchor="middle">A</text> <text x="130" y="84" font-size="19" text-anchor="middle">B</text> <text x="230" y="84" font-size="19" text-anchor="middle">36</text> <path d="M80 128 Q155 182 226 136" fill="none" stroke="#000" stroke-width="2"/> <polygon points="230,128 220,136 231,142" fill="#000"/> <circle cx="155" cy="162" r="18" fill="#fff" stroke="#000" stroke-width="2"/> <text x="155" y="169" font-size="17" text-anchor="middle" font-weight="bold">· 2</text> <line x1="370" y1="110" x2="690" y2="110" stroke="#000" stroke-width="2"/> <path d="M410 98V122M460 98V122M510 98V122M560 98V122M610 98V122" stroke="#000" stroke-width="2"/> <text x="460" y="84" font-size="19" text-anchor="middle">C</text> <text x="560" y="84" font-size="19" text-anchor="middle">50</text> <text x="610" y="84" font-size="19" text-anchor="middle">D</text> <path d="M410 128 Q510 190 606 136" fill="none" stroke="#000" stroke-width="2"/> <polygon points="610,128 600,136 611,142" fill="#000"/> <circle cx="510" cy="168" r="22" fill="#fff" stroke="#000" stroke-width="2"/> <text x="510" y="175" font-size="17" text-anchor="middle" font-weight="bold">+36</text> </svg>',
  'ciselne-osy.svg',
  'Dvě číselné osy: první se čtyřmi značkami A, B, prázdná, 36 a šipkou krát 2; druhá s pěti značkami, z nichž jsou popsány C, 50 a D, a šipkou plus 36.',
  'Výchozí obrázek k úloze 6',
  new List<String>{'6.1 Z šipky plyne $2A=36$, tedy $A=18$. Od $A$ k číslu 36 vedou tři stejné díly, jeden díl je $(36-18):3=6$. Proto $B=18+6=24$.','6.2 Na druhé ose je $D$ o 36 větší než první značka. Mezi první značkou a $D$ jsou čtyři stejné díly, jeden díl je tedy $36:4=9$. Číslo 50 je předposlední značka, proto $D=50+9=59$ a $C$ je o dva díly menší než 50, tedy $C=50-18=32$.'},
  '6.1: $A=18$, $B=24$; 6.2: $C=32$, $D=59$',
  5, 6, '3',
  new List<String>{'zs1','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2017 – úloha 7 (konstrukce)',
  new List<String>{'V rovině leží dvě různoběžné přímky $p$, $r$ a bod $D$ (viz obrázek).','Bod $D$ je vrchol trojúhelníku $BCD$. Strana $BD$ leží na rovnoběžce s přímkou $r$. Strana $CD$ leží na kolmici k přímce $p$. Strana $BC$ leží na přímce $p$.','7.1 Sestrojte trojúhelník $BCD$ a označte všechny jeho vrcholy.','7.2 K bodům $B$, $C$, $D$ doplňte takový bod $A$, aby byl obrazec $ABCD$ obdélník. Obdélník $ABCD$ narýsujte.','7.3 Sestrojte střed obdélníku $ABCD$ a označte jej $S$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 660 430" font-family="sans-serif"> <rect x="2" y="2" width="656" height="426" fill="none" stroke="#bbb"/> <line x1="110" y1="70" x2="285" y2="365" stroke="#000" stroke-width="3"/> <text x="86" y="98" font-size="21" font-style="italic">r</text> <line x1="345" y1="410" x2="550" y2="85" stroke="#000" stroke-width="3"/> <text x="558" y="82" font-size="21" font-style="italic">p</text> <text x="190" y="56" font-size="21" font-style="italic">D</text> <text x="200" y="82" font-size="20" text-anchor="middle">×</text> </svg>',
  'primky-pr-bod-D.svg',
  'Dvě různoběžné přímky p a r a bod D nad nimi.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'7.1 Bodem $D$ vedeme rovnoběžku s přímkou $r$; její průsečík s přímkou $p$ je vrchol $B$. Bodem $D$ vedeme kolmici k přímce $p$; její pata na přímce $p$ je vrchol $C$. Trojúhelník $BCD$ má pravý úhel u vrcholu $C$.','7.2 Protože $ABCD$ je obdélník, je $A$ obrazem bodu $D$ v posunutí o vektor $CB$ (tj. $AB$ je rovnoběžná s $DC$ a $AD$ s $BC$). Bod $A$ leží na rovnoběžce s $p$ vedené bodem $D$ a na rovnoběžce s $DC$ vedené bodem $B$.','7.3 Střed $S$ je průsečík úhlopříček $AC$ a $BD$ (stačí sestrojit jednu úhlopříčku a její střed).'},
  'Konstrukce podle klíče: $B$ je průsečík rovnoběžky s $r$ vedené bodem $D$ s přímkou $p$; $C$ je pata kolmice z $D$ na přímku $p$; $A$ doplníme tak, aby $ABCD$ byl obdélník; $S$ je průsečík úhlopříček $AC$ a $BD$.',
  6, 10, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
