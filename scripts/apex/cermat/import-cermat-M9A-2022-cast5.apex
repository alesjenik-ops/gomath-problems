String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD22C0T01';
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
  'CERMAT M9A 2022 – úloha 14',
  new List<String>{'V soutěži mohli jednotliví soutěžící dosáhnout výsledků: $0$ bodů, $1$ bod, nebo $2$ body. Graf znázorňuje rozdělení soutěžících podle výsledků. Po jednom bodu získalo $30$ soutěžících, po dvou bodech $10\\,\\%$ všech soutěžících. Soutěžících, kteří získali po $1$ bodu, bylo dvakrát více než soutěžících bez bodu.','Jaký je aritmetický průměr výsledků všech soutěžících?'},
  new List<String>{'A) $0{,}8$ bodu','B) $0{,}75$ bodu','C) $0{,}6\\overline{6}$ bodu','D) $0{,}6$ bodu','E) jiný průměr'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 310" font-family="sans-serif"> <path d="M 230 160 L 334.6 194.0 A 110 110 0 1 1 165.3 71.0 Z" fill="#c9c9c9" stroke="#000" stroke-width="1.5"/> <path d="M 230 160 L 230 50 A 110 110 0 0 1 334.6 194.0 Z" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <path d="M 230 160 L 165.3 71.0 A 110 110 0 0 1 230 50 Z" fill="#444444" stroke="#000" stroke-width="1.5"/> <text x="150" y="36" font-size="15" font-weight="bold">2 body</text> <text x="170" y="55" font-size="14">10 %</text> <text x="352" y="112" font-size="15" font-weight="bold">0 bodů</text> <text x="96" y="258" font-size="15" font-weight="bold">1 bod</text> <text x="66" y="278" font-size="14">30 soutěžících</text> </svg>',
  'graf-soutez.svg',
  'Kruhový graf rozdělení soutěžících: 0 bodů, 1 bod (30 soutěžících), 2 body (10 %).',
  'Rozdělení soutěžících podle výsledků',
  new List<String>{'Po $1$ bodu $30$ soutěžících, bez bodu polovina, tedy $15$. Nechť je celkem $N$ soutěžících; po $2$ bodech je $0{,}1N$. Pak $15+30+0{,}1N=N$, odtud $0{,}9N=45$ a $N=50$; po $2$ bodech je $5$ soutěžících. Průměr $=\\dfrac{15\\cdot 0+30\\cdot 1+5\\cdot 2}{50}=\\dfrac{40}{50}=0{,}8$ bodu.'},
  'A) $0{,}8$ bodu',
  2, 4, '3',
  new List<String>{'zs2','r9','statistika','porozumeni','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
