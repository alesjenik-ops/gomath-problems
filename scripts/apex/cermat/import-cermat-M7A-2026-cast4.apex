String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD26C0T01';
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
  'CERMAT M7A 2026 - uloha 10',
  new List<String>{'Ve ctvercove siti je zakresleno 6 ornamentu oznacenych pismeny A az F. Kruznice v ornamentu E ma stred v mrizovem bode a prochazi ctyrmi mrizovymi body. Kazda pulkruznice v ornamentu F ma stred i krajni body v mrizovych bodech. Ostatni utvary ve vsech ornamentech maji vrcholy v mrizovych bodech.','Rozhodnete o kazdem z nasledujicich tvrzeni (10.1-10.3), zda je pravdive (A), ci nikoli (N).','10.1 Ornament E ma celkem 2 osy soumernosti.','10.2 Kazdy z ornamentu A, B, C a D ma jen jednu osu soumernosti.','10.3 Primek, ktere jsou osami soumernosti jednotlivych ornamentu A az F, je dohromady presne 9.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 320" font-family="sans-serif"><g stroke="#e2e2e2" stroke-width="1"><line x1="20" y1="20" x2="20" y2="300"/><line x1="50" y1="20" x2="50" y2="300"/><line x1="80" y1="20" x2="80" y2="300"/><line x1="110" y1="20" x2="110" y2="300"/><line x1="140" y1="20" x2="140" y2="300"/><line x1="170" y1="20" x2="170" y2="300"/><line x1="200" y1="20" x2="200" y2="300"/><line x1="230" y1="20" x2="230" y2="300"/><line x1="260" y1="20" x2="260" y2="300"/><line x1="290" y1="20" x2="290" y2="300"/><line x1="320" y1="20" x2="320" y2="300"/><line x1="350" y1="20" x2="350" y2="300"/><line x1="380" y1="20" x2="380" y2="300"/><line x1="410" y1="20" x2="410" y2="300"/><line x1="440" y1="20" x2="440" y2="300"/><line x1="470" y1="20" x2="470" y2="300"/><line x1="500" y1="20" x2="500" y2="300"/><line x1="530" y1="20" x2="530" y2="300"/><line x1="560" y1="20" x2="560" y2="300"/><line x1="590" y1="20" x2="590" y2="300"/><line x1="20" y1="20" x2="590" y2="20"/><line x1="20" y1="50" x2="590" y2="50"/><line x1="20" y1="80" x2="590" y2="80"/><line x1="20" y1="110" x2="590" y2="110"/><line x1="20" y1="140" x2="590" y2="140"/><line x1="20" y1="170" x2="590" y2="170"/><line x1="20" y1="200" x2="590" y2="200"/><line x1="20" y1="230" x2="590" y2="230"/><line x1="20" y1="260" x2="590" y2="260"/><line x1="20" y1="290" x2="590" y2="290"/></g><g fill="none" stroke="#000" stroke-width="2"><polyline points="135,55 70,55 70,125 135,125"/><line x1="70" y1="90" x2="120" y2="90"/><polygon points="270,110 330,110 330,72 300,50 270,72"/><polygon points="500,50 522,120 500,102 478,120"/><rect x="60" y="180" width="80" height="60"/><line x1="60" y1="180" x2="140" y2="240"/><line x1="140" y1="180" x2="60" y2="240"/><circle cx="300" cy="210" r="35"/><polygon points="300,175 335,210 300,245 265,210"/><path d="M 465 210 A 17 17 0 0 1 499 210 A 17 17 0 0 0 533 210"/></g><g font-size="15" text-anchor="middle"><text x="100" y="42">A</text><text x="300" y="42">B</text><text x="500" y="42">C</text><text x="100" y="296">D</text><text x="300" y="296">E</text><text x="500" y="296">F</text></g></svg>',
  'ornamenty.svg',
  'Sest ornamentu A az F ve ctvercove siti - schematicke zastupne tvary.',
  'Schematicky nakres ornamentu A az F',
  new List<String>{'10.1 Ornament E (kruznice s vepsanym ctvercem) ma 4 osy soumernosti, ne 2 - nepravdive (N).','10.2 Ornament D (obdelnik s uhloprickami) ma 2 osy soumernosti, takze tvrzeni, ze kazdy z A, B, C, D ma jen jednu osu, je nepravdive (N).','10.3 Pocty os: A $1$, B $1$, C $1$, D $2$, E $4$, F $0$; dohromady $1+1+1+2+4+0=9$ - pravdive (A).'},
  '10.1: N; 10.2: N; 10.3: A',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
