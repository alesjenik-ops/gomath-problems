String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 2. náhradní termín (M9D)';
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
  'CERMAT 2024 M9D · úloha 8',
  new List<String>{'Průměrné denní činnosti paní Kratochvílové ($24$ hodin) jsou v grafu rozděleny takto: zaměstnání $25\\ \\%$, spánek $30\\ \\%$, denní povinnosti $35\\ \\%$, volný čas $10\\ \\%$. Její volný čas se dělí na sledování TV, sport a četbu, přičemž sport tvoří $40\\ \\%$ volného času.','8.1 Kolik hodin denně tráví v zaměstnání?','8.2 Kolik minut denně sportuje? (Zaokrouhlete na celé minuty.)'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: zaměstnání tvoří $25\\ \\%$ z $24$ hodin, tj. $6$ hodin.','8.2: volný čas tvoří $10\\ \\%$ z $24$ hodin $=2{,}4$ h $=144$ minut; sport je $40\\ \\%$ volného času $=0{,}4\\cdot144\\doteq58$ minut.'},
  '8.1: $6$ hodin; 8.2: $58$ minut',
  4, 5, '3',
  new List<String>{'zs2','r9','procenta','statistika','porozumeni','bez-kalkulacky','bezny-zivot'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 9',
  new List<String>{'V rovině je dána přímka $p$ a body $A$, $S$, které na $p$ neleží. Bod $A$ je vrchol obdélníku $ABCD$, bod $S$ je střed obdélníku (průsečík úhlopříček), vrchol $D$ leží na přímce $p$ (viz obrázek).','Sestrojte obdélník $ABCD$. Nalezněte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 536 514"><path d="M4 4L5 4L5 510L4 510Z" style="fill:#000000"/><path d="M456 4L458 4L458 510L456 510Z" style="fill:#000000"/><path d="M57 197L402 168M148 254L140 261M140 254L148 261M224 232L217 240M217 232L224 240" style="fill:none;stroke:#000000;stroke-width:2"/><text x="70" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině je dána přímka</text><text x="133" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="156" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a body</text><text x="179" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="188" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="196" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="200" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="259" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">které neleží na přímce</text><text x="318" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="336" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">. Bod</text><text x="353" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="380" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je vrchol</text><text x="37" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">obdélníku</text><text x="77" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABCD</text><text x="105" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">, bod</text><text x="121" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="244" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je střed obdélníku (průsečík úhlopříček). Vrchol</text><text x="368" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="409" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">obdélníku leží</text><text x="36" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">na přímce</text><text x="66" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="71" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="134" y="267" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="221" y="230" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="85" y="191" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">p</text></svg>',
  'obr.svg',
  'Přímka p a body A, S, které na ní neleží.',
  '',
  new List<String>{'Vrchol $C$ je obraz $A$ ve středové souměrnosti podle $S$; kružnice $k$ se středem $S$ a poloměrem $|SA|$ prochází všemi vrcholy.','Vrchol $D$ leží na kružnici $k$ i na přímce $p$ (Thaletova kružnice nad $AC$ zaručí pravý úhel u $D$); průsečíky dávají dvě řešení, $B$ je obraz $D$ podle $S$.'},
  'Kružnice $k(S,|SA|)$; $C$ je obraz $A$ podle $S$; $D=k\\cap p$ (Thaletova kružnice nad $AC$), $B$ obraz $D$ podle $S$ (dvě řešení).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PDD24C0T04', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
