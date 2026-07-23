String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M5B 2018 – úloha 4',
  new List<String>{'Dvě housky váží o $10$ gramů více než dvě topinky. Jedna houska a dvě topinky váží celkem $110$ gramů (viz obrázek).','4.1 Vypočtěte, o kolik gramů méně váží jedna topinka než jedna houska.','4.2 Vypočtěte, kolik gramů váží tři topinky.','4.3 Vypočtěte, kolik gramů váží jedna houska.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 200" font-family="sans-serif"><circle cx="52" cy="52" r="21" fill="#dcdcdc" stroke="#000" stroke-width="1.4"/><path d="M 41 52 C 46 43, 58 43, 63 52" fill="none" stroke="#666" stroke-width="1"/><path d="M 41 52 C 46 61, 58 61, 63 52" fill="none" stroke="#666" stroke-width="1"/><line x1="52" y1="34" x2="52" y2="70" stroke="#666" stroke-width="1"/><circle cx="102" cy="52" r="21" fill="#dcdcdc" stroke="#000" stroke-width="1.4"/><path d="M 91 52 C 96 43, 108 43, 113 52" fill="none" stroke="#666" stroke-width="1"/><path d="M 91 52 C 96 61, 108 61, 113 52" fill="none" stroke="#666" stroke-width="1"/><line x1="102" y1="34" x2="102" y2="70" stroke="#666" stroke-width="1"/><text x="150" y="60" font-size="22">=</text><text x="185" y="60" font-size="20">10 g</text><text x="248" y="60" font-size="22">+</text><rect x="278" y="31" width="42" height="42" rx="7" fill="#ffffff" stroke="#000" stroke-width="1.4"/><rect x="328" y="31" width="42" height="42" rx="7" fill="#ffffff" stroke="#000" stroke-width="1.4"/><circle cx="52" cy="150" r="21" fill="#dcdcdc" stroke="#000" stroke-width="1.4"/><path d="M 41 150 C 46 141, 58 141, 63 150" fill="none" stroke="#666" stroke-width="1"/><path d="M 41 150 C 46 159, 58 159, 63 150" fill="none" stroke="#666" stroke-width="1"/><line x1="52" y1="132" x2="52" y2="168" stroke="#666" stroke-width="1"/><text x="90" y="158" font-size="22">+</text><rect x="120" y="129" width="42" height="42" rx="7" fill="#ffffff" stroke="#000" stroke-width="1.4"/><rect x="170" y="129" width="42" height="42" rx="7" fill="#ffffff" stroke="#000" stroke-width="1.4"/><text x="228" y="158" font-size="22">=</text><text x="264" y="158" font-size="20">110 g</text></svg>',
  'housky-topinky.svg',
  'Dvě rovnice s obrázky: dvě housky se rovnají 10 g a dvěma topinkám; jedna houska a dvě topinky se rovnají 110 g.',
  'Vztahy mezi hmotnostmi housek a topinek',
  new List<String>{'Ze vztahu dvě housky $= 10$ g $+$ dvě topinky plyne, že dvě housky váží o $10$ g více než dvě topinky, tedy jedna houska o $5$ g více než jedna topinka.','4.1 Jedna topinka váží o $5$ g méně než jedna houska.','4.2 Dosadíme do vztahu houska $+$ dvě topinky $= 110$ g. Protože houska $=$ topinka $+ 5$ g, je $3 \\cdot$ topinka $+ 5 = 110$, takže tři topinky váží $105$ g.','4.3 Jedna topinka váží $105 : 3 = 35$ g, jedna houska tedy $35 + 5 = 40$ g.'},
  '4.1: o $5$ g; 4.2: $105$ g; 4.3: $40$ g',
  5, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2018 – úloha 5',
  new List<String>{'Maminka rozložila všechny upečené koláče na dva talíře, na oba talíře dala stejný počet koláčů. Jarda z prvního talíře $5$ koláčů snědl a potom na něj přendal $3$ koláče z druhého talíře. Emilka pak z talíře s větším počtem koláčů odebrala třetinu koláčů a dala si je do krabičky. Odnesla si tak v krabičce celkem $5$ koláčů.','5.1 Určete počet všech upečených koláčů (tj. na obou talířích dohromady).','5.2 Určete počet koláčů, které zbyly na druhém talíři.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Na každém talíři bylo na začátku $n$ koláčů. Na prvním talíři po snědení $5$ koláčů a přidání $3$ koláčů zůstalo $n - 2$, na druhém $n - 3$. Talíř s větším počtem je první ($n - 2$). Emilka z něj odebrala třetinu: $\\frac{n - 2}{3} = 5$, odtud $n - 2 = 15$ a $n = 17$.','5.1 Celkem bylo upečeno $2 \\cdot 17 = 34$ koláčů.','5.2 Na druhém talíři zbylo $n - 3 = 17 - 3 = 14$ koláčů.'},
  '5.1: $34$ koláčů; 5.2: $14$ koláčů',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
