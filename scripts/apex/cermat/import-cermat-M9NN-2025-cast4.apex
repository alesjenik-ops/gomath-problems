String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M9 nanečisto 2025 – úloha 11',
  new List<String>{'V náčrtku pravidelného desetiúhelníku se středem $S$ jsou vyznačeny úhly $\\alpha$, $\\beta$, $\\gamma$ (viz obrázek). Úhly neměřte, náčrtek není přesný.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 $\\alpha=72^\\circ$','11.2 $\\beta<36^\\circ$','11.3 $\\gamma=\\alpha$'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 300" font-family="sans-serif"> <polygon points="150,30 220,53 264,113 264,187 220,247 150,270 80,247 36,187 36,113 80,53" fill="none" stroke="#000" stroke-width="2"/> <circle cx="150" cy="150" r="2.5" fill="#000"/> <text x="156" y="146" font-size="14" font-style="italic">S</text> <line x1="150" y1="150" x2="150" y2="30" stroke="#000"/> <line x1="150" y1="150" x2="264" y2="113" stroke="#000"/> <line x1="150" y1="150" x2="264" y2="187" stroke="#000"/> <line x1="150" y1="150" x2="36" y2="113" stroke="#000"/> <text x="168" y="118" font-size="15">β</text> <text x="168" y="176" font-size="15">α</text> <text x="96" y="140" font-size="15">γ</text> </svg>',
  'desetiuhelnik.svg',
  'Schematický náčrtek pravidelného desetiúhelníku se středem S a vyznačenými úhly alfa, beta a gama.',
  'Schematický nákres (úhly neměřte)',
  new List<String>{'V pravidelném desetiúhelníku je středový úhel příslušný jedné straně $360^\\circ:10=36^\\circ$ a vnitřní úhel $144^\\circ$; úhlopříčky z jednoho vrcholu dělí vnitřní úhel na osm dílů po $18^\\circ$.','11.1 Úhel $\\alpha$ je středový úhel nad dvěma stranami: $2\\cdot 36^\\circ=72^\\circ$ → Ano (A).','11.2 Úhel $\\beta=2\\cdot 18^\\circ=36^\\circ$, není tedy menší než $36^\\circ$ → Ne (N).','11.3 Úhel $\\gamma=4\\cdot 18^\\circ=72^\\circ=\\alpha$ → Ano (A).'},
  '11.1: A; 11.2: N; 11.3: A',
  4, 6, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 12',
  new List<String>{'Kytice byla svázána ze tří druhů květin: růží, chryzantém a static.','Růží a chryzantém dohromady je v kytici o 2 více než chryzantém a static dohromady. Počet růží ku počtu static je v poměru $5:4$, počet static ku počtu chryzantém v poměru $2:3$.','Cena za jeden kus: růže $54$ korun, chryzantéma $40$ korun, statice $35$ korun. Cena celé kytice se získá jako součet cen jednotlivých květin.','Kolik korun bude stát celá kytice?'},
  new List<String>{'A) $1\\,090$ korun','B) $1\\,252$ korun','C) $1\\,280$ korun','D) $1\\,300$ korun','E) jinou částku'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Z podmínky „růží a chryzantém o 2 více než chryzantém a static" plyne $R=St+2$. Z poměru $R:St=5:4$ je $R=\\frac{5}{4}St$, odtud $\\frac{5}{4}St=St+2$, tedy $St=8$ a $R=10$. Z poměru $St:Ch=2:3$ je $Ch=\\frac{3}{2}\\cdot 8=12$.','Cena kytice: $10\\cdot 54+12\\cdot 40+8\\cdot 35=540+480+280=1300$ korun.'},
  'D) $1\\,300$ korun',
  2, 6, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 13',
  new List<String>{'Na čtvrtku papíru narýsujeme rovné čáry, které jsou rovnoběžné s jedním nebo s druhým okrajem čtvrtky. Čáry jsou nakresleny přes celou čtvrtku a rozdělují ji na několik částí. Např. na obrázku rozděluje 6 rovných čar čtvrtku na 15 částí.','Jaký je nejmenší počet rovných čar, které rozdělí čtvrtku na 40 částí?'},
  new List<String>{'A) 11','B) 12','C) 13','D) 14','E) větší než 14'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 180" font-family="sans-serif"> <rect x="30" y="30" width="200" height="120" fill="#d9d9d9" stroke="#000" stroke-width="1"/> <line x1="70" y1="30" x2="70" y2="150" stroke="#000" stroke-width="3"/> <line x1="110" y1="30" x2="110" y2="150" stroke="#000" stroke-width="3"/> <line x1="150" y1="30" x2="150" y2="150" stroke="#000" stroke-width="3"/> <line x1="190" y1="30" x2="190" y2="150" stroke="#000" stroke-width="3"/> <line x1="30" y1="70" x2="230" y2="70" stroke="#000" stroke-width="3"/> <line x1="30" y1="110" x2="230" y2="110" stroke="#000" stroke-width="3"/> </svg>',
  'ctvrtka-cary.svg',
  'Schematický nákres čtvrtky rozdělené 6 rovnými čarami na 15 částí.',
  'Příklad: 6 čar rozdělí čtvrtku na 15 částí',
  new List<String>{'Čáry rovnoběžné se dvěma okraji: $v$ svislých a $h$ vodorovných čar rozdělí čtvrtku na $(v+1)(h+1)$ částí. Hledáme rozklad $40=(v+1)(h+1)$ s nejmenším součtem $v+h$.','Nejmenší součet dává rozklad $40=5\\cdot 8$: $v+1=5$, $h+1=8$, tj. $v=4$, $h=7$, celkem $4+7=11$ čar.'},
  'A) 11',
  2, 5, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
