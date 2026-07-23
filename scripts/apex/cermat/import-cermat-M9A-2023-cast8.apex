String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD23C0T01';
Integer YEAR = 2023;

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
  'CERMAT M9A 2023 – úloha 16',
  new List<String>{'Prvním obrazcem je bílý rovnostranný trojúhelník. Každý další obrazec vznikne z předchozího podle pravidel: 1. Nejprve každý bílý trojúhelník v obrazci rozdělíme na $4$ shodné rovnostranné trojúhelníky. 2. Poté v každé takto vzniklé čtveřici bílých trojúhelníků obarvíme vnitřní trojúhelník na šedo (viz obrázek).','16.1 Určete, kolik bílých trojúhelníků obsahuje pátý obrazec.','16.2 Šestý obrazec obsahuje $121$ šedých trojúhelníků. Určete, kolik šedých trojúhelníků obsahuje sedmý obrazec.','16.3 Počet šedých trojúhelníků v posledním a v předposledním obrazci se liší o $6\\,561$. Určete, kolik bílých trojúhelníků obsahuje poslední obrazec.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 150" font-family="sans-serif"><polygon points="70,10 20,110 120,110" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="205.0,60.0 230.0,110.0 255.0,60.0" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="230,10 205.0,60.0 255.0,60.0" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="205.0,60.0 180,110 230.0,110.0" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="255.0,60.0 230.0,110.0 280,110" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="365.0,60.0 390.0,110.0 415.0,60.0" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="377.5,35.0 390.0,60.0 402.5,35.0" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="390,10 377.5,35.0 402.5,35.0" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="377.5,35.0 365.0,60.0 390.0,60.0" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="402.5,35.0 390.0,60.0 415.0,60.0" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="352.5,85.0 365.0,110.0 377.5,85.0" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="365.0,60.0 352.5,85.0 377.5,85.0" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="352.5,85.0 340,110 365.0,110.0" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="377.5,85.0 365.0,110.0 390.0,110.0" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="402.5,85.0 415.0,110.0 427.5,85.0" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="415.0,60.0 402.5,85.0 427.5,85.0" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="402.5,85.0 390.0,110.0 415.0,110.0" fill="#fff" stroke="#000" stroke-width="1"/><polygon points="427.5,85.0 415.0,110.0 440,110" fill="#fff" stroke="#000" stroke-width="1"/><text x="70" y="132" font-size="12" text-anchor="middle">1. obrazec</text><text x="230" y="132" font-size="12" text-anchor="middle">2. obrazec</text><text x="390" y="132" font-size="12" text-anchor="middle">3. obrazec</text></svg>',
  'obrazce-trojuhelniky.svg',
  'První, druhý a třetí obrazec: rovnostranný trojúhelník postupně dělený na čtyři menší, přičemž prostřední z každé čtveřice je šedý.',
  '1., 2. a 3. obrazec',
  new List<String>{'Každý bílý trojúhelník se v dalším kroku rozdělí na $4$, z nichž $3$ zůstanou bílé; počet bílých trojúhelníků se tedy vždy ztrojnásobí. V $n$-tém obrazci je $3^{\\,n-1}$ bílých trojúhelníků. Šedé trojúhelníky přibývají a nedělí se dále: v každém kroku přibude tolik šedých, kolik bylo bílých v předchozím obrazci.','16.1 Pátý obrazec: $3^4=81$ bílých trojúhelníků.','16.2 Sedmý obrazec má o počet bílých v šestém více šedých než šestý: $121+3^5=121+243=364$ šedých trojúhelníků.','16.3 Rozdíl počtu šedých v posledním a předposledním obrazci je počet bílých v předposledním, tj. $3^{\\,n-2}=6\\,561=3^8$, odtud $n=10$. Poslední obrazec má $3^{\\,9}=19\\,683$ bílých trojúhelníků.'},
  '16.1: $81$ bílých trojúhelníků; 16.2: $364$ šedých trojúhelníků; 16.3: $19\\,683$ bílých trojúhelníků',
  4, 5, '3',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
