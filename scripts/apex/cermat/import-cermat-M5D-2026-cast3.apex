String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD26C0T04';
Integer YEAR = 2026;

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
  'CERMAT M5D 2026 – úloha 6',
  new List<String>{'Spolek daroval na školní akci velké a malé balíčky sušenek. Malý balíček obsahuje $6$ sušenek a velký balíček $10$ sušenek. Ve všech darovaných balíčcích bylo celkem $264$ sušenek.','6.1 Dopoledne se na akci rozdalo $15$ balíčků sušenek. Velkých balíčků se dopoledne rozdalo o polovinu více než malých. Vypočtěte, kolik sušenek bylo v balíčcích, které zbyly na odpoledne.','6.2 Všech darovaných balíčků bylo dohromady $32$. Vypočtěte, kolik z darovaných balíčků bylo velkých.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Dopoledne: malých $m$, velkých $1{,}5m$; $m+1{,}5m=15\\Rightarrow m=6$ malých a $9$ velkých. Rozdáno $6\\cdot 6+9\\cdot 10=126$ sušenek, na odpoledne zbývá $264-126=138$ sušenek.','6.2 Balíčků je $32$ a sušenek $264$. Kdyby byly všechny malé, bylo by jen $32\\cdot 6=192$ sušenek; přebytek $264-192=72$ připadá na velké ($+4$ sušenky za každý velký balíček), tedy velkých $72:4=18$.'},
  '6.1: $138$ sušenek; 6.2: $18$ velkých balíčků',
  4, 6, '3',
  new List<String>{'zs1','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2026 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $B$, $D$ (viz obrázek).','Body $A$, $B$ jsou vrcholy trojúhelníku $ABC$, jehož strany $AB$ a $AC$ mají stejnou délku. Body $B$, $D$ jsou vrcholy trojúhelníku $BCD$, jehož strany $BD$ a $CD$ mají stejnou délku. Úsečka $BC$ je společnou stranou obou trojúhelníků $ABC$ a $BCD$.','Sestrojte vrchol $C$, označte ho písmenem a narýsujte trojúhelníky $ABC$ a $BCD$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 600" font-family="sans-serif"> <rect x="6" y="6" width="688" height="588" fill="none" stroke="#ccc"/> <text x="60" y="40" font-size="15">V rovině leží body A, B, D.</text> <text x="600" y="250" font-size="16" font-style="italic">D</text><text x="597" y="270" font-size="15">×</text> <text x="336" y="345" font-size="16" font-style="italic">A</text><text x="333" y="365" font-size="15">×</text> <text x="268" y="562" font-size="16" font-style="italic">B</text><text x="266" y="542" font-size="15">×</text> </svg>',
  'body-abd.svg',
  'Tři body A, B a D v rovině.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Vrchol $C$ má od $A$ stejnou vzdálenost jako $B$ (protože $|AC|=|AB|$) a od $D$ stejnou vzdálenost jako $B$ (protože $|CD|=|BD|$). Sestrojíme proto kružnici se středem $A$ a poloměrem $|AB|$ a kružnici se středem $D$ a poloměrem $|DB|$; jejich průsečík (podle obrázku vlevo nahoře) je vrchol $C$. Pak narýsujeme trojúhelníky $ABC$ a $BCD$.'},
  'Vrchol $C$ je průsečík kružnice se středem $A$ a poloměrem $|AB|$ s kružnicí se středem $D$ a poloměrem $|DB|$; poté narýsujeme trojúhelníky $ABC$ a $BCD$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2026 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží bod $L$ a přímka $p$ (viz obrázek).','Bod $L$ je vrchol čtverce $KLMN$. Přímka $p$ je kolmá ke straně $LM$ tohoto čtverce a protíná ji v bodě $P$. Bod $P$ je střed strany $LM$ čtverce $KLMN$.','Sestrojte střed $P$, vrcholy $K$, $M$, $N$ čtverce $KLMN$, označte je písmeny a čtverec narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 420" font-family="sans-serif"> <rect x="6" y="6" width="668" height="408" fill="none" stroke="#ccc"/> <text x="60" y="40" font-size="15">V rovině leží bod L a přímka p.</text> <line x1="60" y1="300" x2="630" y2="235" stroke="#000" stroke-width="2"/> <text x="640" y="235" font-size="16" font-style="italic">p</text> <text x="418" y="425" font-size="15"></text> <text x="416" y="408" font-size="15">×</text><text x="416" y="425" font-size="16" font-style="italic">L</text> </svg>',
  'bod-l-primka-p.svg',
  'Bod L a přímka p v rovině.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Bod $P$ je pata kolmice spuštěné z bodu $L$ na přímku $p$ (přímka $LM$ je kolmá k $p$). Protože $P$ je střed strany $LM$, je bod $M$ obrazem bodu $L$ ve středové souměrnosti se středem $P$, tj. $|PM|=|PL|$ a $|LM|=2|LP|$. Nad úsečkou $LM$ pak sestrojíme čtverec $KLMN$; ten lze umístit na obě strany přímky $LM$, úloha má proto dvě řešení.'},
  'Dvě řešení: $P$ je pata kolmice z $L$ na $p$, $M$ obraz $L$ ve středové souměrnosti podle $P$ ($|LM|=2|LP|$), nad $LM$ čtverec $KLMN$ na obě strany (viz obrázek v klíči).',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
