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
  'CERMAT M9A 2020 – úloha 8',
  new List<String>{'Obdélníkový záhon má rozměry $210$ cm a $140$ cm (viz obrázek). Rozměry rostlin zanedbáváme.','8.1 Záhon bude po obvodu osázen tulipány ve stejných rozestupech. Rozestupy mezi sousedními tulipány musí být co největší, přitom tulipán musí být v každém rohu záhonu a také uprostřed delší strany. Vypočtěte v cm rozestup mezi sousedními tulipány.','8.2 Uvnitř záhonu je vyznačen menší obdélník. V jeho rozích a po jeho obvodu budou v 10centimetrových rozestupech vysázeny narcisy. Každý narcis bude vzdálen $25$ cm od nejbližšího okraje záhonu. Vypočtěte, kolik narcisů bude vysázeno.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 250" font-family="sans-serif"> <rect x="40" y="45" width="230" height="150" fill="#eef4ea" stroke="#000" stroke-width="2"/> <text x="155" y="218" font-size="13" text-anchor="middle">210 cm</text> <text x="24" y="120" font-size="13" text-anchor="middle" transform="rotate(-90 24 120)">140 cm</text> <text x="155" y="38" font-size="12" text-anchor="middle">105 cm</text> <circle cx="40" cy="45" r="5" fill="#7a7a7a"/><circle cx="155" cy="45" r="5" fill="#7a7a7a"/><circle cx="270" cy="45" r="5" fill="#7a7a7a"/> <circle cx="40" cy="195" r="5" fill="#7a7a7a"/><circle cx="155" cy="195" r="5" fill="#7a7a7a"/><circle cx="270" cy="195" r="5" fill="#7a7a7a"/> <text x="155" y="240" font-size="10" text-anchor="middle" fill="#555">tulipány v rozích a uprostřed delší strany</text> <rect x="360" y="45" width="230" height="150" fill="none" stroke="#000" stroke-width="1" stroke-dasharray="5 4"/> <rect x="410" y="85" width="130" height="70" fill="#eef4ea" stroke="#000" stroke-width="2"/> <text x="475" y="76" font-size="11" text-anchor="middle">25 cm</text> <text x="380" y="124" font-size="10">25 cm</text><text x="548" y="124" font-size="10">25 cm</text> <text x="475" y="180" font-size="10" text-anchor="middle" fill="#555">narcisy po 10 cm po obvodu vnitřního obdélníku</text> <text x="475" y="216" font-size="13" text-anchor="middle">210 cm</text> </svg>',
  'zahon.svg',
  'Vlevo obdélníkový záhon 210 krát 140 cm s tulipány v rozích a uprostřed delších stran; vpravo vnitřní obdélník s narcisy po 10 cm, 25 cm od okrajů záhonu.',
  'Rozmístění tulipánů a narcisů na záhonu',
  new List<String>{'8.1 Rozestup musí dělit délku $140$ cm i vzdálenost $105$ cm (roh – střed delší strany). Největší společný dělitel čísel $105$ a $140$ je $35$, rozestup je tedy $35$ cm.','8.2 Vnitřní obdélník má rozměry $(210-2\\cdot 25)\\times(140-2\\cdot 25) = 160\\times 90$ cm, jeho obvod je $2\\cdot(160+90)=500$ cm. Při rozestupu $10$ cm je narcisů $500:10 = 50$.'},
  '8.1: $35$ cm; 8.2: $50$ narcisů',
  4, 7, '4',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2020 – úloha 9',
  new List<String>{'V rovině leží přímka $AC$ a přímka $b$ (viz obrázek). Body $A$, $C$ jsou vrcholy trojúhelníku $ABC$. Na přímce $b$ leží vrchol $B$. Délka těžnice $t_b$ na stranu $AC$ je $6$ cm.','Sestrojte vrchol $B$ trojúhelníku $ABC$, označte jej písmenem a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif"> <line x1="55" y1="235" x2="405" y2="70" stroke="#000" stroke-width="2"/> <text x="177" y="182" font-size="15">×</text><text x="158" y="180" font-size="16" font-style="italic">A</text> <text x="333" y="108" font-size="15">×</text><text x="342" y="100" font-size="16" font-style="italic">C</text> <line x1="55" y1="258" x2="415" y2="205" stroke="#000" stroke-width="2"/> <text x="422" y="210" font-size="16" font-style="italic">b</text> </svg>',
  'primka-ac-b.svg',
  'Přímka AC se dvěma vyznačenými body A a C a pod ní samostatná přímka b.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Sestrojíme střed $S_{AC}$ strany $AC$. Těžnice $t_b$ spojuje vrchol $B$ se středem $S_{AC}$ a má délku $6$ cm, proto $B$ leží na kružnici se středem $S_{AC}$ a poloměrem $6$ cm. Průsečíky této kružnice s přímkou $b$ dávají dvě řešení $B_1$, $B_2$.'},
  'Střed $S_{AC}$ úsečky $AC$; vrchol $B$ je průsečík přímky $b$ s kružnicí se středem $S_{AC}$ a poloměrem $6$ cm. Dvě řešení $B_1$, $B_2$ (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
