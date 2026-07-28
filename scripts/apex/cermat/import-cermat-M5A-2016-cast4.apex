String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M5A 2016 – úloha 12',
  new List<String>{'Školy K, L, M, N a O v letech 2013–2015 soutěžily ve sběru papíru. V roce 2014 nasbíralo všech pět škol dohromady 30 tun papíru (viz graf).','Vítězem soutěže se stala škola, která za 3 roky nasbírala nejvíce papíru.','Kolik tun papíru nasbírala za 3 roky vítězná škola?'},
  new List<String>{'A) méně než 10 tun','B) 10 tun','C) 18 tun','D) 20 tun','E) více než 20 tun'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 320" font-family="sans-serif"><text x="270" y="26" font-size="17" font-weight="bold" text-anchor="middle">Sběr papíru</text><text x="26" y="150" font-size="13" text-anchor="middle" transform="rotate(-90 26 150)">hmotnost papíru v tunách</text><line x1="78" y1="216.0" x2="465" y2="216.0" stroke="#bbb"/><line x1="78" y1="180.0" x2="465" y2="180.0" stroke="#bbb"/><line x1="78" y1="144.0" x2="465" y2="144.0" stroke="#bbb"/><line x1="78" y1="108.0" x2="465" y2="108.0" stroke="#bbb"/><line x1="78" y1="72.0" x2="465" y2="72.0" stroke="#bbb"/><line x1="78" y1="36.0" x2="465" y2="36.0" stroke="#bbb"/><line x1="78" y1="30" x2="78" y2="252" stroke="#000" stroke-width="2"/><line x1="78" y1="252" x2="465" y2="252" stroke="#000" stroke-width="2"/><rect x="98" y="144.0" width="19" height="108.0" fill="#ffffff" stroke="#000"/><rect x="117" y="216.0" width="19" height="36.0" fill="#c9c9c9" stroke="#000"/><rect x="136" y="72.0" width="19" height="180.0" fill="#6b6b6b" stroke="#000"/><text x="126.5" y="272" font-size="14" text-anchor="middle">K</text><rect x="175" y="108.0" width="19" height="144.0" fill="#ffffff" stroke="#000"/><rect x="194" y="180.0" width="19" height="72.0" fill="#c9c9c9" stroke="#000"/><rect x="213" y="108.0" width="19" height="144.0" fill="#6b6b6b" stroke="#000"/><text x="203.5" y="272" font-size="14" text-anchor="middle">L</text><rect x="252" y="144.0" width="19" height="108.0" fill="#ffffff" stroke="#000"/><rect x="271" y="144.0" width="19" height="108.0" fill="#c9c9c9" stroke="#000"/><rect x="290" y="144.0" width="19" height="108.0" fill="#6b6b6b" stroke="#000"/><text x="280.5" y="272" font-size="14" text-anchor="middle">M</text><rect x="329" y="216.0" width="19" height="36.0" fill="#ffffff" stroke="#000"/><rect x="348" y="108.0" width="19" height="144.0" fill="#c9c9c9" stroke="#000"/><rect x="367" y="216.0" width="19" height="36.0" fill="#6b6b6b" stroke="#000"/><text x="357.5" y="272" font-size="14" text-anchor="middle">N</text><rect x="406" y="216.0" width="19" height="36.0" fill="#ffffff" stroke="#000"/><rect x="425" y="72.0" width="19" height="180.0" fill="#c9c9c9" stroke="#000"/><rect x="444" y="144.0" width="19" height="108.0" fill="#6b6b6b" stroke="#000"/><text x="434.5" y="272" font-size="14" text-anchor="middle">O</text><rect x="480" y="80" width="14" height="14" fill="#ffffff" stroke="#000"/><text x="500" y="92" font-size="13">2013</text><rect x="480" y="106" width="14" height="14" fill="#c9c9c9" stroke="#000"/><text x="500" y="118" font-size="13">2014</text><rect x="480" y="132" width="14" height="14" fill="#6b6b6b" stroke="#000"/><text x="500" y="144" font-size="13">2015</text></svg>',
  'graf-sber-papiru.svg',
  'Sloupcový graf sběru papíru pěti škol K až O v letech 2013, 2014 a 2015 bez číselné osy.',
  'Sběr papíru (hmotnost v tunách)',
  new List<String>{'V roce 2014 odpovídají sloupce dílkům $1+2+3+4+5=15$, dohromady $30$ tun, jeden dílek je tedy $2$ tuny.','Součty za tři roky: K $=6+2+10=18$ t, L $=8+4+8=20$ t, M $=6+6+6=18$ t, N $=2+8+2=12$ t, O $=2+10+6=18$ t.','Nejvíce nasbírala škola L, a to $20$ tun.'},
  'D) 20 tun',
  2, 5, '4',
  new List<String>{'zs1','statistika','porozumeni','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
