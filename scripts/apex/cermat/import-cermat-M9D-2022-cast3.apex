String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD22C0T04';
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
  'CERMAT M9D 2022 – úloha 8',
  new List<String>{'Obrazec se skládá z tmavého čtverce, dvou shodných bílých rovnoramenných trojúhelníků a dvou shodných bílých lichoběžníků. S každou stranou čtverce splývá základna jednoho bílého útvaru. Tmavý čtverec má obsah $144$ cm², což je polovina obsahu celého obrazce. Jeden trojúhelník má obsah $30$ cm². Délka kratší základny lichoběžníku je $9$ cm.','Vypočtěte v cm','8.1 výšku na základnu rovnoramenného trojúhelníku,','8.2 výšku lichoběžníku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 260" font-family="sans-serif"> <rect x="200" y="80" width="100" height="100" fill="#b8b8b8" stroke="#000"/> <polygon points="200,80 200,180 150,130" fill="#fff" stroke="#000"/> <polygon points="300,80 300,180 350,130" fill="#fff" stroke="#000"/> <polygon points="200,80 300,80 285,45 215,45" fill="#fff" stroke="#000"/> <polygon points="200,180 300,180 285,215 215,215" fill="#fff" stroke="#000"/> </svg>',
  'obrazec.svg',
  'Tmavý čtverec uprostřed, dva bílé trojúhelníky vlevo a vpravo, dva bílé lichoběžníky nahoře a dole (schematicky).',
  'Obrazec z tmavého čtverce, dvou trojúhelníků a dvou lichoběžníků',
  new List<String>{'Strana čtverce je $\\sqrt{144}=12$ cm, což je základna každého bílého útvaru. Bílé útvary mají dohromady obsah $144$ cm² (polovina obrazce).','8.1 Trojúhelník: $30=\\frac{1}{2}\\cdot 12\\cdot v$, tedy $v=5$ cm.','8.2 Dva trojúhelníky mají $60$ cm², dva lichoběžníky tedy $144-60=84$ cm², jeden $42$ cm². Lichoběžník: $42=\\frac{12+9}{2}\\cdot v=10{,}5\\,v$, tedy $v=4$ cm.'},
  '8.1: $5$ cm; 8.2: $4$ cm',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2022 – úloha 9',
  new List<String>{'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).','Bod $A$ je vrchol rovnoběžníku $ABCD$, bod $S$ je střed tohoto rovnoběžníku. Na přímce $p$ leží vrchol $B$ rovnoběžníku $ABCD$. Úhel $ASB$ má velikost $120^\\circ$.','Sestrojte vrcholy $B$, $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 235" font-family="sans-serif"> <line x1="40" y1="200" x2="390" y2="120" stroke="#000" stroke-width="2"/> <text x="398" y="118" font-size="16" font-style="italic">p</text> <line x1="150" y1="185" x2="150" y2="166" stroke="#000"/> <text x="150" y="204" font-size="15" text-anchor="middle" font-style="italic">A</text> <text x="255" y="88" font-size="15" text-anchor="middle">×</text> <text x="255" y="76" font-size="15" text-anchor="middle" font-style="italic">S</text> </svg>',
  'body-A-S-p.svg',
  'Přímka p procházející bodem A a bod S nad přímkou.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Vrchol $B$ leží na přímce $p$; sestrojíme jej tak, aby $|\\angle ASB|=120^\\circ$ (přenesením úhlu $120^\\circ$ při vrcholu $S$ k polopřímce $SA$). Bod $C$ je obraz bodu $A$ ve středové souměrnosti se středem $S$ (S je střed úhlopříčky $AC$), bod $D$ je obraz bodu $B$ podle $S$. Spojením vznikne rovnoběžník $ABCD$.'},
  'Konstrukce rovnoběžníku $ABCD$: $B$ na přímce $p$ s $|\\angle ASB|=120^\\circ$, $C$ obraz $A$ a $D$ obraz $B$ ve středové souměrnosti se středem $S$ (viz obrázek v klíči).',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
