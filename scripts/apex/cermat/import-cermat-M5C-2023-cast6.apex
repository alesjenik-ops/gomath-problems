String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD23C0T03';
Integer YEAR = 2023;

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
  'CERMAT M5C 2023 – úloha 13',
  new List<String>{'V každém diagramu se stejná písmena nahradí stejným kladným číslem a do prázdných kroužků se doplní taková čísla, aby byly všechny výpočty provedené ve směru šipek správné. VZOR: z levého dolního kroužku (8) vede šipka $+P$ do horního kroužku, z horního šipka $:P$ do pravého dolního a z levého dolního šipka $-6$ do pravého dolního. Obě písmena $P$ se nahradí číslem 8 (horní kroužek 16, pravý dolní 2).','Ke každému diagramu (13.1–13.3) přiřaďte číslo (A–F), kterým se v diagramu nahradí stejná písmena.','13.1 Levý dolní kroužek $+3$ do horního, horní $:K$ do pravého dolního (v něm je 2), levý dolní $-K$ do pravého dolního. Určete $K$.','13.2 Levý dolní kroužek (14) $+L$ do horního, horní $:3$ do pravého dolního, levý dolní $-L$ do pravého dolního. Určete $L$.','13.3 Horní kroužek (36); levý dolní $+M$ do horního, horní $:M$ do pravého dolního, levý dolní $-24$ do pravého dolního. Určete $M$.'},
  new List<String>{'A) 2','B) 3','C) 4','D) 5','E) 6','F) jiné číslo'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 220 170" font-family="sans-serif"> <circle cx="100" cy="42" r="18" fill="#fff" stroke="#000"/> <circle cx="55" cy="120" r="18" fill="#fff" stroke="#000"/> <circle cx="145" cy="120" r="18" fill="#fff" stroke="#000"/> <text x="100" y="47" font-size="14" text-anchor="middle">16</text> <text x="55" y="125" font-size="14" text-anchor="middle">8</text> <text x="145" y="125" font-size="14" text-anchor="middle">2</text> <line x1="66" y1="106" x2="88" y2="57" stroke="#000" stroke-width="1.5"/> <line x1="112" y1="57" x2="134" y2="106" stroke="#000" stroke-width="1.5"/> <line x1="73" y1="128" x2="127" y2="128" stroke="#000" stroke-width="1.5"/> <text x="58" y="82" font-size="12">+P</text> <text x="132" y="82" font-size="12">:P</text> <text x="100" y="147" font-size="12" text-anchor="middle">-6</text> </svg>',
  'diagram-vzor.svg',
  'Vzorový diagram se třemi kroužky a operacemi plus P, děleno P a minus 6.',
  'Vzorový diagram (schematický nákres)',
  new List<String>{'13.1 Levý dolní $=x$, horní $=x+3$, pravý dolní $=2$. Z $x-K=2$ a $(x+3):K=2$ plyne $x+3=2(x-2)$, tedy $x=7$ a $K=5$ → D.','13.2 Horní $=14+L$, pravý dolní $=(14+L):3=14-L$, odtud $14+L=42-3L$, $L=7$ → F (jiné číslo).','13.3 Horní $36=$ levý dolní $+M$, tj. levý dolní $=36-M$; pravý dolní $=36:M=(36-M)-24$. Z $36=M(12-M)$ plyne $(M-6)^2=0$, tedy $M=6$ → E.'},
  '13.1: D ($K=5$); 13.2: F ($L=7$); 13.3: E ($M=6$)',
  5, 7, '4',
  new List<String>{'zs1','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
