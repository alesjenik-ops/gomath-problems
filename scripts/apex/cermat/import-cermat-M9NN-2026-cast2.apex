String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND26C0T01';
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
  'CERMAT M9 nanečisto 2026 – úloha 6',
  new List<String>{'Klára si v řemeslné pekárně koupila několik tukových rohlíků a několik celozrnných housek. Dvě celozrnné housky stojí o 6 korun více než tři tukové rohlíky. Cenu jedné celozrnné housky v korunách označíme $h$.','6.1 Vyjádřete výrazem s proměnnou $h$, kolik korun stojí tři tukové rohlíky.','6.2 Vyjádřete výrazem s proměnnou $h$, kolik korun stojí jeden tukový rohlík.','6.3 Klára zaplatila za 6 tukových rohlíků a 6 celozrnných housek celkem 78 korun. Vypočtěte, kolik korun stojí jedna celozrnná houska.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Dvě housky stojí $2h$, tři rohlíky o 6 korun méně: tři rohlíky stojí $2h-6$ korun.','6.2 Jeden rohlík stojí $\\frac{2h-6}{3}$ korun.','6.3 $6\\cdot\\frac{2h-6}{3}+6h=78\\Rightarrow 2(2h-6)+6h=78\\Rightarrow 10h-12=78\\Rightarrow h=9$. Houska stojí 9 korun.'},
  '6.1: $2h-6$; 6.2: $\\frac{2h-6}{3}$; 6.3: $9$ korun',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 7',
  new List<String>{'Naši zakázku vyrábí několik automatů. Automaty vždy pracují společně stálým a navzájem stejným tempem. Kdyby pracovalo 12 automatů, vyrobí naši zakázku přesně za 60 hodin.','7.1 Vypočtěte, za kolik hodin vyrobí naši zakázku 20 automatů.','7.2 Vyjádřete zlomkem v základním tvaru, jakou část naší zakázky vyrobí 5 automatů za 24 hodin.','7.3 Čtvrtinu naší zakázky vyrobilo 15 automatů, zbytek zakázky dokončilo 18 automatů. Vypočtěte, kolik hodin trvala výroba celé naší zakázky.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Celková práce je $12\\cdot 60=720$ automatohodin.','7.1 $720:20=36$ hodin.','7.2 $5\\cdot 24=120$ automatohodin, tj. $\\frac{120}{720}=\\frac{1}{6}$ zakázky.','7.3 Čtvrtina $=180$ automatohodin, $180:15=12$ hodin; zbytek $540$ automatohodin, $540:18=30$ hodin. Celkem $12+30=42$ hodin.'},
  '7.1: $36$ hodin; 7.2: $\\frac{1}{6}$ zakázky; 7.3: $42$ hodin',
  4, 7, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 8',
  new List<String>{'Trojúhelníková síť se skládá z rovnostranných trojúhelníků. V této síti jsou z tmavých trojúhelníků složeny tři útvary A, B, C (viz testový sešit). V každém útvaru buď přesuneme, nebo odebereme vždy pouze jeden tmavý trojúhelník tak, aby vznikl osově souměrný nebo středově souměrný útvar. V jednotlivých útvarech je každý tmavý trojúhelník označen číslem. Například z útvaru A vznikne osově souměrný útvar odebráním trojúhelníku 9.','8.1 Určete číslo trojúhelníku, jehož odebráním vznikne z útvaru B osově souměrný útvar.','8.2 Určete číslo trojúhelníku, jehož přesunutím vznikne z útvaru C středově souměrný útvar. Najděte všechna řešení.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 120" font-family="sans-serif"> <text x="260" y="45" font-size="13" text-anchor="middle">Tri utvary A, B, C z tmavych rovnostrannych trojuhelniku v trojuhelnikove siti (viz testovy sesit).</text> <text x="260" y="80" font-size="11" text-anchor="middle" fill="#666">Trojuhelnikovou sit nelze verne prenest do SVG; posuzuje se podle originalu.</text> </svg>',
  'sit-utvary.svg',
  'Tři útvary A, B, C složené z tmavých rovnostranných trojúhelníků v trojúhelníkové síti (schematická poznámka).',
  'Útvary A, B, C – viz testový sešit',
  new List<String>{'8.1 Odebráním trojúhelníku číslo 5 se z útvaru B stane osově souměrný útvar.','8.2 Přesunutím trojúhelníku číslo 3 nebo číslo 14 vznikne z útvaru C středově souměrný útvar.'},
  '8.1: $5$; 8.2: $3$ a $14$',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','porozumeni','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
