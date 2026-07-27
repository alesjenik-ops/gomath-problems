String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD17C0T02';
Integer YEAR = 2017;

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
  'CERMAT M7B 2017 – úloha 14',
  new List<String>{'Každé ze 100 dětí uvedlo jednu aktivitu, kterou má ze všech nabízených aktivit nejraději. Výsledky jsou vyznačeny v diagramu: lezení uvedlo 18 dětí, plavání 26 dětí.','Dále bylo zjištěno: dětí, které mají nejraději kino, je dvakrát více než těch, které mají nejraději fotbal; dětí, které mají nejraději fotbal, je dvakrát více než těch, které mají nejraději cyklistiku.','Kolik dětí má nejraději fotbal?'},
  new List<String>{'A) 10 dětí','B) 12 dětí','C) 14 dětí','D) 16 dětí','E) 18 dětí'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 270" font-family="sans-serif"><text x="175" y="24" font-size="15" text-anchor="middle" font-weight="bold">AKTIVITY</text><path d="M 175 130 L 175 38 A 92 92 0 0 1 258 169 Z" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="271" y="69" font-size="13" font-weight="bold" text-anchor="start">kino</text><path d="M 175 130 L 258 169 A 92 92 0 0 1 187 221 Z" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="242" y="222" font-size="13" font-weight="bold" text-anchor="start">fotbal</text><path d="M 175 130 L 187 221 A 92 92 0 0 1 83 136 Z" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="102" y="218" font-size="13" font-weight="bold" text-anchor="end">plavání</text><text x="102" y="233" font-size="13" text-anchor="end">26 dětí</text><path d="M 175 130 L 83 136 A 92 92 0 0 1 92 91 Z" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="63" y="109" font-size="13" font-weight="bold" text-anchor="end">cyklistika</text><path d="M 175 130 L 92 91 A 92 92 0 0 1 175 38 Z" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="114" y="34" font-size="13" font-weight="bold" text-anchor="end">lezení</text><text x="114" y="49" font-size="13" text-anchor="end">18 dětí</text></svg>',
  'diagram-aktivity.svg',
  'Kruhový diagram AKTIVITY rozdělený na pět výsečí: lezení (18 dětí), kino, fotbal, plavání (26 dětí) a cyklistika.',
  'Diagram AKTIVITY (celkem 100 dětí)',
  new List<String>{'Na kino, fotbal a cyklistiku připadá $100-18-26=56$ dětí.','Označme cyklistiku $c$; pak fotbal $2c$ a kino $4c$, tedy $c+2c+4c=7c=56$, odtud $c=8$.','Fotbal má nejraději $2c=16$ dětí.'},
  'D) 16 dětí',
  2, 4, '2',
  new List<String>{'zs2','r7','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2017 – úloha 15',
  new List<String>{'Adam, Bořek a Cyril dostali za úkol vylepit 300 plakátů. Každý z chlapců má své stálé pracovní tempo. Kdyby pracoval každý sám, Adam by vylepil všechny plakáty za 4 hodiny a Bořek za 6 hodin.','Ve skutečnosti Adam vylepoval plakáty jen 2 hodiny a Bořek 1 hodinu. Zbytek plakátů vylepil Cyril.','Kolik plakátů vylepil Cyril?'},
  new List<String>{'A) 60','B) 75','C) 100','D) 120','E) více než 120'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Adam vylepí $300:4=75$ plakátů za hodinu, za 2 hodiny tedy $150$ plakátů.','Bořek vylepí $300:6=50$ plakátů za hodinu, za 1 hodinu tedy $50$ plakátů.','Cyril vylepil $300-150-50=100$ plakátů.'},
  'C) 100',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2017 – úloha 16',
  new List<String>{'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).','16.1 Radek váží $28$ kg a Petr váží o $25\\,\\%$ více než Radek. Kolik kg váží Petr?','16.2 Aby se snížila hmotnost zavazadla na $85\\,\\%$, muselo se z něj odebrat $6$ kg. Kolik kg váží odlehčené zavazadlo?','16.3 Aleš váží $24$ kg, tedy o třetinu méně než Dan. Kolik kg váží Dan?'},
  new List<String>{'A) méně než 33 kg','B) 33 kg','C) 34 kg','D) 35 kg','E) 36 kg','F) více než 36 kg'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'16.1 $25\\,\\%$ z $28$ kg je $7$ kg, tedy Petr váží $28+7=35$ kg → D.','16.2 Odebraných $6$ kg odpovídá $15\\,\\%$ původní hmotnosti, tj. $1\\,\\%$ je $0{,}4$ kg a celek $40$ kg. Odlehčené zavazadlo váží $85\\,\\%$ ze $40$ kg, tj. $34$ kg (nebo $40-6=34$ kg) → C.','16.3 Aleš váží dvě třetiny hmotnosti Dana: $\\frac{2}{3}d=24$, tedy $d=36$ kg → E.'},
  '16.1: D ($35$ kg); 16.2: C ($34$ kg); 16.3: E ($36$ kg)',
  6, 7, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
