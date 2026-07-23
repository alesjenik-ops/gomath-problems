String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M5B 2018 – úloha 14',
  new List<String>{'Ze stejně velkých čtverečků se podle jednotného pravidla sestavují obdélníky. První obdélník obsahuje $2$ čtverečky. Každý další obdélník vznikne tak, že se k předchozímu přidá nejprve dole jedna řada tmavých čtverečků a poté vpravo jeden sloupec bílých čtverečků. Číslo nahoře nad obdélníkem udává počet všech čtverečků v obdélníku, číslo vpravo udává počet bílých čtverečků v nejdelším z přidaných sloupců (viz obrázek).','14.1 Obdélník obsahuje celkem $110$ čtverečků. Určete počet bílých čtverečků v nejdelším z přidaných sloupců.','14.2 Nejdelší z přidaných sloupců obsahuje $20$ bílých čtverečků. Určete počet všech čtverečků v obdélníku.','14.3 Počet čtverečků v obdélníku je větší než $900$, ale menší než $1\\,000$. Určete přesný počet čtverečků v obdélníku. Najděte všechna možná řešení.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 390 120" font-family="sans-serif"><rect x="24" y="80" width="30" height="15" fill="#ffffff"/><rect x="24" y="80" width="30" height="15" fill="#cfcfcf"/><g stroke="#000" stroke-width="0.9"><line x1="24" y1="80" x2="24" y2="95"/><line x1="39" y1="80" x2="39" y2="95"/><line x1="54" y1="80" x2="54" y2="95"/><line x1="24" y1="80" x2="54" y2="80"/><line x1="24" y1="95" x2="54" y2="95"/><rect x="24" y="80" width="30" height="15" fill="none" stroke="#000" stroke-width="1.4"/></g><text x="39" y="74" font-size="12" text-anchor="middle">2</text><rect x="80" y="65" width="45" height="30" fill="#ffffff"/><rect x="80" y="80" width="45" height="15" fill="#cfcfcf"/><g stroke="#000" stroke-width="0.9"><line x1="80" y1="65" x2="80" y2="95"/><line x1="95" y1="65" x2="95" y2="95"/><line x1="110" y1="65" x2="110" y2="95"/><line x1="125" y1="65" x2="125" y2="95"/><line x1="80" y1="65" x2="125" y2="65"/><line x1="80" y1="80" x2="125" y2="80"/><line x1="80" y1="95" x2="125" y2="95"/><rect x="80" y="65" width="45" height="30" fill="none" stroke="#000" stroke-width="1.4"/></g><text x="102" y="59" font-size="12" text-anchor="middle">6</text><text x="133" y="84" font-size="12">2</text><rect x="151" y="50" width="60" height="45" fill="#ffffff"/><rect x="151" y="80" width="60" height="15" fill="#cfcfcf"/><g stroke="#000" stroke-width="0.9"><line x1="151" y1="50" x2="151" y2="95"/><line x1="166" y1="50" x2="166" y2="95"/><line x1="181" y1="50" x2="181" y2="95"/><line x1="196" y1="50" x2="196" y2="95"/><line x1="211" y1="50" x2="211" y2="95"/><line x1="151" y1="50" x2="211" y2="50"/><line x1="151" y1="65" x2="211" y2="65"/><line x1="151" y1="80" x2="211" y2="80"/><line x1="151" y1="95" x2="211" y2="95"/><rect x="151" y="50" width="60" height="45" fill="none" stroke="#000" stroke-width="1.4"/></g><text x="181" y="44" font-size="12" text-anchor="middle">12</text><text x="219" y="76" font-size="12">3</text><rect x="237" y="35" width="75" height="60" fill="#ffffff"/><rect x="237" y="80" width="75" height="15" fill="#cfcfcf"/><g stroke="#000" stroke-width="0.9"><line x1="237" y1="35" x2="237" y2="95"/><line x1="252" y1="35" x2="252" y2="95"/><line x1="267" y1="35" x2="267" y2="95"/><line x1="282" y1="35" x2="282" y2="95"/><line x1="297" y1="35" x2="297" y2="95"/><line x1="312" y1="35" x2="312" y2="95"/><line x1="237" y1="35" x2="312" y2="35"/><line x1="237" y1="50" x2="312" y2="50"/><line x1="237" y1="65" x2="312" y2="65"/><line x1="237" y1="80" x2="312" y2="80"/><line x1="237" y1="95" x2="312" y2="95"/><rect x="237" y="35" width="75" height="60" fill="none" stroke="#000" stroke-width="1.4"/></g><text x="274" y="29" font-size="12" text-anchor="middle">20</text><text x="320" y="69" font-size="12">4</text><text x="342" y="83" font-size="18">…</text></svg>',
  'obdelniky.svg',
  'Čtyři rostoucí obdélníky s 2, 6, 12 a 20 čtverečky; spodní řada je tmavá, pravý sloupec bílý, nad každým je počet čtverečků a vpravo počet přidaných bílých čtverečků.',
  'První čtyři obdélníky rostoucí posloupnosti',
  new List<String>{'$n$-tý obdélník má rozměr $(n + 1)$ krát $n$ čtverečků, takže obsahuje $n \\cdot (n + 1)$ čtverečků; číslo vpravo (počet bílých čtverečků v nejdelším přidaném sloupci) je rovno $n$.','14.1 $n \\cdot (n + 1) = 110 = 10 \\cdot 11$, tedy $n = 10$; hledaný počet bílých čtverečků je $10$.','14.2 Je $n = 20$, počet všech čtverečků je $20 \\cdot 21 = 420$.','14.3 Hledáme $n \\cdot (n + 1)$ mezi $900$ a $1\\,000$: $30 \\cdot 31 = 930$ a $31 \\cdot 32 = 992$. Obě hodnoty vyhovují.'},
  '14.1: $10$; 14.2: $420$; 14.3: $930$ a $992$',
  4, 6, '3',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
