String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD21C0T01';
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
  'CERMAT M9A 2021 – úloha 16',
  new List<String>{'Každý díl stavebnice se skládá ze tří stejných krychliček; všechny díly jsou stejné. Z dílů stavíme stále větší pyramidy jako na obrázku. Nejmenší pyramidu tvoří jediný díl. Druhá pyramida sestavená ze $3$ dílů má $1$ otvor, $4$ řady a ve spodní řadě $4$ krychličky. Každá další pyramida bude o dvě řady vyšší než předchozí pyramida.','16.1 Pyramida má ve spodní řadě $50$ krychliček. Určete počet otvorů ve druhé řadě zdola.','16.2 Pyramida má celkem $10$ otvorů. Určete počet krychliček v celé pyramidě.','16.3 Pyramida je sestavena z $21$ dílů. Určete počet krychliček ve spodní řadě.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif"><text x="95" y="138" font-size="13" text-anchor="middle">1. pyramida</text><rect x="84.0" y="150" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="73.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="95.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><text x="255" y="94" font-size="13" text-anchor="middle">2. pyramida</text><rect x="244.0" y="106" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="233.0" y="128" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="255.0" y="128" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="222.0" y="150" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="266.0" y="150" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="211.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="233.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="255.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="277.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><text x="445" y="50" font-size="13" text-anchor="middle">3. pyramida</text><rect x="434.0" y="62" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="423.0" y="84" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="445.0" y="84" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="412.0" y="106" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="456.0" y="106" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="401.0" y="128" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="423.0" y="128" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="445.0" y="128" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="467.0" y="128" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="390.0" y="150" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="434.0" y="150" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="478.0" y="150" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="379.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="401.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="423.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="445.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="467.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><rect x="489.0" y="172" width="22" height="22" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/><text x="528" y="182" font-size="22">…</text></svg>',
  'pyramidy.svg',
  'Tři pyramidy z krychliček: 1. pyramida (2 řady), 2. pyramida (4 řady, 1 otvor), 3. pyramida (6 řad, 3 otvory).',
  '1., 2. a 3. pyramida z dílů po třech krychličkách',
  new List<String>{'$n$-tá pyramida má $2n$ řad; řada odshora s pořadím $r$ má $r$ pozic a v liché řadě ($r\\ge 3$) se pravidelně střídají krychlička a otvor, takže obsahuje $\\dfrac{r-1}{2}$ otvorů. Spodní řada má $2n$ krychliček, počet dílů je $\\dfrac{n(n+1)}{2}$, počet krychliček $3\\cdot\\dfrac{n(n+1)}{2}$ a počet otvorů $\\dfrac{n(n-1)}{2}$.','16.1 Spodní řada $2n=50$, tedy $n=25$. Druhá řada zdola má $2n-1=49$ pozic, otvorů je $\\dfrac{49-1}{2}=24$.','16.2 $\\dfrac{n(n-1)}{2}=10\\Rightarrow n(n-1)=20\\Rightarrow n=5$. Krychliček $3\\cdot\\dfrac{5\\cdot 6}{2}=45$.','16.3 Dílů $\\dfrac{n(n+1)}{2}=21\\Rightarrow n(n+1)=42\\Rightarrow n=6$. Ve spodní řadě je $2n=12$ krychliček.'},
  '16.1: $24$ otvorů; 16.2: $45$ krychliček; 16.3: $12$ krychliček',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
