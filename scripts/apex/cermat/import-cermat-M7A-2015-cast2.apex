String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M7A 2015 – úloha 4–5',
  new List<String>{'Všechny osoby skupiny A postupně přešly na stanoviště X nebo Y tak, jak znázorňuje schéma.','Ze skupiny A odešla $\\frac{1}{3}$ osob na stanoviště X, zbytek osob se přesunul na přechodné stanoviště P.','Na přechodné stanoviště P se dostalo 60 osob. Z něj pak přešla $\\frac{1}{3}$ osob na stanoviště X, ostatní na stanoviště Y.','4.1 Určete konečný počet osob na stanovišti Y.','4.2 Určete původní počet osob ve skupině A.','5.1 Vyjádřete zlomkem v základním tvaru, jaká část osob skupiny A se dostala na stanoviště X.','5.2 Vyjádřete zlomkem v základním tvaru, jaká část osob skupiny A se dostala na stanoviště Y.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 330" font-family="sans-serif"><defs><marker id="a" markerWidth="9" markerHeight="9" refX="8" refY="3" orient="auto"><path d="M0,0 L8,3 L0,6 z" fill="#000"/></marker></defs><ellipse cx="220" cy="45" rx="55" ry="22" fill="none" stroke="#000" stroke-width="2"/><text x="220" y="18" font-size="16" font-weight="bold" text-anchor="middle">A</text><ellipse cx="280" cy="165" rx="52" ry="21" fill="none" stroke="#000" stroke-width="2"/><text x="280" y="140" font-size="16" font-weight="bold" text-anchor="middle">P</text><text x="280" y="170" font-size="13" text-anchor="middle">60 osob</text><ellipse cx="110" cy="285" rx="55" ry="22" fill="none" stroke="#000" stroke-width="2"/><text x="110" y="258" font-size="16" font-weight="bold" text-anchor="middle">X</text><ellipse cx="360" cy="285" rx="55" ry="22" fill="none" stroke="#000" stroke-width="2"/><text x="360" y="258" font-size="16" font-weight="bold" text-anchor="middle">Y</text><line x1="205" y1="66" x2="122" y2="262" stroke="#000" stroke-width="2" marker-end="url(#a)"/><line x1="240" y1="64" x2="272" y2="143" stroke="#000" stroke-width="2" marker-end="url(#a)"/><line x1="255" y1="182" x2="140" y2="268" stroke="#000" stroke-width="2" marker-end="url(#a)"/><line x1="303" y1="184" x2="345" y2="261" stroke="#000" stroke-width="2" marker-end="url(#a)"/><text x="140" y="146" font-size="13" text-anchor="middle">1</text><line x1="132" y1="150" x2="148" y2="150" stroke="#000" stroke-width="1"/><text x="140" y="164" font-size="13" text-anchor="middle">3</text><text x="275" y="96" font-size="13" text-anchor="middle">2</text><line x1="267" y1="100" x2="283" y2="100" stroke="#000" stroke-width="1"/><text x="275" y="114" font-size="13" text-anchor="middle">3</text><text x="210" y="216" font-size="13" text-anchor="middle">1</text><line x1="202" y1="220" x2="218" y2="220" stroke="#000" stroke-width="1"/><text x="210" y="234" font-size="13" text-anchor="middle">3</text><text x="345" y="216" font-size="13" text-anchor="middle">2</text><line x1="337" y1="220" x2="353" y2="220" stroke="#000" stroke-width="1"/><text x="345" y="234" font-size="13" text-anchor="middle">3</text></svg>',
  'schema-stanoviste.svg',
  'Schéma: ze skupiny A vede jedna třetina na stanoviště X a dvě třetiny na přechodné stanoviště P se 60 osobami; z P jde jedna třetina na X a dvě třetiny na Y.',
  'Schéma přesunů osob',
  new List<String>{'Na P se dostaly $\\frac{2}{3}$ osob skupiny A, což je 60 osob, tedy $A=60:\\frac{2}{3}=90$ osob.','4.1 Z P přešly na Y dvě třetiny: $\\frac{2}{3}\\cdot 60=40$ osob.','4.2 Skupina A měla $90$ osob.','5.1 Na X: přímo $\\frac{1}{3}\\cdot 90=30$ a z P $\\frac{1}{3}\\cdot 60=20$, celkem $50$ osob, tj. $\\frac{50}{90}=\\frac{5}{9}$.','5.2 Na Y: $40$ osob z $90$, tj. $\\frac{40}{90}=\\frac{4}{9}$.'},
  '4.1: $40$ osob; 4.2: $90$ osob; 5.1: $\\frac{5}{9}$; 5.2: $\\frac{4}{9}$',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2015 – úloha 6',
  new List<String>{'Pavel měl sraz s kamarádem. Z postele vstal hned po zazvonění budíku.','Ranní hygienu zvládl za $\\frac{1}{5}$ hodiny, 5 minut se oblékal, snídal $\\frac{1}{3}$ hodiny a cesta na sraz mu trvala $\\frac{1}{10}$ hodiny.','Na sraz přišel v 9:20.','6.1 Vypočtěte, kolik minut Pavlovi trvala ranní hygiena.','6.2 Vypočtěte, kolik minut uplynulo od zazvonění budíku k příchodu Pavla na sraz.','6.3 Vypočtěte, v kolik hodin zazvonil budík.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 $\\frac{1}{5}$ hodiny $=\\frac{60}{5}=12$ minut.','6.2 Snídaně $\\frac{1}{3}\\cdot 60=20$ min, cesta $\\frac{1}{10}\\cdot 60=6$ min. Celkem $12+5+20+6=43$ minut.','6.3 $9{:}20$ mínus $43$ minut je $8{:}37$.'},
  '6.1: $12$ minut; 6.2: $43$ minut; 6.3: v $8{:}37$',
  3, 5, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
