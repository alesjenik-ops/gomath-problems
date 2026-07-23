String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD21C0T02';
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
  'CERMAT M9B 2021 – úloha 7',
  new List<String>{'Každý účastník soutěže mohl získat 0, 1, 2, 3, nebo 4 body. Výsledky jsou v tabulce, některá pole nejsou vyplněna (viz obrázek).','7.1 Dívek, které získaly pouze 1 bod, bylo dvakrát více než dívek bez bodu. Vypočtěte průměrný bodový zisk dívek.','7.2 Chlapců, kteří získali pouze 1 bod, bylo dvakrát více než chlapců bez bodu. Všichni chlapci dohromady získali v soutěži 36 bodů. Vypočtěte průměrný bodový zisk chlapců.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 140" font-family="sans-serif"> <rect x="12" y="12" width="536" height="122" fill="none" stroke="#000"/> <line x1="78" y1="12" x2="78" y2="134" stroke="#000"/> <line x1="328" y1="12" x2="328" y2="134" stroke="#000"/> <line x1="408" y1="12" x2="408" y2="134" stroke="#000"/> <line x1="78" y1="40" x2="328" y2="40" stroke="#000"/> <line x1="128" y1="40" x2="128" y2="134" stroke="#000"/> <line x1="178" y1="40" x2="178" y2="134" stroke="#000"/> <line x1="228" y1="40" x2="228" y2="134" stroke="#000"/> <line x1="278" y1="40" x2="278" y2="134" stroke="#000"/> <line x1="12" y1="66" x2="548" y2="66" stroke="#000"/> <line x1="12" y1="100" x2="548" y2="100" stroke="#000"/> <text x="203" y="30" font-size="11" text-anchor="middle">Počet účastníků, kteří získali</text> <text x="103" y="57" font-size="10" text-anchor="middle">0 bodů</text> <text x="153" y="57" font-size="10" text-anchor="middle">1 bod</text> <text x="203" y="57" font-size="10" text-anchor="middle">2 body</text> <text x="253" y="57" font-size="10" text-anchor="middle">3 body</text> <text x="303" y="57" font-size="10" text-anchor="middle">4 body</text> <text x="368" y="35" font-size="10" text-anchor="middle">Celkový</text> <text x="368" y="49" font-size="10" text-anchor="middle">počet bodů</text> <text x="478" y="35" font-size="10" text-anchor="middle">Aritmetický průměr</text> <text x="478" y="49" font-size="10" text-anchor="middle">počtu bodů</text> <text x="18" y="87" font-size="11">Dívky</text> <text x="103" y="87" font-size="11" text-anchor="middle">7</text> <text x="203" y="87" font-size="11" text-anchor="middle">4</text> <text x="253" y="87" font-size="11" text-anchor="middle">0</text> <text x="303" y="87" font-size="11" text-anchor="middle">5</text> <text x="18" y="121" font-size="11">Chlapci</text> <text x="203" y="121" font-size="11" text-anchor="middle">5</text> <text x="253" y="121" font-size="11" text-anchor="middle">4</text> <text x="303" y="121" font-size="11" text-anchor="middle">2</text> <text x="368" y="121" font-size="11" text-anchor="middle">36</text> </svg>',
  'tabulka-soutez.svg',
  'Tabulka počtu účastníků podle získaných bodů; u dívek chybí počet s 1 bodem, u chlapců počet bez bodu a s 1 bodem.',
  'Výsledky soutěže (chybějící pole)',
  new List<String>{'7.1 Dívek bez bodu je $7$, s $1$ bodem tedy $14$. Počet dívek $7+14+4+0+5=30$, celkem bodů $14\\cdot1+4\\cdot2+0\\cdot3+5\\cdot4=42$. Průměr $42:30=1{,}4$ bodu.','7.2 Chlapců bez bodu je $c$, s $1$ bodem $2c$. Body: $2c+5\\cdot2+4\\cdot3+2\\cdot4=2c+30=36$, tedy $c=3$. Počet chlapců $3+6+5+4+2=20$, průměr $36:20=1{,}8$ bodu.'},
  '7.1: $1{,}4$ bodu; 7.2: $1{,}8$ bodu',
  3, 5, '3',
  new List<String>{'zs2','r9','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
