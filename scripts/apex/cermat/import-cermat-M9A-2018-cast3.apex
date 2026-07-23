String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD18C0T01';
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
  'CERMAT M9A 2018 – úloha 9',
  new List<String>{'V rovině leží přímka $AB$ a mimo ni bod $M$ (viz obrázek).','Úsečka $AB$ je strana $c$ trojúhelníku $ABC$. Bod $M$ leží uvnitř tohoto trojúhelníku na těžnici $t_c$ (těžnice na stranu $c$). Výška $v_c$ (výška na stranu $c$) měří $6$ cm.','9.1 Sestrojte těžnici $t_c$, chybějící vrchol $C$ trojúhelníku $ABC$ a trojúhelník narýsujte.','9.2 Sestrojte těžiště trojúhelníku $ABC$ a označte jej písmenem $T$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 240" font-family="sans-serif"> <line x1="40" y1="190" x2="360" y2="190" stroke="#000" stroke-width="2"/> <line x1="110" y1="184" x2="110" y2="196" stroke="#000"/> <line x1="290" y1="184" x2="290" y2="196" stroke="#000"/> <text x="104" y="212" font-size="15" font-style="italic">A</text> <text x="284" y="212" font-size="15" font-style="italic">B</text> <text x="300" y="86" font-size="15">×</text> <text x="298" y="72" font-size="15" font-style="italic">M</text> </svg>',
  'primka-ab-m.svg',
  'Přímka AB s vyznačenými body A a B a bod M ležící mimo přímku.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Střed $S_c$ strany $AB$ najdeme jako průsečík osy úsečky $AB$ s $AB$. Těžnice $t_c$ je přímka procházející body $S_c$ a $M$. Vrchol $C$ leží na $t_c$ ve vzdálenosti $v_c=6$ cm od přímky $AB$ (na téže straně jako $M$); sestrojíme jej jako průsečík $t_c$ s rovnoběžkou s $AB$ vedenou ve vzdálenosti $6$ cm. Trojúhelník $ABC$ narýsujeme.','Těžiště $T$ leží na těžnici $t_c$, přičemž $|S_cT|=\\frac{1}{3}|S_cC|$ (nebo jako průsečík dalších těžnic).'},
  'Konstrukce: $S_c$ je střed strany $AB$; těžnice $t_c$ je přímka $S_cM$; vrchol $C$ leží na $t_c$ ve vzdálenosti $v_c=6$ cm od $AB$ (na straně bodu $M$); těžiště $T$ leží na $t_c$ s $|S_cT|=\\frac{1}{3}|S_cC|$ (viz obrázek v klíči).',
  3, 7, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 10',
  new List<String>{'V rovině leží trojúhelník $KLM$ (viz obrázek).','Kružnice $k$ prochází vrcholy trojúhelníku $KLM$. Sestrojte střed $S$ kružnice $k$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 300" font-family="sans-serif"> <polygon points="70,150 320,90 150,270" fill="none" stroke="#000" stroke-width="2"/> <text x="50" y="150" font-size="15" font-style="italic">M</text> <text x="326" y="92" font-size="15" font-style="italic">L</text> <text x="146" y="288" font-size="15" font-style="italic">K</text> </svg>',
  'trojuhelnik-klm.svg',
  'Trojúhelník KLM v rovině (M vlevo, L vpravo nahoře, K dole).',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Střed $S$ kružnice opsané je stejně vzdálen od všech vrcholů, leží tedy na osách stran. Sestrojíme osy dvou stran trojúhelníku (např. $KL$ a $LM$); jejich průsečík je hledaný střed $S$.'},
  'Konstrukce: střed $S$ je průsečík os stran trojúhelníku $KLM$ (os úseček $KL$ a $LM$) (viz obrázek v klíči).',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 11',
  new List<String>{'Pro vnitřní úhly trojúhelníku $ABC$ platí: $\\alpha:\\beta=5:3$, $\\alpha:\\gamma=1:2$.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 $\\beta:\\gamma=5:6$','11.2 $\\gamma-\\beta=70^\\circ$','11.3 $\\gamma-\\alpha=50^\\circ$'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Z $\\alpha:\\beta=5:3$ a $\\alpha:\\gamma=1:2$ plyne $\\alpha=5t$, $\\beta=3t$, $\\gamma=10t$. Součet $18t=180^\\circ$, tedy $t=10^\\circ$: $\\alpha=50^\\circ$, $\\beta=30^\\circ$, $\\gamma=100^\\circ$.','11.1 $\\beta:\\gamma=30:100=3:10\\ne 5:6$ → Ne.','11.2 $\\gamma-\\beta=100^\\circ-30^\\circ=70^\\circ$ → Ano.','11.3 $\\gamma-\\alpha=100^\\circ-50^\\circ=50^\\circ$ → Ano.'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  4, 5, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
