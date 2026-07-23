String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD26C0T01';
Integer YEAR = 2026;

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
  'CERMAT M5A 2026 – úloha 1.1',
  new List<String>{'Vypočtěte: $45-15:5+42:(10-4)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podle pořadí operací: $45-3+7=49$.'},
  '$49$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2026 – úloha 1.2',
  new List<String>{'Vypočtěte: $50\\cdot 1600-1600:40+40=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$80\\,000-40+40=80\\,000$.'},
  '$80\\,000$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2026 – úloha 2',
  new List<String>{'Sára měla v kasičce tři korunové, tři dvoukorunové a tři pětikorunové mince. Sára si z kasičky vyklepala tři mince. Nejméně tak mohla získat částku 3 koruny a nejvíce 15 korun.','Určete v celých korunách všechny částky od 3 do 15 korun, které Sára nemohla získat.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Ze tří mincí lze složit částky $3,4,5,6,7,8,9,11,12,15$. V rozsahu 3–15 tedy nelze získat $10$, $13$ a $14$ korun.'},
  '$10$ korun; $13$ korun; $14$ korun',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2026 – úloha 3',
  new List<String>{'V řeznictví stojí 1 kg masa 180 korun.','3.1 Vypočtěte, kolik korun zaplatíme v řeznictví za 200 g masa.','3.2 Vypočtěte, kolik gramů masa koupíme v řeznictví za 54 korun.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 $200$ g $=\\frac{1}{5}$ kg, tj. $\\frac{180}{5}=36$ korun.','3.2 $1$ Kč $\\to \\frac{1000}{180}$ g; za $54$ Kč: $\\frac{54}{180}\\cdot 1000=300$ g.'},
  '3.1: $36$ korun; 3.2: $300$ gramů',
  3, 4, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2026 – úloha 4',
  new List<String>{'Na třech linkách pro třídění lahví se testovali roboti Arex, Bot a Cibo. Každý robot pracoval stále stejným tempem, nejrychlejší byl Cibo. Bot roztřídil za každých 10 minut o polovinu více lahví než Arex. Když pracoval každý ze tří robotů půl hodiny, roztřídili dohromady 900 lahví. Když pracovali Arex a Bot každý 10 minut, roztřídili dohromady 250 lahví.','4.1 Vypočtěte, kolik lahví roztřídil Cibo za půl hodiny.','4.2 Vypočtěte, kolik lahví roztřídil Arex za 10 minut.','4.3 Vypočtěte, za kolik minut Bot roztřídil 360 lahví.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Za 10 min: Arex $a$, Bot $1{,}5a$, dohromady $2{,}5a=250\\Rightarrow a=100$. Za 10 min: Arex 100, Bot 150.','4.2 Arex za 10 min $=100$ lahví.','4.1 Za 30 min všichni tři $900$; Arex+Bot za 30 min $=3\\cdot 250=750$, tedy Cibo $900-750=150$.','4.3 Bot třídí $150$ lahví za 10 min, tj. $15$/min; $360:15=24$ min.'},
  '4.1: $150$ lahví; 4.2: $100$ lahví; 4.3: za $24$ minut',
  5, 7, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
