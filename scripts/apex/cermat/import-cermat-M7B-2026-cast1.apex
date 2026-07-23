String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD26C0T02';
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
  'CERMAT M7B 2026 – úloha 1',
  new List<String>{'Ve větší krabičce je 200 kusů papírových kapesníků, což je o čtvrtinu více než v menší krabičce.','Vypočtěte, kolik kusů papírových kapesníků je v menší krabičce.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Menší krabička má $x$ kusů, větší o čtvrtinu více: $x + \\frac{1}{4}x = \\frac{5}{4}x = 200$, tedy $x = 200 \\cdot \\frac{4}{5} = 160$.'},
  '$160$ kusů',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2026 – úloha 2.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$5 \\cdot \\frac{4}{25} - 3 + 3 : \\frac{5}{3} =$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$5 \\cdot \\frac{4}{25} = \\frac{4}{5}$ a $3 : \\frac{5}{3} = 3 \\cdot \\frac{3}{5} = \\frac{9}{5}$.','Celkem $\\frac{4}{5} - 3 + \\frac{9}{5} = \\frac{4 + 9}{5} - 3 = \\frac{13}{5} - \\frac{15}{5} = -\\frac{2}{5}$.'},
  '$-\\frac{2}{5}$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2026 – úloha 2.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\frac{3 \\cdot \\frac{9}{100} + 1 : 100}{\\frac{4}{5} + \\frac{2}{50}} =$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $3 \\cdot \\frac{9}{100} + 1 : 100 = \\frac{27}{100} + \\frac{1}{100} = \\frac{28}{100}$.','Jmenovatel: $\\frac{4}{5} + \\frac{2}{50} = \\frac{40}{50} + \\frac{2}{50} = \\frac{42}{50}$.','Podíl: $\\frac{28}{100} : \\frac{42}{50} = \\frac{28}{100} \\cdot \\frac{50}{42} = \\frac{28}{84} = \\frac{1}{3}$.'},
  '$\\frac{1}{3}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2026 – úloha 3',
  new List<String>{'Na číselné ose je zobrazeno 8 bodů oddělujících 7 stejných dílků. V prvním z těchto bodů je číslo 40 a body $A$, $B$ představují další dvě čísla. Součet čísel v bodech $A$, $B$ je 168.','Určete: 3.1 hodnotu, které odpovídá jeden dílek na číselné ose; 3.2 číslo v bodě $A$; 3.3 číslo v bodě $B$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 722 160" font-family="sans-serif"><line x1="30" y1="100" x2="702" y2="100" stroke="#000" stroke-width="2"/><polygon points="702,100 690,94 690,106" fill="#000"/><line x1="60" y1="91" x2="60" y2="109" stroke="#000" stroke-width="2"/><line x1="146" y1="91" x2="146" y2="109" stroke="#000" stroke-width="2"/><line x1="232" y1="91" x2="232" y2="109" stroke="#000" stroke-width="2"/><line x1="318" y1="91" x2="318" y2="109" stroke="#000" stroke-width="2"/><line x1="404" y1="91" x2="404" y2="109" stroke="#000" stroke-width="2"/><line x1="490" y1="91" x2="490" y2="109" stroke="#000" stroke-width="2"/><line x1="576" y1="91" x2="576" y2="109" stroke="#000" stroke-width="2"/><line x1="662" y1="91" x2="662" y2="109" stroke="#000" stroke-width="2"/><text x="60" y="82" font-size="18" text-anchor="middle">40</text><text x="404" y="132" font-size="18" font-style="italic" text-anchor="middle">A</text><text x="662" y="132" font-size="18" font-style="italic" text-anchor="middle">B</text></svg>',
  'osa.svg',
  'Číselná osa s osmi body a sedmi stejnými dílky; první bod je 40, bod A ve čtvrtém dílku a bod B v sedmém dílku.',
  'Číselná osa s body A a B',
  new List<String>{'Bod $A$ je vzdálen 4 dílky a bod $B$ 7 dílků od prvního bodu. Označme dílek $d$: $A = 40 + 4d$, $B = 40 + 7d$.','Součet: $(40 + 4d) + (40 + 7d) = 80 + 11d = 168$, odtud $11d = 88$, tedy $d = 8$.','3.1 jeden dílek $= 8$; 3.2 $A = 40 + 4 \\cdot 8 = 72$; 3.3 $B = 40 + 7 \\cdot 8 = 96$.'},
  '3.1: $8$; 3.2: $72$; 3.3: $96$',
  3, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
