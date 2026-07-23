String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD22C0T01';
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
  'CERMAT M7A 2022 – úloha 1',
  new List<String>{'Vypočtěte, kolik milimetrů jsou $\\frac{3}{20}$ ze tří metrů.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Tři metry jsou $3000$ mm. $\\frac{3}{20}$ ze $3000$ mm $=\\frac{3\\cdot 3000}{20}=450$ mm.'},
  '$450$ mm',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2022 – úloha 2',
  new List<String>{'Na číselné ose je zobrazeno jedenáct bodů oddělujících deset stejných dílků. Body $A$, $B$, $C$, $D$ představují čtyři čísla. V bodě $C$ je číslo $48$. Číslo v bodě $D$ je o $24$ větší než číslo v bodě $B$.','2.1 Vyznačte na číselné ose bod $P$, v němž je číslo $0$.','2.2 Vypočtěte číslo v bodě $A$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 140" font-family="sans-serif"><line x1="30" y1="90" x2="440" y2="90" stroke="#000" stroke-width="1.5"/><polygon points="440,90 430,85 430,95" fill="#000"/><line x1="40" y1="83" x2="40" y2="97" stroke="#000" stroke-width="1.5"/><line x1="76" y1="83" x2="76" y2="97" stroke="#000" stroke-width="1.5"/><line x1="112" y1="83" x2="112" y2="97" stroke="#000" stroke-width="1.5"/><line x1="148" y1="83" x2="148" y2="97" stroke="#000" stroke-width="1.5"/><line x1="184" y1="83" x2="184" y2="97" stroke="#000" stroke-width="1.5"/><line x1="220" y1="83" x2="220" y2="97" stroke="#000" stroke-width="1.5"/><line x1="256" y1="83" x2="256" y2="97" stroke="#000" stroke-width="1.5"/><line x1="292" y1="83" x2="292" y2="97" stroke="#000" stroke-width="1.5"/><line x1="328" y1="83" x2="328" y2="97" stroke="#000" stroke-width="1.5"/><line x1="364" y1="83" x2="364" y2="97" stroke="#000" stroke-width="1.5"/><line x1="400" y1="83" x2="400" y2="97" stroke="#000" stroke-width="1.5"/><text x="76" y="116" font-size="15" text-anchor="middle" font-style="italic">A</text><text x="292" y="116" font-size="15" text-anchor="middle" font-style="italic">B</text><text x="364" y="116" font-size="15" text-anchor="middle" font-style="italic">C</text><text x="400" y="116" font-size="15" text-anchor="middle" font-style="italic">D</text><text x="364" y="76" font-size="14" text-anchor="middle">48</text></svg>',
  'ciselna-osa.svg',
  'Číselná osa s jedenácti dělicími body; body A, B, C, D označují čtyři čísla, nad bodem C je číslo 48.',
  'Číselná osa k úloze 2',
  new List<String>{'Mezi body $B$ a $D$ leží tři dílky a čísla se liší o $24$, takže jeden dílek odpovídá číslu $24:3=8$.','2.1 Číslo $0$ je dva dílky vpravo od bodu $A$ (čtvrtý dělicí bod zleva).','2.2 Bod $A$ je osm dílků vlevo od bodu $C$: $A=48-8\\cdot 8=-16$.'},
  '2.1: bod $P$ (číslo $0$) leží dva dílky vpravo od bodu $A$; 2.2: $A=-16$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2022 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\frac{2}{5}:\\frac{8}{15}-\\frac{7}{8}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{2}{5}:\\frac{8}{15}=\\frac{2}{5}\\cdot\\frac{15}{8}=\\frac{30}{40}=\\frac{3}{4}$. Pak $\\frac{3}{4}-\\frac{7}{8}=\\frac{6}{8}-\\frac{7}{8}=-\\frac{1}{8}$.'},
  '$-\\frac{1}{8}$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2022 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\dfrac{\\frac{9}{7}\\cdot\\frac{14}{15}}{\\left(\\frac{4}{3}+2\\right)\\cdot 3}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{9}{7}\\cdot\\frac{14}{15}=\\frac{126}{105}=\\frac{6}{5}$. Jmenovatel: $\\left(\\frac{4}{3}+2\\right)\\cdot 3=\\frac{10}{3}\\cdot 3=10$. Celkem $\\frac{6}{5}:10=\\frac{6}{50}=\\frac{3}{25}$.'},
  '$\\frac{3}{25}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2022 – úloha 4.1',
  new List<String>{'Když neznámé kladné číslo vynásobíme samo sebou, dostaneme číslo o $17$ menší než devítinásobek čísla $9$.','Určete neznámé číslo.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Devítinásobek čísla $9$ je $9\\cdot 9=81$. Hledané kladné číslo $x$ splňuje $x^2=81-17=64$, tedy $x=8$.'},
  '$8$',
  2, 3, '2',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
