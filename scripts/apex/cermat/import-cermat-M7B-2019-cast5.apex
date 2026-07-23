String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M7B 2019 – úloha 11',
  new List<String>{'Na obrázku jsou dvě rovnoběžné přímky (označené shodnými značkami), svislá přímka k nim kolmá a dvě různoběžky. Jsou vyznačeny úhly $15^\\circ$, $38^\\circ$ a hledaný úhel $\\alpha$.','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $53^\\circ$','B) $53^\\circ$','C) $63^\\circ$','D) $67^\\circ$','E) větší než $67^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 285" font-family="sans-serif"> <line x1="60" y1="80" x2="445" y2="80" stroke="#000" stroke-width="2"/> <line x1="60" y1="210" x2="445" y2="210" stroke="#000" stroke-width="2"/> <line x1="405" y1="71" x2="415" y2="89" stroke="#000" stroke-width="1.4"/> <line x1="413" y1="71" x2="423" y2="89" stroke="#000" stroke-width="1.4"/> <line x1="405" y1="201" x2="415" y2="219" stroke="#000" stroke-width="1.4"/> <line x1="413" y1="201" x2="423" y2="219" stroke="#000" stroke-width="1.4"/> <line x1="95" y1="52" x2="95" y2="256" stroke="#000" stroke-width="2"/> <path d="M95 98 L113 98 L113 80" fill="none" stroke="#000" stroke-width="1.3"/> <circle cx="104" cy="89" r="1.6" fill="#000"/> <line x1="95" y1="210" x2="368" y2="80" stroke="#000" stroke-width="2"/> <line x1="198" y1="272" x2="368" y2="80" stroke="#000" stroke-width="2"/> <text x="112" y="196" font-size="17" font-style="italic">a</text> <text x="300" y="120" font-size="15">15°</text> <text x="252" y="200" font-size="15">38°</text> </svg>',
  'uhly-rovnobezky.svg',
  'Dvě rovnoběžné vodorovné přímky, svislá kolmá přímka s pravým úhlem a dvě různoběžky svírající úhly 15° a 38°; hledaný úhel alfa.',
  'Výchozí obrázek k úloze 11',
  new List<String>{'Různoběžka svírá s rovnoběžkami úhel $38^\\circ$. Mezi oběma různoběžkami je $15^\\circ$, takže druhá různoběžka svírá s rovnoběžkami $38^\\circ-15^\\circ=23^\\circ$. Svislá přímka je k rovnoběžkám kolmá, proto $\\alpha=90^\\circ-23^\\circ=67^\\circ$.'},
  'D) $67^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2019 – úloha 12',
  new List<String>{'Do prázdného klobouku jsme vysypali červené a zelené kuličky, zelených bylo o 6 více než červených. Pak jsme z klobouku vytáhli třetinu všech červených a třetinu všech zelených kuliček. V klobouku tak ubylo 12 kuliček.','Kolik červených kuliček v klobouku zbylo?'},
  new List<String>{'A) 5','B) 10','C) 12','D) 15','E) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Vytažená třetina všech kuliček je 12, takže všech kuliček bylo $36$. Červené $c$, zelené $c+6$: $c+(c+6)=36\\Rightarrow c=15$. V klobouku zbyly dvě třetiny červených, tj. $\\frac{2}{3}\\cdot 15=10$.'},
  'B) 10',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2019 – úloha 13',
  new List<String>{'V grafu jsou všichni žáci třídy rozděleni podle počtu svých sourozenců do čtyř skupin. Ve třídě je celkem 30 žáků a s nimi do třídy nechodí žádný z jejich sourozenců. Pouze jeden žák má 3 sourozence. Skupina žáků se 2 sourozenci tvoří šestinu žáků třídy. Žáků, kteří mají nějakého sourozence (jednoho, dva, nebo tři), je dvakrát více než těch, kteří žádného sourozence nemají.','Kolik žáků třídy nemá žádného sourozence?'},
  new List<String>{'A) 8','B) 10','C) 11','D) 12','E) 15'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 330" font-family="sans-serif"><path d="M205,165 L205.0,73.0 A92,92 0 0 1 224.1,75.0 Z" fill="#585858" stroke="#000" stroke-width="1.2"/><path d="M205,165 L224.1,75.0 A92,92 0 0 1 273.4,226.6 Z" fill="#c9c9c9" stroke="#000" stroke-width="1.2"/><path d="M205,165 L273.4,226.6 A92,92 0 0 1 125.3,119.0 Z" fill="#efefef" stroke="#000" stroke-width="1.2"/><path d="M205,165 L125.3,119.0 A92,92 0 0 1 205.0,73.0 Z" fill="#ffffff" stroke="#000" stroke-width="1.2"/><text x="205" y="22" font-size="13" text-anchor="middle">žáci se 3 sourozenci</text><text x="322" y="120" font-size="13">žáci bez sourozenců</text><text x="205" y="312" font-size="13" text-anchor="middle">žáci s 1 sourozencem</text><text x="8" y="95" font-size="13">žáci se 2 sourozenci</text></svg>',
  'graf-sourozenci.svg',
  'Kruhový graf rozdělení 30 žáků podle počtu sourozenců na čtyři výseče (bez, 1, 2, 3 sourozenci).',
  'Rozdělení žáků podle počtu sourozenců',
  new List<String>{'Nechť žáků bez sourozence je $x$; žáků s aspoň jedním sourozencem je $2x$, dohromady $3x=30$, tedy $x=10$.'},
  'B) 10',
  2, 3, '2',
  new List<String>{'zs2','r7','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
