String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD21C0T01';
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
  'CERMAT M7A 2021 – úloha 13',
  new List<String>{'Vycházejte z téhož výchozího textu, grafu a tabulky jako u úlohy 12 (prodej triček a mikin ve $3$ obchodech A–C).','O kolik korun se lišila cena jedné mikiny v obchodech B a C?'},
  new List<String>{'A) o $20$ Kč','B) o $40$ Kč','C) o $60$ Kč','D) o $90$ Kč','E) ceny se nelišily'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 360" font-family="sans-serif" font-size="12"><line x1="70" y1="20" x2="70" y2="300" stroke="#000"/><line x1="70" y1="300" x2="420" y2="300" stroke="#000"/><line x1="66" y1="300" x2="70" y2="300" stroke="#000"/><text x="62" y="304" text-anchor="end">0</text><line x1="66" y1="268" x2="70" y2="268" stroke="#000"/><text x="62" y="272" text-anchor="end">4</text><line x1="66" y1="236" x2="70" y2="236" stroke="#000"/><text x="62" y="240" text-anchor="end">8</text><line x1="66" y1="204" x2="70" y2="204" stroke="#000"/><text x="62" y="208" text-anchor="end">12</text><line x1="66" y1="172" x2="70" y2="172" stroke="#000"/><text x="62" y="176" text-anchor="end">16</text><line x1="66" y1="140" x2="70" y2="140" stroke="#000"/><text x="62" y="144" text-anchor="end">20</text><line x1="66" y1="108" x2="70" y2="108" stroke="#000"/><text x="62" y="112" text-anchor="end">24</text><line x1="66" y1="76" x2="70" y2="76" stroke="#000"/><text x="62" y="80" text-anchor="end">28</text><line x1="66" y1="44" x2="70" y2="44" stroke="#000"/><text x="62" y="48" text-anchor="end">32</text><rect x="120" y="204" width="60" height="96" fill="#ffffff" stroke="#000"/><rect x="120" y="172" width="60" height="32" fill="#b0b0b0" stroke="#000"/><text x="150.0" y="316" text-anchor="middle">A</text><rect x="230" y="220" width="60" height="80" fill="#ffffff" stroke="#000"/><rect x="230" y="60" width="60" height="160" fill="#b0b0b0" stroke="#000"/><text x="260.0" y="316" text-anchor="middle">B</text><rect x="340" y="140" width="60" height="160" fill="#ffffff" stroke="#000"/><rect x="340" y="92" width="60" height="48" fill="#b0b0b0" stroke="#000"/><text x="370.0" y="316" text-anchor="middle">C</text><rect x="350" y="40" width="14" height="14" fill="#b0b0b0" stroke="#000"/><text x="370" y="52">Trička</text><rect x="350" y="62" width="14" height="14" fill="#ffffff" stroke="#000"/><text x="370" y="74">Mikiny</text><text x="18" y="165" transform="rotate(-90 18 165)" text-anchor="middle" font-size="11">Počet prodaných kusů</text></svg>',
  'graf-tricka-mikiny.svg',
  'Skládaný sloupcový graf počtu prodaných triček a mikin v obchodech A, B, C (A 12 a 4, B 10 a 20, C 20 a 6).',
  'Počty prodaných kusů v obchodech A–C (mikiny bílé, trička šedá)',
  new List<String>{'Obchod C: mikin $20$ (graf), tržba $7\\,200$ Kč, cena mikiny $7\\,200:20=360$ Kč.','Obchod B: triček $20$ po $180$ Kč $=3\\,600$ Kč $=$ tržba za mikiny; mikin je $10$, cena mikiny $3\\,600:10=360$ Kč. Ceny mikin v B i C jsou $360$ Kč, tedy stejné.'},
  'E) ceny se nelišily',
  2, 5, '3',
  new List<String>{'zs2','r7','statistika','porozumeni','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M7A 2021 – úloha 14',
  new List<String>{'V cukrárně mají zabaleno celkem $80$ zákusků buď v malých krabičkách po $2$ zákuscích, nebo ve velkých krabičkách po $3$ zákuscích. Malých krabiček je o $10$ více než velkých.','Kolik krabiček se zákusky (malých i velkých dohromady) mají v cukrárně?'},
  new List<String>{'A) $24$','B) $34$','C) $38$','D) $40$','E) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Velkých $v$, malých $v+10$: $2(v+10)+3v=80$, tj. $5v+20=80$, $v=12$. Malých $22$, celkem $12+22=34$ krabiček.'},
  'B) $34$',
  2, 4, '2',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
