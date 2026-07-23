String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M9A 2020 – úloha 10',
  new List<String>{'V rovině leží přímka $o$ a body $A$, $M$ (viz obrázek). Bod $A$ je vrchol rovnoramenného lichoběžníku $ABCD$, bod $M$ je střed jeho ramene $BC$. Přímka $o$ je osou lichoběžníku $ABCD$.','Sestrojte vrcholy $B$, $C$, $D$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <line x1="235" y1="45" x2="180" y2="285" stroke="#000" stroke-width="2"/> <text x="243" y="46" font-size="16" font-style="italic">o</text> <text x="322" y="152" font-size="15">×</text><text x="330" y="172" font-size="16" font-style="italic">M</text> <text x="197" y="260" font-size="15">×</text><text x="205" y="280" font-size="16" font-style="italic">A</text> </svg>',
  'osa-a-m.svg',
  'Šikmá přímka o a dva body A a M ležící po její straně.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Vrchol $B$ je obrazem bodu $A$ v osové souměrnosti podle osy $o$ (osa souměrnosti rovnoramenného lichoběžníku zaměňuje $A$ a $B$). Bod $M$ je střed ramene $BC$, proto vrchol $C$ získáme jako obraz bodu $B$ ve středové souměrnosti se středem $M$ ($|MC| = |MB|$). Vrchol $D$ je obrazem bodu $C$ v osové souměrnosti podle osy $o$. Spojením bodů $A$, $B$, $C$, $D$ vznikne hledaný rovnoramenný lichoběžník.'},
  'Konstrukce: $B$ obraz $A$ v osové souměrnosti podle $o$; $C$ obraz $B$ ve středové souměrnosti se středem $M$; $D$ obraz $C$ podle $o$; lichoběžník $ABCD$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2020 – úloha 11',
  new List<String>{'Všichni pracovníci natírají plot stejným tempem. Polovinu plotu by natřeli všichni pracovníci společně za $6$ hodin.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Celý plot by natřeli všichni pracovníci společně za $9$ hodin.','11.2 Polovinu plotu by natřela třetina pracovníků společně za $18$ hodin.','11.3 Čtvrtinu plotu by natřela čtvrtina pracovníků společně za $12$ hodin.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'11.1 Celý plot je dvojnásobek poloviny, všichni jej natřou za $2\\cdot 6 = 12$ hodin, ne za $9$ → Ne.','11.2 Na stejnou práci (polovinu plotu) potřebuje třetina pracovníků třikrát delší čas: $3\\cdot 6 = 18$ hodin → Ano.','11.3 Čtvrtinu plotu natřou všichni za $\\frac{6}{2}=3$ hodiny; čtvrtina pracovníků potřebuje čtyřikrát déle: $4\\cdot 3 = 12$ hodin → Ano.'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  4, 5, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2020 – úloha 12',
  new List<String>{'Dvě rovnoběžné přímky protíná lomená čára; jsou vyznačeny úhly $62^\\circ$, $32^\\circ$ a $128^\\circ$ (viz obrázek). Velikosti úhlů neměřte, ale vypočtěte.','Jaká je velikost úhlu $\\alpha$?'},
  new List<String>{'A) menší než $98^\\circ$','B) $98^\\circ$','C) $100^\\circ$','D) $102^\\circ$','E) větší než $102^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 180" font-family="sans-serif"> <line x1="30" y1="40" x2="470" y2="40" stroke="#000" stroke-width="2"/> <line x1="30" y1="150" x2="470" y2="150" stroke="#000" stroke-width="2"/> <line x1="452" y1="33" x2="468" y2="33" stroke="#000"/><line x1="452" y1="47" x2="468" y2="47" stroke="#000"/> <line x1="452" y1="143" x2="468" y2="143" stroke="#000"/><line x1="452" y1="157" x2="468" y2="157" stroke="#000"/> <polyline points="70,40 130,150 250,40 360,150" fill="none" stroke="#000" stroke-width="2"/> <text x="54" y="60" font-size="16" font-style="italic">α</text> <text x="118" y="136" font-size="14">32°</text> <text x="232" y="66" font-size="14">62°</text> <text x="368" y="140" font-size="14">128°</text> </svg>',
  'uhly-rovnobezky.svg',
  'Dvě rovnoběžné vodorovné přímky proťaté lomenou čárou; vyznačené úhly α, 62°, 32° a 128°.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'Vedeme-li vrcholy lomené čáry rovnoběžky s oběma danými přímkami a použijeme střídavé úhly, dostaneme $\\alpha = 128^\\circ - 62^\\circ + 32^\\circ = 98^\\circ$. (Vnitřní úhel u dolní přímky je $180^\\circ - 128^\\circ = 52^\\circ$.)'},
  'B) $98^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
