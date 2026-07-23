String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD21C0T04';
Integer YEAR = 2021;

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
  'CERMAT M5D 2021 – úloha 1.1',
  new List<String>{'Vypočtěte: $(11\\,706-7\\,302):12=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(11\\,706-7\\,302):12 = 4\\,404:12 = 367$.'},
  '$367$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2021 – úloha 1.2',
  new List<String>{'Vypočtěte: $2\\cdot 1\\,600-585-85\\cdot 20=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$3\\,200-585-1\\,700 = 915$.'},
  '$915$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2021 – úloha 2',
  new List<String>{'Na číselné ose je zobrazeno šestnáct stejných dílků, číslo $45$ a dvě neznámá čísla $A$ a $B$. Číslo $B$ je dvakrát větší než číslo $A$. Součet čísel $A$ a $B$ je stejný jako součet čísel $45$ a $C$.','2.1 K odpovídajícímu bodu číselné osy zapište číslo $0$.','2.2 K odpovídajícímu bodu číselné osy zapište číslo $C$.','V záznamovém archu oba body na ose zvýrazněte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 120" font-family="sans-serif"><line x1="40" y1="70" x2="536" y2="70" stroke="#000" stroke-width="2"/><polygon points="536,70 524,64 524,76" fill="#000"/><line x1="40" y1="62" x2="40" y2="78" stroke="#000" stroke-width="1.4"/><line x1="70" y1="62" x2="70" y2="78" stroke="#000" stroke-width="1.4"/><line x1="100" y1="62" x2="100" y2="78" stroke="#000" stroke-width="1.4"/><line x1="130" y1="62" x2="130" y2="78" stroke="#000" stroke-width="1.4"/><line x1="160" y1="62" x2="160" y2="78" stroke="#000" stroke-width="1.4"/><line x1="190" y1="62" x2="190" y2="78" stroke="#000" stroke-width="1.4"/><line x1="220" y1="62" x2="220" y2="78" stroke="#000" stroke-width="1.4"/><line x1="250" y1="62" x2="250" y2="78" stroke="#000" stroke-width="1.4"/><line x1="280" y1="62" x2="280" y2="78" stroke="#000" stroke-width="1.4"/><line x1="310" y1="62" x2="310" y2="78" stroke="#000" stroke-width="1.4"/><line x1="340" y1="62" x2="340" y2="78" stroke="#000" stroke-width="1.4"/><line x1="370" y1="62" x2="370" y2="78" stroke="#000" stroke-width="1.4"/><line x1="400" y1="62" x2="400" y2="78" stroke="#000" stroke-width="1.4"/><line x1="430" y1="62" x2="430" y2="78" stroke="#000" stroke-width="1.4"/><line x1="460" y1="62" x2="460" y2="78" stroke="#000" stroke-width="1.4"/><line x1="490" y1="62" x2="490" y2="78" stroke="#000" stroke-width="1.4"/><line x1="520" y1="62" x2="520" y2="78" stroke="#000" stroke-width="1.4"/><text x="220" y="100" font-size="16" text-anchor="middle" font-style="italic">45</text><text x="280" y="100" font-size="16" text-anchor="middle" font-style="italic">A</text><text x="430" y="100" font-size="16" text-anchor="middle" font-style="italic">B</text></svg>',
  'cislena-osa.svg',
  'Číselná osa se šestnácti stejnými dílky; vyznačeno je číslo 45 a body A a B.',
  'Číselná osa k úloze 2',
  new List<String>{'Vzdálenost mezi $A$ a $B$ je pět dílků; protože $B=2A$, odpovídá $A$ také pěti dílkům. Číslo $45$ je tři dílky vpravo od nuly, proto jeden dílek $=45:3=15$. Odtud $A=75$ a $B=150$.','2.1 Číslo $0$ leží tři dílky vlevo od čísla $45$.','2.2 Ze vztahu $A+B=45+C$ plyne $75+150=45+C$, tedy $C=180$; bod $C$ leží dva dílky vpravo od bodu $B$.'},
  '2.1: bod $0$ je tři dílky vlevo od čísla $45$; 2.2: $C=180$ (dva dílky vpravo od bodu $B$)',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2021 – úloha 3.1',
  new List<String>{'Telefonní hovor trval $8$ minut a $55$ sekund. Během hovoru blikala žárovka. Žárovka poprvé blikla po prvních $25$ sekundách hovoru a poté znovu po každých $25$ sekundách.','Určete, kolikrát během celého hovoru blikla žárovka.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Hovor trval $8\\cdot 60+55=535$ sekund. Žárovka blikne v čase $25, 50, 75, \\ldots$ Počet bliknutí je $535:25=21$ (zbytek $10$), tedy $21$krát.'},
  '$21$krát',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2021 – úloha 3.2',
  new List<String>{'Řeka Labe protéká pouze dvěma státy a délka celého jejího toku je $1\\,094$ km. V Německu je tok Labe o $352$ km delší než v České republice.','Vypočtěte délku toku Labe v Německu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Délka toku v České republice: $(1\\,094-352):2=371$ km. Délka toku v Německu: $371+352=723$ km.'},
  '$723$ km',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
