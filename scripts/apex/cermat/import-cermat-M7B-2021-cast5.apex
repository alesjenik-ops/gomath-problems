String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD21C0T02';
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
  'CERMAT M7B 2021 – úloha 10',
  new List<String>{'V grafu jsou znázorněny počty dívek a počty chlapců v jazykových školách A a B. Ve škole A je v každé třídě $10$ dětí a ve škole B je v každé třídě $20$ dětí.','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).','10.1 Ve škole A je o polovinu méně chlapců než ve škole B.','10.2 Ve škole B je o třetinu více chlapců než dívek.','10.3 Ve škole B je o třetinu méně tříd než ve škole A.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 350" font-family="sans-serif"><line x1="70" y1="40" x2="70" y2="300" stroke="#000"/><line x1="70" y1="300" x2="460" y2="300" stroke="#000"/><line x1="66" y1="300.0" x2="70" y2="300.0" stroke="#000"/><text x="62" y="304.0" font-size="11" text-anchor="end">0</text><line x1="66" y1="265.0" x2="70" y2="265.0" stroke="#000"/><text x="62" y="269.0" font-size="11" text-anchor="end">20</text><line x1="66" y1="230.0" x2="70" y2="230.0" stroke="#000"/><text x="62" y="234.0" font-size="11" text-anchor="end">40</text><line x1="66" y1="195.0" x2="70" y2="195.0" stroke="#000"/><text x="62" y="199.0" font-size="11" text-anchor="end">60</text><line x1="66" y1="160.0" x2="70" y2="160.0" stroke="#000"/><text x="62" y="164.0" font-size="11" text-anchor="end">80</text><line x1="66" y1="125.0" x2="70" y2="125.0" stroke="#000"/><text x="62" y="129.0" font-size="11" text-anchor="end">100</text><line x1="66" y1="90.0" x2="70" y2="90.0" stroke="#000"/><text x="62" y="94.0" font-size="11" text-anchor="end">120</text><line x1="66" y1="55.0" x2="70" y2="55.0" stroke="#000"/><text x="62" y="59.0" font-size="11" text-anchor="end">140</text><rect x="127" y="142.5" width="38" height="157.5" fill="#1a1a1a" stroke="#000"/><rect x="165" y="160.0" width="38" height="140.0" fill="#bdbdbd" stroke="#000"/><text x="165" y="318" font-size="13" text-anchor="middle">Divky</text><rect x="292" y="195.0" width="38" height="105.0" fill="#1a1a1a" stroke="#000"/><rect x="330" y="90.0" width="38" height="210.0" fill="#bdbdbd" stroke="#000"/><text x="330" y="318" font-size="13" text-anchor="middle">Chlapci</text><rect x="360" y="70" width="14" height="14" fill="#1a1a1a" stroke="#000"/><text x="380" y="82" font-size="12">Skola A</text><rect x="360" y="92" width="14" height="14" fill="#bdbdbd" stroke="#000"/><text x="380" y="104" font-size="12">Skola B</text><text x="22" y="170" font-size="12" text-anchor="middle" transform="rotate(-90 22 170)">Pocet deti</text></svg>',
  'graf-skoly.svg',
  'Sloupcový graf počtu dětí: dívky ve škole A devadesát, ve škole B osmdesát; chlapci ve škole A šedesát, ve škole B sto dvacet.',
  'Počty dívek a chlapců ve školách A a B',
  new List<String>{'10.1 Chlapci: škola A $60$, škola B $120$; $60$ je polovina ze $120$. Pravda (Ano).','10.2 Ve škole B: chlapců $120$, dívek $80$; $120$ je o polovinu (ne o třetinu) více než $80$. Nepravda (Ne).','10.3 Tříd: škola A $(90+60):10=15$, škola B $(80+120):20=10$; $10$ je o třetinu méně než $15$. Pravda (Ano).'},
  '10.1: Ano; 10.2: Ne; 10.3: Ano',
  4, 5, '3',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2021 – úloha 11',
  new List<String>{'V dětské hře se smí provádět pouze následující nákupy: za $5$ mincí lze koupit $6$ panáčků, za $20$ mincí lze koupit $9$ zvířátek.','Pepa si chce koupit stejný počet panáčků jako zvířátek. Kolik nejméně mincí k takovému nákupu potřebuje?'},
  new List<String>{'A) méně než $55$ mincí','B) $55$ mincí','C) $85$ mincí','D) $110$ mincí','E) více než $110$ mincí'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Panáčci se kupují po $6$, zvířátka po $9$; nejmenší společný počet je $18$. $18$ panáčků $=3\\cdot 5=15$ mincí, $18$ zvířátek $=2\\cdot 20=40$ mincí. Celkem $15+40=55$ mincí.'},
  'B) $55$ mincí',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
