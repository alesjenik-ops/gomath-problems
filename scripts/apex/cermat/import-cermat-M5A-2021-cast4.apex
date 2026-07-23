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
  'CERMAT M5A 2021 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží lomená čára $BCDEFG$ (viz obrázek).','Body $B$, $C$ jsou vrcholy trojúhelníku $ABC$. Vrchol $A$ tohoto trojúhelníku leží na lomené čáře $BCDEFG$. Délka strany $AC$ je stejná jako délka úsečky $EF$.','Sestrojte vrchol $A$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 470" font-family="sans-serif"><polyline points="430,95 210,150 130,360 410,430 650,255 380,270" fill="none" stroke="#000" stroke-width="2"/><line x1="422" y1="86" x2="438" y2="104" stroke="#000" stroke-width="2"/><line x1="372" y1="261" x2="388" y2="279" stroke="#000" stroke-width="2"/><text x="440" y="92" font-size="15" font-style="italic">B</text><text x="186" y="146" font-size="15" font-style="italic">C</text><text x="108" y="366" font-size="15" font-style="italic">D</text><text x="406" y="452" font-size="15" font-style="italic">E</text><text x="658" y="252" font-size="15" font-style="italic">F</text><text x="366" y="292" font-size="15" font-style="italic">G</text></svg>',
  'lomena-cara-BCDEFG.svg',
  'Lomená čára s vrcholy B, C, D, E, F, G; koncové body B a G jsou označeny příčkou.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Vrchol $A$ leží na lomené čáře $BCDEFG$ a zároveň platí $|AC|=|EF|$. Sestrojíme kružnici se středem $C$ a poloměrem $|EF|$; její průsečíky s lomenou čárou jsou hledané vrcholy $A_1$ a $A_2$. Úloha má dvě řešení.'},
  'Průsečíky kružnice se středem $C$ a poloměrem $|EF|$ s lomenou čárou $BCDEFG$ dávají vrcholy $A_1$, $A_2$ trojúhelníku $ABC$ (dvě řešení, viz obrázek v klíči).',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2021 – úloha 8',
  new List<String>{'V počítačové hře jsou tři znaky: hvězdička, kolečko a čtvereček. Jedna hvězdička má hodnotu tří koleček. Čtvereček a kolečko mají dohromady hodnotu dvou hvězdiček.','Rozhodněte o každé z následujících rovností (8.1–8.3), zda platí (A), či nikoli (N).','8.1 ★ □ □ = ★ ★ ★ ★','8.2 ★ ★ ★ ★ ★ = □ □ □','8.3 ★ ★ ○ = □ ★'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 130" font-family="sans-serif"><text x="20" y="48" font-size="26">★ = ○ ○ ○</text><text x="20" y="100" font-size="26">□ ○ = ★ ★</text></svg>',
  'znaky-hra.svg',
  'Dvě pravidla: hvězdička se rovná třem kolečkům; čtvereček a kolečko se rovnají dvěma hvězdičkám.',
  'Hodnoty znaků ve hře',
  new List<String>{'Hodnoty (v kolečkách): hvězdička $=3$, kolečko $=1$, čtvereček $=5$ (protože čtvereček $+$ kolečko $=2$ hvězdičky $=6$).','8.1 Vlevo $3+5+5=13$, vpravo $4\\cdot 3=12$; $13\\ne 12$, neplatí → N.','8.2 Vlevo $5\\cdot 3=15$, vpravo $3\\cdot 5=15$; rovnost platí → A.','8.3 Vlevo $3+3+1=7$, vpravo $5+3=8$; $7\\ne 8$, neplatí → N.'},
  '8.1: Ne; 8.2: Ano; 8.3: Ne',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
