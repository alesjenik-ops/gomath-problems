String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD21C0T01';
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
  'CERMAT M5A 2021 – úloha 9',
  new List<String>{'Panáček se rozloží na $6$ dílků – čepici, hlavu, každou ruku zvlášť, trup a nohy. Tabulka udává, jakou část hmotnosti panáčka tvoří jednotlivé dílky. (Např. nohy váží $72$ gramů a tvoří jednu třetinu hmotnosti panáčka.)','O kolik gramů je trup panáčka těžší než čepice?'},
  new List<String>{'A) o méně než 18 gramů','B) o 18 gramů','C) o 27 gramů','D) o 36 gramů','E) o 54 gramů'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 490 244" font-family="sans-serif"><line x1="8" y1="8" x2="338" y2="8" stroke="#000"/><line x1="8" y1="46" x2="338" y2="46" stroke="#000"/><line x1="8" y1="84" x2="338" y2="84" stroke="#000"/><line x1="8" y1="122" x2="338" y2="122" stroke="#000"/><line x1="8" y1="160" x2="338" y2="160" stroke="#000"/><line x1="8" y1="198" x2="338" y2="198" stroke="#000"/><line x1="8" y1="236" x2="338" y2="236" stroke="#000"/><line x1="8" y1="8" x2="8" y2="236" stroke="#000"/><line x1="118" y1="8" x2="118" y2="236" stroke="#000"/><line x1="238" y1="8" x2="238" y2="236" stroke="#000"/><line x1="338" y1="8" x2="338" y2="236" stroke="#000"/><text x="63.0" y="31.0" font-size="12" text-anchor="middle" font-weight="bold">Dílek</text><text x="178.0" y="31.0" font-size="12" text-anchor="middle" font-weight="bold">Část hmotn.</text><text x="288.0" y="31.0" font-size="12" text-anchor="middle" font-weight="bold">Hmotnost</text><text x="63.0" y="69.0" font-size="12" text-anchor="middle">Čepice</text><text x="178.0" y="69.0" font-size="12" text-anchor="middle">1/12</text><text x="63.0" y="107.0" font-size="12" text-anchor="middle">Hlava</text><text x="178.0" y="107.0" font-size="12" text-anchor="middle">1/6</text><text x="63.0" y="145.0" font-size="12" text-anchor="middle">1 ruka</text><text x="178.0" y="145.0" font-size="12" text-anchor="middle">1/12</text><text x="63.0" y="183.0" font-size="12" text-anchor="middle">Trup</text><text x="178.0" y="183.0" font-size="12" text-anchor="middle">1/4</text><text x="63.0" y="221.0" font-size="12" text-anchor="middle">Nohy</text><text x="178.0" y="221.0" font-size="12" text-anchor="middle">1/3</text><text x="288.0" y="221.0" font-size="12" text-anchor="middle">72 gramů</text><rect x="407" y="26" width="26" height="8" fill="#cccccc" stroke="#000"/><circle cx="420" cy="48" r="15" fill="none" stroke="#000"/><rect x="405" y="63" width="30" height="45" fill="#cccccc" stroke="#000"/><line x1="405" y1="72" x2="375" y2="98" stroke="#000"/><line x1="435" y1="72" x2="465" y2="98" stroke="#000"/><line x1="412" y1="108" x2="402" y2="150" stroke="#000"/><line x1="428" y1="108" x2="438" y2="150" stroke="#000"/></svg>',
  'panacek-tabulka.svg',
  'Tabulka dílků panáčka s částmi hmotnosti (čepice 1/12, hlava 1/6, ruka 1/12, trup 1/4, nohy 1/3, nohy 72 gramů) a schematický panáček.',
  'Části hmotnosti panáčka',
  new List<String>{'Nohy tvoří $\\frac{1}{3}$ hmotnosti a váží $72$ g, celý panáček váží $72\\cdot 3=216$ g.','Trup $\\frac{1}{4}\\cdot 216=54$ g, čepice $\\frac{1}{12}\\cdot 216=18$ g. Rozdíl $54-18=36$ g.'},
  'D) o 36 gramů',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2021 – úloha 10',
  new List<String>{'Karla, Zora a Olda postupně zametli $1$ km dlouhý chodník. První část chodníku zametla Karla, Zora pak zametla dvakrát delší část než Karla a Olda zametl ještě o $100$ metrů delší část chodníku než Zora. (Každou část chodníku zametala pouze jedna osoba.)','Kolik metrů chodníku zametl Olda?'},
  new List<String>{'A) 460 metrů','B) 500 metrů','C) 540 metrů','D) 550 metrů','E) jiný počet metrů'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Karla $x$, Zora $2x$, Olda $2x+100$; dohromady $1000$ m: $x+2x+2x+100=1000$, tj. $5x=900$, $x=180$. Olda: $2\\cdot 180+100=460$ m.'},
  'A) 460 metrů',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
