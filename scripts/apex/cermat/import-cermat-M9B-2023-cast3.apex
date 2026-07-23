String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD23C0T02';
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
  'CERMAT M9B 2023 – úloha 8',
  new List<String>{'Dort tvaru rotačního válce leží na kruhovém tácu. Průměr podstavy dortu je větší než výška dortu, ale menší než průměr tácu. Dort jsme rozdělili svislým řezem na dvě stejné poloviny.','8.1 Tác má tvar kruhu o průměru $d$ a obsahu $\\pi\\cdot 144$ cm$^2$. Vypočtěte v cm průměr $d$ tácu.','8.2 Plocha řezu dortu má obsah $200$ cm$^2$ a tvoří ji obdélník, který lze rozdělit na dva čtverce. Vypočtěte v cm$^3$ objem celého dortu. Výsledek zaokrouhlete na desítky cm$^3$.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 210" font-family="sans-serif"> <ellipse cx="160" cy="165" rx="140" ry="28" fill="#e6e6e6" stroke="#000" stroke-width="1.4"/> <path d="M 60 95 L 60 130 A 100 24 0 0 0 260 130 L 260 95" fill="#f4f4f4" stroke="#000" stroke-width="1.4"/> <ellipse cx="160" cy="95" rx="100" ry="24" fill="#fbfbfb" stroke="#000" stroke-width="1.4"/> <rect x="152" y="95" width="16" height="35" fill="#c4c4c4"/> <line x1="160" y1="71" x2="160" y2="154" stroke="#000" stroke-width="1.2" stroke-dasharray="4 3"/> <text x="160" y="40" font-size="12" text-anchor="middle">dort tvaru rotačního válce</text> <text x="288" y="205" font-size="11" text-anchor="middle">tác</text> </svg>',
  'dort-valec.svg',
  'Dort tvaru rotačního válce na kruhovém tácu, se svislým řezem procházejícím středem.',
  'Schematický nákres dortu na tácu',
  new List<String>{'8.1 Z $\\pi r^2=\\pi\\cdot 144$ plyne $r^2=144$, tedy $r=12$ cm a průměr $d=24$ cm.','8.2 Obdélníkový řez lze rozdělit na dva čtverce, takže jeho delší strana (průměr dortu) je dvojnásobkem kratší strany (výšky dortu $v$): obsah $2v\\cdot v=200$, tj. $v^2=100$, $v=10$ cm. Průměr dortu je $20$ cm, poloměr $10$ cm. Objem $V=\\pi\\cdot 10^2\\cdot 10=1\\,000\\pi\\doteq 3\\,140$ cm$^3$.'},
  '8.1: $d=24$ cm; 8.2: přibližně $3\\,140$ cm$^3$',
  3, 6, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2023 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží úsečka $AB$ a bod $S$ (viz obrázek). Úsečka $AB$ je základna rovnoramenného lichoběžníku $ABCD$. Bod $S$ je střed ramene $AD$ tohoto lichoběžníku.','Sestrojte vrcholy $C$, $D$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif"> <rect x="4" y="4" width="452" height="242" fill="none" stroke="#bbb"/> <line x1="90" y1="205" x2="390" y2="150" stroke="#000" stroke-width="1.8"/> <line x1="85" y1="199" x2="95" y2="211" stroke="#000"/> <line x1="385" y1="144" x2="395" y2="156" stroke="#000"/> <text x="84" y="228" font-size="15" font-style="italic">A</text> <text x="393" y="146" font-size="15" font-style="italic">B</text> <text x="200" y="118" font-size="15">×</text> <text x="211" y="118" font-size="15" font-style="italic">S</text> </svg>',
  'usecka-ab-bod-s.svg',
  'Úsečka AB (A vlevo dole, B vpravo nahoře) a bod S nad úsečkou.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Bod $S$ je střed ramene $AD$, proto je vrchol $D$ obrazem bodu $A$ ve středové souměrnosti se středem $S$ (na polopřímce $AS$ platí $|AS|=|SD|$). Lichoběžník je rovnoramenný se základnou $AB$, má tedy osu souměrnosti totožnou s osou úsečky $AB$; vrchol $C$ je obrazem vrcholu $D$ v této osové souměrnosti (přímka $CD$ je rovnoběžná s $AB$). Čtyřúhelník $ABCD$ je hledaný lichoběžník.'},
  'Konstrukce lichoběžníku $ABCD$: $D$ je obraz bodu $A$ ve středové souměrnosti se středem $S$, vrchol $C$ je obraz $D$ v osové souměrnosti podle osy úsečky $AB$ (viz nákres v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
