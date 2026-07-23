String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD22C0T02';
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
  'CERMAT M9B 2022 – úloha 8',
  new List<String>{'Bílý čtverec má obsah $9$ cm², černá plocha uvnitř čtverce $KLMN$ má obsah $16$ cm² a šedá plocha uvnitř čtverce $ABCD$ má obsah $56$ cm². Bílý čtverec leží uvnitř čtverce $KLMN$ a ten uvnitř čtverce $ABCD$.','8.1 Vypočtěte v cm délku strany $KL$.','8.2 Vypočtěte v cm obvod čtverce $ABCD$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 280" font-family="sans-serif"> <rect x="55" y="35" width="200" height="200" fill="#cfcfcf" stroke="#000" stroke-width="1.5"/> <text x="46" y="30" font-size="14" font-style="italic">D</text> <text x="252" y="30" font-size="14" font-style="italic">C</text> <text x="46" y="252" font-size="14" font-style="italic">A</text> <text x="252" y="252" font-size="14" font-style="italic">B</text> <polygon points="150,55 240,120 175,205 90,140" fill="#111" stroke="#000"/> <polygon points="150,95 203,133 170,173 120,138" fill="#fff" stroke="#000"/> <text x="150" y="48" font-size="13" font-style="italic" text-anchor="middle">N</text> <text x="250" y="122" font-size="13" font-style="italic">M</text> <text x="175" y="222" font-size="13" font-style="italic" text-anchor="middle">L</text> <text x="76" y="142" font-size="13" font-style="italic">K</text> </svg>',
  'vnorene-ctverce.svg',
  'Šedý čtverec ABCD, uvnitř něj natočený černý čtverec KLMN a uvnitř něj bílý čtverec.',
  'Vnořené čtverce ABCD, KLMN a bílý čtverec',
  new List<String>{'8.1 Čtverec $KLMN$ má obsah $16+9=25$ cm², tedy $|KL|=\\sqrt{25}=5$ cm.','8.2 Čtverec $ABCD$ má obsah $56+25=81$ cm², jeho strana je $\\sqrt{81}=9$ cm, obvod $4\\cdot9=36$ cm.'},
  '8.1: $5$ cm; 8.2: $36$ cm',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2022 – úloha 9',
  new List<String>{'V rovině leží bod $C$ a přímka $q$ (viz obrázek).','Bod $C$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Základna $AB$ leží na přímce $q$ a má délku $6$ cm.','Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 240" font-family="sans-serif"> <line x1="60" y1="185" x2="360" y2="70" stroke="#000" stroke-width="1.5"/> <text x="368" y="66" font-size="15" font-style="italic">q</text> <text x="250" y="170" font-size="14" text-anchor="middle">×</text> <text x="250" y="188" font-size="14" font-style="italic" text-anchor="middle">C</text> </svg>',
  'bod-primka-q.svg',
  'Přímka q stoupající zleva doprava a bod C ležící pod přímkou.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Patou kolmice vedené z bodu $C$ k přímce $q$ je střed $M$ základny $AB$. Na přímce $q$ naneseme na obě strany od $M$ vzdálenost $3$ cm a získáme vrcholy $A$ a $B$ (aby $|AB|=6$ cm). Spojením s bodem $C$ vznikne rovnoramenný trojúhelník $ABC$.'},
  'Konstrukce: $M$ je pata kolmice z $C$ na $q$ (střed $AB$); $A$ a $B$ leží na $q$ ve vzdálenosti $3$ cm od $M$ na obě strany, $|AB|=6$ cm (viz obrázek v klíči).',
  2, 5, '2',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
