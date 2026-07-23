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
  'CERMAT M5A 2020 – úloha 9',
  new List<String>{'Adéla a Hana dostaly stejnou knihu. Hana přečetla z knihy denně 10 stran. Adéla přečetla celou knihu za 8 dní a každý den z ní přečetla o polovinu více stran než Hana.','Za kolik dní přečetla knihu Hana?'},
  new List<String>{'A) za méně než 10 dní','B) za 10 dní','C) za 12 dní','D) za 15 dní','E) za více než 15 dní'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Adéla čte $1{,}5\\cdot 10=15$ stran denně, kniha má $8\\cdot 15=120$ stran. Hana čte $10$ stran denně: $120:10=12$ dní.'},
  'C) za 12 dní',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2020 – úloha 10',
  new List<String>{'Všichni žáci 4. a 5. třídy se zúčastnili soutěže, v níž mohl každý z nich získat 0 až 3 body. V následujícím grafu jsou uvedeny počty žáků, kteří získali v soutěži daný počet bodů, jeden údaj však chybí. Žáci 4. třídy získali v soutěži celkem o 2 body méně než žáci 5. třídy.','Kolik bodů celkem získali v soutěži žáci 5. třídy?'},
  new List<String>{'A) 34 bodů','B) 36 bodů','C) 38 bodů','D) 40 bodů','E) jiný počet bodů'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 360" font-family="sans-serif"><line x1="70" y1="55" x2="70" y2="300" stroke="#000"/><line x1="70" y1="300" x2="460" y2="300" stroke="#000"/><line x1="70" y1="300" x2="450" y2="300" stroke="#e4e4e4"/><line x1="66" y1="300" x2="70" y2="300" stroke="#000"/><text x="62" y="304" font-size="12" text-anchor="end">0</text><line x1="70" y1="260" x2="450" y2="260" stroke="#e4e4e4"/><line x1="66" y1="260" x2="70" y2="260" stroke="#000"/><text x="62" y="264" font-size="12" text-anchor="end">2</text><line x1="70" y1="220" x2="450" y2="220" stroke="#e4e4e4"/><line x1="66" y1="220" x2="70" y2="220" stroke="#000"/><text x="62" y="224" font-size="12" text-anchor="end">4</text><line x1="70" y1="180" x2="450" y2="180" stroke="#e4e4e4"/><line x1="66" y1="180" x2="70" y2="180" stroke="#000"/><text x="62" y="184" font-size="12" text-anchor="end">6</text><line x1="70" y1="140" x2="450" y2="140" stroke="#e4e4e4"/><line x1="66" y1="140" x2="70" y2="140" stroke="#000"/><text x="62" y="144" font-size="12" text-anchor="end">8</text><line x1="70" y1="100" x2="450" y2="100" stroke="#e4e4e4"/><line x1="66" y1="100" x2="70" y2="100" stroke="#000"/><text x="62" y="104" font-size="12" text-anchor="end">10</text><line x1="70" y1="60" x2="450" y2="60" stroke="#e4e4e4"/><line x1="66" y1="60" x2="70" y2="60" stroke="#000"/><text x="62" y="64" font-size="12" text-anchor="end">12</text><text x="26" y="175" font-size="13" text-anchor="middle" transform="rotate(-90 26 175)">Počet žáků</text><rect x="90" y="240" width="28" height="60" fill="#666" stroke="#000"/><rect x="122" y="200" width="28" height="100" fill="#cfcfcf" stroke="#000"/><text x="118" y="318" font-size="12" text-anchor="middle">0 bodů</text><rect x="182" y="100" width="28" height="200" fill="#666" stroke="#000"/><rect x="214" y="220" width="28" height="80" fill="#cfcfcf" stroke="#000"/><text x="210" y="318" font-size="12" text-anchor="middle">1 bod</text><rect x="274" y="140" width="28" height="160" fill="#666" stroke="#000"/><rect x="306" y="120" width="28" height="180" fill="#cfcfcf" stroke="#000"/><text x="302" y="318" font-size="12" text-anchor="middle">2 body</text><rect x="366" y="220" width="28" height="80" fill="#666" stroke="#000"/><rect x="398" y="55" width="28" height="245" fill="none" stroke="#aaa" stroke-dasharray="4 4"/><text x="412" y="260" font-size="18" text-anchor="middle">?</text><text x="394" y="318" font-size="12" text-anchor="middle">3 body</text><rect x="478" y="150" width="14" height="14" fill="#666" stroke="#000"/><text x="497" y="162" font-size="12">4. třída</text><rect x="478" y="172" width="14" height="14" fill="#cfcfcf" stroke="#000"/><text x="497" y="184" font-size="12">5. třída</text></svg>',
  'graf-body.svg',
  'Sloupcový graf počtu žáků 4. a 5. třídy podle získaných bodů 0 až 3; údaj pro 5. třídu a 3 body chybí.',
  'Počty žáků podle získaných bodů',
  new List<String>{'Body 4. třídy: $1\\cdot 10+2\\cdot 8+3\\cdot 4=38$. Žáci 4. třídy mají o $2$ body méně než 5. třída, takže 5. třída získala $38+2=40$ bodů.'},
  'D) 40 bodů',
  2, 4, '3',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
