String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD22C0T04';
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
  'CERMAT M7D 2022 – úloha 7',
  new List<String>{'Obrazec se skládá z tmavého čtverce, dvou shodných bílých rovnoramenných trojúhelníků a dvou shodných bílých lichoběžníků. S každou stranou čtverce splývá základna jednoho bílého útvaru. Tmavý čtverec má stranu délky $12$ cm a jeho obsah je polovinou obsahu celého obrazce. Jeden trojúhelník má obsah $30$ cm$^2$. Délka kratší základny lichoběžníku je $9$ cm.','7.1 Vypočtěte v cm výšku na základnu rovnoramenného trojúhelníku.','7.2 Vypočtěte v cm výšku lichoběžníku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 260" font-family="sans-serif" font-size="13"> <polygon points="100,80 200,80 150,28" fill="#fff" stroke="#000"/> <polygon points="100,180 200,180 150,232" fill="#fff" stroke="#000"/> <polygon points="100,80 100,180 52,155 52,105" fill="#fff" stroke="#000"/> <polygon points="200,80 200,180 248,155 248,105" fill="#fff" stroke="#000"/> <rect x="100" y="80" width="100" height="100" fill="#9a9a9a" stroke="#000"/> </svg>',
  'obrazec.svg',
  'Tmavý čtverec se čtyřmi bílými útvary na stranách: dvěma trojúhelníky a dvěma lichoběžníky (schematicky).',
  'Složený obrazec',
  new List<String>{'Obsah čtverce je $12^2=144$ cm$^2$, což je polovina obrazce, takže celý obrazec má $288$ cm$^2$ a bílé útvary dohromady $288-144=144$ cm$^2$.','7.1 Základna trojúhelníku splývá se stranou čtverce, tj. $12$ cm. Z $30=\\frac{1}{2}\\cdot 12\\cdot v$ plyne $v=5$ cm.','7.2 Dva trojúhelníky mají $60$ cm$^2$, dva lichoběžníky tedy $144-60=84$ cm$^2$, jeden $42$ cm$^2$. Delší základna lichoběžníku je $12$ cm, kratší $9$ cm. Z $42=\\frac{12+9}{2}\\cdot v$ plyne $v=4$ cm.'},
  '7.1: $5$ cm; 7.2: $4$ cm',
  3, 6, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2022 – úloha 8 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).','Bod $A$ je vrchol rovnoběžníku $ABCD$, bod $S$ je střed tohoto rovnoběžníku. Na přímce $p$ leží vrchol $B$ rovnoběžníku $ABCD$. Úhel $ASB$ má velikost $120^\\circ$.','Sestrojte vrcholy $B$, $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 210" font-family="sans-serif" font-size="14"> <line x1="40" y1="175" x2="340" y2="115" stroke="#000" stroke-width="1.5"/><text x="346" y="117" font-style="italic">p</text> <line x1="150" y1="146" x2="150" y2="162" stroke="#000"/><text x="145" y="180" font-style="italic">A</text> <text x="204" y="90" font-size="15">×</text><text x="213" y="78" font-style="italic">S</text> </svg>',
  'primka-A-S.svg',
  'Přímka p procházející bodem A a bod S nad přímkou (výchozí obrázek ke konstrukci).',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Bod $B$ leží na přímce $p$ a platí $|\\angle ASB|=120^\\circ$; sestrojíme jej pomocí úhlu $120^\\circ$ s vrcholem $S$ a ramenem $SA$ (druhé rameno protne přímku $p$ v bodě $B$).','Protože $S$ je střed rovnoběžníku, je bod $C$ obrazem $A$ a bod $D$ obrazem $B$ ve středové souměrnosti se středem $S$ (tj. $S$ je střed úhlopříček $AC$ i $BD$). Doplněním vznikne rovnoběžník $ABCD$.'},
  'Konstrukce rovnoběžníku $ABCD$: $B$ na přímce $p$ s $|\\angle ASB|=120^\\circ$, $C$ středovou souměrností bodu $A$ podle $S$, $D$ středovou souměrností bodu $B$ podle $S$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
