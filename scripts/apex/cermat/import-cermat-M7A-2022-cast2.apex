String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD22C0T01';
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
  'CERMAT M7A 2022 – úloha 4.2',
  new List<String>{'V každé lahvi je dva a čtvrt litru sirupu. Ve všech lahvích je celkem $72$ litrů sirupu.','Určete počet lahví se sirupem.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Jedna lahev obsahuje $2\\frac{1}{4}$ litru $=2{,}25$ litru. Počet lahví $=72:2{,}25=32$.'},
  '$32$ lahví',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2022 – úloha 5',
  new List<String>{'Letadlo letělo nad oceánem stálou rychlostí a za každou půlhodinu uletělo vzdálenost $360$ km.','5.1 Vypočtěte, kolik kilometrů uletělo letadlo nad oceánem za $20$ minut.','5.2 Vypočtěte, za jak dlouho uletělo letadlo nad oceánem vzdálenost $9\\,000$ km. Výsledek uveďte v hodinách a minutách.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Rychlost: $360$ km za $30$ minut, tj. $12$ km za minutu.','5.1 Za $20$ minut: $12\\cdot 20=240$ km.','5.2 $9\\,000:12=750$ minut $=12$ hodin $30$ minut.'},
  '5.1: $240$ km; 5.2: za $12$ hodin $30$ minut',
  4, 4, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2022 – úloha 6',
  new List<String>{'Petr šel stálou rychlostí z domova do sportovní haly. Když byl ve třetině cesty od domova, jeho hodinky ukazovaly čas $15{:}28$. Když mu k hale zbývala ještě čtvrtina cesty, ukazovaly hodinky čas $15{:}43$.','6.1 Vypočtěte, kolik minut trvala Petrovi cesta z domova do sportovní haly.','6.2 Vypočtěte, jaký čas ukazovaly Petrovy hodinky, když došel do sportovní haly.','6.3 Vypočtěte, jaký čas ukazovaly Petrovy hodinky, když vycházel z domova.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 190" font-family="sans-serif"> <path d="M40,150 C110,70 170,80 240,120 C300,150 360,60 440,150" fill="none" stroke="#000" stroke-width="2"/> <circle cx="40" cy="150" r="5" fill="#000"/> <circle cx="200" cy="103" r="5" fill="#000"/> <circle cx="330" cy="95" r="5" fill="#000"/> <circle cx="440" cy="150" r="5" fill="#000"/> <text x="40" y="172" font-size="13" text-anchor="middle">domov</text> <text x="440" y="172" font-size="13" text-anchor="middle">hala</text> <text x="200" y="90" font-size="13" text-anchor="middle">15:28</text> <text x="330" y="82" font-size="13" text-anchor="middle">15:43</text> </svg>',
  'petr-cesta.svg',
  'Schematická křivka cesty z domova do haly se dvěma vyznačenými časy 15:28 a 15:43.',
  'Cesta Petra z domova do haly',
  new List<String>{'Mezi třetinou a třemi čtvrtinami cesty leží $\\frac{3}{4}-\\frac{1}{3}=\\frac{5}{12}$ cesty, což trvalo $15$ minut. Celá cesta tedy trvala $15\\cdot\\frac{12}{5}=36$ minut.','6.2 Od tří čtvrtin cesty do cíle zbývá $\\frac{1}{4}$ cesty, tj. $36:4=9$ minut; $15{:}43+9$ min $=15{:}52$.','6.3 První třetina cesty trvá $36:3=12$ minut; $15{:}28-12$ min $=15{:}16$.'},
  '6.1: $36$ minut; 6.2: $15{:}52$; 6.3: $15{:}16$',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
