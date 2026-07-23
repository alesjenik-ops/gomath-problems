String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD22C0T01';
Integer YEAR = 2022;

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
  'CERMAT M9A 2022 – úloha 15',
  new List<String>{'Ve škole, která má v každém ročníku dvě třídy (A, B), proběhla soutěž ve sběru papíru. V tabulkách jsou uvedeny některé údaje z této soutěže (třídy 1. A a 1. B nasbíraly po $600$ kg, první ročník celkem $1\\,200$ kg).','Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Třída 2. A nasbírala o $25\\,\\%$ méně papíru než třída 1. A. Kolik kg papíru nasbírala třída 2. A?','15.2 Třída 1. B nasbírala o $20\\,\\%$ více papíru než třída 2. B. Kolik kg papíru nasbírala třída 2. B?','15.3 Ze všech žáků prvního ročníku nasbíraly dívky o $50\\,\\%$ více papíru než chlapci. Kolik kg papíru nasbírali dohromady chlapci z prvního ročníku?'},
  new List<String>{'A) $800$ kg','B) $720$ kg','C) $500$ kg','D) $480$ kg','E) $450$ kg','F) jiný počet kg'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 130" font-family="sans-serif"> <rect x="20" y="20" width="380" height="30" fill="none" stroke="#000"/> <text x="210" y="40" font-size="14" text-anchor="middle">První ročník</text> <rect x="20" y="50" width="76" height="30" fill="none" stroke="#000"/> <rect x="96" y="50" width="76" height="30" fill="none" stroke="#000"/> <rect x="172" y="50" width="76" height="30" fill="none" stroke="#000"/> <rect x="248" y="50" width="76" height="30" fill="none" stroke="#000"/> <rect x="324" y="50" width="76" height="30" fill="none" stroke="#000"/> <text x="58" y="70" font-size="13" text-anchor="middle">1. A</text> <text x="134" y="70" font-size="13" text-anchor="middle">1. B</text> <text x="210" y="70" font-size="13" text-anchor="middle">celkem</text> <text x="286" y="70" font-size="13" text-anchor="middle">dívky</text> <text x="362" y="70" font-size="13" text-anchor="middle">chlapci</text> <rect x="20" y="80" width="76" height="30" fill="none" stroke="#000"/> <rect x="96" y="80" width="76" height="30" fill="none" stroke="#000"/> <rect x="172" y="80" width="76" height="30" fill="none" stroke="#000"/> <rect x="248" y="80" width="76" height="30" fill="none" stroke="#000"/> <rect x="324" y="80" width="76" height="30" fill="none" stroke="#000"/> <text x="58" y="100" font-size="13" text-anchor="middle">600 kg</text> <text x="134" y="100" font-size="13" text-anchor="middle">600 kg</text> <text x="210" y="100" font-size="13" text-anchor="middle">1 200 kg</text> <rect x="452" y="20" width="152" height="30" fill="none" stroke="#000"/> <text x="528" y="40" font-size="14" text-anchor="middle">Druhý ročník</text> <rect x="452" y="50" width="76" height="30" fill="none" stroke="#000"/> <rect x="528" y="50" width="76" height="30" fill="none" stroke="#000"/> <text x="490" y="70" font-size="13" text-anchor="middle">2. A</text> <text x="566" y="70" font-size="13" text-anchor="middle">2. B</text> <rect x="452" y="80" width="76" height="30" fill="none" stroke="#000"/> <rect x="528" y="80" width="76" height="30" fill="none" stroke="#000"/> </svg>',
  'tabulky-papir.svg',
  'Dvě tabulky sběru papíru: První ročník (1. A 600 kg, 1. B 600 kg, celkem 1 200 kg, dívky, chlapci) a Druhý ročník (2. A, 2. B).',
  'Údaje ze soutěže ve sběru papíru',
  new List<String>{'15.1 $600\\cdot(1-0{,}25)=600\\cdot 0{,}75=450$ kg → E.','15.2 $600=1{,}2\\cdot(\\text{2. B})$, tedy $\\text{2. B}=600:1{,}2=500$ kg → C.','15.3 Chlapci $=c$, dívky $=1{,}5c$; $c+1{,}5c=2{,}5c=1\\,200$, odtud $c=480$ kg → D.'},
  '15.1: E ($450$ kg); 15.2: C ($500$ kg); 15.3: D ($480$ kg)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
