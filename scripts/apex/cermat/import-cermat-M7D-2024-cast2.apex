String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD24C0T04';
Integer YEAR = 2024;

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
  'CERMAT M7D 2024 – úloha 6',
  new List<String>{'V kině je celkem $280$ dospělých diváků, žen je o $120$ více než mužů.','6.1 Kolik je v kině žen?','6.2 Jaký je poměr počtu žen k počtu mužů?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Nechť mužů je $m$, žen pak $m+120$. Dohromady $2m+120=280$, odtud $m=80$ a žen $80+120=200$.','6.2 Poměr počtu žen k počtu mužů $200:80=5:2$.'},
  '6.1: $200$ žen; 6.2: $5:2$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2024 – úloha 7',
  new List<String>{'Kadeřnice a pedikérka si pronajaly společně provozovnu a dohodly se, že veškeré náklady na provoz si rozdělí podle času, po který provozovnu využívají. V grafu je zobrazen počet hodin, které kadeřnice a pedikérka odpracují za týden (v neděli nepracují). Počet odpracovaných hodin kadeřnice za čtvrtek v grafu není uveden.','7.1 Kolik hodin pracuje ve čtvrtek kadeřnice, když průměrně od pondělí do soboty pracuje $6$ hodin denně?','7.2 Jestliže dohromady za týden za náklady na provoz zaplatí pedikérka s kadeřnicí $17\\,400$ Kč, kolik korun z této částky zaplatí pedikérka?'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 330" font-family="sans-serif"><line x1="60" y1="20" x2="60" y2="290" stroke="#000"/><line x1="60" y1="290" x2="500" y2="290" stroke="#000"/><line x1="56" y1="290" x2="60" y2="290" stroke="#000"/><text x="52" y="294" font-size="11" text-anchor="end">0</text><line x1="56" y1="260" x2="60" y2="260" stroke="#000"/><text x="52" y="264" font-size="11" text-anchor="end">1</text><line x1="56" y1="230" x2="60" y2="230" stroke="#000"/><text x="52" y="234" font-size="11" text-anchor="end">2</text><line x1="56" y1="200" x2="60" y2="200" stroke="#000"/><text x="52" y="204" font-size="11" text-anchor="end">3</text><line x1="56" y1="170" x2="60" y2="170" stroke="#000"/><text x="52" y="174" font-size="11" text-anchor="end">4</text><line x1="56" y1="140" x2="60" y2="140" stroke="#000"/><text x="52" y="144" font-size="11" text-anchor="end">5</text><line x1="56" y1="110" x2="60" y2="110" stroke="#000"/><text x="52" y="114" font-size="11" text-anchor="end">6</text><line x1="56" y1="80" x2="60" y2="80" stroke="#000"/><text x="52" y="84" font-size="11" text-anchor="end">7</text><line x1="56" y1="50" x2="60" y2="50" stroke="#000"/><text x="52" y="54" font-size="11" text-anchor="end">8</text><line x1="56" y1="20" x2="60" y2="20" stroke="#000"/><text x="52" y="24" font-size="11" text-anchor="end">9</text><rect x="78" y="110" width="22" height="180" fill="#b8b8b8" stroke="#000"/><rect x="106" y="170" width="22" height="120" fill="#ffffff" stroke="#000"/><text x="103" y="306" font-size="11" text-anchor="middle">pondeli</text><rect x="148" y="50" width="22" height="240" fill="#b8b8b8" stroke="#000"/><rect x="176" y="200" width="22" height="90" fill="#ffffff" stroke="#000"/><text x="173" y="306" font-size="11" text-anchor="middle">utery</text><rect x="218" y="110" width="22" height="180" fill="#b8b8b8" stroke="#000"/><rect x="246" y="170" width="22" height="120" fill="#ffffff" stroke="#000"/><text x="243" y="306" font-size="11" text-anchor="middle">streda</text><text x="299" y="280" font-size="16" text-anchor="middle">?</text><rect x="316" y="200" width="22" height="90" fill="#ffffff" stroke="#000"/><text x="313" y="306" font-size="11" text-anchor="middle">ctvrtek</text><rect x="358" y="80" width="22" height="210" fill="#b8b8b8" stroke="#000"/><rect x="386" y="170" width="22" height="120" fill="#ffffff" stroke="#000"/><text x="383" y="306" font-size="11" text-anchor="middle">patek</text><rect x="428" y="170" width="22" height="120" fill="#b8b8b8" stroke="#000"/><rect x="456" y="170" width="22" height="120" fill="#ffffff" stroke="#000"/><text x="453" y="306" font-size="11" text-anchor="middle">sobota</text><rect x="350" y="24" width="12" height="12" fill="#b8b8b8" stroke="#000"/><text x="368" y="34" font-size="11">kadernice</text><rect x="440" y="24" width="12" height="12" fill="#ffffff" stroke="#000"/><text x="458" y="34" font-size="11">pedikerka</text></svg>',
  'graf-hodiny.svg',
  'Sdružený sloupcový graf odpracovaných hodin kadeřnice a pedikérky od pondělí do soboty; sloupec kadeřnice za čtvrtek chybí.',
  'Počet odpracovaných hodin za týden',
  new List<String>{'7.1 Za $6$ dnů při průměru $6$ h je celkem $36$ h. Uvedené dny kadeřnice: $6+8+6+7+4=31$ h, ve čtvrtek tedy $36-31=5$ h.','7.2 Kadeřnice odpracuje $36$ h, pedikérka $4+3+4+3+4+4=22$ h, dohromady $58$ h. Na $1$ h připadá $17\\,400:58=300$ Kč, pedikérka zaplatí $22\\cdot 300=6600$ Kč.'},
  '7.1: $5$ hodin; 7.2: $6600$ Kč',
  4, 7, '3',
  new List<String>{'zs2','r7','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
