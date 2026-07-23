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
  'CERMAT M7D 2022 – úloha 13',
  new List<String>{'Čtyři chlapci (Petr, Radek, Standa a Tomáš) sbírají kartičky s legendárními hokejisty. V grafu znázorňujícím počty jejich kartiček některé údaje chybí. Standa má o polovinu méně kartiček než Tomáš a oba dohromady mají $24$ kartiček. Petr má o $5$ kartiček více než Radek.','O kolik se liší počet Petrových a Standových kartiček?'},
  new List<String>{'A) o $1$ kartičku','B) o $8$ kartiček','C) o $10$ kartiček','D) o $17$ kartiček','E) o jiný počet kartiček'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 220" font-family="sans-serif" font-size="13"> <text x="215" y="18" text-anchor="middle">Počet kartiček</text> <line x1="90" y1="38" x2="90" y2="192" stroke="#000"/> <text x="88" y="206" text-anchor="middle">0</text> <text x="80" y="64" text-anchor="end">Petr</text> <text x="80" y="106" text-anchor="end">Radek</text> <text x="80" y="146" text-anchor="end">Standa</text> <text x="80" y="186" text-anchor="end">Tomáš</text> <rect x="90" y="92" width="264" height="24" fill="#9a9a9a" stroke="#000"/> <rect x="90" y="172" width="211" height="24" fill="#9a9a9a" stroke="#000"/> <line x1="90" y1="60" x2="360" y2="60" stroke="#000" stroke-dasharray="5 4"/> <line x1="90" y1="140" x2="360" y2="140" stroke="#000" stroke-dasharray="5 4"/> </svg>',
  'graf-karticky.svg',
  'Vodorovný sloupcový graf počtu kartiček čtyř chlapců; zobrazeny jsou sloupce Radka a Tomáše, sloupce Petra a Standy chybí.',
  'Počet kartiček (Radek a Tomáš)',
  new List<String>{'Standa má o polovinu méně než Tomáš, tj. $S=\\frac{T}{2}$, a $S+T=24$, odtud $T=16$ a $S=8$. Z grafu je Radek $R=20$. Petr má o $5$ více než Radek, tedy $P=25$. Rozdíl $P-S=25-8=17$.'},
  'D) o $17$ kartiček',
  2, 4, '3',
  new List<String>{'zs2','r7','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2022 – úloha 14',
  new List<String>{'Ve stánku mají celkem $140$ krabiček s čaji. Všechny jsou naskládány do sloupečků po čtyřech krabičkách. V $10$ sloupečcích jsou pouze krabičky s černými čaji a v každém ze zbývajících sloupečků je jedna krabička s černým čajem a $3$ krabičky s ovocnými čaji.','Kolik krabiček s ovocnými čaji mají ve stánku?'},
  new List<String>{'A) $30$ krabiček','B) $40$ krabiček','C) $75$ krabiček','D) $100$ krabiček','E) jiný počet krabiček'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Sloupečků je $140:4=35$. Deset je pouze černých, zbývá $35-10=25$ sloupečků, v každém $3$ ovocné krabičky. Ovocných je $25\\cdot 3=75$.'},
  'C) $75$ krabiček',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2022 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Do prosince roku 2020 prodělal covid-19 každý dvacátý Čech. Kolik procent Čechů prodělalo covid-19 do prosince roku 2020?','15.2 Počet novorozenců tvořil v dubnu $\\frac{26}{25}$ počtu novorozenců v březnu. O kolik procent byl počet novorozenců v dubnu vyšší než v březnu?','15.3 Teplá kapalina v nádobě po vychladnutí zmenšila svůj objem o $\\frac{2}{27}$. O kolik procent byl objem teplé kapaliny větší než objem vychladlé kapaliny?'},
  new List<String>{'A) $4\\,\\%$','B) $5\\,\\%$','C) $6\\,\\%$','D) $7\\,\\%$','E) $8\\,\\%$','F) jiný počet procent'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Každý dvacátý je $\\frac{1}{20}=5\\,\\%$ → B.','15.2 $\\frac{26}{25}=1{,}04=104\\,\\%$, tj. o $4\\,\\%$ více → A.','15.3 Vychladlá kapalina je $1-\\frac{2}{27}=\\frac{25}{27}$ objemu teplé. Poměr teplá ku vychladlé je $\\frac{27}{25}=1{,}08=108\\,\\%$, tj. o $8\\,\\%$ více → E.'},
  '15.1: B ($5\\,\\%$); 15.2: A ($4\\,\\%$); 15.3: E ($8\\,\\%$)',
  6, 8, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
