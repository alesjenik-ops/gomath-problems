String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD24C0T01';
Integer YEAR = 2024;

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
  'CERMAT M9A 2024 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží přímka $AE$ a přímka $p$ procházející bodem $E$ (viz obrázek). Bod $A$ je vrchol obdélníku $ABCD$. Vrchol $B$ leží na přímce $AE$ a vrchol $C$ na přímce $p$. Úhlopříčka $BD$ obdélníku $ABCD$ má stejnou délku jako úsečka $AE$.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 320" font-family="sans-serif"> <rect x="6" y="6" width="388" height="308" fill="none" stroke="#ccc"/> <line x1="40" y1="250" x2="370" y2="150" stroke="#000" stroke-width="2"/> <line x1="150" y1="60" x2="300" y2="270" stroke="#000" stroke-width="2"/> <text x="146" y="52" font-size="15" font-style="italic">p</text> <text x="252" y="184" font-size="15" font-style="italic">E</text> <line x1="116" y1="219" x2="126" y2="234" stroke="#000"/> <text x="106" y="248" font-size="15" font-style="italic">A</text> </svg>',
  'primky-AE-p.svg',
  'Přímka AE a přímka p procházející bodem E; na přímce AE je vyznačen bod A.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Úhlopříčky obdélníku jsou shodné, proto $|AC|=|BD|=|AE|$. Vrchol $C$ tedy leží na kružnici se středem $A$ a poloměrem $|AE|$ a zároveň na přímce $p$: $C=k(A;|AE|)\\cap p$. Vrchol $B$ je pata kolmice z bodu $C$ na přímku $AE$ (úhel při $B$ je pravý). Vrchol $D$ doplníme jako průsečík kolmice k $AE$ v bodě $A$ a kolmice k $AB$ v bodě $C$, aby $ABCD$ byl obdélník.'},
  'Vrchol $C$: $k(A;|AE|)\\cap p$; vrchol $B$: pata kolmice z $C$ na přímku $AE$; vrchol $D$ doplníme na obdélník $ABCD$ (viz náčrt konstrukce v klíči).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2024 – úloha 11',
  new List<String>{'V rovině leží přímky $p$, $q$ a $r$, jejichž průsečíky tvoří vrcholy trojúhelníku $ABC$ (viz obrázek). Jsou dány úhly $\\beta=23^\\circ$ a $\\delta=107^\\circ$.','Jaká je velikost rozdílu úhlů $\\gamma-\\alpha$? Velikosti úhlů neměřte, ale vypočítejte (obrázek je ilustrační).'},
  new List<String>{'A) $10^\\circ$','B) $11^\\circ$','C) $12^\\circ$','D) $13^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif"> <line x1="70" y1="235" x2="300" y2="-5" stroke="#000"/> <line x1="55" y1="168" x2="410" y2="250" stroke="#000"/> <line x1="180" y1="-8" x2="405" y2="300" stroke="#000"/> <text x="303" y="8" font-size="15" font-style="italic">p</text> <text x="46" y="162" font-size="15" font-style="italic">q</text> <text x="398" y="292" font-size="15" font-style="italic">r</text> <text x="230" y="108" font-size="15">y</text> <text x="138" y="200" font-size="15">a</text> <text x="118" y="172" font-size="15">d</text> <text x="332" y="228" font-size="15">b</text> <text x="232" y="52" font-size="14" font-style="italic">C</text> <text x="104" y="188" font-size="14" font-style="italic">A</text> <text x="366" y="248" font-size="14" font-style="italic">B</text> </svg>',
  'primky-pqr.svg',
  'Tři přímky p, q, r tvořící trojúhelník ABC; u vrcholu A úhly delta a alfa, u vrcholu C úhel gama, u vrcholu B úhel beta.',
  'Schematický nákres (obrázek je ilustrační)',
  new List<String>{'Úhly $\\alpha$ a $\\delta$ jsou vedlejší (leží na přímce $q$ u vrcholu $A$), proto $\\alpha=180^\\circ-\\delta=180^\\circ-107^\\circ=73^\\circ$. V trojúhelníku $ABC$ platí $\\gamma=180^\\circ-\\alpha-\\beta=180^\\circ-73^\\circ-23^\\circ=84^\\circ$. Rozdíl $\\gamma-\\alpha=84^\\circ-73^\\circ=11^\\circ$.'},
  'B) $11^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
