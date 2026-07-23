String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD26C0T02';
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
  'CERMAT M5B 2026 – úloha 6',
  new List<String>{'Na obrázku jsou dvě části stejné čtvercové sítě. Každý její čtvereček má stranu délky 1 cm a obsah 1 cm². Vlevo je zakreslen šestiúhelník $ABCDEF$, jehož vrcholy leží v mřížových bodech sítě. Vpravo jsou vyznačeny dva mřížové body $K$ a $L$.','6.1 Určete v cm² obsah šestiúhelníku $ABCDEF$.','6.2 Body $K$, $L$ jsou vrcholy trojúhelníku $KLM$, který má obsah 5 cm². Najděte vrchol $M$ v některém z mřížových bodů a sestrojte trojúhelník $KLM$. Ze všech možných řešení zakreslete pouze jedno.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 150" font-family="sans-serif"><line x1="15" y1="15" x2="15" y2="119" stroke="#bbb"/><line x1="41" y1="15" x2="41" y2="119" stroke="#bbb"/><line x1="67" y1="15" x2="67" y2="119" stroke="#bbb"/><line x1="93" y1="15" x2="93" y2="119" stroke="#bbb"/><line x1="119" y1="15" x2="119" y2="119" stroke="#bbb"/><line x1="145" y1="15" x2="145" y2="119" stroke="#bbb"/><line x1="171" y1="15" x2="171" y2="119" stroke="#bbb"/><line x1="15" y1="15" x2="171" y2="15" stroke="#bbb"/><line x1="15" y1="41" x2="171" y2="41" stroke="#bbb"/><line x1="15" y1="67" x2="171" y2="67" stroke="#bbb"/><line x1="15" y1="93" x2="171" y2="93" stroke="#bbb"/><line x1="15" y1="119" x2="171" y2="119" stroke="#bbb"/><polygon points="67,119 119,93 119,41 67,67 41,41 15,93" fill="#dfe6ef" stroke="#000" stroke-width="2"/><text x="63" y="115" font-size="12" font-style="italic">A</text><text x="115" y="89" font-size="12" font-style="italic">B</text><text x="115" y="37" font-size="12" font-style="italic">C</text><text x="63" y="63" font-size="12" font-style="italic">D</text><text x="37" y="37" font-size="12" font-style="italic">E</text><text x="11" y="89" font-size="12" font-style="italic">F</text><line x1="226" y1="15" x2="226" y2="119" stroke="#bbb"/><line x1="252" y1="15" x2="252" y2="119" stroke="#bbb"/><line x1="278" y1="15" x2="278" y2="119" stroke="#bbb"/><line x1="304" y1="15" x2="304" y2="119" stroke="#bbb"/><line x1="330" y1="15" x2="330" y2="119" stroke="#bbb"/><line x1="356" y1="15" x2="356" y2="119" stroke="#bbb"/><line x1="382" y1="15" x2="382" y2="119" stroke="#bbb"/><line x1="226" y1="15" x2="382" y2="15" stroke="#bbb"/><line x1="226" y1="41" x2="382" y2="41" stroke="#bbb"/><line x1="226" y1="67" x2="382" y2="67" stroke="#bbb"/><line x1="226" y1="93" x2="382" y2="93" stroke="#bbb"/><line x1="226" y1="119" x2="382" y2="119" stroke="#bbb"/><text x="274" y="98" font-size="14">×</text><text x="282" y="109" font-size="12" font-style="italic">K</text><text x="326" y="72" font-size="14">×</text><text x="334" y="83" font-size="12" font-style="italic">L</text></svg>',
  'sit-sestiuhelnik-KL.svg',
  'Vlevo šestiúhelník ABCDEF v mřížových bodech čtvercové sítě, vpravo dva mřížové body K a L.',
  'Schematický nákres (dvě části čtvercové sítě)',
  new List<String>{'6.1 Napočítáním čtverečků (např. Pickovou větou) vyjde obsah šestiúhelníku $ABCDEF$ roven $10$ cm².','6.2 Trojúhelník $KLM$ má obsah $5$ cm². Vrchol $M$ leží v mřížovém bodě tak, aby výška z $M$ dala obsah $5$ cm²; takových poloh je více (viz klíč), zakreslí se jedna.'},
  '6.1: $10$ cm²; 6.2: trojúhelník $KLM$ s obsahem $5$ cm² (vrchol $M$ v mřížovém bodě, více řešení) – viz klíč',
  4, 7, '3',
  new List<String>{'zs1','planimetrie','vypocet','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
