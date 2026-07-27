String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD17C0T02';
Integer YEAR = 2017;

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
  'CERMAT M9B 2017 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží trojúhelník $RST$ (viz obrázek).','Sestrojte obraz $R_1S_1T_1$ trojúhelníku $RST$ ve středové souměrnosti se středem $S$. Všechny vrcholy trojúhelníku $R_1S_1T_1$ označte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 240" font-family="sans-serif"> <polygon points="50,190 250,190 340,60" fill="none" stroke="#000" stroke-width="2"/> <text x="40" y="210" font-size="16" font-style="italic">R</text> <text x="246" y="210" font-size="16" font-style="italic">S</text> <text x="346" y="52" font-size="16" font-style="italic">T</text> </svg>',
  'trojuhelnik-RST.svg',
  'Trojúhelník RST v rovině; vrchol R vlevo dole, S uprostřed dole, T vpravo nahoře.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Střed souměrnosti $S$ je samodružný bod, proto $S_1=S$.','Bod $R_1$ leží na přímce $RS$ na opačné polopřímce než $R$ a platí $|SR_1|=|SR|$.','Bod $T_1$ leží na přímce $TS$ na opačné polopřímce než $T$ a platí $|ST_1|=|ST|$.','Spojením bodů $R_1$, $S_1$, $T_1$ vznikne hledaný obraz.'},
  'Trojúhelník $R_1S_1T_1$: $S_1=S$, bod $R_1$ na přímce $RS$ za bodem $S$ s $|SR_1|=|SR|$, bod $T_1$ na přímce $TS$ za bodem $S$ s $|ST_1|=|ST|$ – viz obrázek v klíči.',
  2, 4, '2',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2017 – úloha 10 (konstrukce)',
  new List<String>{'Kružnici $k$ se středem $S$ protíná přímka ve dvou bodech $C$ a $D$ (viz obrázek).','Body $C$, $D$ jsou vrcholy rovnoramenného lichoběžníku $ABCD$. Všechny čtyři vrcholy tohoto lichoběžníku leží na kružnici $k$. Vzdálenost chybějících vrcholů $A$, $B$ od přímky $CD$ je rovna poloměru $r=|SC|$ kružnice $k$.','10.1 Sestrojte vrcholy $A$, $B$ lichoběžníku $ABCD$ a lichoběžník narýsujte.','10.2 Sestrojte osu souměrnosti lichoběžníku $ABCD$ (pokud existuje) a označte ji $o$.','10.3 Sestrojte výšku lichoběžníku $ABCD$ z vrcholu $D$ a označte ji $v$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 320" font-family="sans-serif"> <circle cx="210" cy="180" r="100" fill="none" stroke="#000" stroke-width="2"/> <line x1="61" y1="130" x2="339" y2="90" stroke="#000" stroke-width="2"/> <line x1="270" y1="100" x2="210" y2="180" stroke="#000"/> <text x="272" y="90" font-size="16" font-style="italic">C</text> <text x="112" y="126" font-size="16" font-style="italic">D</text> <text x="304" y="212" font-size="16" font-style="italic">k</text> <text x="204" y="186" font-size="14">x</text> <text x="216" y="198" font-size="15" font-style="italic">S</text> </svg>',
  'kruznice-secna.svg',
  'Kružnice k se středem S, kterou protíná přímka v bodech C a D.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'10.1 Sestrojíme rovnoběžku s přímkou $CD$ ve vzdálenosti $r=|SC|$, a to na té straně přímky $CD$, kde leží střed $S$. Její průsečíky s kružnicí $k$ jsou vrcholy $A$ a $B$. Protože $AB$ je rovnoběžná s $CD$ a obě jsou tětivy téže kružnice, je lichoběžník $ABCD$ rovnoramenný.','10.2 Osa souměrnosti $o$ je společná osa obou rovnoběžných stran; je kolmá na $AB$ i $CD$ a prochází středem $S$.','10.3 Výška $v$ z vrcholu $D$ je kolmice vedená z bodu $D$ k přímce $AB$ (její délka je rovna $r$).'},
  'Vrcholy $A$, $B$ jsou průsečíky kružnice $k$ s rovnoběžkou s $CD$ vedenou ve vzdálenosti $r=|SC|$ na straně středu $S$; osa $o$ prochází $S$ kolmo k $AB$; výška $v$ je kolmice z $D$ k přímce $AB$ – viz obrázek v klíči.',
  3, 8, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2017 – úloha 11',
  new List<String>{'Balení, které obsahuje 15 kg granulí, vystačí čtyřem psům na 15 dnů. Všichni čtyři psi dostávají denně stejné množství granulí.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 Jeden pes dostává denně 250 g granulí.','11.2 Pouze dvěma psům by 15kg balení granulí vystačilo na 30 dnů.','11.3 Jednomu psovi vystačí desetina 15kg balení granulí na 10 dnů.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Jeden pes spotřebuje denně $15\\,000:(4\\cdot 15)=250$ g granulí.','11.1 Ano.','11.2 Dva psi spotřebují denně $500$ g, balení vystačí na $15\\,000:500=30$ dnů → Ano.','11.3 Desetina balení je $1\\,500$ g, což jednomu psovi vystačí na $1\\,500:250=6$ dnů, ne na 10 → Ne.'},
  '11.1: Ano; 11.2: Ano; 11.3: Ne',
  4, 5, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
