String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M7B 2019 – úloha 16',
  new List<String>{'Obkladač vytváří obdélníkovou mozaiku z šedých a bílých čtvercových dlaždic stejné velikosti. V 1. kroku položil vedle sebe dvě šedé dlaždice. Ve 2. kroku dlaždice obklopil zleva a shora jednou vrstvou bílých dlaždic, ve 3. kroku zleva a shora jednou vrstvou šedých dlaždic a ve 4. kroku zleva a shora jednou vrstvou bílých dlaždic. Každá přidaná vrstva má tvar L. V dalších krocích se střídavě přidává vrstva šedých a vrstva bílých dlaždic. V dokončené mozaice bude 20 řad dlaždic.','16.1 Určete, v kolikátém kroku přidá obkladač k mozaice 18 dlaždic.','16.2 Určete, kolik dlaždic dohromady bude obsahovat dokončená mozaika (s 20 řadami).','16.3 Určete, kolik šedých dlaždic bude v dokončené mozaice (s 20 řadami) v 11. řadě zdola.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 170" font-family="sans-serif"><g stroke="#000"><rect x="39" y="26" width="17" height="17" fill="#b9b9b9"/><rect x="22" y="26" width="17" height="17" fill="#b9b9b9"/><rect x="114" y="43" width="17" height="17" fill="#b9b9b9"/><rect x="97" y="43" width="17" height="17" fill="#b9b9b9"/><rect x="80" y="43" width="17" height="17" fill="#fff"/><rect x="114" y="26" width="17" height="17" fill="#fff"/><rect x="97" y="26" width="17" height="17" fill="#fff"/><rect x="80" y="26" width="17" height="17" fill="#fff"/><rect x="206" y="60" width="17" height="17" fill="#b9b9b9"/><rect x="189" y="60" width="17" height="17" fill="#b9b9b9"/><rect x="172" y="60" width="17" height="17" fill="#fff"/><rect x="155" y="60" width="17" height="17" fill="#b9b9b9"/><rect x="206" y="43" width="17" height="17" fill="#fff"/><rect x="189" y="43" width="17" height="17" fill="#fff"/><rect x="172" y="43" width="17" height="17" fill="#fff"/><rect x="155" y="43" width="17" height="17" fill="#b9b9b9"/><rect x="206" y="26" width="17" height="17" fill="#b9b9b9"/><rect x="189" y="26" width="17" height="17" fill="#b9b9b9"/><rect x="172" y="26" width="17" height="17" fill="#b9b9b9"/><rect x="155" y="26" width="17" height="17" fill="#b9b9b9"/><rect x="315" y="77" width="17" height="17" fill="#b9b9b9"/><rect x="298" y="77" width="17" height="17" fill="#b9b9b9"/><rect x="281" y="77" width="17" height="17" fill="#fff"/><rect x="264" y="77" width="17" height="17" fill="#b9b9b9"/><rect x="247" y="77" width="17" height="17" fill="#fff"/><rect x="315" y="60" width="17" height="17" fill="#fff"/><rect x="298" y="60" width="17" height="17" fill="#fff"/><rect x="281" y="60" width="17" height="17" fill="#fff"/><rect x="264" y="60" width="17" height="17" fill="#b9b9b9"/><rect x="247" y="60" width="17" height="17" fill="#fff"/><rect x="315" y="43" width="17" height="17" fill="#b9b9b9"/><rect x="298" y="43" width="17" height="17" fill="#b9b9b9"/><rect x="281" y="43" width="17" height="17" fill="#b9b9b9"/><rect x="264" y="43" width="17" height="17" fill="#b9b9b9"/><rect x="247" y="43" width="17" height="17" fill="#fff"/><rect x="315" y="26" width="17" height="17" fill="#fff"/><rect x="298" y="26" width="17" height="17" fill="#fff"/><rect x="281" y="26" width="17" height="17" fill="#fff"/><rect x="264" y="26" width="17" height="17" fill="#fff"/><rect x="247" y="26" width="17" height="17" fill="#fff"/></g><text x="39" y="59" font-size="11" text-anchor="middle">1. krok</text><rect x="80" y="26" width="51" height="34" fill="none" stroke="#000" stroke-dasharray="4 3"/><text x="105" y="76" font-size="11" text-anchor="middle">2. krok</text><rect x="155" y="26" width="68" height="51" fill="none" stroke="#000" stroke-dasharray="4 3"/><text x="189" y="93" font-size="11" text-anchor="middle">3. krok</text><rect x="247" y="26" width="85" height="68" fill="none" stroke="#000" stroke-dasharray="4 3"/><text x="289" y="110" font-size="11" text-anchor="middle">4. krok</text><text x="340" y="60" font-size="17">…</text><text x="358" y="35" font-size="10">4. řada</text><text x="358" y="91" font-size="10">1. řada</text></svg>',
  'mozaika.svg',
  'Čtyři kroky stavby mozaiky: v každém kroku se ke tvaru přidá L-vrstva dlaždic, poslední vrstva je čárkovaná.',
  'Prvních pět kroků stavby mozaiky (1.–4. krok)',
  new List<String>{'Po $k$-tém kroku má mozaika $k$ řad a $k+1$ sloupců, celkem $k(k+1)$ dlaždic. V $k$-tém kroku (pro $k\\ge 2$) přibude $k(k+1)-(k-1)k=2k$ dlaždic.','16.1 $2k=18\\Rightarrow k=9$, tedy v 9. kroku.','16.2 Dokončená mozaika má 20 řad, tj. $k=20$: $20\\cdot 21=420$ dlaždic.','16.3 11. řada zdola vznikla v 11. kroku a měla nejdříve 12 šedých dlaždic (11. krok je lichý). V krocích 12–20 přibude do této řady vždy 1 dlaždice zleva; šedé přidají liché kroky 13, 15, 17, 19 (4 dlaždice). Šedých je celkem $12+4=16$.'},
  '16.1: v 9. kroku; 16.2: $420$ dlaždic; 16.3: $16$ šedých dlaždic',
  4, 7, '3',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
