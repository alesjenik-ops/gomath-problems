String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD22C0T04';
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
  'CERMAT M5D 2022 – úloha 9',
  new List<String>{'Ve stánku mají celkem $140$ krabiček s čaji. Všechny jsou naskládány do sloupečků po čtyřech krabičkách. V $10$ sloupečcích jsou pouze krabičky s černými čaji a v každém ze zbývajících sloupečků je jedna krabička s černým čajem a $3$ krabičky s ovocnými čaji.','Kolik krabiček s ovocnými čaji mají ve stánku?'},
  new List<String>{'A) 30 krabiček','B) 40 krabiček','C) 75 krabiček','D) 100 krabiček','E) jiný počet krabiček'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Sloupečků je $140 : 4 = 35$. Z toho $10$ je jen s černým čajem, zbývá $25$ smíšených sloupečků a v každém jsou $3$ ovocné krabičky: $25 \\cdot 3 = 75$.'},
  'C) 75 krabiček',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2022 – úloha 10',
  new List<String>{'Čtyři chlapci (Petr, Radek, Standa a Tomáš) sbírají kartičky s hokejisty. V grafu některé údaje chybí (u Petra a Standy). Standa má o polovinu méně kartiček než Tomáš a oba dohromady mají $24$ kartiček. Petr má o $5$ kartiček více než Radek.','O kolik se liší počet Petrových a Standových kartiček?'},
  new List<String>{'A) o 1 kartičku','B) o 8 kartiček','C) o 10 kartiček','D) o 17 kartiček','E) o jiný počet kartiček'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 484 262" font-family="sans-serif"><text x="272.0" y="26" font-size="14" text-anchor="middle">Počet kartiček</text><line x1="90" y1="40" x2="90" y2="232" stroke="#bbb" stroke-width="1"/><line x1="142" y1="40" x2="142" y2="232" stroke="#bbb" stroke-width="1"/><line x1="194" y1="40" x2="194" y2="232" stroke="#bbb" stroke-width="1"/><line x1="246" y1="40" x2="246" y2="232" stroke="#bbb" stroke-width="1"/><line x1="298" y1="40" x2="298" y2="232" stroke="#bbb" stroke-width="1"/><line x1="350" y1="40" x2="350" y2="232" stroke="#bbb" stroke-width="1"/><line x1="402" y1="40" x2="402" y2="232" stroke="#bbb" stroke-width="1"/><line x1="454" y1="40" x2="454" y2="232" stroke="#bbb" stroke-width="1"/><line x1="90" y1="40" x2="90" y2="232" stroke="#000" stroke-width="2"/><text x="90" y="252" font-size="13" text-anchor="middle">0</text><text x="82" y="68.5" font-size="13" text-anchor="end">Petr</text><line x1="90" y1="64.0" x2="454" y2="64.0" stroke="#777" stroke-width="1" stroke-dasharray="7 5"/><text x="82" y="116.5" font-size="13" text-anchor="end">Radek</text><rect x="90" y="97.0" width="260" height="30" fill="#9a9a9a" stroke="#000" stroke-width="1"/><text x="82" y="164.5" font-size="13" text-anchor="end">Standa</text><line x1="90" y1="160.0" x2="454" y2="160.0" stroke="#777" stroke-width="1" stroke-dasharray="7 5"/><text x="82" y="212.5" font-size="13" text-anchor="end">Tomáš</text><rect x="90" y="193.0" width="208" height="30" fill="#9a9a9a" stroke="#000" stroke-width="1"/></svg>',
  'graf-karticky.svg',
  'Vodorovný sloupcový graf počtu kartiček: řádky Petr a Standa jsou prázdné (chybí), Radek má 20 a Tomáš 16 kartiček.',
  'Počet kartiček (některé údaje chybí)',
  new List<String>{'Standa má polovinu toho co Tomáš a spolu mají $24$: Tomáš $= 16$, Standa $= 8$. Z grafu má Radek $20$ kartiček, tedy Petr $= 20 + 5 = 25$. Rozdíl Petrových a Standových kartiček je $25 - 8 = 17$.'},
  'D) o 17 kartiček',
  2, 4, '3',
  new List<String>{'zs1','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
