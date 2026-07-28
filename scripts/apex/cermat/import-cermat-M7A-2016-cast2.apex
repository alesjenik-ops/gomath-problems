String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M7A 2016 – úloha 5',
  new List<String>{'Ve třech sedmých třídách je celkem 75 žáků. Počty dívek a chlapců jsou v poměru $8:7$. Počet žáků třídy 7. A tvoří třetinu všech žáků sedmých tříd. Ve třídě 7. B je o čtyři žáky více než ve třídě 7. C.','Vypočtěte:','5.1 celkový počet chlapců v 7. třídách;','5.2 počet žáků v 7. C.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 350" font-family="sans-serif"><defs><marker id="sip" markerWidth="9" markerHeight="9" refX="8" refY="3" orient="auto"><path d="M0,0 L8,3 L0,6 z" fill="#000"/></marker></defs><ellipse cx="180" cy="72" rx="56" ry="24" fill="#fff" stroke="#000" stroke-width="2"/><ellipse cx="380" cy="72" rx="56" ry="24" fill="#fff" stroke="#000" stroke-width="2"/><text x="180" y="34" font-size="18" text-anchor="middle" font-weight="bold">dívky</text><text x="380" y="34" font-size="18" text-anchor="middle" font-weight="bold">chlapci</text><text x="280" y="72" font-size="16" text-anchor="middle">8 : 7</text><ellipse cx="280" cy="172" rx="52" ry="24" fill="#fff" stroke="#000" stroke-width="2"/><text x="280" y="178" font-size="16" text-anchor="middle">75 žáků</text><line x1="280" y1="150" x2="208" y2="92" stroke="#000" stroke-width="2" marker-end="url(#sip)"/><line x1="280" y1="150" x2="352" y2="92" stroke="#000" stroke-width="2" marker-end="url(#sip)"/><text x="150" y="212" font-size="15" text-anchor="middle">z nich 1/3</text><ellipse cx="120" cy="296" rx="52" ry="24" fill="#fff" stroke="#000" stroke-width="2"/><text x="120" y="256" font-size="18" text-anchor="middle" font-weight="bold">7. A</text><ellipse cx="280" cy="296" rx="52" ry="24" fill="#fff" stroke="#000" stroke-width="2"/><text x="232" y="256" font-size="18" text-anchor="middle" font-weight="bold">7. B</text><ellipse cx="440" cy="296" rx="52" ry="24" fill="#fff" stroke="#000" stroke-width="2"/><text x="440" y="256" font-size="18" text-anchor="middle" font-weight="bold">7. C</text><line x1="280" y1="196" x2="150" y2="276" stroke="#000" stroke-width="2" marker-end="url(#sip)"/><line x1="280" y1="196" x2="280" y2="268" stroke="#000" stroke-width="2" marker-end="url(#sip)"/><line x1="280" y1="196" x2="410" y2="276" stroke="#000" stroke-width="2" marker-end="url(#sip)"/><line x1="388" y1="306" x2="336" y2="306" stroke="#000" stroke-width="2" marker-end="url(#sip)"/><text x="362" y="332" font-size="15" text-anchor="middle">+ 4</text></svg>',
  'schema-zaci.svg',
  'Schéma: 75 žáků se dělí na dívky a chlapce v poměru 8 ku 7 a na třídy 7. A, 7. B a 7. C, přičemž 7. A tvoří třetinu a 7. B má o 4 žáky více než 7. C.',
  'Schéma rozdělení 75 žáků sedmých tříd',
  new List<String>{'5.1 Poměr $8:7$ znamená $8+7=15$ dílů, na jeden díl připadá $75:15=5$ žáků. Chlapců je $7\\cdot 5=35$.','5.2 Ve 7. A je $75:3=25$ žáků, ve 7. B a 7. C dohromady $75-25=50$ žáků.','Je-li ve 7. C $x$ žáků, pak $x+(x+4)=50$, tedy $2x=46$ a $x=23$.'},
  '5.1: $35$ chlapců; 5.2: $23$ žáků',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2016 – úloha 6',
  new List<String>{'Na lanové dráze jezdí mezi horní a dolní stanicí dvě kabiny proti sobě. Z obou míst vyjíždějí kabiny ve stejném okamžiku a míjejí se pravidelně v polovině doby jízdy.','Hodiny ukazují 16:38 a kabiny se minuly před 3 minutami. Do stanic přijedou v 16:40, tam setrvají 5 minut a pak je čeká poslední jízda zpět.','6.1 Vypočtěte, jak dlouho trvá jízda kabiny mezi horní a dolní stanicí.','6.2 Určete přesný čas, kdy se kabiny minou při jízdě zpět.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Kabiny se minuly v $16{:}38-3$ min, tedy v 16:35. Do stanic přijedou v 16:40, druhá polovina jízdy tak trvá 5 minut. Celá jízda trvá $2\\cdot 5=10$ minut.','6.2 Zpět vyjedou v $16{:}40+5$ min $=16{:}45$. Minou se v polovině jízdy, tj. po 5 minutách – v 16:50.'},
  '6.1: $10$ minut; 6.2: v 16:50',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2016 – úloha 7',
  new List<String>{'Karel stavěl věže z kostek. Když na každou věž použil 6 kostek, žádná kostka mu nezbyla. Když vše zboural a na každou novou věž použil 8 kostek, také mu žádná kostka nezbyla.','Karel stavěl z více než 60 a méně než ze 100 kostek.','Vypočtěte, z kolika kostek mohl Karel stavět. Uveďte všechny možnosti.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Počet kostek musí být dělitelný 6 i 8, je to tedy násobek nejmenšího společného násobku čísel 6 a 8, tj. násobek čísla $24$.','Násobky čísla 24 větší než 60 a menší než 100 jsou $72$ a $96$.'},
  '$72$ kostek; $96$ kostek',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
