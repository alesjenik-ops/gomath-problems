String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M5A 2020 – úloha 11',
  new List<String>{'Všichni žáci 4. a 5. třídy se zúčastnili soutěže, v níž mohl každý z nich získat 0 až 3 body. V následujícím grafu jsou uvedeny počty žáků, kteří získali v soutěži daný počet bodů, jeden údaj však chybí. Žáci 4. třídy získali v soutěži celkem o 2 body méně než žáci 5. třídy.','Kolik žáků chodí do 5. třídy?'},
  new List<String>{'A) méně než 24 žáků','B) 24 žáků','C) 25 žáků','D) 26 žáků','E) více než 26 žáků'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 360" font-family="sans-serif"><line x1="70" y1="55" x2="70" y2="300" stroke="#000"/><line x1="70" y1="300" x2="460" y2="300" stroke="#000"/><line x1="70" y1="300" x2="450" y2="300" stroke="#e4e4e4"/><line x1="66" y1="300" x2="70" y2="300" stroke="#000"/><text x="62" y="304" font-size="12" text-anchor="end">0</text><line x1="70" y1="260" x2="450" y2="260" stroke="#e4e4e4"/><line x1="66" y1="260" x2="70" y2="260" stroke="#000"/><text x="62" y="264" font-size="12" text-anchor="end">2</text><line x1="70" y1="220" x2="450" y2="220" stroke="#e4e4e4"/><line x1="66" y1="220" x2="70" y2="220" stroke="#000"/><text x="62" y="224" font-size="12" text-anchor="end">4</text><line x1="70" y1="180" x2="450" y2="180" stroke="#e4e4e4"/><line x1="66" y1="180" x2="70" y2="180" stroke="#000"/><text x="62" y="184" font-size="12" text-anchor="end">6</text><line x1="70" y1="140" x2="450" y2="140" stroke="#e4e4e4"/><line x1="66" y1="140" x2="70" y2="140" stroke="#000"/><text x="62" y="144" font-size="12" text-anchor="end">8</text><line x1="70" y1="100" x2="450" y2="100" stroke="#e4e4e4"/><line x1="66" y1="100" x2="70" y2="100" stroke="#000"/><text x="62" y="104" font-size="12" text-anchor="end">10</text><line x1="70" y1="60" x2="450" y2="60" stroke="#e4e4e4"/><line x1="66" y1="60" x2="70" y2="60" stroke="#000"/><text x="62" y="64" font-size="12" text-anchor="end">12</text><text x="26" y="175" font-size="13" text-anchor="middle" transform="rotate(-90 26 175)">Počet žáků</text><rect x="90" y="240" width="28" height="60" fill="#666" stroke="#000"/><rect x="122" y="200" width="28" height="100" fill="#cfcfcf" stroke="#000"/><text x="118" y="318" font-size="12" text-anchor="middle">0 bodů</text><rect x="182" y="100" width="28" height="200" fill="#666" stroke="#000"/><rect x="214" y="220" width="28" height="80" fill="#cfcfcf" stroke="#000"/><text x="210" y="318" font-size="12" text-anchor="middle">1 bod</text><rect x="274" y="140" width="28" height="160" fill="#666" stroke="#000"/><rect x="306" y="120" width="28" height="180" fill="#cfcfcf" stroke="#000"/><text x="302" y="318" font-size="12" text-anchor="middle">2 body</text><rect x="366" y="220" width="28" height="80" fill="#666" stroke="#000"/><rect x="398" y="55" width="28" height="245" fill="none" stroke="#aaa" stroke-dasharray="4 4"/><text x="412" y="260" font-size="18" text-anchor="middle">?</text><text x="394" y="318" font-size="12" text-anchor="middle">3 body</text><rect x="478" y="150" width="14" height="14" fill="#666" stroke="#000"/><text x="497" y="162" font-size="12">4. třída</text><rect x="478" y="172" width="14" height="14" fill="#cfcfcf" stroke="#000"/><text x="497" y="184" font-size="12">5. třída</text></svg>',
  'graf-body.svg',
  'Sloupcový graf počtu žáků 4. a 5. třídy podle získaných bodů 0 až 3; údaj pro 5. třídu a 3 body chybí.',
  'Počty žáků podle získaných bodů',
  new List<String>{'Chybějící údaj (5. třída, 3 body): body 5. třídy jsou $40$, tj. $1\\cdot 4+2\\cdot 9+3\\cdot x=40$, odtud $x=6$. Počet žáků 5. třídy: $5+4+9+6=24$.'},
  'B) 24 žáků',
  2, 4, '3',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2020 – úloha 12',
  new List<String>{'První číslo je čtvrtinou druhého čísla. Třetí číslo je 64, což je čtyřnásobek druhého čísla.','Jaké je první číslo?'},
  new List<String>{'A) 64','B) 32','C) 16','D) 8','E) 4'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Druhé číslo je $64:4=16$. První číslo je $16:4=4$.'},
  'E) 4',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
